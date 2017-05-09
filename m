From: Dave Aldridge <david.j.aldridge@oracle.com>
Date: Tue, 09 May 2017 08:57:35 +0000
Subject: [PATCH] sparc64: fix fault handling in NGbzero.S and GENbzero.S
Message-Id: <1494320255-406137-1-git-send-email-david.j.aldridge@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When any of the functions contained in NGbzero.S and GENbzero.S
vector through *bzero_from_clear_user, we may end up taking a
fault when executing one of the store alternate address space
instructions. If this happens, the exception handler does not
restore the %asi register.

This commit fixes the issue by introducing a new exception
handler that ensures the %asi register is restored when
a fault is handled.

Orabug: 25577560

Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/kernel/head_64.S |    6 ++++++
 arch/sparc/lib/GENbzero.S   |    2 +-
 arch/sparc/lib/NGbzero.S    |    2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 4410119..41a4073 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -939,3 +939,9 @@ ENTRY(__retl_o1)
 	retl
 	 mov	%o1, %o0
 ENDPROC(__retl_o1)
+
+ENTRY(__retl_o1_asi)
+	wr      %o5, 0x0, %asi
+	retl
+	 mov    %o1, %o0
+ENDPROC(__retl_o1_asi)
diff --git a/arch/sparc/lib/GENbzero.S b/arch/sparc/lib/GENbzero.S
index 8e7a843..2fbf629 100644
--- a/arch/sparc/lib/GENbzero.S
+++ b/arch/sparc/lib/GENbzero.S
@@ -8,7 +8,7 @@
 98:	x,y;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_o1;	\
+	.word 98b, __retl_o1_asi;\
 	.text;			\
 	.align 4;
 
diff --git a/arch/sparc/lib/NGbzero.S b/arch/sparc/lib/NGbzero.S
index beab29b..33053bd 100644
--- a/arch/sparc/lib/NGbzero.S
+++ b/arch/sparc/lib/NGbzero.S
@@ -8,7 +8,7 @@
 98:	x,y;			\
 	.section __ex_table,"a";\
 	.align 4;		\
-	.word 98b, __retl_o1;	\
+	.word 98b, __retl_o1_asi;\
 	.text;			\
 	.align 4;
 
-- 
1.7.1

