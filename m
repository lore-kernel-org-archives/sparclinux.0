From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 08 Apr 2013 05:21:25 +0000
Subject: Re: [PATCH 3/3] powerpc: Set default VGA device
Message-Id: <20130408052124.GA9550@concordia>
List-Id: <sparclinux.vger.kernel.org>
References: <201304042158.r34LwGPg010714@d03av02.boulder.ibm.com>
 <CAErSpo4LsJjRkw6UektwqW8m1NXdU6BTjhTDA9eORM3z3qDcdA@mail.gmail.com>
In-Reply-To: <CAErSpo4LsJjRkw6UektwqW8m1NXdU6BTjhTDA9eORM3z3qDcdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>, klebers <klebers@linux.vnet.ibm.com>, sparclinux@vger.kernel.org

On Fri, Apr 05, 2013 at 02:24:09PM -0600, Bjorn Helgaas wrote:
> On Thu, Apr 4, 2013 at 3:58 PM, Brian King <brking@linux.vnet.ibm.com> wrote:
> > @@ -1725,3 +1726,15 @@ static void fixup_hide_host_resource_fsl
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);
> > +
> > +static void fixup_vga(struct pci_dev *pdev)
> > +{
> > +       u16 cmd;
> > +
> > +       pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +       if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
> > +               vga_set_default_device(pdev);
> > +
> > +}
> > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> > +                             PCI_CLASS_DISPLAY_VGA, 8, fixup_vga);
> 
> This not really an arch-specific issue, so it's a shame to add another
> arch-specific quirk for it (in addition to the x86 and ia64 ones we
> already have).
> 
> In b5e4efe7e0, Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com> tried to
> make this quirk generic, but the implementation was naive and it
> didn't work for sparc64.  There's a good thread about the sparc issue
> at https://lkml.org/lkml/2006/10/19/17
> 
> The outcome was to basically revert back to arch-specific quirks with
> 6b5c76b8e2, but I think the generic version probably could have been
> made to work, possibly with a pcibios hook or something for anything
> that really is arch-dependent, like the shadowed ROM image.
> 
> This particular patch is arch-specific, and I'm not going to try to
> nack it because I'm not the powerpc maintainer, but I will certainly
> try to help you if you want to push on making a generic version.

OK.

Looking at x86, ia64 and ours, there's a fair bit of difference.

x86/ia64 both walk up the parents checking PCI_BRIDGE_CTL_VGA, which
powerpc doesn't (though maybe it should?).

x86/ia64 set IORESOURCE_ROM_SHADOW, which powerpc doesn't.

ia64 doesn't call vga_set_default_device(), x86 and powerpc do.

So we'll merge this and maybe someone can tease out the common bits, but
personally I don't see that there's an obvious chunk of generic logic.

cheers
