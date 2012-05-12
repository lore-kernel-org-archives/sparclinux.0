From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 11:43:46 +0000
Subject: [PATCH 1/4] sparc32: remove sun4c specific variables from head_32.S
Message-Id: <1336823029-8206-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This gives us back 7 pages...

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 0d01798..10830b5 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -401,18 +401,9 @@ trapbase_cpu3:
 /* This was the only reasonable way I could think of to properly align
  * these page-table data structures.
  */
-	.globl pg0, pg1, pg2, pg3
-	.globl empty_bad_page
-	.globl empty_bad_page_table
-	.globl empty_zero_page
 	.globl swapper_pg_dir
 swapper_pg_dir:		.skip PAGE_SIZE
-pg0:			.skip PAGE_SIZE
-pg1:			.skip PAGE_SIZE
-pg2:			.skip PAGE_SIZE
-pg3:			.skip PAGE_SIZE
-empty_bad_page:		.skip PAGE_SIZE
-empty_bad_page_table:	.skip PAGE_SIZE
+	.globl empty_zero_page
 empty_zero_page:	.skip PAGE_SIZE
 
 	.global root_flags
-- 
1.6.0.6

