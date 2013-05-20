From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 20 May 2013 23:42:01 +0000
Subject: Re: [PATCH 1/2] powerpc/PCI: Use PCI_UNKNOWN for unknown power state
Message-Id: <1369093321.6387.24.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
In-Reply-To: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org

On Mon, 2013-05-20 at 17:19 -0600, Bjorn Helgaas wrote:
> Previously we initialized dev->current_state to 4 (PCI_D3cold), but I think
> we wanted PCI_UNKNOWN (5) here based on the comment and the fact that the
> generic version of this code, pci_setup_device(), uses PCI_UNKNOWN.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Ack. Do you send to Linus or should I ?

Thanks.

Cheers,
Ben.

>  arch/powerpc/kernel/pci_of_scan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 2a67e9b..d2d407d 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -165,7 +165,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>  	pr_debug("    class: 0x%x\n", dev->class);
>  	pr_debug("    revision: 0x%x\n", dev->revision);
>  
> -	dev->current_state = 4;		/* unknown power state */
> +	dev->current_state = PCI_UNKNOWN;	/* unknown power state */
>  	dev->error_state = pci_channel_io_normal;
>  	dev->dma_mask = 0xffffffff;
>  


