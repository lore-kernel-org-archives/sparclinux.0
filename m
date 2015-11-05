From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Thu, 05 Nov 2015 17:01:45 +0000
Subject: [PATCH 1/1 v4] drivers/nvme: default to 4k device page size
Message-Id: <20151105170145.GB16308@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
 <20151103134624.GG13904@localhost.localdomain>
In-Reply-To: <20151103134624.GG13904@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03.11.2015 [13:46:25 +0000], Keith Busch wrote:
> On Tue, Nov 03, 2015 at 05:18:24AM -0800, Christoph Hellwig wrote:
> > On Fri, Oct 30, 2015 at 02:35:11PM -0700, Nishanth Aravamudan wrote:
> > > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > > index ccc0c1f93daa..a9a5285bdb39 100644
> > > --- a/drivers/block/nvme-core.c
> > > +++ b/drivers/block/nvme-core.c
> > > @@ -1717,7 +1717,12 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
> > >  	u32 aqa;
> > >  	u64 cap = readq(&dev->bar->cap);
> > >  	struct nvme_queue *nvmeq;
> > > -	unsigned page_shift = PAGE_SHIFT;
> > > +	/*
> > > +	 * default to a 4K page size, with the intention to update this
> > > +	 * path in the future to accomodate architectures with differing
> > > +	 * kernel and IO page sizes.
> > > +	 */
> > > +	unsigned page_shift = 12;
> > >  	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
> > >  	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
> > 
> > Looks good as a start.  Note that all the MPSMIN/MAX checking could
> > be removed as NVMe devices must support 4k pages.
> 
> MAX can go, and while it's probably the case that all devices support 4k,
> it's not a spec requirement, so we should keep the dev_page_min check.

Ok, here's an updated patch.

We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).

The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).

In this particular case of page sizes, we clearly want to use the
IOMMU's page size in the driver. And generally, the NVMe driver in this
function should be using the IOMMU's page size for the default device
page size, rather than the kernel's page size. There is not currently an
API to obtain the IOMMU's page size across all architectures and in the
interest of a stop-gap fix to this functional issue, default the NVMe
device page size to 4K, with the intent of adding such an API and
implementation across all architectures in the next merge window.

With the functionally equivalent v3 of this patch, our hardware test
exerciser survives when using 32-bit DMA; without the patch, the kernel
will BUG within a few minutes.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
v1 -> v2:
  Based upon feedback from Christoph Hellwig, implement the IOMMU page
  size lookup as a generic DMA API, rather than an architecture-specific
  hack.

v2 -> v3:
  In the interest of fixing the functional problem in the short-term,
  just force the device page size to 4K and work on adding the new API
  in the next merge window.

v3 -> v4:
  Rebase to the 4.3, including the new code locations.
  Based upon feedback from Keith Busch and Christoph Hellwig, remove the
  device max check, as the spec requires MPSMAX >= 4K.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e878590e71b6..00ca45bb0bc0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1701,9 +1701,13 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u32 aqa;
 	u64 cap = readq(&dev->bar->cap);
 	struct nvme_queue *nvmeq;
-	unsigned page_shift = PAGE_SHIFT;
+	/*
+	 * default to a 4K page size, with the intention to update this
+	 * path in the future to accomodate architectures with differing
+	 * kernel and IO page sizes.
+	 */
+	unsigned page_shift = 12;
 	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
-	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
 
 	if (page_shift < dev_page_min) {
 		dev_err(dev->dev,
@@ -1712,13 +1716,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 				1 << page_shift);
 		return -ENODEV;
 	}
-	if (page_shift > dev_page_max) {
-		dev_info(dev->dev,
-				"Device maximum page size (%u) smaller than "
-				"host (%u); enabling work-around\n",
-				1 << dev_page_max, 1 << page_shift);
-		page_shift = dev_page_max;
-	}
 
 	dev->subsystem = readl(&dev->bar->vs) >= NVME_VS(1, 1) ?
 						NVME_CAP_NSSRC(cap) : 0;

