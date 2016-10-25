From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 15:02:36 +0000
Subject: [PATCH 10/11] sparc64: Delete now unused user copy assembler helpers.
Message-Id: <20161025.110236.1757074649571672137.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


All of __ret{,l}_mone{_asi,_fp,_asi_fpu} are now unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/head_64.S | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 5f17de6..6aa3da1 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -931,36 +931,6 @@ ENTRY(__retl_efault)
 	 mov	-EFAULT, %o0
 ENDPROC(__retl_efault)
 
-ENTRY(__retl_mone)
-	retl
-	 mov	-1, %o0
-ENDPROC(__retl_mone)
-
-ENTRY(__retl_mone_fp)
-	VISExitHalf
-	retl
-	 mov	1, %o0
-ENDPROC(__retl_mone_fp)
-
-ENTRY(__ret_mone_asi)
-	wr	%g0, ASI_AIUS, %asi
-	ret
-	 restore %g0, 1, %o0
-ENDPROC(__ret_mone_asi)
-
-ENTRY(__retl_mone_asi)
-	wr	%g0, ASI_AIUS, %asi
-	retl
-	 mov	1, %o0
-ENDPROC(__retl_mone_asi)
-
-ENTRY(__retl_mone_asi_fp)
-	wr	%g0, ASI_AIUS, %asi
-	VISExitHalf
-	retl
-	 mov	1, %o0
-ENDPROC(__retl_mone_asi_fp)
-
 ENTRY(__retl_o1)
 	retl
 	 mov	%o1, %o0
-- 
2.1.2.532.g19b5d50

