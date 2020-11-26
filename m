From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 26 Nov 2020 12:01:20 +0000
Subject: [PATCH v2 6/6] powerpc/8xx: Implement pXX_leaf_size() support
Message-Id: <20201126121121.364451610@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201126120114.071913521@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com
Cc: christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com, peterz@infradead.org

Christophe Leroy wrote:

> I can help with powerpc 8xx. It is a 32 bits powerpc. The PGD has 1024
> entries, that means each entry maps 4M.
>
> Page sizes are 4k, 16k, 512k and 8M.
>
> For the 8M pages we use hugepd with a single entry. The two related PGD
> entries point to the same hugepd.
>
> For the other sizes, they are in standard page tables. 16k pages appear
> 4 times in the page table. 512k entries appear 128 times in the page
> table.
>
> When the PGD entry has _PMD_PAGE_8M bits, the PMD entry points to a
> hugepd with holds the single 8M entry.
>
> In the PTE, we have two bits: _PAGE_SPS and _PAGE_HUGE
>
> _PAGE_HUGE means it is a 512k page
> _PAGE_SPS means it is not a 4k page
>
> The kernel can by build either with 4k pages as standard page size, or
> 16k pages. It doesn't change the page table layout though.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -135,6 +135,29 @@ static inline pte_t pte_mkhuge(pte_t pte
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
