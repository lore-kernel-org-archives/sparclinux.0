From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:21 +0000
Subject: [PATCH 1/12]: rtc: Allow RTC_DRV_CMOS to be used on SPARC.
Message-Id: <20080828.230921.126967947.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


rtc: Allow RTC_DRV_CMOS to be used on SPARC.

Add Sparc to the Kconfig depends list.

Add __sparc___ to address_sparc = 128 ifdef.

Finally, don't be concerned about 24-hour BCD mode support if the RTC
doesn't have a valid IRQ.  We won't even use the alarm code in this
case and the Sparc RTCs have this limitation.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/rtc/Kconfig    |    2 +-
 drivers/rtc/rtc-cmos.c |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 9a9755c..8cb158d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -329,7 +329,7 @@ comment "Platform RTC drivers"
 
 config RTC_DRV_CMOS
 	tristate "PC-style 'CMOS'"
-	depends on X86 || ALPHA || ARM || M32R || ATARI || PPC || MIPS
+	depends on X86 || ALPHA || ARM || M32R || ATARI || PPC || MIPS || SPARC
 	default y if X86
 	help
 	  Say "yes" here to get direct support for the real time clock
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 6ea349a..04ecfd2 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -636,7 +636,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	 */
 #if	defined(CONFIG_ATARI)
 	address_space = 64;
-#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)
+#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) || defined(__sparc__)
 	address_space = 128;
 #else
 #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.
@@ -699,7 +699,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	/* FIXME teach the alarm code how to handle binary mode;
 	 * <asm-generic/rtc.h> doesn't know 12-hour mode either.
 	 */
-	if (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY))) {
+	if (is_valid_irq(rtc_irq) &&
+	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
 		dev_dbg(dev, "only 24-hr BCD mode supported\n");
 		retval = -ENXIO;
 		goto cleanup1;
-- 
1.5.6.5.GIT

