From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Fri, 29 Oct 2004 00:27:51 +0000
Subject: PATCH to fix initialisation issue for GC3 (linux-2.5.64 +).
Message-Id: <Pine.LNX.4.10.10410290107100.1071-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@redhat.com, ecd@skynet.be, jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, trivial@rustcorp.com.au

Hi All,

This patch fixes an error in the blanking code for the GCThree SBUS
video card. Now I get a logo and black screen, not just a blank (no
video) screen. It is a trivual fix that has taken too long to identify as
it is such a small typing error during the rewriting of the code for
the new frame buffer system introduced in the 2.5 series kernels.

Given that it still exists in the 2.6.8.1 kernel, I assume that not many
people have tried using the latest kernel on systems with a CGThree.
  
Regards
	Mark Fortescue.
------------------------------------------------------------------------
#######################################################################
#
# Mark Fortescue <mark@mtfhpc.demon.co.uk>
#
# Patch to fix the blanking on the CG3 (SBUS) video card.
# The file (formally cgthreefb.c, now cg3.c) has a typing error that
# messes up the card initialisation when blanking is enabled/disabled.
# Given that the blanking functions are called in the initialisation
# routine, this makes the card un-usable. This patch fixes the error
# and needs to be applied to all kernels from 2.5.64 to 2.8.6.1 and
# possibly later if the CG3 is to be used sucessfully. 
#
#######################################################################
diff -rupd ref-2.6.8.1/drivers/video/cg3.c linux-2.6.8.1/drivers/video/cg3.c
--- ref-2.6.8.1/drivers/video/cg3.c	Sat Aug 14 11:55:35 2004
+++ linux-2.6.8.1/drivers/video/cg3.c	Fri Oct 29 01:03:03 2004
@@ -198,9 +204,9 @@ cg3_blank(int blank, struct fb_info *inf
 
 	switch (blank) {
 	case 0: /* Unblanking */
-		val = sbus_readl(&regs->control);
+		val = sbus_readb(&regs->control);
 		val |= CG3_CR_ENABLE_VIDEO;
-		sbus_writel(val, &regs->control);
+		sbus_writeb(val, &regs->control);
 		par->flags &= ~CG3_FLAG_BLANKED;
 		break;
 
@@ -208,11 +214,16 @@ cg3_blank(int blank, struct fb_info *inf
 	case 2: /* VESA blank (vsync off) */
 	case 3: /* VESA blank (hsync off) */
 	case 4: /* Poweroff */
-		val = sbus_readl(&regs->control);
-		val |= CG3_CR_ENABLE_VIDEO;
-		sbus_writel(val, &regs->control);
+		val = sbus_readb(&regs->control);
+		val &= ~CG3_CR_ENABLE_VIDEO;
+		sbus_writeb(val, &regs->control);
 		par->flags |= CG3_FLAG_BLANKED;
 		break;
+
+	default:
+		printk ("Invalid Blanking mode (%d), unblanking\n", blank);
+		spin_unlock_irqrestore(&par->lock, flags);
+		return 1;
 	}
 
 	spin_unlock_irqrestore(&par->lock, flags);
--------------------------------------------------------------------------

