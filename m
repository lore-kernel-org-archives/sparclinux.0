From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Tue, 28 Apr 2015 20:51:17 +0000
Subject: [PATCH v2] sparc64: pci slots information is not populated in sysfs
Message-Id: <1430254277-208174-1-git-send-email-eric.snowberg@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add PCI slot numbers within sysfs for sun4v hardware. Larger
sun4v systems contain nested PCI bridges and slots further
down on these bridges were not being populated within sysfs.
Also add ACPI style PCI slot numbers within sysfs for sun4v
hardware since the OF 'slot-names' information is not available
on all sun4v platforms.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

---
Changes in v2:
  - Addresses Julian Calaby's comments: moved hypervisor test
      outside the while loop and updated the typo in the
      commit comment.
---
 arch/sparc/kernel/pci.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 6f7251f..d5f06bd 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -1002,6 +1002,38 @@ static int __init pcibios_init(void)
 subsys_initcall(pcibios_init);
 
 #ifdef CONFIG_SYSFS
+
+#define SLOT_NAME_SIZE  11  /* Max decimal digits + null in u32 */
+
+static void pci_sun4v_bus_slot_names(struct pci_bus *pbus)
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
+		pci_sun4v_bus_slot_names(bus);
+}
+
 static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 {
 	const struct pci_slot_names {
@@ -1051,6 +1083,13 @@ static int __init of_pci_slot_init(void)
 {
 	struct pci_bus *pbus = NULL;
 
+	if (tlb_type = hypervisor) {
+		while ((pbus = pci_find_next_bus(pbus)) != NULL)
+			pci_sun4v_bus_slot_names(pbus);
+
+		return 0;
+	}
+
 	while ((pbus = pci_find_next_bus(pbus)) != NULL) {
 		struct device_node *node;
 
-- 
1.7.1

