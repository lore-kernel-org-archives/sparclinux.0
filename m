From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 15 Mar 2016 23:12:48 +0000
Subject: [PATCH RFC] PCI: Fix for panic while enabling SR-IOV
Message-Id: <1458083568-193689-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, bhelgaas@google.com
Cc: wangyijing@huawei.com, sowmini.varadhan@oracle.com, babu.moger@oracle.com, jiang.liu@linux.intel.com, eric.snowberg@oracle.com, yinghai@kernel.org, dan.j.williams@intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

We noticed this panic while enabling SR-IOV in sparc.
=======================mlx4_core: Mellanox ConnectX core driver v2.2-1 (Jan  1 2015)
mlx4_core: Initializing 0007:01:00.0
mlx4_core 0007:01:00.0: Enabling SR-IOV with 5 VFs
mlx4_core: Initializing 0007:01:00.1
Unable to handle kernel NULL pointer dereference
insmod(10010): Oops [#1]
CPU: 391 PID: 10010 Comm: insmod Not tainted
		4.1.12-32.el6uek.kdump2.sparc64 #1
TPC: <dma_supported+0x20/0x80>
I7: <__mlx4_init_one+0x324/0x500 [mlx4_core]>
Call Trace:
 [00000000104c5ea4] __mlx4_init_one+0x324/0x500 [mlx4_core]
 [00000000104c613c] mlx4_init_one+0xbc/0x120 [mlx4_core]
 [0000000000725f14] local_pci_probe+0x34/0xa0
 [0000000000726028] pci_call_probe+0xa8/0xe0
 [0000000000726310] pci_device_probe+0x50/0x80
 [000000000079f700] really_probe+0x140/0x420
 [000000000079fa24] driver_probe_device+0x44/0xa0
 [000000000079fb5c] __device_attach+0x3c/0x60
 [000000000079d85c] bus_for_each_drv+0x5c/0xa0
 [000000000079f588] device_attach+0x88/0xc0
 [000000000071acd0] pci_bus_add_device+0x30/0x80
 [0000000000736090] virtfn_add.clone.1+0x210/0x360
 [00000000007364a4] sriov_enable+0x2c4/0x520
 [000000000073672c] pci_enable_sriov+0x2c/0x40
 [00000000104c2d58] mlx4_enable_sriov+0xf8/0x180 [mlx4_core]
 [00000000104c49ac] mlx4_load_one+0x42c/0xd40 [mlx4_core]
Disabling lock debugging due to kernel taint
Caller[00000000104c5ea4]: __mlx4_init_one+0x324/0x500 [mlx4_core]
Caller[00000000104c613c]: mlx4_init_one+0xbc/0x120 [mlx4_core]
Caller[0000000000725f14]: local_pci_probe+0x34/0xa0
Caller[0000000000726028]: pci_call_probe+0xa8/0xe0
Caller[0000000000726310]: pci_device_probe+0x50/0x80
Caller[000000000079f700]: really_probe+0x140/0x420
Caller[000000000079fa24]: driver_probe_device+0x44/0xa0
Caller[000000000079fb5c]: __device_attach+0x3c/0x60
Caller[000000000079d85c]: bus_for_each_drv+0x5c/0xa0
Caller[000000000079f588]: device_attach+0x88/0xc0
Caller[000000000071acd0]: pci_bus_add_device+0x30/0x80
Caller[0000000000736090]: virtfn_add.clone.1+0x210/0x360
Caller[00000000007364a4]: sriov_enable+0x2c4/0x520
Caller[000000000073672c]: pci_enable_sriov+0x2c/0x40
Caller[00000000104c2d58]: mlx4_enable_sriov+0xf8/0x180 [mlx4_core]
Caller[00000000104c49ac]: mlx4_load_one+0x42c/0xd40 [mlx4_core]
Caller[00000000104c5f90]: __mlx4_init_one+0x410/0x500 [mlx4_core]
Caller[00000000104c613c]: mlx4_init_one+0xbc/0x120 [mlx4_core]
Caller[0000000000725f14]: local_pci_probe+0x34/0xa0
Caller[0000000000726028]: pci_call_probe+0xa8/0xe0
Caller[0000000000726310]: pci_device_probe+0x50/0x80
Caller[000000000079f700]: really_probe+0x140/0x420
Caller[000000000079fa24]: driver_probe_device+0x44/0xa0
Caller[000000000079fb08]: __driver_attach+0x88/0xa0
Caller[000000000079d90c]: bus_for_each_dev+0x6c/0xa0
Caller[000000000079f29c]: driver_attach+0x1c/0x40
Caller[000000000079e35c]: bus_add_driver+0x17c/0x220
Caller[00000000007a02d4]: driver_register+0x74/0x120
Caller[00000000007263fc]: __pci_register_driver+0x3c/0x60
Caller[00000000104f62bc]: mlx4_init+0x60/0xcc [mlx4_core]
Kernel panic - not syncing: Fatal exception
Press Stop-A (L1-A) to return to the boot prom
---[ end Kernel panic - not syncing: Fatal exception
===========================
Details:
Here is the call sequence
virtfn_add->__mlx4_init_one->dma_set_mask->dma_supported

The panic happened at line 760(file arch/sparc/kernel/iommu.c)

758 int dma_supported(struct device *dev, u64 device_mask)
759 {
760         struct iommu *iommu = dev->archdata.iommu;
761         u64 dma_addr_mask = iommu->dma_addr_mask;
762
763         if (device_mask >= (1UL << 32UL))
764                 return 0;
765
766         if ((device_mask & dma_addr_mask) = dma_addr_mask)
767                 return 1;
768
769 #ifdef CONFIG_PCI
770         if (dev_is_pci(dev))
771		return pci64_dma_supported(to_pci_dev(dev), device_mask);
772 #endif
773
774         return 0;
775 }
776 EXPORT_SYMBOL(dma_supported);

Same panic happened with Intel ixgbe driver also.

When VF device is added, driver probe function makes set of calls to
initialize the pci device. Because the VF device is added different
way than the normal PF device(which happens via of_create_pci_dev),
some of the arch specific initialization does not happen for VF device.
That causes panic when archdata is accessed.

To fix this I have introduced weak function pci_init_archdata in SR-IOV
code. Sparc will copy the archdata from PF to VF. Also verified the fix.

Please review. Let me know if there is a better way to fix this.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/kernel/pci.c |    7 +++++++
 drivers/pci/iov.c       |    5 +++++
 include/linux/pci.h     |    1 +
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index badf095..0fc774a 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -994,6 +994,13 @@ void pcibios_set_master(struct pci_dev *dev)
 	/* No special bus mastering setup handling */
 }
 
+void pci_init_archdata(struct pci_dev *pdev, struct pci_dev *virtfn)
+{
+	/* Copy dev_archdata from PF to VF */
+	memcpy(&virtfn->dev.archdata, &pdev->dev.archdata,
+			sizeof(struct dev_archdata));
+}
+
 static int __init pcibios_init(void)
 {
 	pci_dfl_cache_line_size = 64 >> 2;
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2194b44..73e3538 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -19,6 +19,10 @@
 
 #define VIRTFN_ID_LEN	16
 
+void __weak pci_init_archdata(struct pci_dev *pdev, struct pci_dev *virtfn)
+{
+}
+
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
 	if (!dev->is_physfn)
@@ -141,6 +145,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 	virtfn->physfn = pci_dev_get(dev);
 	virtfn->is_virtfn = 1;
 	virtfn->multifunction = 0;
+	pci_init_archdata(dev, virtfn);
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 004b813..15b4fbd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -791,6 +791,7 @@ void pcibios_fixup_bus(struct pci_bus *);
 int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 /* Architecture-specific versions may override this (weak) */
 char *pcibios_setup(char *str);
+void pci_init_archdata(struct pci_dev *pdev, struct pci_dev *virtfn);
 
 /* Used only when drivers/pci/setup.c is used */
 resource_size_t pcibios_align_resource(void *, const struct resource *,
-- 
1.7.1

