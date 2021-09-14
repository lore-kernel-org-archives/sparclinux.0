Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6157C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 06:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC00606A5
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 06:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbhINGSZ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 02:18:25 -0400
Received: from verein.lst.de ([213.95.11.211]:58609 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240015AbhINGSY (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 14 Sep 2021 02:18:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94E1467357; Tue, 14 Sep 2021 08:17:05 +0200 (CEST)
Date:   Tue, 14 Sep 2021 08:17:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH] sparc32: Page align size in arch_dma_alloc
Message-ID: <20210914061705.GB26679@lst.de>
References: <20210908074822.16793-1-andreas@gaisler.com> <20210909060712.GA25485@lst.de> <3a653ab5-14d2-f61f-cb0a-cbeba93b4ac8@gaisler.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <3a653ab5-14d2-f61f-cb0a-cbeba93b4ac8@gaisler.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 13, 2021 at 03:18:38PM +0200, Andreas Larsson wrote:
>> Andreas - while I've got your attention:  I've been looking into fully
>> converting sparc32 to the generic DMA code.  Do you have any
>> documentation for the Leon cache handling in dma_make_coherent,
>> and more importantly how that applies to the dma coherent handling?
>> I could see how a flush might be required for the streaming DMA mappings,
>> that is mapping normal cached memory for I/O.  But for the coherent
>> allocations which can be accessed from the device and the cpu without
>> another DMA mapping call this seems really strange.
>
> As long as the area passed to arch_dma_free is mapped by
> arch_dma_allocate, I don't see why the call to dma_make_coherent in
> arch_dma_free should be needed. I am not sure if there are any current
> (or historical paths) where we nevertheless have a cacheable mapping
> when we reach arch_dma_free (or the historical pci32_free_coherent).

Note that the cacheable mapping in the kernel map still exists, but is
is not used for any access.

> The usual case for LEON systems is that cache snooping on the CPU side
> invalidates cache lines matching DMA that the CPU sees on the bus. Under
> the assumption that DMA accesses are seen on the processor bus, this is
> the reason for only flushing if snooping is not enabled in
> dma_make_coherent.

Thanks.  Can you take a look and test the two patches below on top of
your fix?  A git tree is also available here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sparc32-generic-dma

--huq684BweRXVnRxX
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-sparc32-remove-dma_make_coherent.patch"

From 832183d0409a941788e4c27682b2ad5164aec5d9 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 13 Sep 2021 18:39:38 +0200
Subject: sparc32: remove dma_make_coherent

LEON only needs snooping when DMA accesses are not seen on the processor
bus.  Given that coherent allocations are mapped uncached this can't
happen for those, so open code the d-cache flushing logic in the only
remaing place that needs it, arch_sync_dma_for_cpu.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/ioport.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 7ceae24b0ca99..3eb748e862220 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -52,17 +52,6 @@
 #include <asm/io-unit.h>
 #include <asm/leon.h>
 
-/* This function must make sure that caches and memory are coherent after DMA
- * On LEON systems without cache snooping it flushes the entire D-CACHE.
- */
-static inline void dma_make_coherent(unsigned long pa, unsigned long len)
-{
-	if (sparc_cpu_model == sparc_leon) {
-		if (!sparc_leon3_snooping_enabled())
-			leon_flush_dcache_all();
-	}
-}
-
 static void __iomem *_sparc_ioremap(struct resource *res, u32 bus, u32 pa, int sz);
 static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
     unsigned long size, char *name);
@@ -361,18 +350,23 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	if (!sparc_dma_free_resource(cpu_addr, size))
 		return;
 
-	dma_make_coherent(dma_addr, size);
 	srmmu_unmapiorange((unsigned long)cpu_addr, size);
 	free_pages((unsigned long)phys_to_virt(dma_addr), get_order(size));
 }
 
-/* IIep is write-through, not flushing on cpu to device transfer. */
-
+/*
+ * IIep is write-through, not flushing on cpu to device transfer.
+ *
+ * On LEON systems without cache snooping, the entire D-CACHE must be flushed to
+ * make DMA to cacheable memory coherent.
+ */
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	if (dir != PCI_DMA_TODEVICE)
-		dma_make_coherent(paddr, PAGE_ALIGN(size));
+	if (dir != PCI_DMA_TODEVICE &&
+	    sparc_cpu_model == sparc_leon &&
+	    !sparc_leon3_snooping_enabled())
+		leon_flush_dcache_all();
 }
 
 #ifdef CONFIG_PROC_FS
-- 
2.30.2


--huq684BweRXVnRxX
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-sparc32-use-DMA_DIRECT_REMAP.patch"

From 0f612347699290a8d2f604a7640b5568e3d9af57 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 13 Sep 2021 18:44:55 +0200
Subject: sparc32: use DMA_DIRECT_REMAP

Use the generic dma remapping allocator instead of open coding it.
This also avoids setting up page tables from irq context which is
generally dangerous and uses the atomic pool instead.

The only interesting part is the architecture specific pgprot_dmacoherent
definition that sets the SRMMU_PRIV bit as done by the old implementation.
(I have no idea what it is useful for, though).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/Kconfig                  |  3 +-
 arch/sparc/include/asm/pgtable_32.h |  8 +++++
 arch/sparc/kernel/ioport.c          | 54 -----------------------------
 3 files changed, 10 insertions(+), 55 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f0c0f955e1695..8089258d6cc97 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -54,8 +54,9 @@ config SPARC32
 	def_bool !64BIT
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
-	select GENERIC_ATOMIC64
 	select CLZ_TAB
+	select DMA_DIRECT_REMAP
+	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select OLD_SIGACTION
 	select ZONE_DMA
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index ffccfe3b22ed3..1e7984ff7b320 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -313,6 +313,14 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
 	return prot;
 }
 
+#define pgprot_dmacoherent pgprot_dmacoherent
+static inline pgprot_t pgprot_dmacoherent(pgprot_t prot)
+{
+	pgprot_val(prot) &= ~pgprot_val(__pgprot(SRMMU_CACHE));
+	pgprot_val(prot) |= pgprot_val(__pgprot(SRMMU_PRIV));
+	return prot;
+}
+
 static pte_t pte_modify(pte_t pte, pgprot_t newprot) __attribute_const__;
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 3eb748e862220..57a72c46eddb0 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -300,60 +300,6 @@ arch_initcall(sparc_register_ioport);
 
 #endif /* CONFIG_SBUS */
 
-
-/* Allocate and map kernel buffer using consistent mode DMA for a device.
- * hwdev should be valid struct pci_dev pointer for PCI devices.
- */
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
-{
-	unsigned long addr;
-	void *va;
-
-	if (!size || size > 256 * 1024)	/* __get_free_pages() limit */
-		return NULL;
-
-	size = PAGE_ALIGN(size);
-	va = (void *) __get_free_pages(gfp | __GFP_ZERO, get_order(size));
-	if (!va) {
-		printk("%s: no %zd pages\n", __func__, size >> PAGE_SHIFT);
-		return NULL;
-	}
-
-	addr = sparc_dma_alloc_resource(dev, size);
-	if (!addr)
-		goto err_nomem;
-
-	srmmu_mapiorange(0, virt_to_phys(va), addr, size);
-
-	*dma_handle = virt_to_phys(va);
-	return (void *)addr;
-
-err_nomem:
-	free_pages((unsigned long)va, get_order(size));
-	return NULL;
-}
-
-/* Free and unmap a consistent DMA buffer.
- * cpu_addr is what was returned arch_dma_alloc, size must be the same as what
- * was passed into arch_dma_alloc, and likewise dma_addr must be the same as
- * what *dma_ndler was set to.
- *
- * References to the memory and mappings associated with cpu_addr/dma_addr
- * past this call are illegal.
- */
-void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_addr, unsigned long attrs)
-{
-	size = PAGE_ALIGN(size);
-
-	if (!sparc_dma_free_resource(cpu_addr, size))
-		return;
-
-	srmmu_unmapiorange((unsigned long)cpu_addr, size);
-	free_pages((unsigned long)phys_to_virt(dma_addr), get_order(size));
-}
-
 /*
  * IIep is write-through, not flushing on cpu to device transfer.
  *
-- 
2.30.2


--huq684BweRXVnRxX--
