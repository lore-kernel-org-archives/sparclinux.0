From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 28 Feb 2013 21:22:38 +0000
Subject: Re: [PATCH] sparc,leon: support for GRPCI1 PCI host bridge controller
Message-Id: <20130228212237.GA28182@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1362061978-1964-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1362061978-1964-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Daniel.

some nitpicks.

On Thu, Feb 28, 2013 at 03:32:58PM +0100, Daniel Hellstrom wrote:
> Some of the GRPCI1 cores does not support detection of all PCI
> errors, the default is therefore limited PCI error handling.
> The property all_pci_errors my be set by the boot loader to
> enable interrupt on all PCI errors.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  arch/sparc/Kconfig                  |   11 +
>  arch/sparc/kernel/Makefile          |    1 +
>  arch/sparc/kernel/leon_pci_grpci1.c |  725 +++++++++++++++++++++++++++++++++++
>  3 files changed, 737 insertions(+), 0 deletions(-)
>  create mode 100644 arch/sparc/kernel/leon_pci_grpci1.c
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 9bff3db..7f02f72 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -500,6 +500,17 @@ config LEON_PCI
>  	depends on PCI && SPARC_LEON
>  	default y
>  
> +config GRPCI1

I see we do not do so with GRPCI2 - but please prefix
all SPARC specific kconfig symbols with SPARC_

A follow-up patch that fixes GRPCI2 would be nice!

> diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
> new file mode 100644
> index 0000000..0ae4670
> --- /dev/null
> +++ b/arch/sparc/kernel/leon_pci_grpci1.c
> @@ -0,0 +1,725 @@
> +/*
> + * leon_pci_grpci1.c: GRPCI1 Host PCI driver
> + *
> + * Copyright (C) 2013 Aeroflex Gaisler AB
> + *
> + * This GRPCI1 driver does not support PCI interrupts taken from
> + * GPIO pins.
> + *
> + * Contributors: Daniel Hellstrom <daniel@gaisler.com>
> + */
> +
> +#include <linux/of_device.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/of_irq.h>

Sort using inverse christmas tree.
Longest lines at top - equal length lines alphabetically.
And add an empty line between <linux/...> and <asm/...> includes.

> +#include <asm/io.h>
> +#include <asm/leon.h>
> +#include <asm/vaddrs.h>
> +#include <asm/sections.h>
> +#include <asm/leon_pci.h>
> +
> +#include "irq.h"
> +
> +/* Enable/Disable Debugging Configuration Space Access */
> +#undef GRPCI1_DEBUG_CFGACCESS
> +
> +/*
> + * GRPCI1 APB Register MAP
> + */
> +struct grpci1_regs {
> +	unsigned int cfg_stat;		/* 0x00 Configuration / Status */
> +	unsigned int bar0;		/* 0x04 BAR0 (RO) */
> +	unsigned int page0;		/* 0x08 PAGE0 (RO) */
> +	unsigned int bar1;		/* 0x0C BAR1 (RO) */
> +	unsigned int page1;		/* 0x10 PAGE1 */
> +	unsigned int iomap;		/* 0x14 IO Map */
> +	unsigned int stat_cmd;		/* 0x18 PCI Status & Command (RO) */
> +	unsigned int irq;		/* 0x1C Interrupt register */
> +};
> +
> +#define REGLOAD(a)	(be32_to_cpu(__raw_readl(&(a))))
> +#define REGSTORE(a, v)	(__raw_writel(cpu_to_be32(v), &(a)))
> +
> +#define PAGE0_BTEN_BIT    0
> +#define PAGE0_BTEN        (1 << PAGE0_BTEN_BIT)
> +
> +#define CFGSTAT_HOST_BIT  13
> +#define CFGSTAT_CTO_BIT   8
> +#define CFGSTAT_HOST      (1 << CFGSTAT_HOST_BIT)
> +#define CFGSTAT_CTO       (1 << CFGSTAT_CTO_BIT)
> +
> +#define IRQ_DPE (1 << 9)
> +#define IRQ_SSE (1 << 8)
> +#define IRQ_RMA (1 << 7)
> +#define IRQ_RTA (1 << 6)
> +#define IRQ_STA (1 << 5)
> +#define IRQ_DPED (1 << 4)
> +#define IRQ_INTD (1 << 3)
> +#define IRQ_INTC (1 << 2)
> +#define IRQ_INTB (1 << 1)
> +#define IRQ_INTA (1 << 0)
> +#define IRQ_DEF_ERRORS (IRQ_RMA | IRQ_RTA | IRQ_STA)
> +#define IRQ_ALL_ERRORS (IRQ_DPED | IRQ_DEF_ERRORS | IRQ_SSE | IRQ_DPE)
> +#define IRQ_INTX (IRQ_INTA | IRQ_INTB | IRQ_INTC | IRQ_INTD)
> +#define IRQ_MASK_BIT 16
> +
> +#define DEF_PCI_ERRORS (PCI_STATUS_SIG_TARGET_ABORT | \
> +			PCI_STATUS_REC_TARGET_ABORT | \
> +			PCI_STATUS_REC_MASTER_ABORT)
> +#define ALL_PCI_ERRORS (PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY | \
> +			PCI_STATUS_SIG_SYSTEM_ERROR | DEF_PCI_ERRORS)
> +
> +#define TGT 256
> +
> +struct grpci1_priv {
> +	struct leon_pci_info	info; /* must be on top of this structure */
> +	struct grpci1_regs	*regs;
> +	struct device		*dev;
> +	int			pci_err_mask;
> +	int			irq;
> +	unsigned char		irq_map[4];
> +
> +	/* Virtual IRQ numbers */
> +	unsigned int		virq_err;

In all new code I add I use "irq" for the irq numbers.
This mathces the generic irq code.

But I know that a lot of sparc code uses virq.

> +	/* AHB PCI Windows */
> +	unsigned long		pci_area;	/* MEMORY */
> +	unsigned long		pci_area_end;
> +	unsigned long		pci_io;		/* I/O */
> +	unsigned long		pci_conf;	/* CONFIGURATION */
> +	unsigned long		pci_conf_end;
> +	unsigned long		pci_io_va;
> +};
> +
> +DEFINE_SPINLOCK(grpci1_dev_lock);
> +struct grpci1_priv *grpci1priv;
static?

	Sam
