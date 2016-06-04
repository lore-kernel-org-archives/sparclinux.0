From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 04 Jun 2016 09:36:44 +0000
Subject: [PATCH] sparc32: remove stale RTC_PORT definition
Message-Id: <1465033041-2512569-1-git-send-email-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, rtc-linux@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

sparc32:allmodconfig fails to build in next-20160602 as follows.

In file included from drivers/block/floppy.c:185:0:
include/linux/mc146818rtc.h: In function 'mc146818_is_updating':
include/linux/mc146818rtc.h:138:9: error: 'rtc_port' undeclared (first use in this function)
include/linux/mc146818rtc.h:138:9: note: each undeclared identifier is reported only once for each function it appears in
include/linux/mc146818rtc.h: In function 'mc146818_get_time':
include/linux/mc146818rtc.h:172:17: error: 'rtc_port' undeclared (first use in this function)
include/linux/mc146818rtc.h: In function 'mc146818_set_time':
include/linux/mc146818rtc.h:278:8: error: 'rtc_port' undeclared (first use in this function)
scripts/Makefile.build:295: recipe for target 'drivers/block/floppy.o' failed

The reason is a duplicate definition of the RTC_PORT macro. The
one in arch/sparc/include/asm/io_32.h was apparently used a long time
ago for the drivers/char/rtc.c driver that is not available on SPARC
any more, since we now select 'RTC_CLASS' unconditionally.

Removing the macro fixes the build problem, and for consistency,
this also removes the RTC_ALWAYS_BCD macro and the comment for both.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: fd09cc80165c ("rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h")
---
I thought I'd sent this out yesterday, but cannot find an indication of
that now, and Alexandre didn't seem to get it. This should probably
go through the rtc tree that introduced the build failure after my
earlier patches

 arch/sparc/include/asm/io_32.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 57f26c398dc9..4dd268a3a8b0 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -140,16 +140,6 @@ void ioport_unmap(void __iomem *);
 struct pci_dev;
 void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
-
-
-/*
- * At the moment, we do not use CMOS_READ anywhere outside of rtc.c,
- * so rtc_port is static in it. This should not change unless a new
- * hardware pops up.
- */
-#define RTC_PORT(x)   (rtc_port + (x))
-#define RTC_ALWAYS_BCD  0
-
 static inline int sbus_can_dma_64bit(void)
 {
 	return 0; /* actually, sparc_cpu_model=sun4d */
-- 
2.7.0

