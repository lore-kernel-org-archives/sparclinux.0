From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 17 Mar 2009 12:03:24 +0000
Subject: [PATCH] crash with /proc/iomem on sparc64
Message-Id: <Pine.LNX.4.64.0903170758060.24107@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi

When you compile kernel on Sparc64 with heap memory checking and type
"cat /proc/iomem", you get a crash, because pointers in struct resource 
are uninitialized.

Most code fills struct resource with zeros, so I assume that it is 
responsibility of the caller of request_resource to initialized it, not 
the responsibility of request_resource functuion.

After 2.6.29 is out, there could be a check for uninitialized fields added 
to request_resource to avoid crashes like this.

Mikulas

---
 arch/sparc/kernel/pci_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.29-rc8-devel/arch/sparc/kernel/pci_common.c
=================================--- linux-2.6.29-rc8-devel.orig/arch/sparc/kernel/pci_common.c	2009-03-17 12:49:51.000000000 +0100
+++ linux-2.6.29-rc8-devel/arch/sparc/kernel/pci_common.c	2009-03-17 12:50:16.000000000 +0100
@@ -368,7 +368,7 @@ static void pci_register_iommu_region(st
 	const u32 *vdma = of_get_property(pbm->op->node, "virtual-dma", NULL);
 
 	if (vdma) {
-		struct resource *rp = kmalloc(sizeof(*rp), GFP_KERNEL);
+		struct resource *rp = kzalloc(sizeof(*rp), GFP_KERNEL);
 
 		if (!rp) {
 			prom_printf("Cannot allocate IOMMU resource.\n");
