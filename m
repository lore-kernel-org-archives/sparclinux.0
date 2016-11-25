From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 25 Nov 2016 13:11:44 +0000
Subject: Re: [patch] sparc64: enable IRQs on error paths
Message-Id: <20161125131144.GB7578@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161125111054.GE5938@mwanda>
In-Reply-To: <20161125111054.GE5938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On (11/25/16 16:01), Dan Carpenter wrote:
> I'm pretty sure the Fixes tag is correct.  Originally it did:
> 
> +iommu_map_fail:
> +       /* Interrupts are disabled.  */
> +       spin_lock(&iommu->lock);
> +       pci_arena_free(&iommu->arena, entry, npages);
> +       spin_unlock_irqrestore(&iommu->lock, flags);
> +

In that case why dont you just do the local_irq_restore
once at the iommu_map_fail label?

--Sowmini

