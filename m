From: Julia Lawall <julia@diku.dk>
Date: Sat, 31 Jul 2010 09:35:17 +0000
Subject: question about arch/sparc/mm/iommu.c
Message-Id: <Pine.LNX.4.64.1007311132590.6434@ask.diku.dk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function sbus_iommu_init in arch/sparc/mm/iommu.c sometimes uses 
GFP_ATOMIC and sometimes GFP_KERNEL.  Is there a reason for that?

static void __init sbus_iommu_init(struct platform_device *op)
{
        struct iommu_struct *iommu;
	unsigned int impl, vers;
        unsigned long *bitmap;
        unsigned long tmp;

        iommu = kmalloc(sizeof(struct iommu_struct), GFP_ATOMIC);
	...
        /* Allocate IOMMU page table */
	/* Stupid alignment constraints give me a headache.
           We need 256K or 512K or 1M or 2M area aligned to
           its size and current gfp will fortunately give
           it to us. */
        tmp = __get_free_pages(GFP_KERNEL, IOMMU_ORDER);
	...
	bitmap = kmalloc(IOMMU_NPTES>>3, GFP_KERNEL);
	...
}

--------------------

julia
