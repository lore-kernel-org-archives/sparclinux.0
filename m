From: David Miller <davem@davemloft.net>
Date: Wed, 28 Feb 2007 21:13:33 +0000
Subject: Re: parport_pc broken on sparc64
Message-Id: <20070228.131333.104034963.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0702282131050.5156@math>
In-Reply-To: <Pine.SOC.4.64.0702282131050.5156@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 28 Feb 2007 21:38:23 +0200 (EET)

> WARNING: "request_dma" [drivers/parport/parport_pc.ko] undefined!
> WARNING: "free_dma" [drivers/parport/parport_pc.ko] undefined!
> make[1]: *** [__modpost] Error 1

I just pushed the following fix to Linus:

commit 74bd7d093b8e87f35eaf3b14459b96a0e20d1d10
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Feb 28 13:09:34 2007 -0800

    [SPARC64]: Fix parport_pc build.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc64/dma.h b/include/asm-sparc64/dma.h
index 93e5a06..1bf4f7a 100644
--- a/include/asm-sparc64/dma.h
+++ b/include/asm-sparc64/dma.h
@@ -205,10 +205,6 @@ do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
 #define for_each_dvma(dma) \
         for((dma) = dma_chain; (dma); (dma) = (dma)->next)
 
-extern int get_dma_list(char *);
-extern int request_dma(unsigned int, __const__ char *);
-extern void free_dma(unsigned int);
-
 /* From PCI */
 
 #ifdef CONFIG_PCI
diff --git a/include/asm-sparc64/parport.h b/include/asm-sparc64/parport.h
index d389587..be9509c 100644
--- a/include/asm-sparc64/parport.h
+++ b/include/asm-sparc64/parport.h
@@ -23,8 +23,30 @@ static struct sparc_ebus_info {
 	struct ebus_dma_info info;
 	unsigned int addr;
 	unsigned int count;
+	int lock;
 } sparc_ebus_dmas[PARPORT_PC_MAX_PORTS];
 
+static __inline__ int request_dma(unsigned int dmanr, const char *device_id)
+{
+	if (dmanr >= PARPORT_PC_MAX_PORTS)
+		return -EINVAL;
+	if (xchg(&sparc_ebus_dmas[dmanr].lock, 1) != 0)
+		return -EBUSY;
+	return 0;
+}
+
+static __inline__ void free_dma(unsigned int dmanr)
+{
+	if (dmanr >= PARPORT_PC_MAX_PORTS) {
+		printk(KERN_WARNING "Trying to free DMA%d\n", dmanr);
+		return;
+	}
+	if (xchg(&sparc_ebus_dmas[dmanr].lock, 0) = 0) {
+		printk(KERN_WARNING "Trying to free free DMA%d\n", dmanr);
+		return;
+	}	
+}
+
 static __inline__ void enable_dma(unsigned int dmanr)
 {
 	ebus_dma_enable(&sparc_ebus_dmas[dmanr].info, 1);
