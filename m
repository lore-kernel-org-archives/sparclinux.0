From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Dec 2018 19:21:20 +0000
Subject: Re: [PATCH 2/4] sparc: factor the dma coherent mapping into helper
Message-Id: <20181210192120.GA31178@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181207141407.3154-3-hch@lst.de>
In-Reply-To: <20181207141407.3154-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 09, 2018 at 07:42:03AM +0100, Sam Ravnborg wrote:
> > +		return 0;
> > +	res->name = dev->of_node->name;
> Rob Herrring would prefer us to use dev->of_node->full_name

Then he should send a patch for that, which will be a little simpler
now that we just have a single instance of this code.

I'd rather not mix pure refactoring with behavior changes like this.

> > +
> > +	if (allocate_resource(&_sparc_dvma, res, len, _sparc_dvma.start,
> > +			_sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
> Fix indent here. "_sparc_dvma.end," must be aligned below "&_sparc_dvma"

Two tab indentation for conditional continuations is pretty normal,
but I can fix it up.

> 
> > +		printk("sbus_alloc_consistent: cannot occupy 0x%zx", len);
> Use __func__ so we avoid hardcoding the (wrong) function name.

Sure.  Updated patch below.

---
From 7be8f8b18f30bccf1d1630d0d247af991f58c86e Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 3 Dec 2018 14:02:26 +0100
Subject: sparc: factor the dma coherent mapping into helper

Factor the code to remap memory returned from the DMA coherent allocator
into two helpers that can be shared by the IOMMU and direct mapping code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/ioport.c | 151 ++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 84 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 4b2167a0ec0b..ef3c61aec32a 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -247,6 +247,53 @@ static void _sparc_free_io(struct resource *res)
 	release_resource(res);
 }
 
+static unsigned long sparc_dma_alloc_resource(struct device *dev, size_t len)
+{
+	struct resource *res;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return 0;
+	res->name = dev->of_node->name;
+
+	if (allocate_resource(&_sparc_dvma, res, len, _sparc_dvma.start,
+			      _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
+		printk("%s: cannot occupy 0x%zx", __func__, len);
+		kfree(res);
+		return 0;
+	}
+
+	return res->start;
+}
+
+static bool sparc_dma_free_resource(void *cpu_addr, size_t size)
+{
+	unsigned long addr = (unsigned long)cpu_addr;
+	struct resource *res;
+
+	res = lookup_resource(&_sparc_dvma, addr);
+	if (!res) {
+		printk("%s: cannot free %p\n", __func__, cpu_addr);
+		return false;
+	}
+
+	if ((addr & (PAGE_SIZE - 1)) != 0) {
+		printk("%s: unaligned va %p\n", __func__, cpu_addr);
+		return false;
+	}
+
+	size = PAGE_ALIGN(size);
+	if (resource_size(res) != size) {
+		printk("%s: region 0x%lx asked 0x%zx\n",
+			__func__, (long)resource_size(res), size);
+		return false;
+	}
+
+	release_resource(res);
+	kfree(res);
+	return true;
+}
+
 #ifdef CONFIG_SBUS
 
 void sbus_set_sbus64(struct device *dev, int x)
@@ -264,10 +311,8 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 				 dma_addr_t *dma_addrp, gfp_t gfp,
 				 unsigned long attrs)
 {
-	struct platform_device *op = to_platform_device(dev);
 	unsigned long len_total = PAGE_ALIGN(len);
-	unsigned long va;
-	struct resource *res;
+	unsigned long va, addr;
 	int order;
 
 	/* XXX why are some lengths signed, others unsigned? */
@@ -284,32 +329,23 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 	if (va = 0)
 		goto err_nopages;
 
-	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) = NULL)
+	addr = sparc_dma_alloc_resource(dev, len_total);
+	if (!addr)
 		goto err_nomem;
 
-	if (allocate_resource(&_sparc_dvma, res, len_total,
-	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
-		printk("sbus_alloc_consistent: cannot occupy 0x%lx", len_total);
-		goto err_nova;
-	}
-
 	// XXX The sbus_map_dma_area does this for us below, see comments.
 	// srmmu_mapiorange(0, virt_to_phys(va), res->start, len_total);
 	/*
 	 * XXX That's where sdev would be used. Currently we load
 	 * all iommu tables with the same translations.
 	 */
-	if (sbus_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0)
+	if (sbus_map_dma_area(dev, dma_addrp, va, addr, len_total) != 0)
 		goto err_noiommu;
 
-	res->name = op->dev.of_node->name;
-
-	return (void *)(unsigned long)res->start;
+	return (void *)addr;
 
 err_noiommu:
-	release_resource(res);
-err_nova:
-	kfree(res);
+	sparc_dma_free_resource((void *)addr, len_total);
 err_nomem:
 	free_pages(va, order);
 err_nopages:
@@ -319,29 +355,11 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 static void sbus_free_coherent(struct device *dev, size_t n, void *p,
 			       dma_addr_t ba, unsigned long attrs)
 {
-	struct resource *res;
 	struct page *pgv;
 
-	if ((res = lookup_resource(&_sparc_dvma,
-	    (unsigned long)p)) = NULL) {
-		printk("sbus_free_consistent: cannot free %p\n", p);
-		return;
-	}
-
-	if (((unsigned long)p & (PAGE_SIZE-1)) != 0) {
-		printk("sbus_free_consistent: unaligned va %p\n", p);
-		return;
-	}
-
 	n = PAGE_ALIGN(n);
-	if (resource_size(res) != n) {
-		printk("sbus_free_consistent: region 0x%lx asked 0x%zx\n",
-		    (long)resource_size(res), n);
+	if (!sparc_dma_free_resource(p, n))
 		return;
-	}
-
-	release_resource(res);
-	kfree(res);
 
 	pgv = virt_to_page(p);
 	sbus_unmap_dma_area(dev, ba, n);
@@ -418,45 +436,30 @@ arch_initcall(sparc_register_ioport);
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
-	unsigned long len_total = PAGE_ALIGN(size);
+	unsigned long addr;
 	void *va;
-	struct resource *res;
-	int order;
 
-	if (size = 0) {
+	if (!size || size > 256 * 1024)	/* __get_free_pages() limit */
 		return NULL;
-	}
-	if (size > 256*1024) {			/* __get_free_pages() limit */
-		return NULL;
-	}
 
-	order = get_order(len_total);
-	va = (void *) __get_free_pages(gfp, order);
-	if (va = NULL) {
-		printk("%s: no %ld pages\n", __func__, len_total>>PAGE_SHIFT);
-		goto err_nopages;
+	size = PAGE_ALIGN(size);
+	va = (void *) __get_free_pages(gfp, get_order(size));
+	if (!va) {
+		printk("%s: no %zd pages\n", __func__, size >> PAGE_SHIFT);
+		return NULL;
 	}
 
-	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) = NULL) {
-		printk("%s: no core\n", __func__);
+	addr = sparc_dma_alloc_resource(dev, size);
+	if (!addr)
 		goto err_nomem;
-	}
 
-	if (allocate_resource(&_sparc_dvma, res, len_total,
-	    _sparc_dvma.start, _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
-		printk("%s: cannot occupy 0x%lx", __func__, len_total);
-		goto err_nova;
-	}
-	srmmu_mapiorange(0, virt_to_phys(va), res->start, len_total);
+	srmmu_mapiorange(0, virt_to_phys(va), addr, size);
 
 	*dma_handle = virt_to_phys(va);
-	return (void *) res->start;
+	return (void *)addr;
 
-err_nova:
-	kfree(res);
 err_nomem:
-	free_pages((unsigned long)va, order);
-err_nopages:
+	free_pages((unsigned long)va, get_order(size));
 	return NULL;
 }
 
@@ -471,31 +474,11 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	struct resource *res;
-
-	if ((res = lookup_resource(&_sparc_dvma,
-	    (unsigned long)cpu_addr)) = NULL) {
-		printk("%s: cannot free %p\n", __func__, cpu_addr);
-		return;
-	}
-
-	if (((unsigned long)cpu_addr & (PAGE_SIZE-1)) != 0) {
-		printk("%s: unaligned va %p\n", __func__, cpu_addr);
+	if (!sparc_dma_free_resource(cpu_addr, PAGE_ALIGN(size)))
 		return;
-	}
-
-	size = PAGE_ALIGN(size);
-	if (resource_size(res) != size) {
-		printk("%s: region 0x%lx asked 0x%zx\n", __func__,
-		    (long)resource_size(res), size);
-		return;
-	}
 
 	dma_make_coherent(dma_addr, size);
 	srmmu_unmapiorange((unsigned long)cpu_addr, size);
-
-	release_resource(res);
-	kfree(res);
 	free_pages((unsigned long)phys_to_virt(dma_addr), get_order(size));
 }
 
-- 
2.19.2
