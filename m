From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Wed, 27 May 2015 15:59:19 +0000
Subject: [PATCH v3] sparc64: pci slots information is not populated in sysfs
Message-Id: <1432742359-238503-1-git-send-email-eric.snowberg@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add PCI slot numbers within sysfs for PCIe hardware.  Larger
PCIe systems with nested PCI bridges and slots further
down on these bridges were not being populated within sysfs.
This will add ACPI style PCI slot numbers for these systems
since the OF 'slot-names' information is not available on
all PCIe platforms.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>

---
Changes in v3:
  - Addresses David Miller's comments to add support for all
      hardware that contains the physical-slot# field.  The
      check for sun4v has been removed and in its place is
      a check for a PCIe bus.  This will take care of the
      sun4u systems containing the physical-slot# field.

Changes in v2:
  - Addresses Julian Calaby's comments: moved hypervisor test
      outside the while loop and updated the typo in the
      commit comment.
---
 arch/sparc/kernel/pci.c |   59 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 6f7251f..c928bc6 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1002,6 +1002,38 @@ static int __init pcibios_init(void)
 subsys_initcall(pcibios_init);
 
 #ifdef CONFIG_SYSFS
+
+#define SLOT_NAME_SIZE  11  /* Max decimal digits + null in u32 */
+
+static void pcie_bus_slot_names(struct pci_bus *pbus)
+{
+	struct pci_dev *pdev;
+	struct pci_bus *bus;
+
+	list_for_each_entry(pdev, &pbus->devices, bus_list) {
+		char name[SLOT_NAME_SIZE];
+		struct pci_slot *pci_slot;
+		const u32 *slot_num;
+		int len;
+
+		slot_num = of_get_property(pdev->dev.of_node,
+					   "physical-slot#", &len);
+
+		if (slot_num = NULL || len != 4)
+			continue;
+
+		snprintf(name, sizeof(name), "%u", slot_num[0]);
+		pci_slot = pci_create_slot(pbus, slot_num[0], name, NULL);
+
+		if (IS_ERR(pci_slot))
+			pr_err("PCI: pci_create_slot returned %ld.\n",
+			       PTR_ERR(pci_slot));
+	}
+
+	list_for_each_entry(bus, &pbus->children, node)
+		pcie_bus_slot_names(bus);
+}
+
 static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 {
 	const struct pci_slot_names {
@@ -1053,18 +1085,29 @@ static int __init of_pci_slot_init(void)
 
 	while ((pbus = pci_find_next_bus(pbus)) != NULL) {
 		struct device_node *node;
+		struct pci_dev *pdev;
+
+		pdev = list_first_entry(&pbus->devices, struct pci_dev,
+					bus_list);
 
-		if (pbus->self) {
-			/* PCI->PCI bridge */
-			node = pbus->self->dev.of_node;
+		if (pdev && pci_is_pcie(pdev)) {
+			pcie_bus_slot_names(pbus);
 		} else {
-			struct pci_pbm_info *pbm = pbus->sysdata;
 
-			/* Host PCI controller */
-			node = pbm->op->dev.of_node;
-		}
+			if (pbus->self) {
+
+				/* PCI->PCI bridge */
+				node = pbus->self->dev.of_node;
+
+			} else {
+				struct pci_pbm_info *pbm = pbus->sysdata;
 
-		pci_bus_slot_names(node, pbus);
+				/* Host PCI controller */
+				node = pbm->op->dev.of_node;
+			}
+
+			pci_bus_slot_names(node, pbus);
+		}
 	}
 
 	return 0;
-- 
1.7.1

