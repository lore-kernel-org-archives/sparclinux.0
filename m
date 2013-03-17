From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Date: Sun, 17 Mar 2013 21:27:52 +0000
Subject: virtually indexed caches and memory unmapping
Message-Id: <alpine.DEB.2.00.1303170347040.3472@artax.karlin.mff.cuni.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

I am trying to fix some virtual cache bugs on pa-risc and I came to this 
piece of code, in arch/sparc/include/asm/tlb_32.h and 
arch/parisc/include/asm/tlb.h:

#define tlb_start_vma(tlb, vma) \
do {    if (!(tlb)->fullmm)     \
                flush_cache_range(vma, vma->vm_start, vma->vm_end); \
} while (0)

#define tlb_end_vma(tlb, vma)   \
do {    if (!(tlb)->fullmm)     \
                flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
} while (0)

What the code does:
* it calls tlb_start_vma in unmap_page_range
* then it walks the pagetables, unmaps all pages and places them into a 
  batch list in "struct mmu_gather"
* finally it calls tlb_end_vma

Now the question:

What happens if one thread calls mnumap, goes past tlb_start_vma and 
starts walking the pagetables and the second thread running simultaneously 
on another CPU writes to the memory that is being unmapped? Writes done by 
the second thread go to virtually-indexed cache and there doesn't seem to 
be anything else to flush them.


From my understanding of the code:

The code in zap_pte_range removes the pte (but doesn't flush TLB) and 
calls __tlb_remove_page that puts the page on the batch list.

Once the batch list fills up, "force_flush" is set and tlb_flush_mmu is 
called. tlb_flush_mmu flushes the tlb on all CPUs and then frees the pages 
on the batch list.

Now, I think that virtually-indexed cache should be flushed in 
"tlb_flush_mmu" after it broadcasts tlb flush to all processors, but 
before the pages are being freed. (because prior to broadcasting tlb flush 
other processors may write to the page and create dirty cache lines in the 
virtually indexed cache)

But I don't see the code for cache flush there. So it seems that there is 
a bug that if a thread writes to a page that is being unmapped, the write 
could remain in virtually-indexed cache and could corrupt data in that 
page when the page is reused.


Is there something I am missing that prevents this bug? How is cache 
flushing supposed to work correctly when one thread unmaps a range of 
memory and the other thread writes to it?


Mikulas
