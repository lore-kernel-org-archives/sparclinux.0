From: Bob Breuer <breuerr@mc.net>
Date: Sun, 06 Mar 2011 22:55:33 +0000
Subject: sparc32 build failure in fault_32.c
Message-Id: <4D7410E5.3090904@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Using gcc 3.3.4, I'm getting this build failure for sparc32:

arch/sparc/mm/fault_32.c: In function `do_sparc_fault':
arch/sparc/mm/fault_32.c:229: warning: `code' might be used
uninitialized in this function
make[3]: *** [arch/sparc/mm/fault_32.o] Error 1

I have no idea why gcc 3.3 is catching this while 4.x is not, but the
problem is caused by these lines:
  if (!ARCH_SUN4C && address >= TASK_SIZE)
<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/sparc/mm/fault_32.c;h[836f5aea90bcd94d4e4ba1b3114a8115291135;hb=HEAD#l244>         
goto vmalloc_fault;
  code = SEGV_MAPERR;

This first branch can jump to vmalloc_fault before "code" gets
initialized, and from there can jump back to bad_area_nosemaphore, which
may then use "code" without it being initialized.

Would it be safe enough to initialize code to SEGV_MAPERR earlier, or
should vmalloc_fault have a different fault code?

Bob

