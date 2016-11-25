From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 13:46:42 +0000
Subject: Re: [patch] sparc64: enable IRQs on error paths
Message-Id: <20161125133524.GA28558@mwanda>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125111054.GE5938@mwanda>
In-Reply-To: <20161125111054.GE5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Fri, Nov 25, 2016 at 08:11:44AM -0500, Sowmini Varadhan wrote:
> On (11/25/16 16:01), Dan Carpenter wrote:
> > I'm pretty sure the Fixes tag is correct.  Originally it did:
> > 
> > +iommu_map_fail:
> > +       /* Interrupts are disabled.  */
> > +       spin_lock(&iommu->lock);
> > +       pci_arena_free(&iommu->arena, entry, npages);
> > +       spin_unlock_irqrestore(&iommu->lock, flags);
> > +
> 
> In that case why dont you just do the local_irq_restore
> once at the iommu_map_fail label?

I thought this way was easier to read.  It doesn't really matter?

regards,
dan carpenter

