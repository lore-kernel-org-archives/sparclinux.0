From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 15:01:28 +0000
Subject: [PATCH 01/11] sparc64: Delete __ret_efault.
Message-Id: <20161025.110128.485425377697935510.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It is completely unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess_64.h | 1 -
 arch/sparc/kernel/head_64.S         | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index b68acc5..f8518df 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -82,7 +82,6 @@ static inline int access_ok(int type, const void __user * addr, unsigned long si
 	return 1;
 }
 
-void __ret_efault(void);
 void __retl_efault(void);
 
 /* Uh, these should become the main single-value transfer routines..
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index beba6c1..603d736 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -926,13 +926,7 @@ tlb_type:	.word	0	/* Must NOT end up in BSS */
 EXPORT_SYMBOL(tlb_type)
 	.section	".fixup",#alloc,#execinstr
 
-	.globl	__ret_efault, __retl_efault, __ret_one, __retl_one
-ENTRY(__ret_efault)
-	ret
-	 restore %g0, -EFAULT, %o0
-ENDPROC(__ret_efault)
-EXPORT_SYMBOL(__ret_efault)
-
+	.globl	__retl_efault, __ret_one, __retl_one
 ENTRY(__retl_efault)
 	retl
 	 mov	-EFAULT, %o0
-- 
2.1.2.532.g19b5d50

