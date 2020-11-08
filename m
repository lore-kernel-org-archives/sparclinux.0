From: Mike Rapoport <rppt@kernel.org>
Date: Sun, 08 Nov 2020 06:57:55 +0000
Subject: [PATCH v5 2/5] slab: debug: split slab_kernel_map() to map and unmap variants
Message-Id: <20201108065758.1815-3-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201108065758.1815-1-rppt@kernel.org>
In-Reply-To: <20201108065758.1815-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <len.brown@intel.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, linux-pm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, David Rientjes <rientjes@google.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, Mike Rapoport <rppt@kernel.org>

From: Mike Rapoport <rppt@linux.ibm.com>

Instead of using slab_kernel_map() with 'map' parameter to remap pages when
DEBUG_PAGEALLOC is enabled, use dedicated helpers slab_kernel_map() and
slab_kernel_unmap().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/slab.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 07317386e150..0719421d69f7 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1428,17 +1428,21 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
 	return false;
 }
 
-static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
+static void slab_kernel_map(struct kmem_cache *cachep, void *objp)
 {
 	if (!is_debug_pagealloc_cache(cachep))
 		return;
 
-	if (map)
-		debug_pagealloc_map_pages(virt_to_page(objp),
-					  cachep->size / PAGE_SIZE);
-	else
-		debug_pagealloc_unmap_pages(virt_to_page(objp),
-					    cachep->size / PAGE_SIZE);
+	debug_pagealloc_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE);
+}
+
+static void slab_kernel_unmap(struct kmem_cache *cachep, void *objp)
+{
+	if (!is_debug_pagealloc_cache(cachep))
+		return;
+
+	debug_pagealloc_unmap_pages(virt_to_page(objp),
+				    cachep->size / PAGE_SIZE);
 }
 
 static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
@@ -1585,7 +1589,7 @@ static void slab_destroy_debugcheck(struct kmem_cache *cachep,
 
 		if (cachep->flags & SLAB_POISON) {
 			check_poison_obj(cachep, objp);
-			slab_kernel_map(cachep, objp, 1);
+			slab_kernel_map(cachep, objp);
 		}
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
@@ -2360,7 +2364,7 @@ static void cache_init_objs_debug(struct kmem_cache *cachep, struct page *page)
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON) {
 			poison_obj(cachep, objp, POISON_FREE);
-			slab_kernel_map(cachep, objp, 0);
+			slab_kernel_unmap(cachep, objp);
 		}
 	}
 #endif
@@ -2728,7 +2732,7 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 
 	if (cachep->flags & SLAB_POISON) {
 		poison_obj(cachep, objp, POISON_FREE);
-		slab_kernel_map(cachep, objp, 0);
+		slab_kernel_unmap(cachep, objp);
 	}
 	return objp;
 }
@@ -2993,7 +2997,7 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 		return objp;
 	if (cachep->flags & SLAB_POISON) {
 		check_poison_obj(cachep, objp);
-		slab_kernel_map(cachep, objp, 1);
+		slab_kernel_map(cachep, objp);
 		poison_obj(cachep, objp, POISON_INUSE);
 	}
 	if (cachep->flags & SLAB_STORE_USER)
-- 
2.28.0
