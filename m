From: Christoph Hellwig <hch@lst.de>
Date: Wed, 26 Jun 2019 13:13:18 +0000
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20190626131318.GA5101@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190626225807.205f1382@canb.auug.org.au>
In-Reply-To: <20190626225807.205f1382@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

As that function is in code only there to provide compile coverage
something like this should fix the problem:


diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 547ff96fb228..1599de730532 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -861,10 +861,12 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
 #define pgd_page_vaddr(pgd)		\
 	((unsigned long) __va(pgd_val(pgd)))
-#define pgd_page(pgd)			pfn_to_page(pgd_pfn(pgd))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0U)
 #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
 
+/* only used by the stubbed out hugetlb gup code, should never be called */
+#define pgd_page(pgd)			NULL
+
 static inline unsigned long pud_large(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
