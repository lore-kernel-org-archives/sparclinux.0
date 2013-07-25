From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 25 Jul 2013 21:17:15 +0000
Subject: [PATCH]sparc32: Fix exit flag passed from traced sys_sigreturn
Message-Id: <1416931374787035@web27d.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Pass 1 in %o1 to indicate that syscall_trace accounts exit.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index e2a0300..33c02b1 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -839,7 +839,7 @@ sys_sigreturn:
 	 nop
 
 	call	syscall_trace
-	 nop
+	 mov	1, %o1
 
 1:
 	/* We don't want to muck with user registers like a
