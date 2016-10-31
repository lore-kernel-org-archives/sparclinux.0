From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 31 Oct 2016 18:55:26 +0000
Subject: [PATCH 2/3] rtc: sparc: make starfire explicitly non-modular
Message-Id: <20161031185527.20279-3-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161031185527.20279-1-paul.gortmaker@windriver.com>
In-Reply-To: <20161031185527.20279-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, rtc-linux@googlegroups.com

The Kconfig currently controlling compilation of this code is:

drivers/rtc/Kconfig:config RTC_DRV_STARFIRE
drivers/rtc/Kconfig:    bool "Starfire RTC"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: rtc-linux@googlegroups.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/rtc/rtc-starfire.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-starfire.c b/drivers/rtc/rtc-starfire.c
index 83a057a03060..7fc36973fa33 100644
--- a/drivers/rtc/rtc-starfire.c
+++ b/drivers/rtc/rtc-starfire.c
@@ -1,20 +1,18 @@
 /* rtc-starfire.c: Starfire platform RTC driver.
  *
+ * Author: David S. Miller
+ * License: GPL
+ *
  * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 
-MODULE_AUTHOR("David S. Miller <davem@davemloft.net>");
-MODULE_DESCRIPTION("Starfire RTC driver");
-MODULE_LICENSE("GPL");
-
 static u32 starfire_get_time(void)
 {
 	static char obp_gettod[32];
@@ -57,4 +55,4 @@ static struct platform_driver starfire_rtc_driver = {
 	},
 };
 
-module_platform_driver_probe(starfire_rtc_driver, starfire_rtc_probe);
+builtin_platform_driver_probe(starfire_rtc_driver, starfire_rtc_probe);
-- 
2.10.1

