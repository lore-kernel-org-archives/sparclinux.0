From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Thu, 09 Dec 2004 21:15:31 +0000
Subject: Re: Sparc32 - SS5 - TCX-Framebuffer and RTC
Message-Id: <41B8C073.7080008@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Bob Breuer wrote:
> Georg Chini wrote:
>  > 1) TCX-Framebuffer:
> ...
>  >    b) FB-Console does not work:
>  >       When I boot the system with FB-Console I get a blank
>  >       black screen. System boots fine, only nothing is
>  >       displayed.
> 
> I had a similar problem with the cg14 framebuffer, maybe this snippet from
> the cg14 fix will help you:

Yes, this helped a lot. I get FB-console working. But I still have a
problem with X. I cannot start X in 8-Bit mode and the console
is inaccessible after starting X in 32-Bit mode. Here is what
I changed:

--- linux-2.6.10-rc3/drivers/video/tcx.c        Fri Dec  3 22:52:07 2004
+++ l10rc3/drivers/video/tcx.c  Thu Dec  9 19:22:20 2004
@@ -366,6 +366,9 @@
         all->par.lowdepth = prom_getbool(sdev->prom_node, "tcx-8-bit");

         sbusfb_fill_var(&all->info.var, sdev->prom_node, 8);
+       all->info.var.red.length = 8;
+       all->info.var.green.length = 8;
+       all->info.var.blue.length = 8;

         linebytes = prom_getintdefault(sdev->prom_node, "linebytes",
                                        all->info.var.xres);
@@ -439,6 +442,7 @@
                 return;
         }

+       fb_set_cmap(&all->info.cmap, &all->info);
         tcx_init_fix(&all->info, linebytes);

         if (register_framebuffer(&all->info) < 0) {
@@ -466,7 +470,7 @@
                 return -ENODEV;

         for_all_sbusdev(sdev, sbus) {
-               if (!strcmp(sdev->prom_name, "tcx"))
+               if (!strcmp(sdev->prom_name, "SUNW,tcx"))
                         tcx_init_one(sdev);
         }


> 
>  >
>  > 2) RTC:
> 
> Broken by a recent change in include/asm-sparc/mostek.h, need to include
> <asm/io.h> from there now.
> 

Works fine with <asm/io.h> included.

Thanks for the fast help.

Regards
        Georg Chini

