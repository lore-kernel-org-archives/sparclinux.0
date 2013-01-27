From: Yinghai Lu <yinghai@kernel.org>
Date: Sun, 27 Jan 2013 05:36:34 +0000
Subject: [PATCH v2 13/22] PCI, sparc: Kill pci_find_next_bus
Message-Id: <1359265003-16166-14-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <jiang.liu@huawei.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 75b31bc..403f6e0 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -997,11 +997,13 @@ static void __devinit pci_bus_slot_names(struct device_node *node,
 
 static int __init of_pci_slot_init(void)
 {
-	struct pci_bus *pbus = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
+	struct pci_bus *pbus;
 
-	while ((pbus = pci_find_next_bus(pbus)) != NULL) {
+	for_each_pci_host_bridge(host_bridge) {
 		struct device_node *node;
 
+		pbus = host_bridge->bus;
 		if (pbus->self) {
 			/* PCI->PCI bridge */
 			node = pbus->self->dev.of_node;
-- 
1.7.10.4

