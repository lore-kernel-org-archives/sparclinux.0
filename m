From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Thu, 06 Oct 2016 23:33:34 +0000
Subject: [RFC PATCH 4/6] sparc64: Bind PCIe devices to use IOMMU v2 service
Message-Id: <1475796816-14448-5-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475796816-14448-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1475796816-14448-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

In order to use Hypervisor (HV) IOMMU v2 API for map/demap, each PCIe
device has to be bound to IOTSB using HV API pci_iotsb_bind().

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Reviewed-by: chris hyser <chris.hyser@oracle.com>
Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/kernel/pci_sun4v.c     | 43 +++++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/pci_sun4v.h     |  3 +++
 arch/sparc/kernel/pci_sun4v_asm.S | 14 +++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 5404b33..c7f3a0b3 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -216,6 +216,43 @@ range_alloc_fail:
 	return NULL;
 }
 
+unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
+				unsigned long iotsb_num,
+				struct pci_bus *bus_dev)
+{
+	struct pci_dev *pdev;
+	unsigned long err;
+	unsigned int bus;
+	unsigned int device;
+	unsigned int fun;
+
+	list_for_each_entry(pdev, &bus_dev->devices, bus_list) {
+		if (pdev->subordinate) {
+			/* No need to bind pci bridge */
+			dma_4v_iotsb_bind(devhandle, iotsb_num,
+					  pdev->subordinate);
+		} else {
+			bus = bus_dev->number;
+			device = PCI_SLOT(pdev->devfn);
+			fun = PCI_FUNC(pdev->devfn);
+			err = pci_sun4v_iotsb_bind(devhandle, iotsb_num,
+						   HV_PCI_DEVICE_BUILD(bus,
+								       device,
+								       fun));
+
+			/* If bind fails for one device it is going to fail
+			 * for rest of the devices because we are sharing
+			 * IOTSB. So in case of failure simply return with
+			 * error.
+			 */
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static void dma_4v_iommu_demap(void *demap_arg, unsigned long entry,
 			       unsigned long npages)
 {
@@ -628,6 +665,12 @@ static int pci_sun4v_atu_alloc_iotsb(struct pci_pbm_info *pbm)
 	}
 	iotsb->iotsb_num = iotsb_num;
 
+	err = dma_4v_iotsb_bind(pbm->devhandle, iotsb_num, pbm->pci_bus);
+	if (err) {
+		pr_err(PFX "pci_iotsb_bind failed error: %ld\n", err);
+		goto iotsb_conf_failed;
+	}
+
 	return 0;
 
 iotsb_conf_failed:
diff --git a/arch/sparc/kernel/pci_sun4v.h b/arch/sparc/kernel/pci_sun4v.h
index 0ef6d1c..1019e0f 100644
--- a/arch/sparc/kernel/pci_sun4v.h
+++ b/arch/sparc/kernel/pci_sun4v.h
@@ -96,4 +96,7 @@ unsigned long pci_sun4v_iotsb_conf(unsigned long devhandle,
 				   unsigned long page_size,
 				   unsigned long dvma_base,
 				   u64 *iotsb_num);
+unsigned long pci_sun4v_iotsb_bind(unsigned long devhandle,
+				   unsigned long iotsb_num,
+				   unsigned int pci_device);
 #endif /* !(_PCI_SUN4V_H) */
diff --git a/arch/sparc/kernel/pci_sun4v_asm.S b/arch/sparc/kernel/pci_sun4v_asm.S
index fd94d0e..22024a9 100644
--- a/arch/sparc/kernel/pci_sun4v_asm.S
+++ b/arch/sparc/kernel/pci_sun4v_asm.S
@@ -378,3 +378,17 @@ ENTRY(pci_sun4v_iotsb_conf)
 	retl
 	 stx	%o1, [%g1]
 ENDPROC(pci_sun4v_iotsb_conf)
+
+	/*
+	 * %o0:	devhandle
+	 * %o1:	iotsb_num/iotsb_handle
+	 * %o2:	pci_device
+	 *
+	 * returns %o0:	status
+	 */
+ENTRY(pci_sun4v_iotsb_bind)
+	mov	HV_FAST_PCI_IOTSB_BIND, %o5
+	ta	HV_FAST_TRAP
+	retl
+	 nop
+ENDPROC(pci_sun4v_iotsb_bind)
-- 
1.9.1

