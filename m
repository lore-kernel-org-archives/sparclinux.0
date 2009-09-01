From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 01 Sep 2009 22:28:13 +0000
Subject: [PATCH] sparc: convert /proc/io_map, /proc/dvma_map to seq_file
Message-Id: <20090901222813.GA3364@x200.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/sparc/kernel/ioport.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>		/* struct pci_dev */
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/of_device.h>
 
@@ -663,26 +664,33 @@ EXPORT_SYMBOL(pci_dma_sync_sg_for_device);
 
 #ifdef CONFIG_PROC_FS
 
-static int
-_sparc_io_get_info(char *buf, char **start, off_t fpos, int length, int *eof,
-    void *data)
+static int sparc_io_proc_show(struct seq_file *m, void *v)
 {
-	char *p = buf, *e = buf + length;
-	struct resource *r;
+	struct resource *root = m->private, *r;
 	const char *nm;
 
-	for (r = ((struct resource *)data)->child; r != NULL; r = r->sibling) {
-		if (p + 32 >= e)	/* Better than nothing */
-			break;
+	for (r = root->child; r != NULL; r = r->sibling) {
 		if ((nm = r->name) = 0) nm = "???";
-		p += sprintf(p, "%016llx-%016llx: %s\n",
+		seq_printf(m, "%016llx-%016llx: %s\n",
 				(unsigned long long)r->start,
 				(unsigned long long)r->end, nm);
 	}
 
-	return p-buf;
+	return 0;
 }
 
+static int sparc_io_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sparc_io_proc_show, PDE(inode)->data);
+}
+
+static const struct file_operations sparc_io_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= sparc_io_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 #endif /* CONFIG_PROC_FS */
 
 /*
@@ -707,7 +715,7 @@ static struct resource *_sparc_find_resource(struct resource *root,
 static void register_proc_sparc_ioport(void)
 {
 #ifdef CONFIG_PROC_FS
-	create_proc_read_entry("io_map",0,NULL,_sparc_io_get_info,&sparc_iomap);
-	create_proc_read_entry("dvma_map",0,NULL,_sparc_io_get_info,&_sparc_dvma);
+	proc_create_data("io_map", 0, NULL, &sparc_io_proc_fops, &sparc_iomap);
+	proc_create_data("dvma_map", 0, NULL, &sparc_io_proc_fops, &_sparc_dvma);
 #endif
 }
