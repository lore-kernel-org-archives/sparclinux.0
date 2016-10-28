From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Fri, 28 Oct 2016 00:23:32 +0000
Subject: [PATCH v2 6/6] sparc64: Enable 64-bit DMA
Message-Id: <1477614212-13466-7-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1477614212-13466-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1477614212-13466-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, jroedel@suse.de, egtvedt@samfundet.no, robin.murphy@arm.com, m.szyprowski@samsung.com, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

ATU 64bit addressing allows PCIe devices with 64bit DMA capabilities
to use ATU for 64bit DMA.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Reviewed-by: chris hyser <chris.hyser@oracle.com>
Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 arch/sparc/Kconfig        | 4 ++++
 arch/sparc/kernel/iommu.c | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5202eb4..60145c9 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -93,6 +93,10 @@ config ARCH_ATU
 	bool
 	default y if SPARC64
 
+config ARCH_DMA_ADDR_T_64BIT
+	bool
+	default y if ARCH_ATU
+
 config IOMMU_HELPER
 	bool
 	default y if SPARC64
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 5c615ab..852a329 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -760,8 +760,12 @@ int dma_supported(struct device *dev, u64 device_mask)
 	struct iommu *iommu = dev->archdata.iommu;
 	u64 dma_addr_mask = iommu->dma_addr_mask;
 
-	if (device_mask >= (1UL << 32UL))
-		return 0;
+	if (device_mask > DMA_BIT_MASK(32)) {
+		if (iommu->atu)
+			dma_addr_mask = iommu->atu->dma_addr_mask;
+		else
+			return 0;
+	}
 
 	if ((device_mask & dma_addr_mask) = dma_addr_mask)
 		return 1;
-- 
1.9.1

