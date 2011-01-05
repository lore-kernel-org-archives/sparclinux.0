From: kristoffer@gaisler.com
Date: Wed, 05 Jan 2011 19:42:05 +0000
Subject: Re: [PATCH] sparc32: Added LEON dma_ops
Message-Id: <20110105204205.x2mqzcvzvow8ko88@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1294243785-8082-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1294243785-8082-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hi Sam,
   
   
  On Wed, 5 Jan 2011 19:16:23  0100, Sam Ravnborg  wrote:
  >
  > And it is now an exported symbol - looks OK. 
  > But the new implementation differs from the old implementation. 
  >
  > Grepping for pci_set_dma_mask() turned up this implmentation:
  > static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
  > {
  >         return dma_set_mask(&dev->dev, mask);
  > }
  >
  > It looks like an infinite loop??
  >
  >
  > Note: This change alone warrant an independent patch. 
  >
   
  I'm not quite sure what has happened here. My original patch did not 
touch dma_set_mask. I will have to check with Daniel what has gone 
wrong ... 
   
   

  > > diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
  > > index 41f7e4e..7359369 100644
  > > --- a/arch/sparc/kernel/ioport.c
  > >     b/arch/sparc/kernel/ioport.c
  > > @@ -50,10  50,15 @@
  > >  #include <asm/io-unit.h>
  > >  #include <asm/leon.h>
  > >
  > > -#ifdef CONFIG_SPARC_LEON
  > > -#define mmu_inval_dma_area(p, l) leon_flush_dcache_all()
  > > -#else
  > >  #ifndef CONFIG_SPARC_LEON
  > >  #define mmu_inval_dma_area(p, l) /* Anton pulled it out for 2.4.0-xx */
  > >  #else
  > >  static inline void mmu_inval_dma_area(unsigned long va, unsigned 
long len)
  > >  {
  > >   if (!sparc_leon3_snooping_enabled()) {
  > >   leon_flush_dcache_all();
  > >   }
  > >  }
  > >  #endif
  > This is better than before as we no longer has a double definition. 
  > But why do we call mmu_inval_dma_area() wich is empty in SPARC32 build
  > from SBUS code? LEON does not support SBUS only AMBA   PCI IIRC. 
  > Hmm - looking at Kconfig LEON supports SBUS too. Is that correct?
  >
   
  My patch tried to touch the generic SPARC32 code as little as 
possible. Especially since I have no idea why "Anton pulled it out" 
from the beginning :-). The first version of the patch did not touch 
the sbus_ version at all but I changed this because Dave thought it 
better to reuse it also for LEON. We have no SBUS on our chips but the 
SBUS code is used every here and there. Maybe this should be cleaned up 
in the future but this is the current state. 
   

  > >  #ifdef CONFIG_SPARC_LEON
  > >   sparc_mapiorange(0, virt_to_phys(va), res->start, len_total);
  > >   *dma_addrp = virt_to_phys(va);
  > >  #else
  > >   if (mmu_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0) {
  > >   release_resource(res);
  > >   goto err_nova;
  > >   }
  > >  #endif
  >
  >
  > I cannot follow why you need this ugly ifdef here. 
  > Some comments please. 
  >
   
  I agree this is not beautiful :-). It is just an attempt to reuse the 
sbus version of alloc_coherent to avoid code duplicaion. 
   
   

  > Why? comemnts needed again. 
  > Or better find another way to do this. 
  >
   
  Same as above. 
   
   
  > Looking a bit around... 
  > Is it correct understood that BTFIXUPSET_CALL() is used
  > to patch in another function here for for example sun4c?
  > So mmu_unmap_dma_area() becomes a call to sun4c_unmap_dma_area()?
  >
   
  Routines from iommu.c or io-unit.c are patched in depending on 
architecture. They do not apply to LEON ... 
   
   

  > > -#ifdef CONFIG_PCI
  > >  #if defined(CONFIG_PCI) || defined(CONFIG_SPARC_LEON)
  >
  > Why do we need PCI functions when PCI is not defined?
  > >
   
   
  Again it is just to avoid code duplication. The pci dma ops in 
ioport.c correspond quite well to what should happen on LEON. It would 
look nicer to just create LEON specific version of all dma_ops (I did 
originally) but it would also be wasteful. 
   

  > Looks like ordinary SPARC32 gained an unmap_page - correct?
  > Looks like a separate chage to me. 
  >
   
  Indeed!
   
   
  > >
  > >  /*
  > >   * Same as pci_map_single, but with pages. 
  > >   */
  > > @@ -551,8  567,7 @@ static int pci32_map_sg(struct device 
*device, struct scatterlist *sgl,
  > >
  > >   /* IIep is write-through, not flushing. */
  > >   for_each_sg(sgl, sg, nents, n) {
  > > - BUG_ON(page_address(sg_page(sg)) = NULL);
  > Why is this BUG_ON() removed?
   
  I'm not sure how Daniel has generated this latest version the patch. 
I don't remember removing this one ... 
   
   
  >
  > > - sg->dma_address = virt_to_phys(sg_virt(sg));
  > >   sg->dma_address = sg_phys(sg);
  >
  > Why - is this better or what?
   
  Reads cleaner to me. 
   

  > This just looks wrong to me... 
  > Why we need to export only is SBUS is defined - but
  > we define leon3_dma_ops if LEON is defined. 
  >
   
  SBUS is always defined. But I generally agree that it should be 
refactored somehow. I think that could happen in a separate patch 
series in the future. As the SPARC32 port is now SBUS must always be 
defined. 
   
   
  > I think this need to be revisited - and then see if you
  > can hide more of the ifdef in dma-mapping.h
  >
   
  We will await further feedback and post it again next week. 
   
  Thanks,
  Kristoffer
   

