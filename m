From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Fri, 10 Dec 2004 21:59:26 +0000
Subject: TCX framebuffer on SS5 works fine
Message-Id: <41BA1C3E.1020008@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

this is what makes it work for me. The function
fb_pan_display was missing. Hope you can use it.

Regards
        Georg Chini



--- linux-2.6.10-rc3/drivers/video/tcx.c        Fri Dec  3 22:52:07 2004
+++ l10rc3/drivers/video/tcx.c  Fri Dec 10 11:54:31 2004
@@ -36,6 +36,7 @@
  static int tcx_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
  static int tcx_ioctl(struct inode *, struct file *, unsigned int,
                      unsigned long, struct fb_info *);
+static int tcx_pan_display(struct fb_var_screeninfo *, struct fb_info *);

  /*
   *  Frame buffer operations
@@ -45,6 +46,7 @@
         .owner                  = THIS_MODULE,
         .fb_setcolreg           = tcx_setcolreg,
         .fb_blank               = tcx_blank,
+       .fb_pan_display         = tcx_pan_display,
         .fb_fillrect            = cfb_fillrect,
         .fb_copyarea            = cfb_copyarea,
         .fb_imageblit           = cfb_imageblit,
@@ -153,6 +155,12 @@
         spin_unlock_irqrestore(&par->lock, flags);
  }

+static int tcx_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+       tcx_reset(info);
+       return 0;
+}
+
  /**
   *      tcx_setcolreg - Optional function. Sets a color register.
   *      @regno: boolean, 0 copy local, 1 get_user() function
@@ -366,6 +374,9 @@
         all->par.lowdepth = prom_getbool(sdev->prom_node, "tcx-8-bit");

         sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+       all->info.var.red.length = 8;
+       all->info.var.green.length = 8;
+       all->info.var.blue.length = 8;

         linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
                                        all->info.var.xres);
@@ -439,6 +450,7 @@
                 return;
         }

+       fb_set_cmap(&all->info.cmap, &all->info);
         tcx_init_fix(&all->info, linebytes);

         if (register_framebuffer(&all->info) < 0) {
@@ -466,7 +478,7 @@
                 return -ENODEV;

         for_all_sbusdev(sdev, sbus) {
-               if (!strcmp(sdev->prom_name, "tcx"))
+               if (!strcmp(sdev->prom_name, "SUNW,tcx"))
                         tcx_init_one(sdev);
         }

