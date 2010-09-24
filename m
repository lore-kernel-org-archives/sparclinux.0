From: David Miller <davem@davemloft.net>
Date: Fri, 24 Sep 2010 05:01:14 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100923.220114.135523752.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100922185328.GD19804@ZenIV.linux.org.uk>
	<AANLkTi=pJUKRUQhpcVV8XAJF+BO1440v1Py5Opr34DR1@mail.gmail.com>
	<20100923045921.GJ19804@ZenIV.linux.org.uk>
In-Reply-To: <20100923045921.GJ19804@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 23 Sep 2010 05:59:22 +0100

> They do have a reason for doing it that way and it's worth considering on
> other platforms.  Think what happens if we are getting traced.  We'll be
> stopped and tracer will be notified.  Normally it'll tell us to continue
> execution, possibly with a different signal *AND* with a different userland
> address to return to.  Suppose we've got a different return address set
> for us (e.g. with PTRACE_POKEUSR).  Should we ever shift it back by what
> hopefully is a size of syscall insn?

These "tracer changing the program counter" issues are why on sparc we
have this software state bit in the %tstate/%psr we report via regsets
(and thus via ptrace) to debuggers which tells if we are inside of a
syscall or not.

GDB uses this to know whether the kernel signal handling is going to
modify the program counter or not when the inferior continues.

If GDB ever writes the program counter of the inferior, it clears
this "in-syscall" bit, and this short-circuits the restart syscall
logic in the signal dispatch code.

This is what the GDB code looks like:

static void
sparc_linux_write_pc (struct regcache *regcache, CORE_ADDR pc)
{
  struct gdbarch_tdep *tdep = gdbarch_tdep (get_regcache_arch (regcache));
  ULONGEST psr;

  regcache_cooked_write_unsigned (regcache, tdep->pc_regnum, pc);
  regcache_cooked_write_unsigned (regcache, tdep->npc_regnum, pc + 4);

  /* Clear the "in syscall" bit to prevent the kernel from
     messing with the PCs we just installed, if we happen to be
     within an interrupted system call that the kernel wants to
     restart.

     Note that after we return from the dummy call, the PSR et al.
     registers will be automatically restored, and the kernel
     continues to restart the system call at this point.  */
  regcache_cooked_read_unsigned (regcache, SPARC32_PSR_REGNUM, &psr);
  psr &= ~PSR_SYSCALL;
  regcache_cooked_write_unsigned (regcache, SPARC32_PSR_REGNUM, psr);
}
