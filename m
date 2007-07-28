From: David Miller <davem@davemloft.net>
Date: Sat, 28 Jul 2007 05:33:08 +0000
Subject: [PATCH]: Fix for SBUS framebuffer oops in 2.6.23-rc1
Message-Id: <20070727.223308.109316038.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Those seeing crashes when using the SBUS framebuffer drivers
in 2.6.23-rc1 can try out the following patch which should
fix the problem.

Thanks.

commit c962c92edcefb92611f917ab1eb515a98e5b4848
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Fri Jul 27 22:31:46 2007 -0700

    [VIDEO]: Fix OOPS in all SBUS framebuffer drivers.
    
    All of these drivers use a silly:
    
    struct all_info {
    	struct fb_info info;
    	struct foo_par par;
    };
    
    struct all_info *all = kzalloc(sizeof(*all), GFP_KERNEL);
    all->info.par = &all->par;
    
    etc. etc. code sequence, basically replicating the provided
    framebuffer_alloc()/framebuffer_release(), and doing it badly.
    
    Not only is this massive code duplication, it also caused a
    bug in that we weren't setting the fb_info->device pointer
    which results in an OOPS when fb_is_primary_device() runs.
    
    Fix all of this by using framebuffer_{alloc,release}() and
    passing in "&of_device->dev" as the device pointer.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
index b0b2e40..718b9f8 100644
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -279,90 +279,91 @@ static void __devinit bw2_do_default_mode(struct bw2_par *par,
 	}
 }
 
-struct all_info {
-	struct fb_info info;
-	struct bw2_par par;
-};
-
-static int __devinit bw2_init_one(struct of_device *op)
+static int __devinit bw2_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
-	struct all_info *all;
+	struct fb_info *info;
+	struct bw2_par *par;
 	int linebytes, err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct bw2_par), &op->dev);
 
-	spin_lock_init(&all->par.lock);
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
+	par = info->par;
 
-	all->par.physbase = op->resource[0].start;
-	all->par.which_io = op->resource[0].flags & IORESOURCE_BITS;
+	spin_lock_init(&par->lock);
 
-	sbusfb_fill_var(&all->info.var, dp->node, 1);
+	par->physbase = op->resource[0].start;
+	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
+
+	sbusfb_fill_var(&info->var, dp->node, 1);
 	linebytes = of_getintprop_default(dp, "linebytes",
-					  all->info.var.xres);
+					  info->var.xres);
 
-	all->info.var.red.length = all->info.var.green.length -		all->info.var.blue.length = all->info.var.bits_per_pixel;
-	all->info.var.red.offset = all->info.var.green.offset -		all->info.var.blue.offset = 0;
+	info->var.red.length = info->var.green.length +		info->var.blue.length = info->var.bits_per_pixel;
+	info->var.red.offset = info->var.green.offset +		info->var.blue.offset = 0;
 
-	all->par.regs = of_ioremap(&op->resource[0], BWTWO_REGISTER_OFFSET,
-				   sizeof(struct bw2_regs), "bw2 regs");
+	par->regs = of_ioremap(&op->resource[0], BWTWO_REGISTER_OFFSET,
+			       sizeof(struct bw2_regs), "bw2 regs");
+	if (!par->regs)
+		goto out_release_fb;
 
 	if (!of_find_property(dp, "width", NULL))
-		bw2_do_default_mode(&all->par, &all->info, &linebytes);
+		bw2_do_default_mode(par, info, &linebytes);
 
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->info.flags = FBINFO_DEFAULT;
-	all->info.fbops = &bw2_ops;
+	info->flags = FBINFO_DEFAULT;
+	info->fbops = &bw2_ops;
 
-	all->info.screen_base -		of_ioremap(&op->resource[0], 0, all->par.fbsize, "bw2 ram");
-	all->info.par = &all->par;
+	info->screen_base = of_ioremap(&op->resource[0], 0,
+				       par->fbsize, "bw2 ram");
+	if (!info->screen_base)
+		goto out_unmap_regs;
 
-	bw2_blank(0, &all->info);
+	bw2_blank(0, info);
 
-	bw2_init_fix(&all->info, linebytes);
+	bw2_init_fix(info, linebytes);
 
-	err= register_framebuffer(&all->info);
-	if (err < 0) {
-		of_iounmap(&op->resource[0],
-			   all->par.regs, sizeof(struct bw2_regs));
-		of_iounmap(&op->resource[0],
-			   all->info.screen_base, all->par.fbsize);
-		kfree(all);
-		return err;
-	}
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_unmap_screen;
 
-	dev_set_drvdata(&op->dev, all);
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: bwtwo at %lx:%lx\n",
-	       dp->full_name,
-	       all->par.which_io, all->par.physbase);
+	       dp->full_name, par->which_io, par->physbase);
 
 	return 0;
-}
 
-static int __devinit bw2_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
+out_unmap_screen:
+	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
+
+out_unmap_regs:
+	of_iounmap(&op->resource[0], par->regs, sizeof(struct bw2_regs));
+
+out_release_fb:
+	framebuffer_release(info);
 
-	return bw2_init_one(op);
+out_err:
+	return err;
 }
 
 static int __devexit bw2_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct bw2_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
+	unregister_framebuffer(info);
 
-	of_iounmap(&op->resource[0], all->par.regs, sizeof(struct bw2_regs));
-	of_iounmap(&op->resource[0], all->info.screen_base, all->par.fbsize);
+	of_iounmap(&op->resource[0], par->regs, sizeof(struct bw2_regs));
+	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
index b071bb6..41f6dbf 100644
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -448,81 +448,79 @@ static struct sbus_mmap_map __cg14_mmap_map[CG14_MMAP_ENTRIES] __devinitdata = {
 	{ .size = 0 }
 };
 
-struct all_info {
-	struct fb_info info;
-	struct cg14_par par;
-};
-
-static void cg14_unmap_regs(struct of_device *op, struct all_info *all)
+static void cg14_unmap_regs(struct of_device *op, struct fb_info *info,
+			    struct cg14_par *par)
 {
-	if (all->par.regs)
+	if (par->regs)
 		of_iounmap(&op->resource[0],
-			   all->par.regs, sizeof(struct cg14_regs));
-	if (all->par.clut)
+			   par->regs, sizeof(struct cg14_regs));
+	if (par->clut)
 		of_iounmap(&op->resource[0],
-			   all->par.clut, sizeof(struct cg14_clut));
-	if (all->par.cursor)
+			   par->clut, sizeof(struct cg14_clut));
+	if (par->cursor)
 		of_iounmap(&op->resource[0],
-			   all->par.cursor, sizeof(struct cg14_cursor));
-	if (all->info.screen_base)
+			   par->cursor, sizeof(struct cg14_cursor));
+	if (info->screen_base)
 		of_iounmap(&op->resource[1],
-			   all->info.screen_base, all->par.fbsize);
+			   info->screen_base, par->fbsize);
 }
 
-static int __devinit cg14_init_one(struct of_device *op)
+static int __devinit cg14_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
-	struct all_info *all;
+	struct fb_info *info;
+	struct cg14_par *par;
 	int is_8mb, linebytes, i, err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct cg14_par), &op->dev);
+
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
+	par = info->par;
 
-	spin_lock_init(&all->par.lock);
+	spin_lock_init(&par->lock);
 
-	sbusfb_fill_var(&all->info.var, dp->node, 8);
-	all->info.var.red.length = 8;
-	all->info.var.green.length = 8;
-	all->info.var.blue.length = 8;
+	sbusfb_fill_var(&info->var, dp->node, 8);
+	info->var.red.length = 8;
+	info->var.green.length = 8;
+	info->var.blue.length = 8;
 
 	linebytes = of_getintprop_default(dp, "linebytes",
-					  all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+					  info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
 	if (!strcmp(dp->parent->name, "sbus") ||
 	    !strcmp(dp->parent->name, "sbi")) {
-		all->par.physbase = op->resource[0].start;
-		all->par.iospace = op->resource[0].flags & IORESOURCE_BITS;
+		par->physbase = op->resource[0].start;
+		par->iospace = op->resource[0].flags & IORESOURCE_BITS;
 	} else {
-		all->par.physbase = op->resource[1].start;
-		all->par.iospace = op->resource[0].flags & IORESOURCE_BITS;
+		par->physbase = op->resource[1].start;
+		par->iospace = op->resource[0].flags & IORESOURCE_BITS;
 	}
 
-	all->par.regs = of_ioremap(&op->resource[0], 0,
-				   sizeof(struct cg14_regs), "cg14 regs");
-	all->par.clut = of_ioremap(&op->resource[0], CG14_CLUT1,
-				   sizeof(struct cg14_clut), "cg14 clut");
-	all->par.cursor = of_ioremap(&op->resource[0], CG14_CURSORREGS,
-				   sizeof(struct cg14_cursor), "cg14 cursor");
+	par->regs = of_ioremap(&op->resource[0], 0,
+			       sizeof(struct cg14_regs), "cg14 regs");
+	par->clut = of_ioremap(&op->resource[0], CG14_CLUT1,
+			       sizeof(struct cg14_clut), "cg14 clut");
+	par->cursor = of_ioremap(&op->resource[0], CG14_CURSORREGS,
+				 sizeof(struct cg14_cursor), "cg14 cursor");
 
-	all->info.screen_base = of_ioremap(&op->resource[1], 0,
-					   all->par.fbsize, "cg14 ram");
+	info->screen_base = of_ioremap(&op->resource[1], 0,
+				       par->fbsize, "cg14 ram");
 
-	if (!all->par.regs || !all->par.clut || !all->par.cursor ||
-	    !all->info.screen_base)
-		cg14_unmap_regs(op, all);
+	if (!par->regs || !par->clut || !par->cursor || !info->screen_base)
+		goto out_unmap_regs;
 
 	is_8mb = (((op->resource[1].end - op->resource[1].start) + 1) =
 		  (8 * 1024 * 1024));
 
-	BUILD_BUG_ON(sizeof(all->par.mmap_map) != sizeof(__cg14_mmap_map));
+	BUILD_BUG_ON(sizeof(par->mmap_map) != sizeof(__cg14_mmap_map));
 		
-	memcpy(&all->par.mmap_map, &__cg14_mmap_map,
-	       sizeof(all->par.mmap_map));
+	memcpy(&par->mmap_map, &__cg14_mmap_map, sizeof(par->mmap_map));
 
 	for (i = 0; i < CG14_MMAP_ENTRIES; i++) {
-		struct sbus_mmap_map *map = &all->par.mmap_map[i];
+		struct sbus_mmap_map *map = &par->mmap_map[i];
 
 		if (!map->size)
 			break;
@@ -536,59 +534,55 @@ static int __devinit cg14_init_one(struct of_device *op)
 			map->size *= 2;
 	}
 
-	all->par.mode = MDI_8_PIX;
-	all->par.ramsize = (is_8mb ? 0x800000 : 0x400000);
+	par->mode = MDI_8_PIX;
+	par->ramsize = (is_8mb ? 0x800000 : 0x400000);
 
-	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
-	all->info.fbops = &cg14_ops;
-	all->info.par = &all->par;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->fbops = &cg14_ops;
 
-	__cg14_reset(&all->par);
+	__cg14_reset(par);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
-		cg14_unmap_regs(op, all);
-		kfree(all);
-		return -ENOMEM;
-	}
-	fb_set_cmap(&all->info.cmap, &all->info);
+	if (fb_alloc_cmap(&info->cmap, 256, 0))
+		goto out_unmap_regs;
 
-	cg14_init_fix(&all->info, linebytes, dp);
+	fb_set_cmap(&info->cmap, info);
 
-	err = register_framebuffer(&all->info);
-	if (err < 0) {
-		fb_dealloc_cmap(&all->info.cmap);
-		cg14_unmap_regs(op, all);
-		kfree(all);
-		return err;
-	}
+	cg14_init_fix(info, linebytes, dp);
+
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_dealloc_cmap;
 
-	dev_set_drvdata(&op->dev, all);
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: cgfourteen at %lx:%lx, %dMB\n",
 	       dp->full_name,
-	       all->par.iospace, all->par.physbase,
-	       all->par.ramsize >> 20);
+	       par->iospace, par->physbase,
+	       par->ramsize >> 20);
 
 	return 0;
-}
 
-static int __devinit cg14_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
+out_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
+out_unmap_regs:
+	cg14_unmap_regs(op, info, par);
 
-	return cg14_init_one(op);
+out_err:
+	return err;
 }
 
 static int __devexit cg14_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct cg14_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
-	fb_dealloc_cmap(&all->info.cmap);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 
-	cg14_unmap_regs(op, all);
+	cg14_unmap_regs(op, info, par);
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
index f042428..5741b46 100644
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -353,104 +353,102 @@ static void __devinit cg3_do_default_mode(struct cg3_par *par)
 	}
 }
 
-struct all_info {
-	struct fb_info info;
-	struct cg3_par par;
-};
-
-static int __devinit cg3_init_one(struct of_device *op)
+static int __devinit cg3_probe(struct of_device *op,
+			       const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
-	struct all_info *all;
+	struct fb_info *info;
+	struct cg3_par *par;
 	int linebytes, err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct cg3_par), &op->dev);
 
-	spin_lock_init(&all->par.lock);
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
+	par = info->par;
 
-	all->par.physbase = op->resource[0].start;
-	all->par.which_io = op->resource[0].flags & IORESOURCE_BITS;
+	spin_lock_init(&par->lock);
 
-	sbusfb_fill_var(&all->info.var, dp->node, 8);
-	all->info.var.red.length = 8;
-	all->info.var.green.length = 8;
-	all->info.var.blue.length = 8;
+	par->physbase = op->resource[0].start;
+	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
+
+	sbusfb_fill_var(&info->var, dp->node, 8);
+	info->var.red.length = 8;
+	info->var.green.length = 8;
+	info->var.blue.length = 8;
 	if (!strcmp(dp->name, "cgRDI"))
-		all->par.flags |= CG3_FLAG_RDI;
-	if (all->par.flags & CG3_FLAG_RDI)
-		cg3_rdi_maybe_fixup_var(&all->info.var, dp);
+		par->flags |= CG3_FLAG_RDI;
+	if (par->flags & CG3_FLAG_RDI)
+		cg3_rdi_maybe_fixup_var(&info->var, dp);
 
 	linebytes = of_getintprop_default(dp, "linebytes",
-					  all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+					  info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->par.regs = of_ioremap(&op->resource[0], CG3_REGS_OFFSET,
-				   sizeof(struct cg3_regs), "cg3 regs");
+	par->regs = of_ioremap(&op->resource[0], CG3_REGS_OFFSET,
+			       sizeof(struct cg3_regs), "cg3 regs");
+	if (!par->regs)
+		goto out_release_fb;
 
-	all->info.flags = FBINFO_DEFAULT;
-	all->info.fbops = &cg3_ops;
-	all->info.screen_base -		of_ioremap(&op->resource[0], CG3_RAM_OFFSET,
-			   all->par.fbsize, "cg3 ram");
-	all->info.par = &all->par;
+	info->flags = FBINFO_DEFAULT;
+	info->fbops = &cg3_ops;
+	info->screen_base = of_ioremap(&op->resource[0], CG3_RAM_OFFSET,
+				       par->fbsize, "cg3 ram");
+	if (!info->screen_base)
+		goto out_unmap_regs;
 
-	cg3_blank(0, &all->info);
+	cg3_blank(0, info);
 
 	if (!of_find_property(dp, "width", NULL))
-		cg3_do_default_mode(&all->par);
-
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
-		of_iounmap(&op->resource[0],
-			   all->par.regs, sizeof(struct cg3_regs));
-		of_iounmap(&op->resource[0],
-			   all->info.screen_base, all->par.fbsize);
-		kfree(all);
-		return -ENOMEM;
-	}
-	fb_set_cmap(&all->info.cmap, &all->info);
-
-	cg3_init_fix(&all->info, linebytes, dp);
-
-	err = register_framebuffer(&all->info);
-	if (err < 0) {
-		fb_dealloc_cmap(&all->info.cmap);
-		of_iounmap(&op->resource[0],
-			   all->par.regs, sizeof(struct cg3_regs));
-		of_iounmap(&op->resource[0],
-			   all->info.screen_base, all->par.fbsize);
-		kfree(all);
-		return err;
-	}
+		cg3_do_default_mode(par);
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0))
+		goto out_unmap_screen;
+
+	fb_set_cmap(&info->cmap, info);
 
-	dev_set_drvdata(&op->dev, all);
+	cg3_init_fix(info, linebytes, dp);
+
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_dealloc_cmap;
+
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: cg3 at %lx:%lx\n",
-	       dp->full_name, all->par.which_io, all->par.physbase);
+	       dp->full_name, par->which_io, par->physbase);
 
 	return 0;
-}
 
-static int __devinit cg3_probe(struct of_device *dev,
-			       const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
+out_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
+out_unmap_screen:
+	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
+
+out_unmap_regs:
+	of_iounmap(&op->resource[0], par->regs, sizeof(struct cg3_regs));
+
+out_release_fb:
+	framebuffer_release(info);
 
-	return cg3_init_one(op);
+out_err:
+	return err;
 }
 
 static int __devexit cg3_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct cg3_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
-	fb_dealloc_cmap(&all->info.cmap);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 
-	of_iounmap(&op->resource[0], all->par.regs, sizeof(struct cg3_regs));
-	of_iounmap(&op->resource[0], all->info.screen_base, all->par.fbsize);
+	of_iounmap(&op->resource[0], par->regs, sizeof(struct cg3_regs));
+	of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 4dad23a..87c7471 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -653,135 +653,120 @@ static void cg6_chip_init(struct fb_info *info)
 	sbus_writel(info->var.yres - 1, &fbc->clipmaxy);
 }
 
-struct all_info {
-	struct fb_info info;
-	struct cg6_par par;
-};
-
-static void cg6_unmap_regs(struct of_device *op, struct all_info *all)
+static void cg6_unmap_regs(struct of_device *op, struct fb_info *info,
+			   struct cg6_par *par)
 {
-	if (all->par.fbc)
-		of_iounmap(&op->resource[0], all->par.fbc, 4096);
-	if (all->par.tec)
-		of_iounmap(&op->resource[0],
-			   all->par.tec, sizeof(struct cg6_tec));
-	if (all->par.thc)
-		of_iounmap(&op->resource[0],
-			   all->par.thc, sizeof(struct cg6_thc));
-	if (all->par.bt)
-		of_iounmap(&op->resource[0],
-			   all->par.bt, sizeof(struct bt_regs));
-	if (all->par.fhc)
-		of_iounmap(&op->resource[0],
-			   all->par.fhc, sizeof(u32));
-
-	if (all->info.screen_base)
-		of_iounmap(&op->resource[0],
-			   all->info.screen_base, all->par.fbsize);
+	if (par->fbc)
+		of_iounmap(&op->resource[0], par->fbc, 4096);
+	if (par->tec)
+		of_iounmap(&op->resource[0], par->tec, sizeof(struct cg6_tec));
+	if (par->thc)
+		of_iounmap(&op->resource[0], par->thc, sizeof(struct cg6_thc));
+	if (par->bt)
+		of_iounmap(&op->resource[0], par->bt, sizeof(struct bt_regs));
+	if (par->fhc)
+		of_iounmap(&op->resource[0], par->fhc, sizeof(u32));
+
+	if (info->screen_base)
+		of_iounmap(&op->resource[0], info->screen_base, par->fbsize);
 }
 
-static int __devinit cg6_init_one(struct of_device *op)
+static int __devinit cg6_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
-	struct all_info *all;
+	struct fb_info *info;
+	struct cg6_par *par;
 	int linebytes, err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct cg6_par), &op->dev);
+
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
+	par = info->par;
 
-	spin_lock_init(&all->par.lock);
+	spin_lock_init(&par->lock);
 
-	all->par.physbase = op->resource[0].start;
-	all->par.which_io = op->resource[0].flags & IORESOURCE_BITS;
+	par->physbase = op->resource[0].start;
+	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
-	sbusfb_fill_var(&all->info.var, dp->node, 8);
-	all->info.var.red.length = 8;
-	all->info.var.green.length = 8;
-	all->info.var.blue.length = 8;
+	sbusfb_fill_var(&info->var, dp->node, 8);
+	info->var.red.length = 8;
+	info->var.green.length = 8;
+	info->var.blue.length = 8;
 
 	linebytes = of_getintprop_default(dp, "linebytes",
-					  all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+					  info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 	if (of_find_property(dp, "dblbuf", NULL))
-		all->par.fbsize *= 4;
+		par->fbsize *= 4;
 
-	all->par.fbc = of_ioremap(&op->resource[0], CG6_FBC_OFFSET,
+	par->fbc = of_ioremap(&op->resource[0], CG6_FBC_OFFSET,
 				  4096, "cgsix fbc");
-	all->par.tec = of_ioremap(&op->resource[0], CG6_TEC_OFFSET,
+	par->tec = of_ioremap(&op->resource[0], CG6_TEC_OFFSET,
 				  sizeof(struct cg6_tec), "cgsix tec");
-	all->par.thc = of_ioremap(&op->resource[0], CG6_THC_OFFSET,
+	par->thc = of_ioremap(&op->resource[0], CG6_THC_OFFSET,
 				  sizeof(struct cg6_thc), "cgsix thc");
-	all->par.bt = of_ioremap(&op->resource[0], CG6_BROOKTREE_OFFSET,
+	par->bt = of_ioremap(&op->resource[0], CG6_BROOKTREE_OFFSET,
 				 sizeof(struct bt_regs), "cgsix dac");
-	all->par.fhc = of_ioremap(&op->resource[0], CG6_FHC_OFFSET,
+	par->fhc = of_ioremap(&op->resource[0], CG6_FHC_OFFSET,
 				  sizeof(u32), "cgsix fhc");
 
-	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_IMAGEBLIT |
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_IMAGEBLIT |
                           FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
-	all->info.fbops = &cg6_ops;
-
-	all->info.screen_base =  of_ioremap(&op->resource[0], CG6_RAM_OFFSET,
-					    all->par.fbsize, "cgsix ram");
-	if (!all->par.fbc || !all->par.tec || !all->par.thc ||
-	    !all->par.bt || !all->par.fhc || !all->info.screen_base) {
-		cg6_unmap_regs(op, all);
-		kfree(all);
-		return -ENOMEM;
-	}
+	info->fbops = &cg6_ops;
 
-	all->info.par = &all->par;
+	info->screen_base =  of_ioremap(&op->resource[0], CG6_RAM_OFFSET,
+					    par->fbsize, "cgsix ram");
+	if (!par->fbc || !par->tec || !par->thc ||
+	    !par->bt || !par->fhc || !info->screen_base)
+		goto out_unmap_regs;
 
-	all->info.var.accel_flags = FB_ACCELF_TEXT;
+	info->var.accel_flags = FB_ACCELF_TEXT;
 
-	cg6_bt_init(&all->par);
-	cg6_chip_init(&all->info);
-	cg6_blank(0, &all->info);
+	cg6_bt_init(par);
+	cg6_chip_init(info);
+	cg6_blank(0, info);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
-		cg6_unmap_regs(op, all);
-		kfree(all);
-		return -ENOMEM;
-	}
+	if (fb_alloc_cmap(&info->cmap, 256, 0))
+		goto out_unmap_regs;
 
-	fb_set_cmap(&all->info.cmap, &all->info);
-	cg6_init_fix(&all->info, linebytes);
+	fb_set_cmap(&info->cmap, info);
+	cg6_init_fix(info, linebytes);
 
-	err = register_framebuffer(&all->info);
-	if (err < 0) {
-		cg6_unmap_regs(op, all);
-		fb_dealloc_cmap(&all->info.cmap);
-		kfree(all);
-		return err;
-	}
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_dealloc_cmap;
 
-	dev_set_drvdata(&op->dev, all);
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: CGsix [%s] at %lx:%lx\n",
-	       dp->full_name,
-	       all->info.fix.id,
-	       all->par.which_io, all->par.physbase);
+	       dp->full_name, info->fix.id,
+	       par->which_io, par->physbase);
 
 	return 0;
-}
 
-static int __devinit cg6_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
+out_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
+out_unmap_regs:
+	cg6_unmap_regs(op, info, par);
 
-	return cg6_init_one(op);
+out_err:
+	return err;
 }
 
 static int __devexit cg6_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct cg6_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
-	fb_dealloc_cmap(&all->info.cmap);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 
-	cg6_unmap_regs(op, all);
+	cg6_unmap_regs(op, info, par);
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 3f6c98f..4b520b5 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -371,6 +371,8 @@ struct ffb_par {
 	unsigned long		fbsize;
 
 	int			board_type;
+
+	u32			pseudo_palette[16];
 };
 
 static void FFBFifo(struct ffb_par *par, int n)
@@ -900,75 +902,67 @@ ffb_init_fix(struct fb_info *info)
 	info->fix.accel = FB_ACCEL_SUN_CREATOR;
 }
 
-struct all_info {
-	struct fb_info info;
-	struct ffb_par par;
-	u32 pseudo_palette[16];
-};
-
-static int ffb_init_one(struct of_device *op)
+static int __devinit ffb_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
 	struct ffb_fbc __iomem *fbc;
 	struct ffb_dac __iomem *dac;
-	struct all_info *all;
-	int err;
+	struct fb_info *info;
+	struct ffb_par *par;
 	u32 dac_pnum, dac_rev, dac_mrev;
+	int err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct ffb_par), &op->dev);
 
-	spin_lock_init(&all->par.lock);
-	all->par.fbc = of_ioremap(&op->resource[2], 0,
-				  sizeof(struct ffb_fbc), "ffb fbc");
-	if (!all->par.fbc) {
-		kfree(all);
-		return -ENOMEM;
-	}
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
 
-	all->par.dac = of_ioremap(&op->resource[1], 0,
-				  sizeof(struct ffb_dac), "ffb dac");
-	if (!all->par.dac) {
-		of_iounmap(&op->resource[2],
-			   all->par.fbc, sizeof(struct ffb_fbc));
-		kfree(all);
-		return -ENOMEM;
-	}
+	par = info->par;
+
+	spin_lock_init(&par->lock);
+	par->fbc = of_ioremap(&op->resource[2], 0,
+			      sizeof(struct ffb_fbc), "ffb fbc");
+	if (!par->fbc)
+		goto out_release_fb;
+
+	par->dac = of_ioremap(&op->resource[1], 0,
+			      sizeof(struct ffb_dac), "ffb dac");
+	if (!par->dac)
+		goto out_unmap_fbc;
 
-	all->par.rop_cache = FFB_ROP_NEW;
-	all->par.physbase = op->resource[0].start;
+	par->rop_cache = FFB_ROP_NEW;
+	par->physbase = op->resource[0].start;
 
 	/* Don't mention copyarea, so SCROLL_REDRAW is always
 	 * used.  It is the fastest on this chip.
 	 */
-	all->info.flags = (FBINFO_DEFAULT |
-			   /* FBINFO_HWACCEL_COPYAREA | */
-			   FBINFO_HWACCEL_FILLRECT |
-			   FBINFO_HWACCEL_IMAGEBLIT);
-	all->info.fbops = &ffb_ops;
-	all->info.screen_base = (char *) all->par.physbase + FFB_DFB24_POFF;
-	all->info.par = &all->par;
-	all->info.pseudo_palette = all->pseudo_palette;
-
-	sbusfb_fill_var(&all->info.var, dp->node, 32);
-	all->par.fbsize = PAGE_ALIGN(all->info.var.xres *
-				     all->info.var.yres *
-				     4);
-	ffb_fixup_var_rgb(&all->info.var);
-
-	all->info.var.accel_flags = FB_ACCELF_TEXT;
+	info->flags = (FBINFO_DEFAULT |
+		       /* FBINFO_HWACCEL_COPYAREA | */
+		       FBINFO_HWACCEL_FILLRECT |
+		       FBINFO_HWACCEL_IMAGEBLIT);
+
+	info->fbops = &ffb_ops;
+
+	info->screen_base = (char *) par->physbase + FFB_DFB24_POFF;
+	info->pseudo_palette = par->pseudo_palette;
+
+	sbusfb_fill_var(&info->var, dp->node, 32);
+	par->fbsize = PAGE_ALIGN(info->var.xres * info->var.yres * 4);
+	ffb_fixup_var_rgb(&info->var);
+
+	info->var.accel_flags = FB_ACCELF_TEXT;
 
 	if (!strcmp(dp->name, "SUNW,afb"))
-		all->par.flags |= FFB_FLAG_AFB;
+		par->flags |= FFB_FLAG_AFB;
 
-	all->par.board_type = of_getintprop_default(dp, "board_type", 0);
+	par->board_type = of_getintprop_default(dp, "board_type", 0);
 
-	fbc = all->par.fbc;
+	fbc = par->fbc;
 	if ((upa_readl(&fbc->ucsr) & FFB_UCSR_ALL_ERRORS) != 0)
 		upa_writel(FFB_UCSR_ALL_ERRORS, &fbc->ucsr);
 
-	dac = all->par.dac;
+	dac = par->dac;
 	upa_writel(FFB_DAC_DID, &dac->type);
 	dac_pnum = upa_readl(&dac->value);
 	dac_rev = (dac_pnum & FFB_DAC_DID_REV) >> FFB_DAC_DID_REV_SHIFT;
@@ -985,76 +979,70 @@ static int ffb_init_one(struct of_device *op)
 	 * cursor logic.  We identify Pacifica 1 as not Pacifica 2, the
 	 * latter having a part number value of 0x236e.
 	 */
-	if ((all->par.flags & FFB_FLAG_AFB) || dac_pnum = 0x236e) {
-		all->par.flags &= ~FFB_FLAG_INVCURSOR;
+	if ((par->flags & FFB_FLAG_AFB) || dac_pnum = 0x236e) {
+		par->flags &= ~FFB_FLAG_INVCURSOR;
 	} else {
 		if (dac_mrev < 3)
-			all->par.flags |= FFB_FLAG_INVCURSOR;
+			par->flags |= FFB_FLAG_INVCURSOR;
 	}
 
-	ffb_switch_from_graph(&all->par);
+	ffb_switch_from_graph(par);
 
 	/* Unblank it just to be sure.  When there are multiple
 	 * FFB/AFB cards in the system, or it is not the OBP
 	 * chosen console, it will have video outputs off in
 	 * the DAC.
 	 */
-	ffb_blank(0, &all->info);
-
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
-		printk(KERN_ERR "ffb: Could not allocate color map.\n");
-		of_iounmap(&op->resource[2],
-			   all->par.fbc, sizeof(struct ffb_fbc));
-		of_iounmap(&op->resource[1],
-			   all->par.dac, sizeof(struct ffb_dac));
-		kfree(all);
-		return -ENOMEM;
-	}
+	ffb_blank(0, info);
 
-	ffb_init_fix(&all->info);
-
-	err = register_framebuffer(&all->info);
-	if (err < 0) {
-		printk(KERN_ERR "ffb: Could not register framebuffer.\n");
-		fb_dealloc_cmap(&all->info.cmap);
-		of_iounmap(&op->resource[2],
-			   all->par.fbc, sizeof(struct ffb_fbc));
-		of_iounmap(&op->resource[1],
-			   all->par.dac, sizeof(struct ffb_dac));
-		kfree(all);
-		return err;
-	}
+	if (fb_alloc_cmap(&info->cmap, 256, 0))
+		goto out_unmap_dac;
+
+	ffb_init_fix(info);
 
-	dev_set_drvdata(&op->dev, all);
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_dealloc_cmap;
+
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: %s at %016lx, type %d, "
 	       "DAC pnum[%x] rev[%d] manuf_rev[%d]\n",
 	       dp->full_name,
-	       ((all->par.flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
-	       all->par.physbase, all->par.board_type,
+	       ((par->flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
+	       par->physbase, par->board_type,
 	       dac_pnum, dac_rev, dac_mrev);
 
 	return 0;
-}
 
-static int __devinit ffb_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
+out_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
+out_unmap_dac:
+	of_iounmap(&op->resource[2], par->fbc, sizeof(struct ffb_fbc));
+
+out_unmap_fbc:
+	of_iounmap(&op->resource[2], par->fbc, sizeof(struct ffb_fbc));
+
+out_release_fb:
+	framebuffer_release(info);
 
-	return ffb_init_one(op);
+out_err:
+	return err;
 }
 
 static int __devexit ffb_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct ffb_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
-	fb_dealloc_cmap(&all->info.cmap);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 
-	of_iounmap(&op->resource[2], all->par.fbc, sizeof(struct ffb_fbc));
-	of_iounmap(&op->resource[1], all->par.dac, sizeof(struct ffb_dac));
+	of_iounmap(&op->resource[2], par->fbc, sizeof(struct ffb_fbc));
+	of_iounmap(&op->resource[1], par->dac, sizeof(struct ffb_dac));
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
index a038aa5..e3669b6 100644
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -525,130 +525,123 @@ static void leo_fixup_var_rgb(struct fb_var_screeninfo *var)
 	var->transp.length = 0;
 }
 
-struct all_info {
-	struct fb_info info;
-	struct leo_par par;
-};
-
-static void leo_unmap_regs(struct of_device *op, struct all_info *all)
+static void leo_unmap_regs(struct of_device *op, struct fb_info *info,
+			   struct leo_par *par)
 {
-	if (all->par.lc_ss0_usr)
-		of_iounmap(&op->resource[0], all->par.lc_ss0_usr, 0x1000);
-	if (all->par.ld_ss0)
-		of_iounmap(&op->resource[0], all->par.ld_ss0, 0x1000);
-	if (all->par.ld_ss1)
-		of_iounmap(&op->resource[0], all->par.ld_ss1, 0x1000);
-	if (all->par.lx_krn)
-		of_iounmap(&op->resource[0], all->par.lx_krn, 0x1000);
-	if (all->par.cursor)
+	if (par->lc_ss0_usr)
+		of_iounmap(&op->resource[0], par->lc_ss0_usr, 0x1000);
+	if (par->ld_ss0)
+		of_iounmap(&op->resource[0], par->ld_ss0, 0x1000);
+	if (par->ld_ss1)
+		of_iounmap(&op->resource[0], par->ld_ss1, 0x1000);
+	if (par->lx_krn)
+		of_iounmap(&op->resource[0], par->lx_krn, 0x1000);
+	if (par->cursor)
 		of_iounmap(&op->resource[0],
-			   all->par.cursor, sizeof(struct leo_cursor));
-	if (all->info.screen_base)
-		of_iounmap(&op->resource[0], all->info.screen_base, 0x800000);
+			   par->cursor, sizeof(struct leo_cursor));
+	if (info->screen_base)
+		of_iounmap(&op->resource[0], info->screen_base, 0x800000);
 }
 
-static int __devinit leo_init_one(struct of_device *op)
+static int __devinit leo_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
-	struct all_info *all;
+	struct fb_info *info;
+	struct leo_par *par;
 	int linebytes, err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct leo_par), &op->dev);
+
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
+	par = info->par;
 
-	spin_lock_init(&all->par.lock);
+	spin_lock_init(&par->lock);
 
-	all->par.physbase = op->resource[0].start;
-	all->par.which_io = op->resource[0].flags & IORESOURCE_BITS;
+	par->physbase = op->resource[0].start;
+	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
-	sbusfb_fill_var(&all->info.var, dp->node, 32);
-	leo_fixup_var_rgb(&all->info.var);
+	sbusfb_fill_var(&info->var, dp->node, 32);
+	leo_fixup_var_rgb(&info->var);
 
 	linebytes = of_getintprop_default(dp, "linebytes",
-					  all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+					  info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->par.lc_ss0_usr +	par->lc_ss0_usr  		of_ioremap(&op->resource[0], LEO_OFF_LC_SS0_USR,
 			   0x1000, "leolc ss0usr");
-	all->par.ld_ss0 +	par->ld_ss0  		of_ioremap(&op->resource[0], LEO_OFF_LD_SS0,
 			   0x1000, "leold ss0");
-	all->par.ld_ss1 +	par->ld_ss1  		of_ioremap(&op->resource[0], LEO_OFF_LD_SS1,
 			   0x1000, "leold ss1");
-	all->par.lx_krn +	par->lx_krn  		of_ioremap(&op->resource[0], LEO_OFF_LX_KRN,
 			   0x1000, "leolx krn");
-	all->par.cursor +	par->cursor  		of_ioremap(&op->resource[0], LEO_OFF_LX_CURSOR,
 			   sizeof(struct leo_cursor), "leolx cursor");
-	all->info.screen_base = 
+	info->screen_base = 
 		of_ioremap(&op->resource[0], LEO_OFF_SS0,
 			   0x800000, "leo ram");
-	if (!all->par.lc_ss0_usr ||
-	    !all->par.ld_ss0 ||
-	    !all->par.ld_ss1 ||
-	    !all->par.lx_krn ||
-	    !all->par.cursor ||
-	    !all->info.screen_base) {
-		leo_unmap_regs(op, all);
-		kfree(all);
-		return -ENOMEM;
-	}
+	if (!par->lc_ss0_usr ||
+	    !par->ld_ss0 ||
+	    !par->ld_ss1 ||
+	    !par->lx_krn ||
+	    !par->cursor ||
+	    !info->screen_base)
+		goto out_unmap_regs;
 
-	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
-	all->info.fbops = &leo_ops;
-	all->info.par = &all->par;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->fbops = &leo_ops;
 
-	leo_init_wids(&all->info);
-	leo_init_hw(&all->info);
+	leo_init_wids(info);
+	leo_init_hw(info);
 
-	leo_blank(0, &all->info);
+	leo_blank(0, info);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
-		leo_unmap_regs(op, all);
-		kfree(all);
-		return -ENOMEM;;
-	}
+	if (fb_alloc_cmap(&info->cmap, 256, 0))
+		goto out_unmap_regs;
 
-	leo_init_fix(&all->info, dp);
+	leo_init_fix(info, dp);
 
-	err = register_framebuffer(&all->info);
-	if (err < 0) {
-		fb_dealloc_cmap(&all->info.cmap);
-		leo_unmap_regs(op, all);
-		kfree(all);
-		return err;
-	}
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_dealloc_cmap;
 
-	dev_set_drvdata(&op->dev, all);
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: leo at %lx:%lx\n",
 	       dp->full_name,
-	       all->par.which_io, all->par.physbase);
+	       par->which_io, par->physbase);
 
 	return 0;
-}
 
-static int __devinit leo_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
+out_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
+out_unmap_regs:
+	leo_unmap_regs(op, info, par);
+	framebuffer_release(info);
 
-	return leo_init_one(op);
+out_err:
+	return err;
 }
 
 static int __devexit leo_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct leo_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
-	fb_dealloc_cmap(&all->info.cmap);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 
-	leo_unmap_regs(op, all);
+	leo_unmap_regs(op, info, par);
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
index 637b78b..5849606 100644
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -255,107 +255,95 @@ static void p9100_init_fix(struct fb_info *info, int linebytes, struct device_no
 	info->fix.accel = FB_ACCEL_SUN_CGTHREE;
 }
 
-struct all_info {
-	struct fb_info info;
-	struct p9100_par par;
-};
-
-static int __devinit p9100_init_one(struct of_device *op)
+static int __devinit p9100_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
-	struct all_info *all;
+	struct fb_info *info;
+	struct p9100_par *par;
 	int linebytes, err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct p9100_par), &op->dev);
+
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
+	par = info->par;
 
-	spin_lock_init(&all->par.lock);
+	spin_lock_init(&par->lock);
 
 	/* This is the framebuffer and the only resource apps can mmap.  */
-	all->par.physbase = op->resource[2].start;
-	all->par.which_io = op->resource[2].flags & IORESOURCE_BITS;
-
-	sbusfb_fill_var(&all->info.var, dp->node, 8);
-	all->info.var.red.length = 8;
-	all->info.var.green.length = 8;
-	all->info.var.blue.length = 8;
-
-	linebytes = of_getintprop_default(dp, "linebytes",
-					  all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
-
-	all->par.regs = of_ioremap(&op->resource[0], 0,
-				   sizeof(struct p9100_regs), "p9100 regs");
-	if (!all->par.regs) {
-		kfree(all);
-		return -ENOMEM;
-	}
+	par->physbase = op->resource[2].start;
+	par->which_io = op->resource[2].flags & IORESOURCE_BITS;
 
-	all->info.flags = FBINFO_DEFAULT;
-	all->info.fbops = &p9100_ops;
-	all->info.screen_base = of_ioremap(&op->resource[2], 0,
-					   all->par.fbsize, "p9100 ram");
-	if (!all->info.screen_base) {
-		of_iounmap(&op->resource[0],
-			   all->par.regs, sizeof(struct p9100_regs));
-		kfree(all);
-		return -ENOMEM;
-	}
-	all->info.par = &all->par;
+	sbusfb_fill_var(&info->var, dp->node, 8);
+	info->var.red.length = 8;
+	info->var.green.length = 8;
+	info->var.blue.length = 8;
 
-	p9100_blank(0, &all->info);
+	linebytes = of_getintprop_default(dp, "linebytes", info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
-		of_iounmap(&op->resource[0],
-			   all->par.regs, sizeof(struct p9100_regs));
-		of_iounmap(&op->resource[2],
-			   all->info.screen_base, all->par.fbsize);
-		kfree(all);
-		return -ENOMEM;
-	}
+	par->regs = of_ioremap(&op->resource[0], 0,
+			       sizeof(struct p9100_regs), "p9100 regs");
+	if (!par->regs)
+		goto out_release_fb;
 
-	p9100_init_fix(&all->info, linebytes, dp);
-
-	err = register_framebuffer(&all->info);
-	if (err < 0) {
-		fb_dealloc_cmap(&all->info.cmap);
-		of_iounmap(&op->resource[0],
-			   all->par.regs, sizeof(struct p9100_regs));
-		of_iounmap(&op->resource[2],
-			   all->info.screen_base, all->par.fbsize);
-		kfree(all);
-		return err;
-	}
-	fb_set_cmap(&all->info.cmap, &all->info);
+	info->flags = FBINFO_DEFAULT;
+	info->fbops = &p9100_ops;
+	info->screen_base = of_ioremap(&op->resource[2], 0,
+				       par->fbsize, "p9100 ram");
+	if (!info->screen_base)
+		goto out_unmap_regs;
+
+	p9100_blank(0, info);
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0))
+		goto out_unmap_screen;
 
-	dev_set_drvdata(&op->dev, all);
+	p9100_init_fix(info, linebytes, dp);
+
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_dealloc_cmap;
+
+	fb_set_cmap(&info->cmap, info);
+
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: p9100 at %lx:%lx\n",
 	       dp->full_name,
-	       all->par.which_io, all->par.physbase);
+	       par->which_io, par->physbase);
 
 	return 0;
-}
 
-static int __devinit p9100_probe(struct of_device *dev, const struct of_device_id *match)
-{
-	struct of_device *op = to_of_device(&dev->dev);
+out_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
+out_unmap_screen:
+	of_iounmap(&op->resource[2], info->screen_base, par->fbsize);
+
+out_unmap_regs:
+	of_iounmap(&op->resource[0], par->regs, sizeof(struct p9100_regs));
+
+out_release_fb:
+	framebuffer_release(info);
 
-	return p9100_init_one(op);
+out_err:
+	return err;
 }
 
 static int __devexit p9100_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct p9100_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
-	fb_dealloc_cmap(&all->info.cmap);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 
-	of_iounmap(&op->resource[0], all->par.regs, sizeof(struct p9100_regs));
-	of_iounmap(&op->resource[2], all->info.screen_base, all->par.fbsize);
+	of_iounmap(&op->resource[0], par->regs, sizeof(struct p9100_regs));
+	of_iounmap(&op->resource[2], info->screen_base, par->fbsize);
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index 5a99669..e5a9ddb 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -345,88 +345,82 @@ tcx_init_fix(struct fb_info *info, int linebytes)
 	info->fix.accel = FB_ACCEL_SUN_TCX;
 }
 
-struct all_info {
-	struct fb_info info;
-	struct tcx_par par;
-};
-
-static void tcx_unmap_regs(struct of_device *op, struct all_info *all)
+static void tcx_unmap_regs(struct of_device *op, struct fb_info *info,
+			   struct tcx_par *par)
 {
-	if (all->par.tec)
+	if (par->tec)
 		of_iounmap(&op->resource[7],
-			   all->par.tec, sizeof(struct tcx_tec));
-	if (all->par.thc)
+			   par->tec, sizeof(struct tcx_tec));
+	if (par->thc)
 		of_iounmap(&op->resource[9],
-			   all->par.thc, sizeof(struct tcx_thc));
-	if (all->par.bt)
+			   par->thc, sizeof(struct tcx_thc));
+	if (par->bt)
 		of_iounmap(&op->resource[8],
-			   all->par.bt, sizeof(struct bt_regs));
-	if (all->par.cplane)
+			   par->bt, sizeof(struct bt_regs));
+	if (par->cplane)
 		of_iounmap(&op->resource[4],
-			   all->par.cplane, all->par.fbsize * sizeof(u32));
-	if (all->info.screen_base)
+			   par->cplane, par->fbsize * sizeof(u32));
+	if (info->screen_base)
 		of_iounmap(&op->resource[0],
-			   all->info.screen_base, all->par.fbsize);
+			   info->screen_base, par->fbsize);
 }
 
 static int __devinit tcx_init_one(struct of_device *op)
 {
 	struct device_node *dp = op->node;
-	struct all_info *all;
+	struct fb_info *info;
+	struct tcx_par *par;
 	int linebytes, i, err;
 
-	all = kzalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
-		return -ENOMEM;
+	info = framebuffer_alloc(sizeof(struct tcx_par), &op->dev);
 
-	spin_lock_init(&all->par.lock);
+	err = -ENOMEM;
+	if (!info)
+		goto out_err;
+	par = info->par;
 
-	all->par.lowdepth +	spin_lock_init(&par->lock);
+
+	par->lowdepth  		(of_find_property(dp, "tcx-8-bit", NULL) != NULL);
 
-	sbusfb_fill_var(&all->info.var, dp->node, 8);
-	all->info.var.red.length = 8;
-	all->info.var.green.length = 8;
-	all->info.var.blue.length = 8;
+	sbusfb_fill_var(&info->var, dp->node, 8);
+	info->var.red.length = 8;
+	info->var.green.length = 8;
+	info->var.blue.length = 8;
 
 	linebytes = of_getintprop_default(dp, "linebytes",
-					  all->info.var.xres);
-	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);
+					  info->var.xres);
+	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
 
-	all->par.tec = of_ioremap(&op->resource[7], 0,
+	par->tec = of_ioremap(&op->resource[7], 0,
 				  sizeof(struct tcx_tec), "tcx tec");
-	all->par.thc = of_ioremap(&op->resource[9], 0,
+	par->thc = of_ioremap(&op->resource[9], 0,
 				  sizeof(struct tcx_thc), "tcx thc");
-	all->par.bt = of_ioremap(&op->resource[8], 0,
+	par->bt = of_ioremap(&op->resource[8], 0,
 				 sizeof(struct bt_regs), "tcx dac");
-	all->info.screen_base = of_ioremap(&op->resource[0], 0,
-					   all->par.fbsize, "tcx ram");
-	if (!all->par.tec || !all->par.thc ||
-	    !all->par.bt || !all->info.screen_base) {
-		tcx_unmap_regs(op, all);
-		kfree(all);
-		return -ENOMEM;
-	}
-
-	memcpy(&all->par.mmap_map, &__tcx_mmap_map, sizeof(all->par.mmap_map));
-	if (!all->par.lowdepth) {
-		all->par.cplane = of_ioremap(&op->resource[4], 0,
-					     all->par.fbsize * sizeof(u32),
+	info->screen_base = of_ioremap(&op->resource[0], 0,
+					   par->fbsize, "tcx ram");
+	if (!par->tec || !par->thc ||
+	    !par->bt || !info->screen_base)
+		goto out_unmap_regs;
+
+	memcpy(&par->mmap_map, &__tcx_mmap_map, sizeof(par->mmap_map));
+	if (!par->lowdepth) {
+		par->cplane = of_ioremap(&op->resource[4], 0,
+					     par->fbsize * sizeof(u32),
 					     "tcx cplane");
-		if (!all->par.cplane) {
-			tcx_unmap_regs(op, all);
-			kfree(all);
-			return -ENOMEM;
-		}
+		if (!par->cplane)
+			goto out_unmap_regs;
 	} else {
-		all->par.mmap_map[1].size = SBUS_MMAP_EMPTY;
-		all->par.mmap_map[4].size = SBUS_MMAP_EMPTY;
-		all->par.mmap_map[5].size = SBUS_MMAP_EMPTY;
-		all->par.mmap_map[6].size = SBUS_MMAP_EMPTY;
+		par->mmap_map[1].size = SBUS_MMAP_EMPTY;
+		par->mmap_map[4].size = SBUS_MMAP_EMPTY;
+		par->mmap_map[5].size = SBUS_MMAP_EMPTY;
+		par->mmap_map[6].size = SBUS_MMAP_EMPTY;
 	}
 
-	all->par.physbase = 0;
-	all->par.which_io = op->resource[0].flags & IORESOURCE_BITS;
+	par->physbase = 0;
+	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
 	for (i = 0; i < TCX_MMAP_ENTRIES; i++) {
 		int j;
@@ -444,53 +438,54 @@ static int __devinit tcx_init_one(struct of_device *op)
 			j = i;
 			break;
 		};
-		all->par.mmap_map[i].poff = op->resource[j].start;
+		par->mmap_map[i].poff = op->resource[j].start;
 	}
 
-	all->info.flags = FBINFO_DEFAULT;
-	all->info.fbops = &tcx_ops;
-	all->info.par = &all->par;
+	info->flags = FBINFO_DEFAULT;
+	info->fbops = &tcx_ops;
 
 	/* Initialize brooktree DAC. */
-	sbus_writel(0x04 << 24, &all->par.bt->addr);         /* color planes */
-	sbus_writel(0xff << 24, &all->par.bt->control);
-	sbus_writel(0x05 << 24, &all->par.bt->addr);
-	sbus_writel(0x00 << 24, &all->par.bt->control);
-	sbus_writel(0x06 << 24, &all->par.bt->addr);         /* overlay plane */
-	sbus_writel(0x73 << 24, &all->par.bt->control);
-	sbus_writel(0x07 << 24, &all->par.bt->addr);
-	sbus_writel(0x00 << 24, &all->par.bt->control);
-
-	tcx_reset(&all->info);
-
-	tcx_blank(FB_BLANK_UNBLANK, &all->info);
-
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
-		tcx_unmap_regs(op, all);
-		kfree(all);
-		return -ENOMEM;
-	}
+	sbus_writel(0x04 << 24, &par->bt->addr);         /* color planes */
+	sbus_writel(0xff << 24, &par->bt->control);
+	sbus_writel(0x05 << 24, &par->bt->addr);
+	sbus_writel(0x00 << 24, &par->bt->control);
+	sbus_writel(0x06 << 24, &par->bt->addr);         /* overlay plane */
+	sbus_writel(0x73 << 24, &par->bt->control);
+	sbus_writel(0x07 << 24, &par->bt->addr);
+	sbus_writel(0x00 << 24, &par->bt->control);
+
+	tcx_reset(info);
 
-	fb_set_cmap(&all->info.cmap, &all->info);
-	tcx_init_fix(&all->info, linebytes);
+	tcx_blank(FB_BLANK_UNBLANK, info);
 
-	err = register_framebuffer(&all->info);
-	if (err < 0) {
-		fb_dealloc_cmap(&all->info.cmap);
-		tcx_unmap_regs(op, all);
-		kfree(all);
-		return err;
-	}
+	if (fb_alloc_cmap(&info->cmap, 256, 0))
+		goto out_unmap_regs;
+
+	fb_set_cmap(&info->cmap, info);
+	tcx_init_fix(info, linebytes);
+
+	err = register_framebuffer(info);
+	if (err < 0)
+		goto out_dealloc_cmap;
 
-	dev_set_drvdata(&op->dev, all);
+	dev_set_drvdata(&op->dev, info);
 
 	printk("%s: TCX at %lx:%lx, %s\n",
 	       dp->full_name,
-	       all->par.which_io,
+	       par->which_io,
 	       op->resource[0].start,
-	       all->par.lowdepth ? "8-bit only" : "24-bit depth");
+	       par->lowdepth ? "8-bit only" : "24-bit depth");
 
 	return 0;
+
+out_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
+out_unmap_regs:
+	tcx_unmap_regs(op, info, par);
+
+out_err:
+	return err;
 }
 
 static int __devinit tcx_probe(struct of_device *dev, const struct of_device_id *match)
@@ -502,14 +497,15 @@ static int __devinit tcx_probe(struct of_device *dev, const struct of_device_id
 
 static int __devexit tcx_remove(struct of_device *op)
 {
-	struct all_info *all = dev_get_drvdata(&op->dev);
+	struct fb_info *info = dev_get_drvdata(&op->dev);
+	struct tcx_par *par = info->par;
 
-	unregister_framebuffer(&all->info);
-	fb_dealloc_cmap(&all->info.cmap);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 
-	tcx_unmap_regs(op, all);
+	tcx_unmap_regs(op, info, par);
 
-	kfree(all);
+	framebuffer_release(info);
 
 	dev_set_drvdata(&op->dev, NULL);
 
