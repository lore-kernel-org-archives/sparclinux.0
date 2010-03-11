From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:23:38 +0000
Subject: [PATCH 20/27] drivers/mmc/of: don't use deprecated field in
Message-Id: <20100311182338.13103.88443.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311181604.13103.30088.stgit@angua>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infradead.org, jeremy.kerr@canonical.com, James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/mmc/host/sdhci-of-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index dfe5cea..7802a54 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -205,8 +205,11 @@ static const struct of_device_id sdhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_of_match);
 
 static struct of_platform_driver sdhci_of_driver = {
-	.driver.name = "sdhci-of",
-	.match_table = sdhci_of_match,
+	.driver = {
+		.name = "sdhci-of",
+		.owner = THIS_MODULE,
+		.of_match_table = sdhci_of_match,
+	},
 	.probe = sdhci_of_probe,
 	.remove = __devexit_p(sdhci_of_remove),
 	.suspend = sdhci_of_suspend,

