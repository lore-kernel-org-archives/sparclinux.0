From: Bob Breuer <breuerr@mc.net>
Date: Tue, 01 Feb 2005 04:37:48 +0000
Subject: fix cg14 with serial console
Message-Id: <41FF079C.7070007@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When booting with a serial console and a vsimm installed, the cg14
driver would crash because the driver failed to check the return
value of prom_getproperty().

Here's a patch to fix that and move the SPARC32 conditional out of
the source file and into Kconfig.

Bob


diff -X dontdiff -urp linux-2.6.10-clean/drivers/video/cg14.c linux-2.6.10/drivers/video/cg14.c
--- linux-2.6.10-clean/drivers/video/cg14.c	2005-01-12 00:11:02.000000000 -0600
+++ linux-2.6.10/drivers/video/cg14.c	2005-01-31 22:31:36.000000000 -0600
@@ -469,9 +469,9 @@ static void cg14_init_one(struct sbus_de
  	int is_8mb, linebytes, i;

  	if (!sdev) {
-		prom_getproperty(node, "address",
-				 (char *) &bases[0], sizeof(bases));
-		if (!bases[0]) {
+		if (prom_getproperty(node, "address",
+				     (char *) &bases[0], sizeof(bases)) <= 0
+		    || !bases[0]) {
  			printk(KERN_ERR "cg14: Device is not mapped.\n");
  			return;
  		}
@@ -591,24 +591,20 @@ int __init cg14_init(void)
  {
  	struct sbus_bus *sbus;
  	struct sbus_dev *sdev;
+	int root, node;

  	if (fb_get_options("cg14fb", NULL))
  		return -ENODEV;

-#ifdef CONFIG_SPARC32
-	{
-		int root, node;
-
-		root = prom_getchild(prom_root_node);
-		root = prom_searchsiblings(root, "obio");
-		if (root) {
-			node = prom_searchsiblings(prom_getchild(root),
-						   "cgfourteen");
-			if (node)
-				cg14_init_one(NULL, node, root);
-		}
+	root = prom_getchild(prom_root_node);
+	root = prom_searchsiblings(root, "obio");
+	if (root) {
+		node = prom_searchsiblings(prom_getchild(root),
+					   "cgfourteen");
+		if (node)
+			cg14_init_one(NULL, node, root);
  	}
-#endif
+
  	for_all_sbusdev(sdev, sbus) {
  		if (!strcmp(sdev->prom_name, "cgfourteen"))
  			cg14_init_one(sdev, sdev->prom_node, sbus->prom_node);
diff -X dontdiff -urp linux-2.6.10-clean/drivers/video/Kconfig linux-2.6.10/drivers/video/Kconfig
--- linux-2.6.10-clean/drivers/video/Kconfig	2005-01-12 00:11:01.000000000 -0600
+++ linux-2.6.10/drivers/video/Kconfig	2005-01-31 22:11:23.000000000 -0600
@@ -954,14 +954,14 @@ config FB_FFB

  config FB_TCX
  	bool "TCX (SS4/SS5 only) support"
-	depends on FB_SBUS
+	depends on FB_SBUS && SPARC32
  	help
  	  This is the frame buffer device driver for the TCX 24/8bit frame
  	  buffer.

  config FB_CG14
  	bool "CGfourteen (SX) support"
-	depends on FB_SBUS
+	depends on FB_SBUS && SPARC32
  	help
  	  This is the frame buffer device driver for the CGfourteen frame
  	  buffer on Desktop SPARCsystems with the SX graphics option.


