From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 15 Feb 2005 16:10:32 +0000
Subject: Re: framebuffer blanking
Message-Id: <20050215081032.40d34b45.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 15 Feb 2005 08:02:21 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> On Tue, 15 Feb 2005 12:33:15 +0200 (EET)
> Meelis Roos <mroos@linux.ee> wrote:
> 
> > I have cg3 and cg6 framebuffers in my SS5. Current snapshot kernel makes 
> > both work well for fb console (haven't tried X). There is only one 
> > strange thing left - console blanking.
> > 
> > Both cg3 and cg6 behave the same: when it's blanking time, cursor is 
> > turned off but all the text stays. When I press a key to unblank, the 
> > cursor appears again and start flashing like usual.
> 
> Put some debugging printk()'s into drivers/video/cg3.c:cg3_blank() to
> see if it's actually getting called and programming the registers.

Actually I spotted the cg3 problem already.  You'll need to add some
debugging to the cg6 case as I can't find any problems with the blanking
code there.  If the cg6 is not the primary console, probably the blank
function simply isn't being invoked.

Anyways, here is the cg3 fix:

=== drivers/video/cg3.c 1.16 vs edited ==--- 1.16/drivers/video/cg3.c	2005-02-11 23:26:17 -08:00
+++ edited/drivers/video/cg3.c	2005-02-15 07:36:43 -08:00
@@ -209,7 +209,7 @@
 	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
 	case FB_BLANK_POWERDOWN: /* Poweroff */
 		val = sbus_readb(&regs->control);
-		val |= CG3_CR_ENABLE_VIDEO;
+		val &= ~CG3_CR_ENABLE_VIDEO;
 		sbus_writeb(val, &regs->control);
 		par->flags |= CG3_FLAG_BLANKED;
 		break;
