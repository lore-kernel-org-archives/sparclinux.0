From: "Antonino A. Daplas" <adaplas@hotpop.com>
Date: Wed, 16 Feb 2005 23:02:57 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502170702.58630.adaplas@hotpop.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <20050216075140.77ae3563.davem@davemloft.net> <200502162310.12703.aragorn@tiscali.nl>
In-Reply-To: <200502162310.12703.aragorn@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Frans Pop <aragorn@tiscali.nl>, "David S. Miller" <davem@davemloft.net>
Cc: adaplas@pol.net, debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thursday 17 February 2005 06:10, Frans Pop wrote:
> On Wednesday 16 February 2005 16:51, David S. Miller wrote:
> > On Wed, 16 Feb 2005 19:27:57 +0800 Antonino A. Daplas wrote:
> > > Nope, those are proposed options.  If nobody disagrees, I can easily
> > > add this for atyfb.
> >
> > Please do.
> >
> > BTW, for Sparc we may wish to inherit the CSYNC setting from
> > default_var.
>
> Sounds like a nice idea.
>
> If you have a patch that you would like to have tested, feel free to mail
> me.

Try this patch and let me know. 

video=atyfb:comp_sync:<n>,vert_sync:<n>,hor_sync:<n>

n = 0 (low), 1 (high)

Tony

diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2005-02-16 00:19:00 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2005-02-17 06:56:29 +08:00
@@ -307,6 +307,9 @@
 static int pll;
 static int mclk;
 static int xclk;
+static int comp_sync __initdata = -1;
+static int vert_sync __initdata = -1;
+static int hor_sync  __initdata = -1;
 static char *mode;
 
 #ifdef CONFIG_PPC
@@ -2527,6 +2530,27 @@
 	else
 		var.accel_flags |= FB_ACCELF_TEXT;
 
+	if (comp_sync != -1) {
+		if (!comp_sync)
+			var.sync &= ~FB_SYNC_COMP_HIGH_ACT;
+		else
+			var.sync |= FB_SYNC_COMP_HIGH_ACT;
+	}
+
+	if (vert_sync != -1) {
+		if (!vert_sync)
+			var.sync &= ~FB_SYNC_VERT_HIGH_ACT;
+		else
+			var.sync |= FB_SYNC_VERT_HIGH_ACT;
+	}
+
+	if (hor_sync != -1) {
+		if (!hor_sync)
+			var.sync &= ~FB_SYNC_HOR_HIGH_ACT;
+		else
+			var.sync |= FB_SYNC_HOR_HIGH_ACT;
+	}
+
 	if (var.yres = var.yres_virtual) {
 		u32 videoram = (info->fix.smem_len - (PAGE_SIZE << 2));
 		var.yres_virtual = ((videoram * 8) / var.bits_per_pixel) / var.xres_virtual;
@@ -3611,6 +3635,12 @@
 			mclk = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "xclk:", 5))
 			xclk = simple_strtoul(this_opt+5, NULL, 0);
+		else if (!strncmp(this_opt, "comp_sync:", 10))
+			comp_sync = simple_strtoul(this_opt+7, NULL, 0);
+		else if (!strncmp(this_opt, "vert_sync:", 10))
+			vert_sync = simple_strtoul(this_opt+7, NULL, 0);
+		else if (!strncmp(this_opt, "hor_sync:", 9))
+			hor_sync = simple_strtoul(this_opt+7, NULL, 0);
 #ifdef CONFIG_PPC
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode @@ -3701,6 +3731,12 @@
 MODULE_PARM_DESC(mclk, "int: override memory clock");
 module_param(xclk, int, 0);
 MODULE_PARM_DESC(xclk, "int: override accelerated engine clock");
+module_param(comp_sync, int, 0)
+MODULE_PARM_DESC(comp_sync, "Set composite sync signal to low (0) or high (1)");
+module_param(vert_sync, int, 0)
+MODULE_PARM_DESC(vert_sync, "Set vertical sync signal to low (0) or high (1)");
+module_param(hor_sync, int, 0)
+MODULE_PARM_DESC(hor_sync, "Set horizontal sync signal to low (0) or high (1)");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
 #ifdef CONFIG_MTRR


