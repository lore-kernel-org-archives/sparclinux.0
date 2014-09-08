From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 08 Sep 2014 07:48:52 +0000
Subject: [PATCH v2] sparc32, leon: Make leon_dma_ops avaiable when !CONFIG_PCI
Message-Id: <1410162532-25159-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1409657655-17846-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1409657655-17846-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, sam@ravnborg.org, linux-kernel@vger.kernel.org, software@gaisler.com

The leon_dma_ops struct is needed for leon regardless of PCI configuration.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
Changes from v1: Fixed typo in commit message

 arch/sparc/include/asm/dma-mapping.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 1ee0271..5b1b52a 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -20,10 +20,12 @@ extern struct bus_type pci_bus_type;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-#if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
+#ifdef CONFIG_SPARC_LEON
 	if (sparc_cpu_model = sparc_leon)
 		return leon_dma_ops;
-	else if (dev->bus = &pci_bus_type)
+#endif
+#if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
+	if (dev->bus = &pci_bus_type)
 		return &pci32_dma_ops;
 #endif
 	return dma_ops;
-- 
1.7.10.4

