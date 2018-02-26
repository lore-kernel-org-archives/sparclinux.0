From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 26 Feb 2018 23:21:18 +0000
Subject: [PATCH] sparc64: Oracle DAX driver depends on SPARC64
Message-Id: <1519687278-9785-1-git-send-email-linux@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>

sparc:allmodconfig fails to build as follows.

ERROR: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!
ERROR: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!

The symbols are only available with SPARC64 builds, thus the driver
depends on it.

Fixes: dd0273284c74 ("sparc64: Oracle DAX driver")
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/sbus/char/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sbus/char/Kconfig b/drivers/sbus/char/Kconfig
index a785aa7660c3..bf3c5f735614 100644
--- a/drivers/sbus/char/Kconfig
+++ b/drivers/sbus/char/Kconfig
@@ -72,7 +72,8 @@ config DISPLAY7SEG
 
 config ORACLE_DAX
 	tristate "Oracle Data Analytics Accelerator"
-	default m if SPARC64
+	depends on SPARC64
+	default m
 	help
 	 Driver for Oracle Data Analytics Accelerator, which is
 	 a coprocessor that performs database operations in hardware.
-- 
2.7.4

