From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 25 Sep 2012 08:26:21 +0000
Subject: [PATCH 20/29] PCI, sparc: kill pci_find_next_bus
Message-Id: <1348561590-28067-21-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index acc8c83..70d8c16 100644
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
 
+		pbus = hot_bridge->bus;
 		if (pbus->self) {
 			/* PCI->PCI bridge */
 			node = pbus->self->dev.of_node;
-- 
1.7.7

