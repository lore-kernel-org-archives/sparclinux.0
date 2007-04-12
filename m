From: David Miller <davem@davemloft.net>
Date: Thu, 12 Apr 2007 04:55:11 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <20070411.215511.59675025.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 10 Apr 2007 14:04:58 -0700 (PDT)

> From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 20 Mar 2007 21:53:26 +0100
>=20
> > 	I have tried the last 2.6.21-rc4. Same bug.
>=20
> The good news is that I can reproduce this problem now on my
> Ultra2, I'll try to figure out what's wrong.
>=20
> Running "dbench 32" a few time is enough to trigger it.

Ok, I think I might have killed at least the bug I was able to hit.

I make no promises that this will fix the issues everyone else was
seeing, but let's cross our fingers :-)))

Please give the following patch some testing if you can.  And please
be careful, messing with the DMA mapping code can do things like eat
your disk :-)

If all goes well I'll push this bug fix around, and I have a secret
treat for your poor sparc64 SBUS users once we get past this.

Thanks!

commit af822e612593c1feef5052e685bca0f8d087d120
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Apr 11 21:38:45 2007 -0700

    [SPARC64]: Fix SBUS IOMMU allocation code.
   =20
    There are several IOMMU allocator bugs.  Instead of trying to fix this
    overly complicated code, just mirror the PCI IOMMU arena allocator
    which is very stable and well stress tested.
   =20
    I tried to make the code as identical as possible so we can switch
    sun4u PCI and SBUS over to a common piece of IOMMU code.  All that
    will be need are two callbacks, one to do a full IOMMU flush and one
    to do a streaming buffer flush.
   =20
    This patch gets rid of a lot of hangs and mysterious crashes on SBUS
    sparc64 systems, at least for me.
   =20
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/sbus.c b/arch/sparc64/kernel/sbus.c
index 01d6d86..14f78fb 100644
--- a/arch/sparc64/kernel/sbus.c
+++ b/arch/sparc64/kernel/sbus.c
@@ -24,48 +24,25 @@
=20
 #include "iommu_common.h"
=20
-/* These should be allocated on an SMP_CACHE_BYTES
- * aligned boundary for optimal performance.
- *
- * On SYSIO, using an 8K page size we have 1GB of SBUS
- * DMA space mapped.  We divide this space into equally
- * sized clusters. We allocate a DMA mapping from the
- * cluster that matches the order of the allocation, or
- * if the order is greater than the number of clusters,
- * we try to allocate from the last cluster.
- */
-
-#define NCLUSTERS	8UL
-#define ONE_GIG		(1UL * 1024UL * 1024UL * 1024UL)
-#define CLUSTER_SIZE	(ONE_GIG / NCLUSTERS)
-#define CLUSTER_MASK	(CLUSTER_SIZE - 1)
-#define CLUSTER_NPAGES	(CLUSTER_SIZE >> IO_PAGE_SHIFT)
 #define MAP_BASE	((u32)0xc0000000)
=20
+struct sbus_iommu_arena {
+	unsigned long	*map;
+	unsigned int	hint;
+	unsigned int	limit;
+};
+
 struct sbus_iommu {
-/*0x00*/spinlock_t		lock;
+	spinlock_t		lock;
=20
-/*0x08*/iopte_t			*page_table;
-/*0x10*/unsigned long		strbuf_regs;
-/*0x18*/unsigned long		iommu_regs;
-/*0x20*/unsigned long		sbus_control_reg;
+	struct sbus_iommu_arena	arena;
=20
-/*0x28*/volatile unsigned long	strbuf_flushflag;
+	iopte_t			*page_table;
+	unsigned long		strbuf_regs;
+	unsigned long		iommu_regs;
+	unsigned long		sbus_control_reg;
=20
-	/* If NCLUSTERS is ever decresed to 4 or lower,
-	 * you must increase the size of the type of
-	 * these counters.  You have been duly warned. -DaveM
-	 */
-/*0x30*/struct {
-		u16	next;
-		u16	flush;
-	} alloc_info[NCLUSTERS];
-
-	/* The lowest used consistent mapping entry.  Since
-	 * we allocate consistent maps out of cluster 0 this
-	 * is relative to the beginning of closter 0.
-	 */
-/*0x50*/u32		lowest_consistent_map;
+	volatile unsigned long	strbuf_flushflag;
 };
=20
 /* Offsets from iommu_regs */
@@ -91,19 +68,6 @@ static void __iommu_flushall(struct sbus_iommu *iommu)
 		tag +=3D 8UL;
 	}
 	upa_readq(iommu->sbus_control_reg);
-
-	for (entry =3D 0; entry < NCLUSTERS; entry++) {
-		iommu->alloc_info[entry].flush -			iommu->alloc_info[entry].next;
-	}
-}
-
-static void iommu_flush(struct sbus_iommu *iommu, u32 base, unsigned long =
npages)
-{
-	while (npages--)
-		upa_writeq(base + (npages << IO_PAGE_SHIFT),
-			   iommu->iommu_regs + IOMMU_FLUSH);
-	upa_readq(iommu->sbus_control_reg);
 }
=20
 /* Offsets from strbuf_regs */
@@ -156,178 +120,115 @@ static void sbus_strbuf_flush(struct sbus_iommu *io=
mmu, u32 base, unsigned long
 		       base, npages);
 }
=20
-static iopte_t *alloc_streaming_cluster(struct sbus_iommu *iommu, unsigned=
 long npages)
+/* Based largely upon the ppc64 iommu allocator.  */
+static long sbus_arena_alloc(struct sbus_iommu *iommu, unsigned long npage=
s)
 {
-	iopte_t *iopte, *limit, *first, *cluster;
-	unsigned long cnum, ent, nent, flush_point, found;
-
-	cnum =3D 0;
-	nent =3D 1;
-	while ((1UL << cnum) < npages)
-		cnum++;
-	if(cnum >=3D NCLUSTERS) {
-		nent =3D 1UL << (cnum - NCLUSTERS);
-		cnum =3D NCLUSTERS - 1;
-	}
-	iopte  =3D iommu->page_table + (cnum * CLUSTER_NPAGES);
-
-	if (cnum =3D 0)
-		limit =3D (iommu->page_table +
-			 iommu->lowest_consistent_map);
-	else
-		limit =3D (iopte + CLUSTER_NPAGES);
-
-	iopte +=3D ((ent =3D iommu->alloc_info[cnum].next) << cnum);
-	flush_point =3D iommu->alloc_info[cnum].flush;
-
-	first =3D iopte;
-	cluster =3D NULL;
-	found =3D 0;
-	for (;;) {
-		if (iopte_val(*iopte) =3D 0UL) {
-			found++;
-			if (!cluster)
-				cluster =3D iopte;
+	struct sbus_iommu_arena *arena =3D &iommu->arena;
+	unsigned long n, i, start, end, limit;
+	int pass;
+
+	limit =3D arena->limit;
+	start =3D arena->hint;
+	pass =3D 0;
+
+again:
+	n =3D find_next_zero_bit(arena->map, limit, start);
+	end =3D n + npages;
+	if (unlikely(end >=3D limit)) {
+		if (likely(pass < 1)) {
+			limit =3D start;
+			start =3D 0;
+			__iommu_flushall(iommu);
+			pass++;
+			goto again;
 		} else {
-			/* Used cluster in the way */
-			cluster =3D NULL;
-			found =3D 0;
+			/* Scanned the whole thing, give up. */
+			return -1;
 		}
+	}
=20
-		if (found =3D nent)
-			break;
-
-		iopte +=3D (1 << cnum);
-		ent++;
-		if (iopte >=3D limit) {
-			iopte =3D (iommu->page_table + (cnum * CLUSTER_NPAGES));
-			ent =3D 0;
-
-			/* Multiple cluster allocations must not wrap */
-			cluster =3D NULL;
-			found =3D 0;
+	for (i =3D n; i < end; i++) {
+		if (test_bit(i, arena->map)) {
+			start =3D i + 1;
+			goto again;
 		}
-		if (ent =3D flush_point)
-			__iommu_flushall(iommu);
-		if (iopte =3D first)
-			goto bad;
 	}
=20
-	/* ent/iopte points to the last cluster entry we're going to use,
-	 * so save our place for the next allocation.
-	 */
-	if ((iopte + (1 << cnum)) >=3D limit)
-		ent =3D 0;
-	else
-		ent =3D ent + 1;
-	iommu->alloc_info[cnum].next =3D ent;
-	if (ent =3D flush_point)
-		__iommu_flushall(iommu);
-
-	/* I've got your streaming cluster right here buddy boy... */
-	return cluster;
-
-bad:
-	printk(KERN_EMERG "sbus: alloc_streaming_cluster of npages(%ld) failed!\n=
",
-	       npages);
-	return NULL;
+	for (i =3D n; i < end; i++)
+		__set_bit(i, arena->map);
+
+	arena->hint =3D end;
+
+	return n;
 }
=20
-static void free_streaming_cluster(struct sbus_iommu *iommu, u32 base, uns=
igned long npages)
+static void sbus_arena_free(struct sbus_iommu_arena *arena, unsigned long =
base, unsigned long npages)
 {
-	unsigned long cnum, ent, nent;
-	iopte_t *iopte;
+	unsigned long i;
=20
-	cnum =3D 0;
-	nent =3D 1;
-	while ((1UL << cnum) < npages)
-		cnum++;
-	if(cnum >=3D NCLUSTERS) {
-		nent =3D 1UL << (cnum - NCLUSTERS);
-		cnum =3D NCLUSTERS - 1;
-	}
-	ent =3D (base & CLUSTER_MASK) >> (IO_PAGE_SHIFT + cnum);
-	iopte =3D iommu->page_table + ((base - MAP_BASE) >> IO_PAGE_SHIFT);
-	do {
-		iopte_val(*iopte) =3D 0UL;
-		iopte +=3D 1 << cnum;
-	} while(--nent);
-
-	/* If the global flush might not have caught this entry,
-	 * adjust the flush point such that we will flush before
-	 * ever trying to reuse it.
-	 */
-#define between(X,Y,Z)	(((Z) - (Y)) >=3D ((X) - (Y)))
-	if (between(ent, iommu->alloc_info[cnum].next, iommu->alloc_info[cnum].fl=
ush))
-		iommu->alloc_info[cnum].flush =3D ent;
-#undef between
+	for (i =3D base; i < (base + npages); i++)
+		__clear_bit(i, arena->map);
 }
=20
-/* We allocate consistent mappings from the end of cluster zero. */
-static iopte_t *alloc_consistent_cluster(struct sbus_iommu *iommu, unsigne=
d long npages)
+static void sbus_iommu_table_init(struct sbus_iommu *iommu, unsigned int t=
sbsize)
 {
-	iopte_t *iopte;
+	unsigned long tsbbase, order, sz, num_tsb_entries;
=20
-	iopte =3D iommu->page_table + (1 * CLUSTER_NPAGES);
-	while (iopte > iommu->page_table) {
-		iopte--;
-		if (!(iopte_val(*iopte) & IOPTE_VALID)) {
-			unsigned long tmp =3D npages;
+	num_tsb_entries =3D tsbsize / sizeof(iopte_t);
=20
-			while (--tmp) {
-				iopte--;
-				if (iopte_val(*iopte) & IOPTE_VALID)
-					break;
-			}
-			if (tmp =3D 0) {
-				u32 entry =3D (iopte - iommu->page_table);
+	/* Setup initial software IOMMU state. */
+	spin_lock_init(&iommu->lock);
=20
-				if (entry < iommu->lowest_consistent_map)
-					iommu->lowest_consistent_map =3D entry;
-				return iopte;
-			}
-		}
+	/* Allocate and initialize the free area map.  */
+	sz =3D num_tsb_entries / 8;
+	sz =3D (sz + 7UL) & ~7UL;
+	iommu->arena.map =3D kzalloc(sz, GFP_KERNEL);
+	if (!iommu->arena.map) {
+		prom_printf("PCI_IOMMU: Error, kmalloc(arena.map) failed.\n");
+		prom_halt();
+	}
+	iommu->arena.limit =3D num_tsb_entries;
+
+	/* Now allocate and setup the IOMMU page table itself.  */
+	order =3D get_order(tsbsize);
+	tsbbase =3D __get_free_pages(GFP_KERNEL, order);
+	if (!tsbbase) {
+		prom_printf("IOMMU: Error, gfp(tsb) failed.\n");
+		prom_halt();
 	}
-	return NULL;
+	iommu->page_table =3D (iopte_t *)tsbbase;
+	memset(iommu->page_table, 0, tsbsize);
 }
=20
-static void free_consistent_cluster(struct sbus_iommu *iommu, u32 base, un=
signed long npages)
+static inline iopte_t *alloc_npages(struct sbus_iommu *iommu, unsigned lon=
g npages)
 {
-	iopte_t *iopte =3D iommu->page_table + ((base - MAP_BASE) >> IO_PAGE_SHIF=
T);
+	long entry;
=20
-	if ((iopte - iommu->page_table) =3D iommu->lowest_consistent_map) {
-		iopte_t *walk =3D iopte + npages;
-		iopte_t *limit;
+	entry =3D sbus_arena_alloc(iommu, npages);
+	if (unlikely(entry < 0))
+		return NULL;
=20
-		limit =3D iommu->page_table + CLUSTER_NPAGES;
-		while (walk < limit) {
-			if (iopte_val(*walk) !=3D 0UL)
-				break;
-			walk++;
-		}
-		iommu->lowest_consistent_map -			(walk - iommu->page_table);
-	}
+	return iommu->page_table + entry;
+}
=20
-	while (npages--)
-		*iopte++ =3D __iopte(0UL);
+static inline void free_npages(struct sbus_iommu *iommu, dma_addr_t base, =
unsigned long npages)
+{
+	sbus_arena_free(&iommu->arena, base >> IO_PAGE_SHIFT, npages);
 }
=20
 void *sbus_alloc_consistent(struct sbus_dev *sdev, size_t size, dma_addr_t=
 *dvma_addr)
 {
-	unsigned long order, first_page, flags;
 	struct sbus_iommu *iommu;
 	iopte_t *iopte;
+	unsigned long flags, order, first_page;
 	void *ret;
 	int npages;
=20
-	if (size <=3D 0 || sdev =3D NULL || dvma_addr =3D NULL)
-		return NULL;
-
 	size =3D IO_PAGE_ALIGN(size);
 	order =3D get_order(size);
 	if (order >=3D 10)
 		return NULL;
+
 	first_page =3D __get_free_pages(GFP_KERNEL|__GFP_COMP, order);
 	if (first_page =3D 0UL)
 		return NULL;
@@ -336,108 +237,121 @@ void *sbus_alloc_consistent(struct sbus_dev *sdev, =
size_t size, dma_addr_t *dvma
 	iommu =3D sdev->bus->iommu;
=20
 	spin_lock_irqsave(&iommu->lock, flags);
-	iopte =3D alloc_consistent_cluster(iommu, size >> IO_PAGE_SHIFT);
-	if (iopte =3D NULL) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
+	iopte =3D alloc_npages(iommu, size >> IO_PAGE_SHIFT);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	if (unlikely(iopte =3D NULL)) {
 		free_pages(first_page, order);
 		return NULL;
 	}
=20
-	/* Ok, we're committed at this point. */
-	*dvma_addr =3D MAP_BASE +	((iopte - iommu->page_table) << IO_PAGE_SHIFT);
+	*dvma_addr =3D (MAP_BASE +
+		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));
 	ret =3D (void *) first_page;
 	npages =3D size >> IO_PAGE_SHIFT;
+	first_page =3D __pa(first_page);
 	while (npages--) {
-		*iopte++ =3D __iopte(IOPTE_VALID | IOPTE_CACHE | IOPTE_WRITE |
-				   (__pa(first_page) & IOPTE_PAGE));
+		iopte_val(*iopte) =3D (IOPTE_VALID | IOPTE_CACHE |
+				     IOPTE_WRITE |
+				     (first_page & IOPTE_PAGE));
+		iopte++;
 		first_page +=3D IO_PAGE_SIZE;
 	}
-	iommu_flush(iommu, *dvma_addr, size >> IO_PAGE_SHIFT);
-	spin_unlock_irqrestore(&iommu->lock, flags);
=20
 	return ret;
 }
=20
 void sbus_free_consistent(struct sbus_dev *sdev, size_t size, void *cpu, d=
ma_addr_t dvma)
 {
-	unsigned long order, npages;
 	struct sbus_iommu *iommu;
-
-	if (size <=3D 0 || sdev =3D NULL || cpu =3D NULL)
-		return;
+	iopte_t *iopte;
+	unsigned long flags, order, npages;
=20
 	npages =3D IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu =3D sdev->bus->iommu;
+	iopte =3D iommu->page_table +
+		((dvma - MAP_BASE) >> IO_PAGE_SHIFT);
+
+	spin_lock_irqsave(&iommu->lock, flags);
+
+	free_npages(iommu, dvma - MAP_BASE, npages);
=20
-	spin_lock_irq(&iommu->lock);
-	free_consistent_cluster(iommu, dvma, npages);
-	iommu_flush(iommu, dvma, npages);
-	spin_unlock_irq(&iommu->lock);
+	spin_unlock_irqrestore(&iommu->lock, flags);
=20
 	order =3D get_order(size);
 	if (order < 10)
 		free_pages((unsigned long)cpu, order);
 }
=20
-dma_addr_t sbus_map_single(struct sbus_dev *sdev, void *ptr, size_t size, =
int dir)
+dma_addr_t sbus_map_single(struct sbus_dev *sdev, void *ptr, size_t sz, in=
t direction)
 {
-	struct sbus_iommu *iommu =3D sdev->bus->iommu;
-	unsigned long npages, pbase, flags;
-	iopte_t *iopte;
-	u32 dma_base, offset;
-	unsigned long iopte_bits;
+	struct sbus_iommu *iommu;
+	iopte_t *base;
+	unsigned long flags, npages, oaddr;
+	unsigned long i, base_paddr;
+	u32 bus_addr, ret;
+	unsigned long iopte_protection;
+
+	iommu =3D sdev->bus->iommu;
=20
-	if (dir =3D SBUS_DMA_NONE)
+	if (unlikely(direction =3D SBUS_DMA_NONE))
 		BUG();
=20
-	pbase =3D (unsigned long) ptr;
-	offset =3D (u32) (pbase & ~IO_PAGE_MASK);
-	size =3D (IO_PAGE_ALIGN(pbase + size) - (pbase & IO_PAGE_MASK));
-	pbase =3D (unsigned long) __pa(pbase & IO_PAGE_MASK);
+	oaddr =3D (unsigned long)ptr;
+	npages =3D IO_PAGE_ALIGN(oaddr + sz) - (oaddr & IO_PAGE_MASK);
+	npages >>=3D IO_PAGE_SHIFT;
=20
 	spin_lock_irqsave(&iommu->lock, flags);
-	npages =3D size >> IO_PAGE_SHIFT;
-	iopte =3D alloc_streaming_cluster(iommu, npages);
-	if (iopte =3D NULL)
-		goto bad;
-	dma_base =3D MAP_BASE + ((iopte - iommu->page_table) << IO_PAGE_SHIFT);
-	npages =3D size >> IO_PAGE_SHIFT;
-	iopte_bits =3D IOPTE_VALID | IOPTE_STBUF | IOPTE_CACHE;
-	if (dir !=3D SBUS_DMA_TODEVICE)
-		iopte_bits |=3D IOPTE_WRITE;
-	while (npages--) {
-		*iopte++ =3D __iopte(iopte_bits | (pbase & IOPTE_PAGE));
-		pbase +=3D IO_PAGE_SIZE;
-	}
-	npages =3D size >> IO_PAGE_SHIFT;
+	base =3D alloc_npages(iommu, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
=20
-	return (dma_base | offset);
+	if (unlikely(!base))
+		BUG();
=20
-bad:
-	spin_unlock_irqrestore(&iommu->lock, flags);
-	BUG();
-	return 0;
+	bus_addr =3D (MAP_BASE +
+		    ((base - iommu->page_table) << IO_PAGE_SHIFT));
+	ret =3D bus_addr | (oaddr & ~IO_PAGE_MASK);
+	base_paddr =3D __pa(oaddr & IO_PAGE_MASK);
+
+	iopte_protection =3D IOPTE_VALID | IOPTE_STBUF | IOPTE_CACHE;
+	if (direction !=3D SBUS_DMA_TODEVICE)
+		iopte_protection |=3D IOPTE_WRITE;
+
+	for (i =3D 0; i < npages; i++, base++, base_paddr +=3D IO_PAGE_SIZE)
+		iopte_val(*base) =3D iopte_protection | base_paddr;
+
+	return ret;
 }
=20
-void sbus_unmap_single(struct sbus_dev *sdev, dma_addr_t dma_addr, size_t =
size, int direction)
+void sbus_unmap_single(struct sbus_dev *sdev, dma_addr_t bus_addr, size_t =
sz, int direction)
 {
 	struct sbus_iommu *iommu =3D sdev->bus->iommu;
-	u32 dma_base =3D dma_addr & IO_PAGE_MASK;
-	unsigned long flags;
+	iopte_t *base;
+	unsigned long flags, npages, i;
+
+	if (unlikely(direction =3D SBUS_DMA_NONE))
+		BUG();
+
+	npages =3D IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
+	npages >>=3D IO_PAGE_SHIFT;
+	base =3D iommu->page_table +
+		((bus_addr - MAP_BASE) >> IO_PAGE_SHIFT);
=20
-	size =3D (IO_PAGE_ALIGN(dma_addr + size) - dma_base);
+	bus_addr &=3D IO_PAGE_MASK;
=20
 	spin_lock_irqsave(&iommu->lock, flags);
-	free_streaming_cluster(iommu, dma_base, size >> IO_PAGE_SHIFT);
-	sbus_strbuf_flush(iommu, dma_base, size >> IO_PAGE_SHIFT, direction);
+	sbus_strbuf_flush(iommu, bus_addr, npages, direction);
+	for (i =3D 0; i < npages; i++)
+		iopte_val(base[i]) =3D 0UL;
+	free_npages(iommu, bus_addr - MAP_BASE, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
=20
 #define SG_ENT_PHYS_ADDRESS(SG)	\
 	(__pa(page_address((SG)->page)) + (SG)->offset)
=20
-static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg, int nus=
ed, int nelems, unsigned long iopte_bits)
+static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg,
+			   int nused, int nelems, unsigned long iopte_protection)
 {
 	struct scatterlist *dma_sg =3D sg;
 	struct scatterlist *sg_end =3D sg + nelems;
@@ -462,7 +376,7 @@ static inline void fill_sg(iopte_t *iopte, struct scatt=
erlist *sg, int nused, in
 			for (;;) {
 				unsigned long tmp;
=20
-				tmp =3D (unsigned long) SG_ENT_PHYS_ADDRESS(sg);
+				tmp =3D SG_ENT_PHYS_ADDRESS(sg);
 				len =3D sg->length;
 				if (((tmp ^ pteval) >> IO_PAGE_SHIFT) !=3D 0UL) {
 					pteval =3D tmp & IO_PAGE_MASK;
@@ -478,7 +392,7 @@ static inline void fill_sg(iopte_t *iopte, struct scatt=
erlist *sg, int nused, in
 				sg++;
 			}
=20
-			pteval =3D ((pteval & IOPTE_PAGE) | iopte_bits);
+			pteval =3D iopte_protection | (pteval & IOPTE_PAGE);
 			while (len > 0) {
 				*iopte++ =3D __iopte(pteval);
 				pteval +=3D IO_PAGE_SIZE;
@@ -509,103 +423,111 @@ static inline void fill_sg(iopte_t *iopte, struct s=
catterlist *sg, int nused, in
 	}
 }
=20
-int sbus_map_sg(struct sbus_dev *sdev, struct scatterlist *sg, int nents, =
int dir)
+int sbus_map_sg(struct sbus_dev *sdev, struct scatterlist *sglist, int nel=
ems, int direction)
 {
-	struct sbus_iommu *iommu =3D sdev->bus->iommu;
-	unsigned long flags, npages;
-	iopte_t *iopte;
+	struct sbus_iommu *iommu;
+	unsigned long flags, npages, iopte_protection;
+	iopte_t *base;
 	u32 dma_base;
 	struct scatterlist *sgtmp;
 	int used;
-	unsigned long iopte_bits;
-
-	if (dir =3D SBUS_DMA_NONE)
-		BUG();
=20
 	/* Fast path single entry scatterlists. */
-	if (nents =3D 1) {
-		sg->dma_address +	if (nelems =3D 1) {
+		sglist->dma_address  			sbus_map_single(sdev,
-					(page_address(sg->page) + sg->offset),
-					sg->length, dir);
-		sg->dma_length =3D sg->length;
+					(page_address(sglist->page) + sglist->offset),
+					sglist->length, direction);
+		sglist->dma_length =3D sglist->length;
 		return 1;
 	}
=20
-	npages =3D prepare_sg(sg, nents);
+	iommu =3D sdev->bus->iommu;
+
+	if (unlikely(direction =3D SBUS_DMA_NONE))
+		BUG();
+
+	npages =3D prepare_sg(sglist, nelems);
=20
 	spin_lock_irqsave(&iommu->lock, flags);
-	iopte =3D alloc_streaming_cluster(iommu, npages);
-	if (iopte =3D NULL)
-		goto bad;
-	dma_base =3D MAP_BASE + ((iopte - iommu->page_table) << IO_PAGE_SHIFT);
+	base =3D alloc_npages(iommu, npages);
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	if (unlikely(base =3D NULL))
+		BUG();
+
+	dma_base =3D MAP_BASE +
+		((base - iommu->page_table) << IO_PAGE_SHIFT);
=20
 	/* Normalize DVMA addresses. */
-	sgtmp =3D sg;
-	used =3D nents;
+	used =3D nelems;
=20
+	sgtmp =3D sglist;
 	while (used && sgtmp->dma_length) {
 		sgtmp->dma_address +=3D dma_base;
 		sgtmp++;
 		used--;
 	}
-	used =3D nents - used;
+	used =3D nelems - used;
=20
-	iopte_bits =3D IOPTE_VALID | IOPTE_STBUF | IOPTE_CACHE;
-	if (dir !=3D SBUS_DMA_TODEVICE)
-		iopte_bits |=3D IOPTE_WRITE;
+	iopte_protection =3D IOPTE_VALID | IOPTE_STBUF | IOPTE_CACHE;
+	if (direction !=3D SBUS_DMA_TODEVICE)
+		iopte_protection |=3D IOPTE_WRITE;
+
+	fill_sg(base, sglist, used, nelems, iopte_protection);
=20
-	fill_sg(iopte, sg, used, nents, iopte_bits);
 #ifdef VERIFY_SG
-	verify_sglist(sg, nents, iopte, npages);
+	verify_sglist(sglist, nelems, base, npages);
 #endif
-	spin_unlock_irqrestore(&iommu->lock, flags);
=20
 	return used;
-
-bad:
-	spin_unlock_irqrestore(&iommu->lock, flags);
-	BUG();
-	return 0;
 }
=20
-void sbus_unmap_sg(struct sbus_dev *sdev, struct scatterlist *sg, int nent=
s, int direction)
+void sbus_unmap_sg(struct sbus_dev *sdev, struct scatterlist *sglist, int =
nelems, int direction)
 {
-	unsigned long size, flags;
 	struct sbus_iommu *iommu;
-	u32 dvma_base;
-	int i;
+	iopte_t *base;
+	unsigned long flags, i, npages;
+	u32 bus_addr;
=20
-	/* Fast path single entry scatterlists. */
-	if (nents =3D 1) {
-		sbus_unmap_single(sdev, sg->dma_address, sg->dma_length, direction);
-		return;
-	}
+	if (unlikely(direction =3D SBUS_DMA_NONE))
+		BUG();
+
+	iommu =3D sdev->bus->iommu;
+
+	bus_addr =3D sglist->dma_address & IO_PAGE_MASK;
=20
-	dvma_base =3D sg[0].dma_address & IO_PAGE_MASK;
-	for (i =3D 0; i < nents; i++) {
-		if (sg[i].dma_length =3D 0)
+	for (i =3D 1; i < nelems; i++)
+		if (sglist[i].dma_length =3D 0)
 			break;
-	}
 	i--;
-	size =3D IO_PAGE_ALIGN(sg[i].dma_address + sg[i].dma_length) - dvma_base;
+	npages =3D (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length) -
+		  bus_addr) >> IO_PAGE_SHIFT;
+
+	base =3D iommu->page_table +
+		((bus_addr - MAP_BASE) >> IO_PAGE_SHIFT);
=20
-	iommu =3D sdev->bus->iommu;
 	spin_lock_irqsave(&iommu->lock, flags);
-	free_streaming_cluster(iommu, dvma_base, size >> IO_PAGE_SHIFT);
-	sbus_strbuf_flush(iommu, dvma_base, size >> IO_PAGE_SHIFT, direction);
+	sbus_strbuf_flush(iommu, bus_addr, npages, direction);
+	for (i =3D 0; i < npages; i++)
+		iopte_val(base[i]) =3D 0UL;
+	free_npages(iommu, bus_addr - MAP_BASE, npages);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
=20
-void sbus_dma_sync_single_for_cpu(struct sbus_dev *sdev, dma_addr_t base, =
size_t size, int direction)
+void sbus_dma_sync_single_for_cpu(struct sbus_dev *sdev, dma_addr_t bus_ad=
dr, size_t sz, int direction)
 {
-	struct sbus_iommu *iommu =3D sdev->bus->iommu;
-	unsigned long flags;
+	struct sbus_iommu *iommu;
+	unsigned long flags, npages;
+
+	iommu =3D sdev->bus->iommu;
=20
-	size =3D (IO_PAGE_ALIGN(base + size) - (base & IO_PAGE_MASK));
+	npages =3D IO_PAGE_ALIGN(bus_addr + sz) - (bus_addr & IO_PAGE_MASK);
+	npages >>=3D IO_PAGE_SHIFT;
+	bus_addr &=3D IO_PAGE_MASK;
=20
 	spin_lock_irqsave(&iommu->lock, flags);
-	sbus_strbuf_flush(iommu, base & IO_PAGE_MASK, size >> IO_PAGE_SHIFT, dire=
ction);
+	sbus_strbuf_flush(iommu, bus_addr, npages, direction);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
=20
@@ -613,23 +535,25 @@ void sbus_dma_sync_single_for_device(struct sbus_dev =
*sdev, dma_addr_t base, siz
 {
 }
=20
-void sbus_dma_sync_sg_for_cpu(struct sbus_dev *sdev, struct scatterlist *s=
g, int nents, int direction)
+void sbus_dma_sync_sg_for_cpu(struct sbus_dev *sdev, struct scatterlist *s=
glist, int nelems, int direction)
 {
-	struct sbus_iommu *iommu =3D sdev->bus->iommu;
-	unsigned long flags, size;
-	u32 base;
-	int i;
+	struct sbus_iommu *iommu;
+	unsigned long flags, npages, i;
+	u32 bus_addr;
+
+	iommu =3D sdev->bus->iommu;
=20
-	base =3D sg[0].dma_address & IO_PAGE_MASK;
-	for (i =3D 0; i < nents; i++) {
-		if (sg[i].dma_length =3D 0)
+	bus_addr =3D sglist[0].dma_address & IO_PAGE_MASK;
+	for (i =3D 0; i < nelems; i++) {
+		if (!sglist[i].dma_length)
 			break;
 	}
 	i--;
-	size =3D IO_PAGE_ALIGN(sg[i].dma_address + sg[i].dma_length) - base;
+	npages =3D (IO_PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length)
+		  - bus_addr) >> IO_PAGE_SHIFT;
=20
 	spin_lock_irqsave(&iommu->lock, flags);
-	sbus_strbuf_flush(iommu, base, size >> IO_PAGE_SHIFT, direction);
+	sbus_strbuf_flush(iommu, bus_addr, npages, direction);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
=20
@@ -1104,7 +1028,7 @@ static void __init sbus_iommu_init(int __node, struct=
 sbus_bus *sbus)
 	struct linux_prom64_registers *pr;
 	struct device_node *dp;
 	struct sbus_iommu *iommu;
-	unsigned long regs, tsb_base;
+	unsigned long regs;
 	u64 control;
 	int i;
=20
@@ -1132,14 +1056,6 @@ static void __init sbus_iommu_init(int __node, struc=
t sbus_bus *sbus)
=20
 	memset(iommu, 0, sizeof(*iommu));
=20
-	/* We start with no consistent mappings. */
-	iommu->lowest_consistent_map =3D CLUSTER_NPAGES;
-
-	for (i =3D 0; i < NCLUSTERS; i++) {
-		iommu->alloc_info[i].flush =3D 0;
-		iommu->alloc_info[i].next =3D 0;
-	}
-
 	/* Setup spinlock. */
 	spin_lock_init(&iommu->lock);
=20
@@ -1159,25 +1075,13 @@ static void __init sbus_iommu_init(int __node, stru=
ct sbus_bus *sbus)
 	       sbus->portid, regs);
=20
 	/* Setup for TSB_SIZE=3D7, TBW_SIZE=3D0, MMU_DE=3D1, MMU_EN=3D1 */
+	sbus_iommu_table_init(iommu, IO_TSB_SIZE);
+
 	control =3D upa_readq(iommu->iommu_regs + IOMMU_CONTROL);
 	control =3D ((7UL << 16UL)	|
 		   (0UL << 2UL)		|
 		   (1UL << 1UL)		|
 		   (1UL << 0UL));
-
-	/* Using the above configuration we need 1MB iommu page
-	 * table (128K ioptes * 8 bytes per iopte).  This is
-	 * page order 7 on UltraSparc.
-	 */
-	tsb_base =3D __get_free_pages(GFP_ATOMIC, get_order(IO_TSB_SIZE));
-	if (tsb_base =3D 0UL) {
-		prom_printf("sbus_iommu_init: Fatal error, cannot alloc TSB table.\n");
-		prom_halt();
-	}
-
-	iommu->page_table =3D (iopte_t *) tsb_base;
-	memset(iommu->page_table, 0, IO_TSB_SIZE);
-
 	upa_writeq(control, iommu->iommu_regs + IOMMU_CONTROL);
=20
 	/* Clean out any cruft in the IOMMU using
@@ -1195,7 +1099,7 @@ static void __init sbus_iommu_init(int __node, struct=
 sbus_bus *sbus)
 	upa_readq(iommu->sbus_control_reg);
=20
 	/* Give the TSB to SYSIO. */
-	upa_writeq(__pa(tsb_base), iommu->iommu_regs + IOMMU_TSBBASE);
+	upa_writeq(__pa(iommu->page_table), iommu->iommu_regs + IOMMU_TSBBASE);
=20
 	/* Setup streaming buffer, DE=3D1 SB_EN=3D1 */
 	control =3D (1UL << 1UL) | (1UL << 0UL);
