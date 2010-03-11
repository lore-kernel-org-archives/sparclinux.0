From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:05:49 +0000
Subject: [PATCH 22/37] drivers/leds: use .dev.of_node instead of .node in
Message-Id: <20100311180549.4824.31164.stgit@angua>
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

 drivers/leds/leds-gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index e5225d2..7ff758a 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -210,7 +210,7 @@ struct gpio_led_of_platform_data {
 static int __devinit of_gpio_leds_probe(struct of_device *ofdev,
 					const struct of_device_id *match)
 {
-	struct device_node *np = ofdev->node, *child;
+	struct device_node *np = ofdev->dev.of_node, *child;
 	struct gpio_led led;
 	struct gpio_led_of_platform_data *pdata;
 	int count = 0, ret;

