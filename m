From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 02 Jul 2005 21:56:18 +0000
Subject: [2.6 patch] sparc: remove the useless APM_RTC_IS_GMT option
Message-Id: <20050702215618.GH5346@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

I can't see any effect of this option outside the i386-specific APM 
code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc1-mm1-full/drivers/sbus/char/Kconfig.old	2005-07-02 20:24:49.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/sbus/char/Kconfig	2005-07-02 20:25:20.000000000 +0200
@@ -71,20 +71,6 @@
 
 # XXX Why don't we do "source drivers/char/Config.in" somewhere?
 # no shit
-config APM_RTC_IS_GMT
-	bool
-	depends on EXPERIMENTAL && SPARC32 && PCI
-	default y
-	help
-	  Say Y here if your RTC (Real Time Clock a.k.a. hardware clock)
-	  stores the time in GMT (Greenwich Mean Time). Say N if your RTC
-	  stores localtime.
-
-	  It is in fact recommended to store GMT in your RTC, because then you
-	  don't have to worry about daylight savings time changes. The only
-	  reason not to use GMT in your RTC is if you also run a broken OS
-	  that doesn't understand GMT.
-
 config RTC
 	tristate "PC-style Real Time Clock Support"
 	depends on PCI && EXPERIMENTAL && SPARC32

