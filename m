From: Roel Kluin <roel.kluin@gmail.com>
Date: Mon, 27 Apr 2009 11:03:21 +0000
Subject: [PATCH 1/2] sparc: use NO_IRQ if irq_of_parse_and_map() fails
Message-Id: <49F590F9.9060507@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Roel Kluin <roel.kluin@gmail.com>
> Date: Thu, 23 Apr 2009 14:52:44 +0200
> 
>> Not sure which irq_of_parse_and_map() is used, but I found definitions here:
>>
>> vi arch/microblaze/kernel/irq.c +23
>> vi arch/powerpc/kernel/irq.c +727
>> vi arch/sparc/kernel/of_device_32.c +33
>> vi arch/sparc/kernel/of_device_64.c +59
>>
>> They either return 0 or NO_IRQ - either defined 0, -1, 255 or INT_MAX.

> This test is way too convoluted for my taste.
> 
> I would rather that the implementations of this interface
> use a consistent value for errors.  Preferrably NO_IRQ.

NO_IRQ has no consistent value:

// vi arch/arm/include/asm/irq.h +15
#define NO_IRQ  ((unsigned int)(-1))
// vi arch/microblaze/include/asm/irq.h +18
#define NO_IRQ (-1)
// vi arch/mn10300/include/asm/irq.h +22
#define NO_IRQ          INT_MAX
// vi arch/parisc/include/asm/irq.h +13
#define NO_IRQ          (-1)
// vi arch/powerpc/include/asm/irq.h +29
#define NO_IRQ                  (0)
// vi arch/xtensa/variants/s6000/include/variant/irq.h +4
#define NO_IRQ          (-1)
// vi drivers/input/touchscreen/ucb1400_ts.c +295
#define NO_IRQ  0
// vi drivers/pcmcia/pd6729.c +42
#define NO_IRQ  ((unsigned int)(0))
// vi drivers/rtc/rtc-m48t59.c +24
#define NO_IRQ  (-1)
// vi drivers/scsi/arm/fas216.h +16
#define NO_IRQ 255

I could define another for sparc, and use one definition, if that's
what you meant:
------------------------------>8-------------8<---------------------------------
Also use NO_IRQ if irq_of_parse_and_map() fails for sparc.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com> 
---
diff --git a/arch/sparc/include/asm/irq.h b/arch/sparc/include/asm/irq.h
index 3b44a6a..191cb5c 100644
--- a/arch/sparc/include/asm/irq.h
+++ b/arch/sparc/include/asm/irq.h
@@ -6,3 +6,6 @@
 #include <asm/irq_32.h>
 #endif
 #endif
+
+#define NO_IRQ		0
+
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index c8f14c1..e74e082 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -34,7 +34,7 @@ unsigned int irq_of_parse_and_map(struct device_node *node, int index)
 	struct of_device *op = of_find_device_by_node(node);
 
 	if (!op || index >= op->num_irqs)
-		return 0;
+		return NO_IRQ;
 
 	return op->irqs[index];
 }
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 5ac287a..6506ebd 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -60,7 +60,7 @@ unsigned int irq_of_parse_and_map(struct device_node *node, int index)
 	struct of_device *op = of_find_device_by_node(node);
 
 	if (!op || index >= op->num_irqs)
-		return 0;
+		return NO_IRQ;
 
 	return op->irqs[index];
 }
