From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 12 Jan 2017 18:52:49 +0000
Subject: [PATCH 4/4] n2rng: update version info
Message-Id: <1484247169-245086-5-git-send-email-shannon.nelson@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1484247169-245086-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1484247169-245086-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-crypto@vger.kernel.org
Cc: sparclinux@vger.kernel.org, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@oracle.com>

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/char/hw_random/n2-drv.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index f0bd5ee..31cbdbb 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -21,11 +21,11 @@
 
 #define DRV_MODULE_NAME		"n2rng"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.2"
-#define DRV_MODULE_RELDATE	"July 27, 2011"
+#define DRV_MODULE_VERSION	"0.3"
+#define DRV_MODULE_RELDATE	"Jan 7, 2017"
 
 static char version[] -	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
+	DRV_MODULE_NAME " v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
 MODULE_AUTHOR("David S. Miller (davem@davemloft.net)");
 MODULE_DESCRIPTION("Niagara2 RNG driver");
@@ -765,7 +765,7 @@ static int n2rng_probe(struct platform_device *op)
 		  "multi-unit-capable" : "single-unit"),
 		 np->num_units);
 
-	np->hwrng.name = "n2rng";
+	np->hwrng.name = DRV_MODULE_NAME;
 	np->hwrng.data_read = n2rng_data_read;
 	np->hwrng.priv = (unsigned long) np;
 
-- 
1.7.1

