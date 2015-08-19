From: Meelis Roos <mroos@linux.ee>
Date: Wed, 19 Aug 2015 10:40:46 +0000
Subject: Re: Aw: A500 boot crash in 4.2.0-rc3-00246-g763e326
Message-Id: <alpine.LRH.2.20.1508191340020.31468@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507260929000.30065@math.ut.ee> <trinity-122a736f-3aac-4830-afc5-2abcd91792ea-1439820380917@3capp-gmx-bs71> <trinity-5720bef8-5a4c-4465-b9eb-622daaef650a-1439902901415@3capp-gmx-bs02> <alpine.LRH.2.20.1508182141200.24742@math.ut.ee>
 <55D38BE6.6080302@gmx.de> <CAE9FiQVUUN-SLO0U4G5CC6MEoXfb=bGd+f3bRgQprtaMHjsvpA@mail.gmail.com>
In-Reply-To: <CAE9FiQVUUN-SLO0U4G5CC6MEoXfb=bGd+f3bRgQprtaMHjsvpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>

> >>> I did a bisect and commit 3a9ad0b4fdcd57f775d3615004c8c64c021a9e7d ("PCI:
> >>> Add pci_bus_addr_t") seems to be the culprit:
> >>>
> >>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id:9ad0b4fdcd57f775d3615004c8c64c021a9e7d
> >>
> >> CC: patch author and linux-pci.
> >
> >
> > I think this is the problem:
> >
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -1,6 +1,10 @@
> >  #
> >  # PCI configuration
> >  #
> > +config PCI_BUS_ADDR_T_64BIT
> > +       def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
> > +       depends on PCI
> 
> Thanks for bisecting.
> 
> Then we should change to
> 
> config PCI_BUS_ADDR_T_64BIT
>        def_bool y if (ARCH_DMA_ADDR_T_64BIT || SPARC64)
>        depends on PCI

This works for my A500.

-- 
Meelis Roos (mroos@linux.ee)
