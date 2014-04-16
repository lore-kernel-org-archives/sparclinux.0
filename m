From: Kamal Mostafa <kamal@canonical.com>
Date: Wed, 16 Apr 2014 22:37:51 +0000
Subject: [3.8.y.z extended stable] Patch "sparc64: don't treat 64-bit syscall return codes as 32-bit" has bee
Message-Id: <1397687871-17140-1-git-send-email-kamal@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a note to let you know that I have just added a patch titled

    sparc64: don't treat 64-bit syscall return codes as 32-bit

to the linux-3.8.y-queue branch of the 3.8.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.8.y-queue

This patch is scheduled to be released in version 3.8.13.22.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.8.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

From 7bf9d29202571eeece71b70343d69d269b873988 Mon Sep 17 00:00:00 2001
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 14 Mar 2014 10:42:01 -0500
Subject: sparc64: don't treat 64-bit syscall return codes as 32-bit

[ Upstream commit 1535bd8adbdedd60a0ee62e28fd5225d66434371 ]

When checking a system call return code for an error,
linux_sparc_syscall was sign-extending the lower 32-bit value and
comparing it to -ERESTART_RESTARTBLOCK. lseek can return valid return
codes whose lower 32-bits alone would indicate a failure (such as 4G-1).
Use the whole 64-bit value to check for errors. Only the 32-bit path
should sign extend the lower 32-bit value.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Acked-by: Bob Picco <bob.picco@oracle.com>
Acked-by: Allen Pais <allen.pais@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/sparc/kernel/syscalls.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index dc7b524..d654e9f 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -195,7 +195,8 @@ linux_sparc_syscall32:
 	 mov	%i0, %l5				! IEU1
 5:	call	%l7					! CTI	Group brk forced
 	 srl	%i5, 0, %o5				! IEU1
-	ba,a,pt	%xcc, 3f
+	ba,pt	%xcc, 3f
+	 sra	%o0, 0, %o0

 	/* Linux native system calls enter here... */
 	.align	32
@@ -223,7 +224,6 @@ linux_sparc_syscall:
 3:	stx	%o0, [%sp + PTREGS_OFF + PT_V9_I0]
 ret_sys_call:
 	ldx	[%sp + PTREGS_OFF + PT_V9_TSTATE], %g3
-	sra	%o0, 0, %o0
 	mov	%ulo(TSTATE_XCARRY | TSTATE_ICARRY), %g2
 	sllx	%g2, 32, %g2

--
1.8.3.2

