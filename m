From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 06 Oct 2017 16:54:53 +0000
Subject: [PATCH v3 5/5] sparc64: Use sparc optimised fls and __fls for T4 and above
Message-Id: <1507308893-9218-6-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com, sam@ravnborg.org

For T4 and above, patch fls and __fls functions
at the boot time to use lzcnt instruction.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/kernel/head_64.S |    2 ++
 arch/sparc/lib/NG4patch.S   |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 4de9fbd..f362ecb 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -640,6 +640,8 @@ niagara4_patch:
 	 nop
 	call	niagara4_patch_pageops
 	 nop
+	call	niagara4_patch_fls
+	 nop
 
 	ba,a,pt	%xcc, 80f
 	 nop
diff --git a/arch/sparc/lib/NG4patch.S b/arch/sparc/lib/NG4patch.S
index 3cc0f8c..da65a3e 100644
--- a/arch/sparc/lib/NG4patch.S
+++ b/arch/sparc/lib/NG4patch.S
@@ -3,6 +3,8 @@
  * Copyright (C) 2012 David S. Miller <davem@davemloft.net>
  */
 
+#include <linux/linkage.h>
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define NG_DO_PATCH(OLD, NEW)	\
@@ -52,3 +54,10 @@ niagara4_patch_pageops:
 	retl
 	 nop
 	.size	niagara4_patch_pageops,.-niagara4_patch_pageops
+
+ENTRY(niagara4_patch_fls)
+	NG_DO_PATCH(fls, NG4fls)
+	NG_DO_PATCH(__fls, __NG4fls)
+	retl
+	 nop
+ENDPROC(niagara4_patch_fls)
-- 
1.7.1

