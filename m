From: Julia Lawall <julia@diku.dk>
Date: Tue, 24 Jun 2008 08:24:57 +0000
Subject: [PATCH 9/14] arch/sparc64: Eliminate NULL test and memset after
Message-Id: <Pine.LNX.4.64.0806241024340.26777@ask.diku.dk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akinobu.mita@gmail.com, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

As noted by Akinobu Mita in patch b1fceac2b9e04d278316b2faddf276015fc06e3b,
alloc_bootmem and related functions never return NULL and always return a
zeroed region of memory.  Thus a NULL test or memset after calls to these
functions is unnecessary.

 arch/sparc64/kernel/irq.c |    8 --------
 1 file changed, 8 deletions(-)

This was fixed using the following semantic patch.
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression E;
statement S;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\)(...)
... when != E
(
- BUG_ON (E = NULL);
|
- if (E = NULL) S
)

@@
expression E,E1;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\)(...)
... when != E
- memset(E,0,E1);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
---

diff -u -p a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -882,10 +882,6 @@ static void __init init_cpu_send_mondo_i
 	BUILD_BUG_ON((NR_CPUS * sizeof(u16)) > (PAGE_SIZE - 64));
 
 	page = alloc_bootmem_pages(PAGE_SIZE);
-	if (!page) {
-		prom_printf("SUN4V: Error, cannot allocate cpu mondo page.\n");
-		prom_halt();
-	}
 
 	tb->cpu_mondo_block_pa = __pa(page);
 	tb->cpu_list_pa = __pa(page + 64);
@@ -929,10 +925,6 @@ void __init init_IRQ(void)
 
 	size = sizeof(struct ino_bucket) * NUM_IVECS;
 	ivector_table = alloc_bootmem(size);
-	if (!ivector_table) {
-		prom_printf("Fatal error, cannot allocate ivector_table\n");
-		prom_halt();
-	}
 	__flush_dcache_range((unsigned long) ivector_table,
 			     ((unsigned long) ivector_table) + size);
 
