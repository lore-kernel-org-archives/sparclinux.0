From: Denis Efremov <efremov@linux.com>
Date: Sun, 28 Jul 2019 20:22:13 +0000
Subject: [PATCH 5/5] spark/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Message-Id: <20190728202213.15550-6-efremov@linux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190728202213.15550-1-efremov@linux.com>
In-Reply-To: <20190728202213.15550-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

The function pci_resource_to_user() was turned to a weak one. Thus,
spark-specific version will automatically override the generic one
and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/sparc/include/asm/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/pci.h b/arch/sparc/include/asm/pci.h
index cfec79bb1831..4deddf430e5d 100644
--- a/arch/sparc/include/asm/pci.h
+++ b/arch/sparc/include/asm/pci.h
@@ -38,8 +38,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define arch_can_pci_mmap_io()	1
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
-
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
 #endif /* CONFIG_SPARC64 */
 
 #if defined(CONFIG_SPARC64) || defined(CONFIG_LEON_PCI)
-- 
2.21.0
