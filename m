From: "Helge Deller" <deller@gmx.de>
Date: Wed, 19 Aug 2015 14:06:38 +0000
Subject: Aw: Re:  A500 boot crash in 4.2.0-rc3-00246-g763e326
Message-Id: <trinity-ceafa563-3aad-4955-a6c6-205a2caf1e95-1439993198188@3capp-gmx-bs16>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507260929000.30065@math.ut.ee>
 <trinity-122a736f-3aac-4830-afc5-2abcd91792ea-1439820380917@3capp-gmx-bs71>
 <trinity-5720bef8-5a4c-4465-b9eb-622daaef650a-1439902901415@3capp-gmx-bs02>
 <alpine.LRH.2.20.1508182141200.24742@math.ut.ee> <55D38BE6.6080302@gmx.de>
 <CAE9FiQVUUN-SLO0U4G5CC6MEoXfb=bGd+f3bRgQprtaMHjsvpA@mail.gmail.com>
 <alpine.LRH.2.20.1508190747360.5154@math.ut.ee>
 <CAE9FiQW9hjDe2NBEfwQqcVZoJKqDjKT1P=7FcGjhVrF7wQW9+g@mail.gmail.com>,
 <BLU436-SMTP773488774A8C76BF6C12E597670@phx.gbl>
In-Reply-To: <BLU436-SMTP773488774A8C76BF6C12E597670@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John David Anglin <dave.anglin@bell.net>
Cc: Yinghai Lu <yinghai@kernel.org>, Meelis Roos <mroos@linux.ee>, linux-parisc@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>

> On 2015-08-19, at 1:30 AM, Yinghai Lu wrote:
> > On Tue, Aug 18, 2015 at 9:48 PM, Meelis Roos <mroos@linux.ee> wrote:
> >>> On Tue, Aug 18, 2015 at 12:47 PM, Helge Deller <deller@gmx.de> wrote:
> >>> 
> >>> Then we should change to
> >>> 
> >>> config PCI_BUS_ADDR_T_64BIT
> >>>       def_bool y if (ARCH_DMA_ADDR_T_64BIT || SPARC64)
> >>>       depends on PCI
> >> 
> >> Why SPARC64? The problem happened on parisc.
> > so will not set PCI_BUS_ADDR_T_64BIT for parisc.

I think given the current time frame it's probably the best approach to fix this problem for kernel 4.2.
It reverts the behaviour back to how it was before (for all arches beside SPARC64).
I'm still wondering if/why parisc is the only arch (in the sym53c8xx driver only!) which broke by this change...

> I'm not sure this is optimal.  While the A500 may only have 32-bit PCI, c8000 appears to have a mix
> of 32 and 64-bit, and rp34XX is all 64-bit.

True, but probably nobody of us noticed that we only used the 32-bit PCI interface even with 64bit kernel on parisc up to now?
pci_bus_alloc_resource() in drivers/pci/bus.c just disabled (flag=0) all 64bit resources for us.
But I agree, I think we need to fix drivers/parisc/lba_pci.c to correctly cope with 64bit pci addresses.

In the meantime I did some more debugging on sym_iomap_device() in drivers/scsi/sym53c8xx_2/sym_glue.c:
   pcibios_resource_to_bus(pdev->bus, &bus_addr,
                          &pdev->resource[i]);
   ram_base = bus_addr.start;

with (working) 32bit PCI addresses I get:
ressource = [mem 0xffffffff80002000-0xffffffff80003fff 64bit]
and pcibios_resource_to_bus() returning: ram_base = 0x80002000 

and with (failing) 64bit PCI addresses I get:
ressource = [mem 0xfffffff004000000-0xfffffff004001fff 64bit]
and pcibios_resource_to_bus() returning: ram_base = 0xfffffff004000000 

It seems the resource window doesn't get initialized correctly for 64bit...

Helge
