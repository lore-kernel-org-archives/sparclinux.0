From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 26 Nov 2020 10:46:51 +0000
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-Id: <20201126104651.GG3092@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
 <16ad8cab-08e2-27a7-6803-baadc6b8721b@csgroup.eu>
 <2a32b00b-2214-3283-58e0-9cb0ff4bd728@csgroup.eu>
 <20201120122004.GG3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201120122004.GG3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Fri, Nov 20, 2020 at 01:20:04PM +0100, Peter Zijlstra wrote:

> > > I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024
> > > entries, that means each entry maps 4M.
> > > 
> > > Page sizes are 4k, 16k, 512k and 8M.
> > > 
> > > For the 8M pages we use hugepd with a single entry. The two related PGD
> > > entries point to the same hugepd.
> > > 
> > > For the other sizes, they are in standard page tables. 16k pages appear
> > > 4 times in the page table. 512k entries appear 128 times in the page
> > > table.
> > > 
> > > When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a
> > > hugepd with holds the single 8M entry.
> > > 
> > > In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
> > > 
> > > _PAGE_HUGE means it is a 512k page
> > > _PAGE_SPS means it is not a 4k page
> > > 
> > > The kernel can by build either with 4k pages as standard page size, or
> > > 16k pages. It doesn't change the page table layout though.
> > > 
> > > Hope this is clear. Now I don't really know to wire that up to your series.

Does the below accurately reflect things?

Let me go find a suitable cross-compiler ..

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 1581204467e1..fcc48d590d88 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -135,6 +135,29 @@ static inline pte_t pte_mkhuge(pte_t pte)
 }
 
 #define pte_mkhuge pte_mkhuge
+
+static inline unsigned long pgd_leaf_size(pgd_t pgd)
+{
+	if (pgd_val(pgd) & _PMD_PAGE_8M)
+		return SZ_8M;
+	return SZ_4M;
+}
+
+#define pgd_leaf_size pgd_leaf_size
+
+static inline unsigned long pte_leaf_size(pte_t pte)
+{
+	pte_basic_t val = pte_val(pte);
+
+	if (val & _PAGE_HUGE)
+		return SZ_512K;
+	if (val & _PAGE_SPS)
+		return SZ_16K;
+	return SZ_4K;
+}
+
+#define pte_leaf_size pte_leaf_size
+
 #endif
 
 #endif /* __KERNEL__ */
