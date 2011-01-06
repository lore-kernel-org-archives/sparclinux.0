From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 06 Jan 2011 13:39:27 +0000
Subject: [PATCH v2] cassini: Use local-mac-address prom property for
Message-Id: <1294321167.6193.69.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fallback on the local-mac-address prom property if the Cassini device
does not have an address programmed in the VPD ROM. This uses the same
technique as implemented by the sungem driver.

The problem was reported by Frans van Berckel using Debian kernel 2.6.34-7
on Sun Fire V440. udev was assigning a new eth<n> device name on each reboot
because the cassini driver was using a random MAC address.

Fix tested on 2.6.34-7/Sun Fire V440. Compile tested only against 2.6.36
davem/sparc-2.6.git because Sun Fire V440 does not currently boot recent
kernels so runtime test is not possible at present.

Reported-by: Frans van Berckel <fberckel@xs4all.nl>
Tested-by: Frans van Berckel <fberckel@xs4all.nl>
Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
---
 drivers/net/cassini.c |   20 ++++++++++++++++++++
 drivers/net/cassini.h |    3 +++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/net/cassini.c b/drivers/net/cassini.c
index d6b6d6a..08ef2f9 100644
--- a/drivers/net/cassini.c
+++ b/drivers/net/cassini.c
@@ -82,6 +82,10 @@
 #include <linux/highmem.h>
 #include <linux/list.h>
 #include <linux/dma-mapping.h>
+#if defined(CONFIG_OF)
+#include <linux/of.h>
+#include <linux/of_device.h>
+#endif
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -3203,6 +3207,10 @@ static int cas_get_vpd_info(struct cas *cp, unsigned char *dev_addr,
 	int phy_type = CAS_PHY_MII_MDIO0; /* default phy type */
 	int mac_off  = 0;
 
+#if defined(CONFIG_OF)
+	const unsigned char *addr;
+#endif
+
 	/* give us access to the PROM */
 	writel(BIM_LOCAL_DEV_PROM | BIM_LOCAL_DEV_PAD,
 	       cp->regs + REG_BIM_LOCAL_DEV_EN);
@@ -3350,6 +3358,14 @@ use_random_mac_addr:
 	if (found & VPD_FOUND_MAC)
 		goto done;
 
+#if defined(CONFIG_OF)
+	addr = of_get_property(cp->of_node, "local-mac-address", NULL);
+	if (addr != NULL) {
+		memcpy(dev_addr, addr, 6);
+		goto done;
+	}
+#endif
+
 	/* Sun MAC prefix then 3 random bytes. */
 	pr_info("MAC address not found in ROM VPD\n");
 	dev_addr[0] = 0x08;
@@ -5019,6 +5035,10 @@ static int __devinit cas_init_one(struct pci_dev *pdev,
 	cp->msg_enable = (cassini_debug < 0) ? CAS_DEF_MSG_ENABLE :
 	  cassini_debug;
 
+#if defined(CONFIG_OF)
+	cp->of_node = pci_device_to_OF_node(pdev);
+#endif
+
 	cp->link_transition = LINK_TRANSITION_UNKNOWN;
 	cp->link_transition_jiffies_valid = 0;
 
diff --git a/drivers/net/cassini.h b/drivers/net/cassini.h
index dbc4787..faf4746 100644
--- a/drivers/net/cassini.h
+++ b/drivers/net/cassini.h
@@ -2868,6 +2868,9 @@ struct cas {
 	dma_addr_t block_dvma, tx_tiny_dvma[N_TX_RINGS];
 	struct pci_dev *pdev;
 	struct net_device *dev;
+#if defined(CONFIG_OF)
+	struct device_node	*of_node;
+#endif
 
 	/* Firmware Info */
 	u16			fw_load_addr;
-- 
1.4.4.4



