From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 30 Jun 2017 19:06:35 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <bbf565c7-a086-6c48-6ff7-8e01d9b9d43d@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 29/06/17 23:09, Mark Cave-Ayland wrote:

> Okay. Peeking at the various other PCI drivers I see a similar pattern
> with ioremap() there too, i.e.
> 
>     addr = pci_resource_start(pdev, 0);
>     size = pci_resource_len(pdev, 0);
>     bochs->fb_map = ioremap(addr, size);
> 
> Looking at a couple of other driver examples I see in several cases that
> accesses to memory returned by ioremap() are done with
> readb/readw/readl/readq accessors which seems correct for SPARC64 in
> that the accesses would take place with the ASI_PHYS_BYPASS_EC_E_L ASI.
> 
> This definitely isn't the case with the blit routines in
> drivers/video/fbdev/core/sysimgblt.c as they reference the address
> directly via a pointer so could this be the bug? This would seem to
> agree with the documentation at
> https://01.org/linuxgraphics/gfx-docs/drm/driver-api/device-io.html.

So after a lot of digging I've finally found and have a potential fix
for the issue. The good news is that it's restricted to the bochs_drm
module.

The clue eventually came from working through the git history and coming
across this commit 68648ed1f58d98b8e8d994022e5e25331fbfe42a with the
following message:


fbdev: add drawing functions for framebuffers in system RAM

The generic drawing functions (cfbimgblt, cfbcopyarea, cfbfillrect)
assume that the framebuffer is in IO memory.  However, we have 3 drivers
(hecubafb, arcfb, and vfb) where the framebuffer is allocated from
system RAM (via vmalloc). Using _raw_read/write and family for these
drivers (as used in the cfb* functions) is illegal, especially in other
platforms.


Switching across to use the cfb family of helper functions in bochs_drm
ensures that the correct macros for IO memory access are used and is
enough to allow Linux to boot with a framebuffer here under
qemu-system-sparc64 with the bochs_drm module enabled (as per the
current debian 9 images):

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c
b/drivers/gpu/drm/bochs/bochs_fbdev.c


index 932a769..d3a75c2 100644



--- a/drivers/gpu/drm/bochs/bochs_fbdev.c



+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c



@@ -23,9 +23,9 @@ static int bochsfb_mmap(struct fb_info *info,



 static struct fb_ops bochsfb_ops = {
        .owner = THIS_MODULE,
        DRM_FB_HELPER_DEFAULT_OPS,
-       .fb_fillrect = drm_fb_helper_sys_fillrect,
-       .fb_copyarea = drm_fb_helper_sys_copyarea,
-       .fb_imageblit = drm_fb_helper_sys_imageblit,
+       .fb_fillrect = drm_fb_helper_cfb_fillrect,
+       .fb_copyarea = drm_fb_helper_cfb_copyarea,
+       .fb_imageblit = drm_fb_helper_cfb_imageblit,
        .fb_mmap = bochsfb_mmap,
 };

I'm not sure yet if the choice of functions will need to be
platform-specific, but as I'm running out of time before the weekend
I'll have to follow this up next week.


ATB,

Mark.

