From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 15 Sep 2012 07:32:10 +0000
Subject: Re: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
Message-Id: <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -17,6 +17,14 @@
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
>
> +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int irq)
> +{
> +#ifdef CONFIG_PCI_DEBUG
> +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
> +              pci_name(dev));

pr_debug()?
Or even better, dev_dbg()?

> +#endif
> +       pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
