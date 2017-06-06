From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 06 Jun 2017 19:10:16 +0000
Subject: Unify the various copies of libgcc into lib v2
Message-Id: <20170606191023.24581-1-palmer@dabbelt.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Thanks to everyone who responded to my original patch set.  I believe I've
responded to everyone's comments.  There have been a handful of changes since
the original patch set:

 * The Kconfig names for the routines are now GENERIC_* instead of LIB_*.  This
   matches the existing generic implementation Kconfig names.
 * Tracing is disabled, which matches the MIPS behavior and seems correct
   globally.
 * I've cross compiled this to make sure it builds, and fixed all the build
   errors I found.
 * The MIPS patches actually do what they say in the commit message.

I don't know of any remaining problems with this patch set, so hopefully it's
ready to get merged.  I'll be including patch 1 in our RISC-V submissions, but
as I'm somewhat new to this I don't have a tree that anyone pulls from yet.

If everyone is happy with this patch set then I'd be willing to use this as a
first attempt to get patches upstream myself.

[PATCH 1/7] lib: Add shared copies of some GCC library routines
[PATCH 2/7] m32r: Use lib/ucmpdi2.c
[PATCH 3/7] microblaze: Use libgcc files from lib/
[PATCH 4/7] score: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
[PATCH 5/7] sh: Use lib/ashldi3,ashrdi3,lshrdi3}.c
[PATCH 6/7] sparc: Use lib/{cmpdi2,ucmpdi2}.c
[PATCH 7/7] MIPS: Use generic libgcc intrinsics
