From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 11 Apr 2018 13:33:34 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <20180411133334.GA91792@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
 <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804102144240.32411@math.ut.ee>
 <20180410185610.GD24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804111045330.18432@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1804111045330.18432@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, Apr 11, 2018 at 10:59:19AM +0300, Meelis Roos wrote:
> > Oops, sorry, I can't easily compile test it.  Here's an updated patch:
> > 
> > commit a9ded309cbf3f57e9979848fd0aa0ffacdf11f1a
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Apr 10 08:47:34 2018 -0500
> 
> Thanks, this patch compiles and works - Video RAM related BAR allocation 
> errors are gone.

Great, thanks!  I didn't mean to take up so much of your time testing
*all* of your systems :)

> Hera are the /proc/iomem's but unfortunately the physical 
> addresses have been censored by security:

If you look at /proc/iomem as root, you should see the actual
addresses.

If you have any systems with VGA, it would be useful to test one of
them.  

I took a quick look through your lspci logs, and it *looks* like the
Blade 100 has a VGA at 00:13.0, but I don't see the "Video RAM area"
entry in /proc/iomem that I expected:

> Blade 100: Video RAM related BAR error is gnone, this is still here:
> [    6.131499] pci 0000:00:07.0: can't claim BAR 0 [io  0x1fe02000000-0x1fe0200ffff]: address conflict with 0000:00:03.0 [io  0x1fe02000600-0x1fe0200061f]
> 
> 00000000-00000000 : System RAM
>   00000000-00000000 : Kernel code
>   00000000-00000000 : Kernel data
>   00000000-00000000 : Kernel bss
> 00000000-00000000 : System RAM
> 00000000-00000000 : System RAM
> 00000000-00000000 : /pci@1f,0
>   00000000-00000000 : 0000:00:07.0
>   00000000-00000000 : 0000:00:0c.1
>     00000000-00000000 : sungem
>   00000000-00000000 : 0000:00:0c.2
>   00000000-00000000 : 0000:00:0c.2
>   00000000-00000000 : 0000:00:08.0
>   00000000-00000000 : 0000:00:13.0
>   00000000-00000000 : 0000:00:13.0
>   00000000-00000000 : 0000:00:0c.1
>   00000000-00000000 : 0000:00:0c.2
>   00000000-00000000 : 0000:00:0c.3
>   00000000-00000000 : 0000:00:0c.3
>     00000000-00000000 : ohci_hcd
>   00000000-00000000 : PCI Bus 0000:01
>     00000000-00000000 : 0000:01:00.0
>       00000000-00000000 : sym53c8xx
>     00000000-00000000 : 0000:01:02.0
>     00000000-00000000 : 0000:01:02.0
>   00000000-00000000 : 0000:00:13.0
>     00000000-00000000 : atyfb
>   00000000-00000000 : IOMMU
>   00000000-00000000 : eeprom
