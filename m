From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:23:27 +0000
Subject: [PATCH 18/27] drivers/parport/of: don't use deprecated field in
Message-Id: <20100311182327.13103.91141.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311181604.13103.30088.stgit@angua>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/parport/parport_sunbpp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 065f229..9a5b4b8 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -382,8 +382,11 @@ static const struct of_device_id bpp_match[] = {
 MODULE_DEVICE_TABLE(of, bpp_match);
 
 static struct of_platform_driver bpp_sbus_driver = {
-	.name		= "bpp",
-	.match_table	= bpp_match,
+	.driver = {
+		.name = "bpp",
+		.owner = THIS_MODULE,
+		.of_match_table = bpp_match,
+	},
 	.probe		= bpp_probe,
 	.remove		= __devexit_p(bpp_remove),
 };

