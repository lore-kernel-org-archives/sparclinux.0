From: Bob Breuer <breuerr@mc.net>
Date: Wed, 10 Nov 2004 02:45:32 +0000
Subject: PATCH for cg14 framebuffer
Message-Id: <419180CC.3060708@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch fixes the cg14 framebuffer.  Fixed the initialization with
a NULL sbus_dev and also the colormap setup.  Tested with 2.6.9 and
both the linux logo and console text are displayed without problems.

Looks like the other sbus framebuffers are also missing the fb_set_cmap call.


--- linux-2.6.9/drivers/video/cg14.c.orig	2004-10-18 16:55:28.000000000 -0500
+++ linux-2.6.9/drivers/video/cg14.c	2004-11-09 01:46:15.000000000 -0600
@@ -255,6 +255,9 @@ static int cg14_setcolreg(unsigned regno
  	if (regno >= 256)
  		return 1;

+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
  	val = (red | (green << 8) | (blue << 16));

  	spin_lock_irqsave(&par->lock, flags);
@@ -322,7 +325,8 @@ static int cg14_ioctl(struct inode *inod
  			break;

  		case MDI_16_PIX:
-			cur_mode |= 0x20;
+			cur_mode |= (CG14_MCR_PIXMODE_16 <<
+				     CG14_MCR_PIXMODE_SHIFT);
  			break;

  		case MDI_8_PIX:
@@ -331,7 +335,7 @@ static int cg14_ioctl(struct inode *inod
  		default:
  			ret = -ENOSYS;
  			break;
-		};
+		}
  		if (!ret) {
  			sbus_writeb(cur_mode, &regs->mcr);
  			par->mode = mode;
@@ -341,9 +345,9 @@ static int cg14_ioctl(struct inode *inod

  	default:
  		ret = sbusfb_ioctl_helper(cmd, arg, info,
-					  FBTYPE_MDICOLOR, 24, par->fbsize);
+					  FBTYPE_MDICOLOR, 8, par->fbsize);
  		break;
-	};
+	}

  	return ret;
  }
@@ -355,11 +359,16 @@ static int cg14_ioctl(struct inode *inod
  static void cg14_init_fix(struct fb_info *info, int linebytes)
  {
  	struct cg14_par *par = (struct cg14_par *)info->par;
+	const char *name;
+
+	name = "cgfourteen";
+	if (par->sdev)
+		name = par->sdev->prom_name;

-	strlcpy(info->fix.id, par->sdev->prom_name, sizeof(info->fix.id));
+	strlcpy(info->fix.id, name, sizeof(info->fix.id));

  	info->fix.type = FB_TYPE_PACKED_PIXELS;
-	info->fix.visual = FB_VISUAL_TRUECOLOR;
+	info->fix.visual = FB_VISUAL_PSEUDOCOLOR;

  	info->fix.line_length = linebytes;

@@ -484,8 +493,11 @@ static void cg14_init_one(struct sbus_de
  	spin_lock_init(&all->par.lock);

  	sbusfb_fill_var(&all->info.var, node, 8);
+	all->info.var.red.length = 8;
+	all->info.var.green.length = 8;
+	all->info.var.blue.length = 8;

-	linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
+	linebytes = prom_getintdefault(node, "linebytes",
  				       all->info.var.xres);
  	all->par.fbsize = PAGE_ALIGN(linebytes * all->info.var.yres);

@@ -562,6 +574,7 @@ static void cg14_init_one(struct sbus_de
  		kfree(all);
  		return;
  	}
+	fb_set_cmap(&all->info.cmap, &all->info);

  	cg14_init_fix(&all->info, linebytes);

@@ -574,8 +587,8 @@ static void cg14_init_one(struct sbus_de

  	list_add(&all->list, &cg14_list);

-	printk("cg14: cgfourteen at %lx:%lx\n",
-	       all->par.physbase, all->par.iospace);
+	printk("cg14: cgfourteen at %lx:%lx, %dMB\n",
+	       all->par.iospace, all->par.physbase, all->par.ramsize >> 20);

  }

