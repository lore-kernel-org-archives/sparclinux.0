From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2008 08:05:23 +0000
Subject: Re: [BUG] 2.6.26-rc1 hangs during boot on UltraSPARC 5
Message-Id: <20080506.010523.113767579.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18464.3741.133714.308327@harpo.it.uu.se>
In-Reply-To: <18464.3741.133714.308327@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 6 May 2008 09:54:05 +0200

> OF stdout device is: /pci@1f,0/pci@1,1/SUNW,m64B@2
> PROM: Built device tree with 46848 bytes of memory.
> On node 0 totalpages: 32298
>   Normal zone: 335 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 31963 pages, LIFO batch:7
>   Movable zone: 0 pages used for memmap
> Booting Linux...
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 31963
> Kernel command line: ro root=/dev/sda5
> PID hash table entries: 1024 (order: 10, 8192 bytes)
> clocksource: mult[28000] shift[16]
> clockevent: mult[66666666] shift[32]
> Console: colour dummy device 80x25
> console handover: boot [earlyprom0] -> real [tty0]
> 
> *** 2.6.26-rc1 gets as far as the line above, then hangs

It's possible your machine does boot up all the way.
The video driver simply isn't registerring for whatever
reason.

Can you ping the box if you wait a minute or two after the
messages stop?

The only patch to the aty driver since 2.6.25 is the
following, below, which you can try reverting.

Another thing you can do is edit arch/sparc64/kernel/setup.c
and in the prom_early_console struct initializer, remove the
"CON_BOOT" bit from the .flags setting.  That will keep the
PROM console enabled even when another console wants to
register.  We'll get more messages that way.

commit 21b4d1db84a70175251d86078123cc27e46ff69d
Author: Roel Kluin <12o3l@tiscali.nl>
Date:   Mon Apr 28 02:15:04 2008 -0700

    video/aty/atyfb_base.c: free when fb can't be registered
    
    Free buffer when the framebuffer can't be registered
    
    Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
    Cc: "Antonino A. Daplas" <adaplas@pol.net>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 62f9c6e..e4bcf53 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2621,10 +2621,13 @@ static int __devinit aty_init(struct fb_info *info)
 #endif /* CONFIG_FB_ATY_CT */
 	info->var = var;
 
-	fb_alloc_cmap(&info->cmap, 256, 0);
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+		goto aty_init_exit;
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info) < 0) {
+		fb_dealloc_cmap(&info->cmap);
 		goto aty_init_exit;
+	}
 
 	fb_list = info;
 
