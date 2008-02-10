From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Sun, 10 Feb 2008 20:16:57 +0000
Subject: [PATCH] SPARC64:  Use shorter "get_zeroed_page" call.
Message-Id: <alpine.LFD.1.00.0802101516030.15057@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/sparc64/kernel/iommu.c b/arch/sparc64/kernel/iommu.c
index d3276eb..0e347ff 100644
--- a/arch/sparc64/kernel/iommu.c
+++ b/arch/sparc64/kernel/iommu.c
@@ -200,12 +200,11 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
 	/* Allocate and initialize the dummy page which we
 	 * set inactive IO PTEs to point to.
 	 */
-	iommu->dummy_page = __get_free_pages(GFP_KERNEL, 0);
+	iommu->dummy_page = get_zeroed_page(GFP_KERNEL);
 	if (!iommu->dummy_page) {
 		printk(KERN_ERR "IOMMU: Error, gfp(dummy_page) failed.\n");
 		goto out_free_map;
 	}
-	memset((void *)iommu->dummy_page, 0, PAGE_SIZE);
 	iommu->dummy_page_pa = (unsigned long) __pa(iommu->dummy_page);

 	/* Now allocate and setup the IOMMU page table itself.  */


====================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

Home page:                                         http://crashcourse.ca
Fedora Cookbook:    http://crashcourse.ca/wiki/index.php/Fedora_Cookbook
====================================
