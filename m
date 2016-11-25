From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 21:11:10 +0000
Subject: Re: [patch] sparc64: enable IRQs on error paths
Message-Id: <20161125211110.GC28558@mwanda>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125111054.GE5938@mwanda>
In-Reply-To: <20161125111054.GE5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Fri, Nov 25, 2016 at 09:45:24PM +0100, Sam Ravnborg wrote:
> Hi Dan.
> 
> On Fri, Nov 25, 2016 at 02:12:51PM +0300, Dan Carpenter wrote:
> > There are several error paths where we should enable IRQs but we don't.
> > 
> > Fixes: bb620c3d3925 ("sparc: Make sparc64 use scalable lib/iommu-common.c functions")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Please use a more descriptive subject such as:
> sparc64: restore irq in error paths in iommu
>

Is this really "in iommu"?

> > ---
> > Not tested.
> > 
> > diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
> > index 06981cc7..274df7a 100644
> > --- a/arch/sparc/kernel/pci_sun4v.c
> > +++ b/arch/sparc/kernel/pci_sun4v.c
> > @@ -230,12 +230,16 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
> >  
> >  	for (n = 0; n < npages; n++) {
> >  		long err = iommu_batch_add(first_page + (n * PAGE_SIZE), mask);
> > -		if (unlikely(err < 0L))
> > +		if (unlikely(err < 0L)) {
> > +			local_irq_restore(flags);
> >  			goto iommu_map_fail;
> > +		}
> >  	}
> 
> Locate all cleanup after the iommu_map_fail label.
> 
> As it is now the irq_restore is on the error site
> and the free() is at the error label.
> 
> It is very confusing that half of the recovery is in one
> place and the other in another place.

My way is the correct, more elegant way.  When you're allocating things
you do:

	a = alloc();
	b = alloc();
	c = alloc();

	...

	return 0;

free_c:
	free(c);
free_b:
	free(b);
free_a:
	free(a);

	return ret;

Those things build on each other.  We allocate and then free
symetrically.  The locks don't build on each other, we take them and
then release them as needed.  It's just chance that we are holding the
locks for both "goto iommu_map_fail;" statements.  If we added to this
function we would have to move the unlocks back out of the release
path.

The original code was written the way you suggest and it was too
confusing so we introduced a bug.  It was *even commented* but it was
still too confusing.  Best to keep all the locking together.

To be honest, I don't care.  I'll send a v2.

regards,
dan carpenter

