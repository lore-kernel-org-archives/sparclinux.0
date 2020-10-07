From: Jann Horn <jannh@google.com>
Date: Wed, 07 Oct 2020 07:39:32 +0000
Subject: [PATCH 2/2] sparc: Check VMA range in sparc_validate_prot()
Message-Id: <20201007073932.865218-2-jannh@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
In-Reply-To: <20201007073932.865218-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Anthony Yznaga <anthony.yznaga@oracle.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

sparc_validate_prot() is called from do_mprotect_pkey() as
arch_validate_prot(); it tries to ensure that an mprotect() call can't
enable ADI on incompatible VMAs.
The current implementation only checks that the VMA at the start address
matches the rules for ADI mappings; instead, check all VMAs that will be
affected by mprotect().

(This hook is called before mprotect() makes sure that the specified range
is actually covered by VMAs, and mprotect() returns specific error codes
when that's not the case. In order for mprotect() to still generate the
same error codes for mprotect(<unmapped_ptr>, <len>, ...|PROT_ADI), we need
to *accept* cases where the range is not fully covered by VMAs.)

Cc: stable@vger.kernel.org
Fixes: 74a04967482f ("sparc64: Add support for ADI (Application Data Integrity)")
Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only, I don't have a Sparc ADI setup - might be nice if some
Sparc person could test this?

 arch/sparc/include/asm/mman.h | 50 +++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index e85222c76585..6dced75567c3 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -60,31 +60,41 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr,
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
 		return 0;
 	if (prot & PROT_ADI) {
+		struct vm_area_struct *vma, *next;
+
 		if (!adi_capable())
 			return 0;
 
-		if (addr) {
-			struct vm_area_struct *vma;
+		vma = find_vma(current->mm, addr);
+		/* if @addr is unmapped, let mprotect() deal with it */
+		if (!vma || vma->vm_start > addr)
+			return 1;
+		while (1) {
+			/* ADI can not be enabled on PFN
+			 * mapped pages
+			 */
+			if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+				return 0;
 
-			vma = find_vma(current->mm, addr);
-			if (vma) {
-				/* ADI can not be enabled on PFN
-				 * mapped pages
-				 */
-				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
-					return 0;
+			/* Mergeable pages can become unmergeable
+			 * if ADI is enabled on them even if they
+			 * have identical data on them. This can be
+			 * because ADI enabled pages with identical
+			 * data may still not have identical ADI
+			 * tags on them. Disallow ADI on mergeable
+			 * pages.
+			 */
+			if (vma->vm_flags & VM_MERGEABLE)
+				return 0;
 
-				/* Mergeable pages can become unmergeable
-				 * if ADI is enabled on them even if they
-				 * have identical data on them. This can be
-				 * because ADI enabled pages with identical
-				 * data may still not have identical ADI
-				 * tags on them. Disallow ADI on mergeable
-				 * pages.
-				 */
-				if (vma->vm_flags & VM_MERGEABLE)
-					return 0;
-			}
+			/* reached the end of the range without errors? */
+			if (addr+len <= vma->vm_end)
+				return 1;
+			next = vma->vm_next;
+			/* if a VMA hole follows, let mprotect() deal with it */
+			if (!next || next->vm_start != vma->vm_end)
+				return 1;
+			vma = next;
 		}
 	}
 	return 1;
-- 
2.28.0.806.g8561365e88-goog
