From: Meelis Roos <mroos@linux.ee>
Date: Fri, 06 Jul 2018 19:49:19 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <alpine.LRH.2.21.1807062218350.21056@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee> <20180620220525.GC108993@bhelgaas-glaptop.roam.corp.google.com> <alpine.LRH.2.21.1806291158320.6026@math.ut.ee> <20180629134721.GA98204@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180629134721.GA98204@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

> > Video RAM area related BAR messages are gone from all servers.
> > 
> > V100 OK
> > V120 OK
> > Netra X1 OK
> > Netra T1-200 OK
> > Netra T1-105 OK
> > 
> > T2000 still has "no compatible bridge window" about ULi ISA Bridge:
> > 
> > [    3.767832] pci 0001:05:02.0: can't claim BAR 0 [io  0xf010000000-0xf01000ffff]: no compatible bridge window
> 
> >From the dmesg log at https://bugzilla.kernel.org/show_bug.cgi?id7191,
> 
>   pci_sun4v f0287174: PCI host bridge to bus 0001:02
>   pci_bus 0001:02: root bus resource [io  0xf010000000-0xf01fffffff] (bus address [0x0000-0xfffffff])
>   pci 0001:05:02.0: can't claim BAR 0 [io  0xf010000000-0xf01000ffff]: no compatible bridge window
> 
> BAR 0 could potentially be valid, if the intermediate bridge windows
> were set up correctly.  But from the lspci:
> 
>   0001:02:00.0 PCI bridge: PEX 8532 Upstream Port
>     Bus: primary, secondary, subordinate	
>     I/O behind bridge: 00000000-00002fff
>   0001:03:01.0 PCI bridge: PEX 8532 Downstream Port
>     Bus: primary, secondary, subordinate
>     I/O behind bridge: 00000000-00000fff
>   0001:04:00.0 PCI bridge: PCIe to PCI/PCI-X Bridge
>     Bus: primary, secondary, subordinate
>     I/O behind bridge: 00000000-00000fff
>   0001:05:02.0 ISA bridge: ULi M1533/M1535/M1543 PCI to ISA Bridge
>     Region 0: [virtual] I/O ports at f010000000 [sizedK]
> 
> (lspci normally shows the CPU addresses, but it looks like it's showing
> bus addresses here (except for the 0001:05:02.0 I/O BAR).  That might
> be something we should sort out at some point.  I know sparc does
> things differently in that area.)
> 
> But either way, the 0001:04:00.0 I/O aperture is only 4K in size, and
> apparently OF is telling us the ISA bridge has a 64K I/O BAR, so that
> explains the "no compatible bridge window" message.  We can't fit a
> 64K BAR in a 4K window.
> 
> Do you know if there's an ISA device behind that bridge?  If there
> is, and it only requires I/O ports in the 0-0xfff range, it probably
> still works in spite of the warning.

prtconf shows from OF that a serial port is there:

                        Node 0xf02991b8
                            ignore-cd:
                            reg:  00000000.000003f8.00000008
                            interrupts:  00000001
                            compatible: 'su16550' + 'su'
                            device_type:  'serial'
                            name:  'serial'


> But if it needs anything above 0xfff, or if we decided to be "smart"
> and not enable I/O on the bridge because we think the I/O BAR is
> invalid, it wouldn't work.
> 
> > V245 still has "no compatible bridge window" about ULI ISA Bridge:
> > 
> > [    4.522892] pci 0000:05:1e.0: can't claim BAR 0 [io  0x7f810000000-0x7f810000fff]: no compatible bridge window
> 
> Again from https://bugzilla.kernel.org/show_bug.cgi?id7191,
> 
>   fire f0068b8c: PCI host bridge to bus 0000:02
>   pci_bus 0000:02: root bus resource [io  0x7f810000000-0x7f81fffffff] (bus address [0x0000-0xfffffff])
>   pci 0000:05:1e.0: can't claim BAR 0 [io  0x7f810000000-0x7f810000fff]: no compatible bridge window
> 
>   0000:04:00.0 PCI bridge: ULi M5249 HTT to PCI Bridge
>     Bus: primary, secondary, subordinate
>     I/O behind bridge: 00001000-00001fff
>     Memory behind bridge: 00200000-03ffffff
>   0000:05:1c.0 ULi USB 1.1 Controller [OHCI]
>     Region 0: Memory at 01000000 (32-bit, non-prefetchable) [sizeM]
>   0000:05:1c.1 ULi USB 1.1 Controller [OHCI]
>     Region 0: Memory at 02000000 (32-bit, non-prefetchable) [sizeM]
>   0000:05:1c.3 ULi USB 2.0 Controller [EHCI]
>     Region 0: Memory at 00200000 (32-bit, non-prefetchable) [size=8K]
>   0000:05:1e.0 ISA bridge: ULi M1575 South Bridge
>     Region 0: [virtual] I/O ports at 7f810000000 [size=4K]
>   0000:05:1f.0 ULi M5229 IDE
>     Region 0: I/O ports at 1040 [sized]
>     Region 1: I/O ports at 1080 [sized]
>     Region 2: I/O ports at 10c0 [sized]
>     Region 3: I/O ports at 1100 [sized]
>     Region 4: I/O ports at 1000 [sized]
> 
> The 0000:05:1e.0 I/O BAR (BAR 0) contains 0 (at least according to
> OF).  This is clearly invalid because the bridge at 0000:04:00.0 will
> never route anything to bus 05 with an I/O bus address of 0, so
> nothing behind the 05:1e.0 ISA bridge should work.
> 
> If you still have the v4.18-rc1 logs from these boxes, would you mind
> attaching them to the bugzilla?

Found 4.17.0 and 4.18-rc2+git dmesgs for both T2000 and V245, attached 
there.

-- 
Meelis Roos (mroos@linux.ee)
