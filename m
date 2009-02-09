From: David Miller <davem@davemloft.net>
Date: Mon, 09 Feb 2009 06:46:38 +0000
Subject: [PATCH 0/2]: Fix bugs and bloat in sparc64 user copy code
Message-Id: <20090208.224638.195498342.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


A while ago Chris Torek posted an analysis and patch to fix
probe_kernel_{read,write}() on sparc64.

The main problem is that when we copy from kernel space to kernel
space we just do a straight copy.  But actually such callers
want exception detection just like a userspace access would get.

Chris proposed a byte-by-byte copy, and we discussed whether this
might cause some performance problems even if such copies are
only lightly used.

Chris also noticed that .fixup sections are bloated because we
have hundreds if not thousands of stubs which do the same exact
thing (function return, and set function return register to one).

These two patches kill the .fixup bloat Chris noticed and fix the
probe_kernel_{read,write}() issue by making __copy_in_user() handle
arbitrary %asi values and using that instead of memcpy_user_stub().

Some background information:

We have seperate functions emitted for each optimized memcpy
variant, and one for copying from userspace and one for copying
to userspace.  We have to do this because of the restrictions
that exist for using load and store instructions with the %asi
register.

The %asi register holds which address space "set_fs()" has us
set to currently, either user (ASI_AIUS) or kernel (ASI_P).

The restriction in the instruction set is that you can only
use %asi with a load or store if you use register + immediate
addressing.  Lots of our code wants to user register + register
address generation, which is only allowed with immediate
ASI_* specifications.

So we hardcode ASI_AIUS in the optimized user copy routines,
and thus we need one version when userspace is the source
and one version for when userspace is the destination.

Since the case where we copy from userspace to userspace is
more rare and done on smaller sizes, there is a single
___copy_in_user() implementation which only optimizes
generically up to 64-bit word at a time copies.

Therefore, to solve the bug I reimplemented ___copy_in_user()
slightly so that it only uses register + immediate loads and
stores, and thus could use %asi.  Then we just kill off
memcpy_user_stub() and replace all callers of memcpy_user_stub()
to use ___copy_in_user() instead.

Chris, I actually ran those KGDB tests you triggered this bug with
when I wrote the KGDB support code.  I was mystified as to why I
didn't hit the bug.  Then it occurred to me, copy_from_user() for
UltraSPARC-III doesn't need to use register+register addressing so it
doesn't do the revector to memcpy_user_stub() for kernel space copies.
So probe_kernel_read() would work properly on my workstation, and
maybe that explains it. :-)
