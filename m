From: David Miller <davem@davemloft.net>
Date: Wed, 07 Nov 2012 00:09:49 +0000
Subject: [PATCH] sparc: Allow OF_GPIO on sparc.
Message-Id: <20121106.190949.616204095438376098.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d055cee..f11d8e3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -47,7 +47,7 @@ if GPIOLIB
 
 config OF_GPIO
 	def_bool y
-	depends on OF && !SPARC
+	depends on OF
 
 config DEBUG_GPIO
 	bool "Debug GPIO calls"
-- 
1.7.12.2.dirty

