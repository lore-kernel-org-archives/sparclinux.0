From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 26 Jul 2013 13:21:12 +0000
Subject: [PATCH v2] sparc64: Fix not SRA'ed %o5 in 32-bit traced syscall
Message-Id: <2143211374844872@web24e.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

(From v1 to v2: changed comment)

On the way linux_sparc_syscall32->linux_syscall_trace32->goto 2f,
register %o5 doesn't clear its second 32-bit.

Fix that.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/syscalls.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 22a1098..73ec8a7 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -152,7 +152,7 @@ linux_syscall_trace32:
 	srl	%i4, 0, %o4
 	srl	%i1, 0, %o1
 	srl	%i2, 0, %o2
-	ba,pt	%xcc, 2f
+	ba,pt	%xcc, 5f
 	 srl	%i3, 0, %o3
 
 linux_syscall_trace:
@@ -182,13 +182,13 @@ linux_sparc_syscall32:
 	srl	%i1, 0, %o1				! IEU0	Group
 	ldx	[%g6 + TI_FLAGS], %l0		! Load
 
-	srl	%i5, 0, %o5				! IEU1
+	srl	%i3, 0, %o3				! IEU0
 	srl	%i2, 0, %o2				! IEU0	Group
 	andcc	%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_SYSCALL_TRACEPOINT), %g0
 	bne,pn	%icc, linux_syscall_trace32		! CTI
 	 mov	%i0, %l5				! IEU1
-	call	%l7					! CTI	Group brk forced
-	 srl	%i3, 0, %o3				! IEU0
+5:	call	%l7					! CTI	Group brk forced
+	 srl	%i5, 0, %o5				! IEU1
 	ba,a,pt	%xcc, 3f
 
 	/* Linux native system calls enter here... */
