From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 07 Jan 2011 06:03:47 +0000
Subject: Re: [PATCH 2/4] sunhme: cleanup conditional on CONFIG_SBUS
Message-Id: <20110107060347.GA18169@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294261427-26104-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1294261427-26104-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 06, 2011 at 02:26:51PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed,  5 Jan 2011 22:03:45 +0100
> 
> > sparc has always SBUS defined.
> > So there is no need to have #ifdef CONFIG_SBUS within
> > code that is SPARC only.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> This breaks the build on x86, sbus_can_burst64() is only defined on
> sparc currently.
> 
> So if you want to make this patch you'll need to add a dummy
> implementation somewhere that gets defined on non-sparc.

The lines that are removed are within a code-block that is SPARC only.

The following diff with --unified shows this.
Note the conditional "#ifndef CONFIG_SPARC"

	Sam



diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index 5e28c41..e716795 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -1571,42 +1571,35 @@ static int happy_meal_init(struct happy_meal *hp)
 
 	/* Set the supported burst sizes. */
 	HMD(("happy_meal_init: old[%08x] bursts<",
 	     hme_read32(hp, gregs + GREG_CFG)));
 
 #ifndef CONFIG_SPARC
 	/* It is always PCI and can handle 64byte bursts. */
 	hme_write32(hp, gregs + GREG_CFG, GREG_CFG_BURST64);
 #else
 	if ((hp->happy_bursts & DMA_BURST64) &&
-	    ((hp->happy_flags & HFLAG_PCI) != 0
-#ifdef CONFIG_SBUS
-	     || sbus_can_burst64()
-#endif
-	     || 0)) {
+	    ((hp->happy_flags & HFLAG_PCI) != 0 || sbus_can_burst64() || 0)) {
 		u32 gcfg = GREG_CFG_BURST64;
 
 		/* I have no idea if I should set the extended
 		 * transfer mode bit for Cheerio, so for now I
 		 * do not.  -DaveM
 		 */
-#ifdef CONFIG_SBUS
 		if ((hp->happy_flags & HFLAG_PCI) = 0) {
 			struct platform_device *op = hp->happy_dev;
 			if (sbus_can_dma_64bit()) {
 				sbus_set_sbus64(&op->dev,
 						hp->happy_bursts);
 				gcfg |= GREG_CFG_64BIT;
 			}
 		}
-#endif
-
 		HMD(("64>"));
 		hme_write32(hp, gregs + GREG_CFG, gcfg);
 	} else if (hp->happy_bursts & DMA_BURST32) {
 		HMD(("32>"));
 		hme_write32(hp, gregs + GREG_CFG, GREG_CFG_BURST32);
 	} else if (hp->happy_bursts & DMA_BURST16) {
 		HMD(("16>"));
 		hme_write32(hp, gregs + GREG_CFG, GREG_CFG_BURST16);
 	} else {
 		HMD(("XXX>"));

> 
