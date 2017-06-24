From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Sat, 24 Jun 2017 09:13:28 +0000
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-Id: <20170624091328.GY4902@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20170623214538.25967-1-palmer@dabbelt.com>
In-Reply-To: <20170623214538.25967-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> We wanted to add RISC-V to the list of architectures that used the
> generic PCI setup-irq.o inside the Makefile and it was suggested that
> instead we define a Kconfig entry and use that.
> 
> I've done very minimal testing on this: I just checked to see that
> an aarch64 defconfig still build setup-irq.o with the patch applied.
> The intention is that this patch doesn't change the behavior of any
> build.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Looks fine from an ARM point of view, thanks.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e0cacb7b8563..658c9f95ab3f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -131,6 +131,9 @@ config PCI_HYPERV
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
>  
> +config PCI_GENERIC_SETUP
> +	def_bool n

	bool

would be sufficient here - the default is 'n' for all options.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
