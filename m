From: "David S. Miller" <davem@redhat.com>
Date: Thu, 12 Aug 2004 20:05:53 +0000
Subject: Re: 2.6.8 BK compile failure (arch/sparc64/mm/tlb.c)
Message-Id: <20040812130553.1cfd8ebd.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0408121609130.12542-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0408121609130.12542-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 12 Aug 2004 16:09:47 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

>   CC      arch/sparc64/mm/tlb.o
> In file included from arch/sparc64/mm/tlb.c:17:
> include/asm/tlb.h: In function `tlb_finish_mmu':
> include/asm/tlb.h:95: error: invalid operands to binary &
> make[1]: *** [arch/sparc64/mm/tlb.o] Error 1

Guess I'm not testing non-SMP builds very much these
days. :-)

This should fix it.

=== include/asm-sparc64/tlb.h 1.7 vs edited ==--- 1.7/include/asm-sparc64/tlb.h	2004-08-06 23:01:03 -07:00
+++ edited/include/asm-sparc64/tlb.h	2004-08-12 12:48:41 -07:00
@@ -73,7 +73,7 @@
 extern void smp_flush_tlb_mm(struct mm_struct *mm);
 #define do_flush_tlb_mm(mm) smp_flush_tlb_mm(mm)
 #else
-#define do_flush_tlb_mm(mm) __flush_tlb_mm(CTX_HWBITS(mm), SECONDARY_CONTEXT)
+#define do_flush_tlb_mm(mm) __flush_tlb_mm(CTX_HWBITS(mm->context), SECONDARY_CONTEXT)
 #endif
 
 static inline void tlb_finish_mmu(struct mmu_gather *mp, unsigned long start, unsigned long end)
