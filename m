From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Date: Thu, 18 Aug 2011 10:05:48 +0000
Subject: Re: [PATCH] sparc: fix array bounds error setting up PCIC NMI trap
Message-Id: <1313661948.5010.263.camel@zakaz.uk.xensource.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1313655297-20075-1-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1313655297-20075-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2011-08-18 at 10:49 +0100, Sam Ravnborg wrote:
> On Thu, Aug 18, 2011 at 10:25:15AM +0100, Ian Campbell wrote:
> > On Thu, 2011-08-18 at 09:59 +0100, David Miller wrote:
> > > From: Ian Campbell <ian.campbell@citrix.com>
> > > Date: Thu, 18 Aug 2011 09:14:57 +0100
> > > 
> > > >>From a sparc64 defconfig:
> > > >   CC      arch/sparc/kernel/pcic.o
> > > 
> > > A sparc64 defconfig?  This is code only built for 32-bit sparc :-)
> > 
> > My local script confused me, it translated sparc64 into ARCH=sparc for
> > me, where it turns out the defconfig = sparc32_defconfig, so I was
> > actually building 32 bit. Sorry about that.
> > 
> > Turns out I also saw this on 32-bit sparc defconfig, which is hardly
> > surprising given the two .configs are exactly the same ;-)
> sparse complains too - I just never got around to fix it up.
> 
> If you do nto beat me I will look at it soon.

With my patch applied I don't see any sparse warnings for these lines of
pcic.c, although there are others:
  CHECK   /local/scratch/ianc/devel/kernels/linux-2.6/arch/sparc/kernel/pcic.c
arch/sparc/kernel/pcic.c:163:14: warning: symbol 'pcic_regs' was not declared. Should it be static?
arch/sparc/kernel/pcic.c:164:14: warning: symbol 'pcic_speculative' was not declared. Should it be static?
arch/sparc/kernel/pcic.c:165:14: warning: symbol 'pcic_trapped' was not declared. Should it be static?
arch/sparc/kernel/pcic.c:331:66: warning: Using plain integer as NULL pointer
arch/sparc/kernel/pcic.c:343:66: warning: Using plain integer as NULL pointer
arch/sparc/kernel/pcic.c:539:38: warning: Using plain integer as NULL pointer
arch/sparc/kernel/pcic.c:677:1: warning: symbol 'pcic_pin_to_irq' was not declared. Should it be static?
arch/sparc/kernel/pcic.c:718:5: warning: symbol 'pci_gettimeoffset' was not declared. Should it be static?
arch/sparc/kernel/pcic.c:787:6: warning: symbol 'pcic_nmi' was not declared. Should it be static?
arch/sparc/kernel/pcic.c:883:5: warning: symbol 'pcibios_assign_resource' was not declared. Should it be static?
  CC      arch/sparc/kernel/pcic.o

Ian.

