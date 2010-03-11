From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:05:27 +0000
Subject: [PATCH 18/37] drivers/pcmcia: use .dev.of_node instead of .node in
Message-Id: <20100311180527.4824.74325.stgit@angua>
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

 drivers/pcmcia/electra_cf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 89cfddc..a4d821f 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -184,7 +184,7 @@ static int __devinit electra_cf_probe(struct of_device *ofdev,
 				      const struct of_device_id *match)
 {
 	struct device *device = &ofdev->dev;
-	struct device_node *np = ofdev->node;
+	struct device_node *np = ofdev->dev.of_node;
 	struct electra_cf_socket   *cf;
 	struct resource mem, io;
 	int status;

