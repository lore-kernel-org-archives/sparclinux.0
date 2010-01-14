From: David Miller <davem@davemloft.net>
Date: Thu, 14 Jan 2010 10:43:15 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20100114.024315.175527306.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 12 Jan 2010 11:35:59 +0100

> David Miller wrote:
>> And I'm guessing that's why using virt_to_page() in the DMA mapping
>> implementation failed for you Kristoffer, it would be the only common
>> path it would be used on sparc32.
>> 
> 
> For me it still fails if I'm not adding phys_base in page_to_phys.

So I did research and this code is the way it is because
of LEON (this commit is from "linux-2.6-history.git") :-)

commit a44032987aaa82d48927b87a0193c7805ec9aade
Author: Keith M. Wesolowski <wesolows@foobazco.org>
Date:   Sat Mar 20 22:43:40 2004 -0800

    [SPARC32]: Support memory starting at physical address other than 0
    
    From: Stefan Holst <mail@s-holst.de>
    
    Allow physical memory to start at almost arbitrary addresses.  LEON
    needs it, so do SPARCstation 10/20 without slot 0 populated.  Although
    Sun do not support this configuration, at least some such systems can
    boot with this patch.
    
    Physical memory starting at or above 0xF4000000 is not supported.

This commit missed updating page_to_phys() appropriately, so
you were right all along I think.

So let's take baby steps, please confirm that you agree with me that
the following patch is correct and that it works on your machine.

If it works I want to reinstate the virt_to_page() change I posted
the other day as well, simply so that we consistently use the
asm-generic/memory-model.h interfaces instead of assuming FLATMEM
memory model all over our headers.

But I am truly mystified how anything works with non-zero phys_base
with this being wrong.  Fundamental operations like
{srmmu,sun4c}_mk_pte() use this.

LEON uses this via SRMMU, so how does it work properly? :-)

Thanks!

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 93fe21e..679c750 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -8,7 +8,7 @@
 #include <asm/page.h>      /* IO address mapping routines need this */
 #include <asm/system.h>
 
-#define page_to_phys(page)	(((page) - mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 
 static inline u32 flip_dword (u32 l)
 {
