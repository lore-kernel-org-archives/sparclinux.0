From: Qinglang Miao <miaoqinglang@huawei.com>
Date: Tue, 28 Jul 2020 02:28:17 +0000
Subject: [PATCH -next] sparc: use for_each_child_of_node() macro
Message-Id: <20200728022817.87957-1-miaoqinglang@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/sparc/kernel/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 5d45b6d76..9c2b720bf 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -552,9 +552,8 @@ static void pci_of_scan_bus(struct pci_pbm_info *pbm,
 		pci_info(bus, "scan_bus[%pOF] bus no %d\n",
 			 node, bus->number);
 
-	child = NULL;
 	prev_devfn = -1;
-	while ((child = of_get_next_child(node, child)) != NULL) {
+	for_each_child_of_node(node, child) {
 		if (ofpci_verbose)
 			pci_info(bus, "  * %pOF\n", child);
 		reg = of_get_property(child, "reg", &reglen);
-- 
2.25.1
