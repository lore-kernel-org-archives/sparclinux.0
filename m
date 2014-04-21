From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:19 +0000
Subject: [PATCH 07/24] sparc32: fix sparse warnings in ioport.c
Message-Id: <1398100356-19794-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
ioport.c:189:38: warning: Using plain integer as NULL pointer
ioport.c:78:25: warning: symbol 'sparc_iomap' was not declared. Should it be static?
ioport.c:403:20: warning: symbol 'sbus_dma_ops' was not declared. Should it be static?
ioport.c:684:39: warning: Using plain integer as NULL pointer

Add one missing prototype, and use NULL.
sbus_dma_ops declared static.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgalloc_32.h | 2 ++
 arch/sparc/kernel/ioport.c          | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 9b1c36d..a3890da 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -14,6 +14,8 @@ struct page;
 void *srmmu_get_nocache(int size, int align);
 void srmmu_free_nocache(void *addr, int size);
 
+extern struct resource sparc_iomap;
+
 #define check_pgt_cache()	do { } while (0)
 
 pgd_t *get_pgd_fast(void);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index e7e215d..7f08ec8 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -186,7 +186,7 @@ static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
 
 	if (name = NULL) name = "???";
 
-	if ((xres = xres_alloc()) != 0) {
+	if ((xres = xres_alloc()) != NULL) {
 		tack = xres->xname;
 		res = &xres->xres;
 	} else {
@@ -400,7 +400,7 @@ static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	BUG();
 }
 
-struct dma_map_ops sbus_dma_ops = {
+static struct dma_map_ops sbus_dma_ops = {
 	.alloc			= sbus_alloc_coherent,
 	.free			= sbus_free_coherent,
 	.map_page		= sbus_map_page,
@@ -681,7 +681,7 @@ static int sparc_io_proc_show(struct seq_file *m, void *v)
 	const char *nm;
 
 	for (r = root->child; r != NULL; r = r->sibling) {
-		if ((nm = r->name) = 0) nm = "???";
+		if ((nm = r->name) = NULL) nm = "???";
 		seq_printf(m, "%016llx-%016llx: %s\n",
 				(unsigned long long)r->start,
 				(unsigned long long)r->end, nm);
-- 
1.8.3.1

