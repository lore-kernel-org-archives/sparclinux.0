From: Bob <bo-liu@hotmail.com>
Date: Thu, 11 Dec 2008 07:16:17 +0000
Subject: what's  a fast syscall
Message-Id: <BAY123-W38E04698CF11056DC900059FF80@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi, all 
 
      I have read the code about syscall in file entry.S and didn't known what's a fast syscall. 
 
And why line 1322 can distinguish it through "andcc" (there %l7 is the sys_* funtions' address?) ?
 
Thanks .
 
1313        .globl  linux_sparc_syscall
1314linux_sparc_syscall:
1315        sethi   %hi(PSR_SYSCALL), %l4
1316        or      %l0, %l4, %l0
1317        /* Direct access to user regs, must faster. */
1318        cmp     %g1, NR_SYSCALLS
1319        bgeu    linux_sparc_ni_syscall
1320         sll    %g1, 2, %l4
1321        ld      [%l7 + %l4], %l7
1322        andcc   %l7, 1, %g0
1323        bne     linux_fast_syscall
1324         /* Just do first insn from SAVE_ALL in the delay slot */


---
Best regards

Bo Liu
_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx
