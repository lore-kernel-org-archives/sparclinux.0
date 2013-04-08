From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 08 Apr 2013 05:25:23 +0000
Subject: Re: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics adapters on Power
Message-Id: <20130408052522.GB9550@concordia>
List-Id: <sparclinux.vger.kernel.org>
References: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
 <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com>
In-Reply-To: <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, klebers@linux.vnet.ibm.com, Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>, sparclinux@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Fri, Apr 05, 2013 at 02:11:01PM -0600, Bjorn Helgaas wrote:
> On Thu, Apr 4, 2013 at 3:58 PM, Brian King <brking@linux.vnet.ibm.com> wrote:
> >
> > Initialize dev->dev.type such that the PCI group attributes for boot_vga
> > and SR-IOV can be displayed if appropriate. This fixes an issue seen on
> > Power preventing X from auto initializing a graphics adapter when using KMS.
> >
> > Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> > ---
> >
> >  arch/powerpc/kernel/pci_of_scan.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff -puN arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type arch/powerpc/kernel/pci_of_scan.c
> > --- linux/arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type    2013-04-03 09:43:19.000000000 -0500
> > +++ linux-bjking1/arch/powerpc/kernel/pci_of_scan.c     2013-04-03 09:43:19.000000000 -0500
> > @@ -141,6 +141,7 @@ struct pci_dev *of_create_pci_dev(struct
> >         dev->dev.of_node = of_node_get(node);
> >         dev->dev.parent = bus->bridge;
> >         dev->dev.bus = &pci_bus_type;
> > +       dev->dev.type = &pci_dev_type;
> >         dev->devfn = devfn;
> >         dev->multifunction = 0;         /* maybe a lie? */
> >         dev->needs_freset = 0;          /* pcie fundamental reset required */
> 
> I think sparc has the same issue in its own copy of of_create_pci_dev().
> 
> Of course, both of_create_pci_dev() implementations are basically
> copies of the generic pci_setup_device() that most arches use.  That's
> the reason why I wish sparc and powerpc had used config space
> accessors that hid the OF mangling internally so they could use the
> generic pci_setup_device() instead of cloning it.
> 
> Of course, they don't, and that's too much work for fixing this issue,
> but if anybody wanted to work on that, I think it would be an
> interesting project.
> 
> But what if you set dev->dev.type in alloc_pci_dev()?  I think if you
> did that, you wouldn't need to export "pci_dev_type," and  it should
> fix this for both powerpc and sparc.

That sounds good, Brian can you confirm that works and send a new series
using that technique.

cheers
