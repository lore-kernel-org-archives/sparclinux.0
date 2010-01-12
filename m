From: David Miller <davem@davemloft.net>
Date: Tue, 12 Jan 2010 07:40:48 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20100111.234048.249682808.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 23 Nov 2009 13:31:32 +0100

> We did yes. You said that mem_map is not offset at phys_base and then
> of
> course we don't need to add it in page_to_phys. Is mem_map not offset
> because typically sp_banks[].base_addr = 0? In our case we pass in one
> sp_banks entry which has base_addr = 0x40000000.

Looking at this code, I can't see how virt_to_page() works right
now at all :-)

mem_map[] is offset by pfn_base

This is why __va() and __pa() account for it.

Can you see if your machine boots with the patch at the end of this
email applied?  Others can feel free to test this too :-)

Really, if pfn_base/phys_base are non-zero, it's quite amazing how a
sparc32 machine could sucessfully boot with the code as-is.

Looking more deeply, I guess it could work if you use CONFIG_SLUB.

Or, you use CONFIG_SLAB and SLABs are never destroyed and SLAB
growing never fails (kmem_freepages() uses virt_to_page()).

And I'm guessing that's why using virt_to_page() in the DMA mapping
implementation failed for you Kristoffer, it would be the only common
path it would be used on sparc32.

Anyways, testing of this change by anyone with sparc32 boxes would be
much appreciated.

Thanks!

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index f72080b..156707b 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -143,7 +143,7 @@ extern unsigned long pfn_base;
 #define phys_to_virt		__va
 
 #define ARCH_PFN_OFFSET		(pfn_base)
-#define virt_to_page(kaddr)	(mem_map + ((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT)))
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 
 #define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
 #define virt_addr_valid(kaddr)	((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT) < max_mapnr)
