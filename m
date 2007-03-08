From: David Miller <davem@davemloft.net>
Date: Thu, 08 Mar 2007 21:35:22 +0000
Subject: Re: parport_pc broken on sparc64
Message-Id: <20070308.133522.63127032.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0702282131050.5156@math>
In-Reply-To: <Pine.SOC.4.64.0702282131050.5156@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 8 Mar 2007 18:37:14 +0200 (EET)

> > I just pushed the following fix to Linus:
> > 
> > commit 74bd7d093b8e87f35eaf3b14459b96a0e20d1d10
> > Author: David S. Miller <davem@sunset.davemloft.net>
> > Date:   Wed Feb 28 13:09:34 2007 -0800
> > 
> >     [SPARC64]: Fix parport_pc build.
> 
> WARNING: "release_dma_lock" [drivers/parport/parport_pc.ko] undefined!
> WARNING: "claim_dma_lock" [drivers/parport/parport_pc.ko] undefined!
> make[1]: *** [__modpost] Error 1
> 
> This is with todays 2.6.21-rc3 git.

Nothing is ever easy :-)
I wonder how it did build for me.

Hopefully this will fix it for good:

diff --git a/include/asm-sparc64/parport.h b/include/asm-sparc64/parport.h
index be9509c..284dfd0 100644
--- a/include/asm-sparc64/parport.h
+++ b/include/asm-sparc64/parport.h
@@ -19,6 +19,17 @@
  */
 #define HAS_DMA
 
+static DEFINE_SPINLOCK(dma_spin_lock);
+
+#define claim_dma_lock() \
+({	unsigned long flags; \
+	spin_lock_irqsave(&dma_spin_lock, flags); \
+	flags; \
+})
+
+#define release_dma_lock(__flags) \
+	spin_unlock_irqrestore(&dma_spin_lock, __flags);
+
 static struct sparc_ebus_info {
 	struct ebus_dma_info info;
 	unsigned int addr;
