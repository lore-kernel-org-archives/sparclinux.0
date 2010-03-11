From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:22:37 +0000
Subject: [PATCH 09/27] drivers/atm/of: don't use deprecated field in
Message-Id: <20100311182237.13103.61327.stgit@angua>
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

 drivers/atm/fore200e.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 593a03a..da8f176 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -2695,8 +2695,11 @@ static const struct of_device_id fore200e_sba_match[] = {
 MODULE_DEVICE_TABLE(of, fore200e_sba_match);
 
 static struct of_platform_driver fore200e_sba_driver = {
-	.name		= "fore_200e",
-	.match_table	= fore200e_sba_match,
+	.driver = {
+		.name = "fore_200e",
+		.owner = THIS_MODULE,
+		.of_match_table = fore200e_sba_match,
+	},
 	.probe		= fore200e_sba_probe,
 	.remove		= __devexit_p(fore200e_sba_remove),
 };

