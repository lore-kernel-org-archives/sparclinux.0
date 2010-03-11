From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:04:32 +0000
Subject: [PATCH 08/37] drivers/watchdog: use .dev.of_node instead of .node in
Message-Id: <20100311180431.4824.39881.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311174830.4824.19820.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org, akpm@linux-foundation.org, davem@davemloft.net, sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org, dwmw2@infradead.org, jeremy.kerr@canonical.com, James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/watchdog/cpwd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 37ea052..89da14f 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -576,7 +576,7 @@ static int __devinit cpwd_probe(struct of_device *op,
 	 * interrupt_mask register cannot be written, so no timer
 	 * interrupts can be masked within the PLD.
 	 */
-	str_prop = of_get_property(op->node, "model", NULL);
+	str_prop = of_get_property(op->dev.of_node, "model", NULL);
 	p->broken = (str_prop && !strcmp(str_prop, WD_BADMODEL));
 
 	if (!p->enabled)

