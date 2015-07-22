From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 22 Jul 2015 02:02:18 +0000
Subject: [PATCH 4/4] drivers/tty: make serial/sunhv.c driver explicitly non-modular
Message-Id: <1437530538-5078-5-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1437530538-5078-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org

The Kconfig for this driver is currently:

config SERIAL_SUNHV
        bool "Sun4v Hypervisor Console support"

...meaning that it currently is not being built as a module by
anyone.  Lets remove the modular and unused code here, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't swap module.h for init.h since this file has init.h already.

We leave some tags like MODULE_LICENSE for documentation purposes, and
for the "git blame" value.  Also note that MODULE_DEVICE_TABLE is a
no-op for non-modular code, so we remove that too.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/sunhv.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 534754440fa8..064031870ba0 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2006, 2007 David S. Miller (davem@davemloft.net)
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/tty.h>
@@ -621,7 +620,6 @@ static const struct of_device_id hv_match[] = {
 	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, hv_match);
 
 static struct platform_driver hv_driver = {
 	.driver = {
@@ -639,16 +637,11 @@ static int __init sunhv_init(void)
 
 	return platform_driver_register(&hv_driver);
 }
+device_initcall(sunhv_init);
 
-static void __exit sunhv_exit(void)
-{
-	platform_driver_unregister(&hv_driver);
-}
-
-module_init(sunhv_init);
-module_exit(sunhv_exit);
-
+#if 0 /* ...def MODULE ; never supported as such */
 MODULE_AUTHOR("David S. Miller");
 MODULE_DESCRIPTION("SUN4V Hypervisor console driver");
 MODULE_VERSION("2.0");
 MODULE_LICENSE("GPL");
+#endif
-- 
2.2.1

