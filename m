From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Fri, 24 Dec 2004 15:30:07 +0000
Subject: Re: 2.6.10-rc3-wli-1
Message-Id: <41CC35FF.6060004@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041223063730.GY771@holomorphy.com>
In-Reply-To: <20041223063730.GY771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

here it is, could not find it in rc3-bk17 as well. It adds
the pan_display function to catch switches from graphic
mode, changes the prom_name from "tcx" to "SUNW,tcx" and
adds the lines suggested by Bob Breuer.

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


