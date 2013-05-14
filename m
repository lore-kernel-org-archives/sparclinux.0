From: Jiang Liu <liuj97@gmail.com>
Date: Tue, 14 May 2013 16:51:54 +0000
Subject: [RFC PATCH v2, part 2 10/18] PCI, SPARC: use hotplug-safe iterators to walk PCI buses
Message-Id: <1368550322-1045-10-git-send-email-jiang.liu@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>, Yijing Wang <wangyijing@huawei.com>, Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org

Enhance SPARC architecture specific code to use hotplug-safe iterators
to walk PCI buses.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/sparc/kernel/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index e5871fb..235208d8 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -995,9 +995,9 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 
 static int __init of_pci_slot_init(void)
 {
-	struct pci_bus *pbus = NULL;
+	struct pci_bus *pbus;
 
-	while ((pbus = pci_find_next_bus(pbus)) != NULL) {
+	for_each_pci_root_bus(pbus) {
 		struct device_node *node;
 
 		if (pbus->self) {
-- 
1.8.1.2

