From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Mar 2015 08:18:43 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <20150328081843.GA27114@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>
 <CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
 <551495EE.20201@oracle.com>
 <CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
 <CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
 <20150328010532.GA15897@ravnborg.org>
 <CAE9FiQVHwR7ge-hFXq=xqOTZEzHdm5AqiwFC3HEcrTKxeDcePg@mail.gmail.com>
In-Reply-To: <CAE9FiQVHwR7ge-hFXq=xqOTZEzHdm5AqiwFC3HEcrTKxeDcePg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Ahern <david.ahern@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

> >>  config ARM_THUMB
> >>       bool "Support Thumb user binaries" if !CPU_THUMBONLY
> >>       depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
> >> Index: linux-2.6/arch/arm64/Kconfig
> >> =================================> >> --- linux-2.6.orig/arch/arm64/Kconfig
> >> +++ linux-2.6/arch/arm64/Kconfig
> >> @@ -125,6 +125,9 @@ config HAVE_GENERIC_RCU_GUP
> >>  config ARCH_DMA_ADDR_T_64BIT
> >>       def_bool y
> >>
> >> +config ARCH_PCI_BUS_ADDR_T_64BIT
> >> +     def_bool y
> >> +
> > Use select
> ...
> 
> I was trying to keep the style to be consistent with old one in each Kconfig.
> 
> So do we just need to make sure new added lines to use new style?

Use new style select everywhere.
That could maybe in the future trigger someone to update the different arch
configs to use select for the remaining bits.

> >> Index: linux-2.6/include/linux/types.h
> >> =================================> >> --- linux-2.6.orig/include/linux/types.h
> >> +++ linux-2.6/include/linux/types.h
> >> @@ -146,6 +146,13 @@ typedef u64 dma_addr_t;
> >>  typedef u32 dma_addr_t;
> >>  #endif /* dma_addr_t */
> >>
> >> +/* A pci_bus_addr_t can hold pci bus address for the platform */
> >> +#ifdef CONFIG_ARCH_PCI_BUS_ADDR_T_64BIT
> >> +typedef u64 pci_bus_addr_t;
> >> +#else
> >> +typedef u32 pci_bus_addr_t;
> >> +#endif /* pci_bus_addr_t */
> >> +
> > Looking att all the Kconfig logic I get the impression that
> > the type of pci_bus_addr_t equals unsigned long.
> > If this is correct then you can skip that and things
> > gets much simpler.
> 
> For x86 32bit with PAE support, we could use 64bit for bus address.
> but unsigned long is 32bit.

Missed that part - OK.

	Sam
