From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Date: Wed, 24 Mar 2004 13:42:45 +0000
Subject: [PATCH] asm-sparc{64}/ide.h cleanup (there are no standard ports)
Message-Id: <200403241442.45189.bzolnier@elka.pw.edu.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-ide@vger.kernel.org


Hi,

Is this patch correct?

Regards,
Bartlomiej

[IDE] asm-sparc{64}/ide.h cleanup (there are no standard ports)

 linux-2.6.5-rc2-bk3-root/include/asm-sparc/ide.h   |   20 ++------------------
 linux-2.6.5-rc2-bk3-root/include/asm-sparc64/ide.h |   20 ++------------------
 2 files changed, 4 insertions(+), 36 deletions(-)

diff -puN include/asm-sparc/ide.h~sparc_no_default_ide_ports include/asm-sparc/ide.h
--- linux-2.6.5-rc2-bk3/include/asm-sparc/ide.h~sparc_no_default_ide_ports	2004-03-24 00:08:03.000000000 +0100
+++ linux-2.6.5-rc2-bk3-root/include/asm-sparc/ide.h	2004-03-24 14:38:06.466086288 +0100
@@ -53,24 +53,8 @@ static __inline__ void ide_init_hwif_por
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_PCI
-	hw_regs_t hw;
-	int index;
-
-	for (index = 0; index < MAX_HWIFS; index++) {
-		memset(&hw, 0, sizeof hw);
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-#endif
-}
+/* There are no standard ports. */
+static inline void ide_init_default_hwifs(void)	{ ; }
 
 #define __ide_insl(data_reg, buffer, wcount) \
 	__ide_insw(data_reg, buffer, (wcount)<<1)
diff -puN include/asm-sparc64/ide.h~sparc_no_default_ide_ports include/asm-sparc64/ide.h
--- linux-2.6.5-rc2-bk3/include/asm-sparc64/ide.h~sparc_no_default_ide_ports	2004-03-24 00:08:03.000000000 +0100
+++ linux-2.6.5-rc2-bk3-root/include/asm-sparc64/ide.h	2004-03-24 14:38:22.286681192 +0100
@@ -54,24 +54,8 @@ static __inline__ void ide_init_hwif_por
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_BLK_DEV_IDEPCI
-	hw_regs_t hw;
-	int index;
-
-	for (index = 0; index < MAX_HWIFS; index++) {
-		memset(&hw, 0, sizeof hw);
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw, NULL);
-	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
-}
+/* There are no standard ports. */
+static inline void ide_init_default_hwifs(void)	{ ; }
 
 #define __ide_insl(data_reg, buffer, wcount) \
 	__ide_insw(data_reg, buffer, (wcount)<<1)

_

