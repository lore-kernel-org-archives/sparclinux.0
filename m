From: Sinan Kaya <okaya@codeaurora.org>
Date: Tue, 19 Dec 2017 05:37:56 +0000
Subject: [PATCH V4 20/26] openprom: deprecate pci_get_bus_and_slot()
Message-Id: <1513661883-28662-21-git-send-email-okaya@codeaurora.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-coding the domain as 0 since domain information is not available.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/sbus/char/openprom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 2c2e6a3..7b31f19 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -251,8 +251,9 @@ static int oprompci2node(void __user *argp, struct device_node *dp, struct openp
 		struct pci_dev *pdev;
 		struct device_node *dp;
 
-		pdev = pci_get_bus_and_slot (((int *) op->oprom_array)[0],
-				      ((int *) op->oprom_array)[1]);
+		pdev = pci_get_domain_bus_and_slot(0,
+						((int *) op->oprom_array)[0],
+						((int *) op->oprom_array)[1]);
 
 		dp = pci_device_to_OF_node(pdev);
 		data->current_node = dp;
-- 
1.9.1

