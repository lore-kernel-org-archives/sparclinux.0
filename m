From: Adam Kropelin <akropel1@rochester.rr.com>
Date: Sat, 11 Dec 2004 16:18:47 +0000
Subject: [PATCH] cg6 framebuffer no display
Message-Id: <20041211131340.A16522@mail.kroptech.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Although the CG6 framebuffer is detected and initialized, without this
patch all it displays is a blank screen. Tested on an Ultra 1 with a
TGX+.

Originally from Bob Breuer for the CG14.

Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

--- linux-2.6.9-rc3-bk5/drivers/video/cg6.c	2004-12-11 15:35:03.106749591 -0500
+++ linux-2.6.9-rc3-bk5.adk/drivers/video/cg6.c	2004-12-11 15:30:18.000000000 -0500
@@ -689,6 +689,9 @@
 	all->par.physbase = sdev->reg_addrs[0].phys_addr;
 
 	sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+	all->info.var.red.length = 8;
+	all->info.var.green.length = 8;
+	all->info.var.blue.length = 8;
 
 	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
 				       all->info.var.xres);
@@ -732,6 +735,7 @@
 		return;
 	}
 
+	fb_set_cmap(&all->info.cmap, &all->info);
 	cg6_init_fix(&all->info, linebytes);
 
 	if (register_framebuffer(&all->info) < 0) {
