From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 05:42:34 +0000
Subject: Re: Re:  A500 boot crash in 4.2.0-rc3-00246-g763e326
Message-Id: <20150820054234.GA10267@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507260929000.30065@math.ut.ee>
 <trinity-122a736f-3aac-4830-afc5-2abcd91792ea-1439820380917@3capp-gmx-bs71>
 <trinity-5720bef8-5a4c-4465-b9eb-622daaef650a-1439902901415@3capp-gmx-bs02>
 <alpine.LRH.2.20.1508182141200.24742@math.ut.ee>
 <55D38BE6.6080302@gmx.de>
 <CAE9FiQVUUN-SLO0U4G5CC6MEoXfb=bGd+f3bRgQprtaMHjsvpA@mail.gmail.com>
 <alpine.LRH.2.20.1508190747360.5154@math.ut.ee>
 <CAE9FiQW9hjDe2NBEfwQqcVZoJKqDjKT1P=7FcGjhVrF7wQW9+g@mail.gmail.com>
 <BLU436-SMTP773488774A8C76BF6C12E597670@phx.gbl>
 <trinity-ceafa563-3aad-4955-a6c6-205a2caf1e95-1439993198188@3capp-gmx-bs16>
In-Reply-To: <trinity-ceafa563-3aad-4955-a6c6-205a2caf1e95-1439993198188@3capp-gmx-bs16>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller@gmx.de>
Cc: John David Anglin <dave.anglin@bell.net>, Yinghai Lu <yinghai@kernel.org>, Meelis Roos <mroos@linux.ee>, linux-parisc@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>

On Wed, Aug 19, 2015 at 04:06:38PM +0200, Helge Deller wrote:
> > On 2015-08-19, at 1:30 AM, Yinghai Lu wrote:
> > > On Tue, Aug 18, 2015 at 9:48 PM, Meelis Roos <mroos@linux.ee> wrote:
> > >>> On Tue, Aug 18, 2015 at 12:47 PM, Helge Deller <deller@gmx.de> wrote:
> > >>> 
> > >>> Then we should change to
> > >>> 
> > >>> config PCI_BUS_ADDR_T_64BIT
> > >>>       def_bool y if (ARCH_DMA_ADDR_T_64BIT || SPARC64)
> > >>>       depends on PCI
> > >> 
> > >> Why SPARC64? The problem happened on parisc.
> > > so will not set PCI_BUS_ADDR_T_64BIT for parisc.
> 
> I think given the current time frame it's probably the best approach to fix this problem for kernel 4.2.
> It reverts the behaviour back to how it was before (for all arches beside SPARC64).
> I'm still wondering if/why parisc is the only arch (in the sym53c8xx driver only!) which broke by this change...
> 
> > I'm not sure this is optimal.  While the A500 may only have 32-bit PCI, c8000 appears to have a mix
> > of 32 and 64-bit, and rp34XX is all 64-bit.
> 
> True, but probably nobody of us noticed that we only used the 32-bit PCI interface even with 64bit kernel on parisc up to now?
> pci_bus_alloc_resource() in drivers/pci/bus.c just disabled (flag=0) all 64bit resources for us.
> But I agree, I think we need to fix drivers/parisc/lba_pci.c to correctly cope with 64bit pci addresses.

I doubt we can fix the underlying issue before v4.2, but I'd at least
like to avoid it.  I applied the patch below to for-linus.

Yinghai proposed this:

> > >>>       def_bool y if (ARCH_DMA_ADDR_T_64BIT || SPARC64)

I did this instead:

+	def_bool y if (ARCH_DMA_ADDR_T_64BIT || (64BIT && !PARISC))

because (a) Yinghai's proposal suggests this change is related to
SPARC64, which is misleading, and (b) I want to keep 64-bit bus
addresses for all 64-bit kernels *except* PA-RISC.

I didn't mark it as Tested-by Meelis because I think he tested
Yinghai's proposal.  But I can add that back, given confirmation.


commit 51a660a2732c
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Aug 20 00:08:15 2015 -0500

    PCI: Don't use 64-bit bus addresses on PA-RISC
    
    Meelis and Helge reported that 3a9ad0b4fdcd ("PCI: Add pci_bus_addr_t")
    caused HPMCs on A500 and hangs on rp5470.
    
    PA-RISC does not set ARCH_DMA_ADDR_T_64BIT, even for 64-bit kernels, so
    prior to 3a9ad0b4fdcd, we always used 32-bit PCI addresses.  After
    3a9ad0b4fdcd, we do use 64-bit PCI addresses in 64-bit kernels, and
    apparently there's some PA-RISC problem related to them.
    
    Fixes: 3a9ad0b4fdcd ("PCI: Add pci_bus_addr_t")
    Link: http://lkml.kernel.org/r/alpine.LRH.2.11.1507260929000.30065@math.ut.ee
    Reported-by: Meelis Roos <mroos@linux.ee>
    Reported-by: Helge Deller <deller@gmx.de>
    Based-on-idea-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 73de4ef..944f500 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -2,7 +2,7 @@
 # PCI configuration
 #
 config PCI_BUS_ADDR_T_64BIT
-	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
+	def_bool y if (ARCH_DMA_ADDR_T_64BIT || (64BIT && !PARISC))
 	depends on PCI
 
 config PCI_MSI
