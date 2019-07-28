From: Denis Efremov <efremov@linux.com>
Date: Sun, 28 Jul 2019 20:22:09 +0000
Subject: [PATCH 1/5] PCI: Convert pci_resource_to_user to a weak function
Message-Id: <20190728202213.15550-2-efremov@linux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190728202213.15550-1-efremov@linux.com>
In-Reply-To: <20190728202213.15550-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

The patch turns pci_resource_to_user() to a weak function. Thus,
architecture-specific versions will automatically override the generic
one. This allows to remove the HAVE_ARCH_PCI_RESOURCE_TO_USER macro and
avoid the conditional compilation for this single function.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/pci.c   |  8 ++++++++
 include/linux/pci.h | 18 +++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ed5ec1ac27..f9dc7563a8b9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5932,6 +5932,14 @@ resource_size_t __weak pcibios_default_alignment(void)
 	return 0;
 }
 
+void __weak pci_resource_to_user(const struct pci_dev *dev, int bar,
+		const struct resource *rsrc, resource_size_t *start,
+		resource_size_t *end)
+{
+	*start = rsrc->start;
+	*end = rsrc->end;
+}
+
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9f28..1a19d0151b0a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1870,25 +1870,13 @@ static inline const char *pci_name(const struct pci_dev *pdev)
 	return dev_name(&pdev->dev);
 }
 
-
 /*
  * Some archs don't want to expose struct resource to userland as-is
  * in sysfs and /proc
  */
-#ifdef HAVE_ARCH_PCI_RESOURCE_TO_USER
-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-			  const struct resource *rsrc,
-			  resource_size_t *start, resource_size_t *end);
-#else
-static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
-		const struct resource *rsrc, resource_size_t *start,
-		resource_size_t *end)
-{
-	*start = rsrc->start;
-	*end = rsrc->end;
-}
-#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
-
+void __weak pci_resource_to_user(const struct pci_dev *dev, int bar,
+				 const struct resource *rsrc,
+				 resource_size_t *start, resource_size_t *end);
 
 /*
  * The world is not perfect and supplies us with broken PCI devices.
-- 
2.21.0
