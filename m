From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 20 Jul 2012 07:55:41 +0000
Subject: [PATCH 6/9] sparc32: drop swapper_pg_dir
Message-Id: <1342770944-17476-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We save one page of RAM dropping swapper_pg_dir.
It was only used for an assignment in init-mm.c and we
redid this later in srmmu.c anyway.

This is likely a left-over from the sun4c removal.

To avoid a dummy variable we use a simple #define swapper_pg_dir NULL

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtable_32.h |    5 +++--
 arch/sparc/kernel/head_32.S         |    2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index cbbbed5..c704f94 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -52,8 +52,9 @@ extern unsigned long calc_highpages(void);
 #define PAGE_READONLY	SRMMU_PAGE_RDONLY
 #define PAGE_KERNEL	SRMMU_PAGE_KERNEL
 
-/* Top-level page directory */
-extern pgd_t swapper_pg_dir[1024];
+/* Top-level page directory - dummy used by init-mm.
+ * srmmu.c will assign the real one (which is dynamically sized) */
+#define swapper_pg_dir NULL
 
 extern void paging_init(void);
 
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index afeb1d7..3d92c0a 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -58,8 +58,6 @@ sun4e_notsup:
 /* This was the only reasonable way I could think of to properly align
  * these page-table data structures.
  */
-	.globl swapper_pg_dir
-swapper_pg_dir:		.skip PAGE_SIZE
 	.globl empty_zero_page
 empty_zero_page:	.skip PAGE_SIZE
 
-- 
1.6.0.6

