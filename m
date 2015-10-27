From: "Busch, Keith" <keith.busch@intel.com>
Date: Tue, 27 Oct 2015 14:06:47 +0000
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-Id: <20151027140647.GA15583@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com>
 <562F1368.1030204@ozlabs.ru>
In-Reply-To: <562F1368.1030204@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 27, 2015 at 05:02:16PM +1100, Alexey Kardashevskiy wrote:
> >+unsigned long dma_get_page_shift(struct device *dev)
> >+{
> >+	struct iommu_table *tbl = get_iommu_table_base(dev);
> >+	if (tbl)
> >+		return tbl->it_page_shift;
> 
> 
> All PCI devices have this initialized on POWER (at least, our, IBM's
> POWER) so 4K will always be returned here while in the case of
> (get_dma_ops(dev)=&dma_direct_ops) it could actually return
> PAGE_SHIFT. Is 4K still preferred value to return here?

4k is always a safe option to return, but ideally you want to return the
highest guaranteed DMA address alignment. The driver just needs to know
which bits to mask from virtual addresses such that the offset is the
same as the DMA address.
