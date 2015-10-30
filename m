From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 30 Oct 2015 21:35:11 +0000
Subject: [PATCH 1/1 v3] drivers/nvme: default to 4k device page size
Message-Id: <20151030213511.GK7716@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
In-Reply-To: <20151029172043.GA8343@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 29.10.2015 [17:20:43 +0000], Busch, Keith wrote:
> On Thu, Oct 29, 2015 at 08:57:01AM -0700, Nishanth Aravamudan wrote:
> > On 29.10.2015 [04:55:36 -0700], Christoph Hellwig wrote:
> > > We had a quick cht about this issue and I think we simply should
> > > default to a NVMe controler page size of 4k everywhere as that's the
> > > safe default.  This is also what we do for RDMA Memory reigstrations and
> > > it works fine there for SRP and iSER.
> > 
> > So, would that imply changing just the NVMe driver code rather than
> > adding the dma_page_shift API at all? What about
> > architectures that can support the larger page sizes? There is an
> > implied performance impact, at least, of shifting the IO size down.
> 
> It is the safe option, but you're right that it might have a
> measurable performance impact (can you run an experiment?). Maybe we
> should just change the driver to always use MPSMIN for the moment in
> the interest of time, and you can flush out the new API before the
> next merge window.

Given that it's 4K just about everywhere by default (and sort of
implicitly expected to be, I guess), I think I'd prefer we default to
4K. That should mitigate the performance impact (I'll ask our IO team to
do some runs, but since this impacts functionality on some hardware, I
don't think it's too relevant for now). Unless there are NVMe devcies
with a MPSMAX < 4K? 

Something like the following?



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

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ccc0c1f93daa..a9a5285bdb39 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1717,7 +1717,12 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
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
 	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
 




-Nish

