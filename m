From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 19 Oct 2017 23:59:21 +0000
Subject: Re: [PATCH v12 09/11] mm: stop zeroing memory during allocation in vmemmap
Message-Id: <20171019165921.de4224c8e627b1477cfb50de@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-10-pasha.tatashin@oracle.com>
In-Reply-To: <20171013173214.27300-10-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 13 Oct 2017 13:32:12 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> vmemmap_alloc_block() will no longer zero the block, so zero memory
> at its call sites for everything except struct pages.  Struct page memory
> is zero'd by struct page initialization.
> 
> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
> we will get the performance improvement by zeroing the memory in parallel
> when struct pages are zeroed.
> 
> Add struct page zeroing as a part of initialization of other fields in
> __init_single_page().
> 
> This single thread performance collected on: Intel(R) Xeon(R) CPU E7-8895
> v3 @ 2.60GHz with 1T of memory (268400646 pages in 8 nodes):
> 
>                          BASE            FIX
> sparse_init     11.244671836s   0.007199623s
> zone_sizes_init  4.879775891s   8.355182299s
>                   --------------------------
> Total           16.124447727s   8.362381922s
> 
> sparse_init is where memory for struct pages is zeroed, and the zeroing
> part is moved later in this patch into __init_single_page(), which is
> called from zone_sizes_init().

x86_64 allmodconfig:

WARNING: vmlinux.o(.text+0x29d099): Section mismatch in reference from the function T.1331() to the function .meminit.text:vmemmap_alloc_block()
The function T.1331() references
the function __meminit vmemmap_alloc_block().
This is often because T.1331 lacks a __meminit 
annotation or the annotation of vmemmap_alloc_block is wrong.

From a quick scan it's unclear to me why this is happening.  Maybe
gcc-4.4.4 decided to create an out-of-line version of
vmemmap_alloc_block_zero() for some reason.

Anyway.  I see no reason to publish vmemmap_alloc_block_zero() to the
whole world when it's only used in sparse-vmemmap.c.  The below fixes
the section mismatch:


--- a/include/linux/mm.h~mm-stop-zeroing-memory-during-allocation-in-vmemmap-fix
+++ a/include/linux/mm.h
@@ -2529,17 +2529,6 @@ static inline void *vmemmap_alloc_block_
 	return __vmemmap_alloc_block_buf(size, node, NULL);
 }
 
-static inline void *vmemmap_alloc_block_zero(unsigned long size, int node)
-{
-	void *p = vmemmap_alloc_block(size, node);
-
-	if (!p)
-		return NULL;
-	memset(p, 0, size);
-
-	return p;
-}
-
 void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
 			       int node);
--- a/mm/sparse-vmemmap.c~mm-stop-zeroing-memory-during-allocation-in-vmemmap-fix
+++ a/mm/sparse-vmemmap.c
@@ -178,6 +178,17 @@ pte_t * __meminit vmemmap_pte_populate(p
 	return pte;
 }
 
+static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
+{
+	void *p = vmemmap_alloc_block(size, node);
+
+	if (!p)
+		return NULL;
+	memset(p, 0, size);
+
+	return p;
+}
+
 pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
_


