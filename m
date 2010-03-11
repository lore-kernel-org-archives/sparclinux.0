From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:06:50 +0000
Subject: [PATCH 33/37] sound/soc: use .dev.of_node instead of .node in struct
Message-Id: <20100311180649.4824.10368.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311174830.4824.19820.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infrade

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index ef67d1c..d7e1b9a 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -202,7 +202,7 @@ static struct snd_soc_ops mpc8610_hpcd_ops = {
 static int mpc8610_hpcd_probe(struct of_device *ofdev,
 	const struct of_device_id *match)
 {
-	struct device_node *np = ofdev->node;
+	struct device_node *np = ofdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct device_node *guts_np = NULL;
 	struct device_node *dma_np = NULL;

