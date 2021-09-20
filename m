Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666ECC433EF
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B3660F93
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhITLeO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbhITLeL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Sep 2021 07:34:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE1C061574
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=u45r6MitWyCxusudU5ASyBKzzauZHQs57vTEQo+c/tw=; b=jPlJ5mhQdREw0t7856DvhhFHTW
        99ZUfwR4EpyLsikwG5wE6xPp6qZFtFiH2NWJcfyLOR9jsZSxpHqY0YfMhflM1Pa+cfXViar7DoltA
        OLswKyCkSwaj2nF8x+TQATE9nxDxEl2IVLmtfnI70Z8eomFRc09gcXF0WVdZNzW2s+S9Wf0O2uDOV
        8OWblDZ+AC3s7NZCCU3chDA+a5yJKFg260tuv7Qpni9vDta7aweGHqcxyvk2waZugRRbhI+b3ooHC
        E4JCu7gpoFGD8mWvEvhr2sDSjlHJHBDCPpMDP59knrYk0BwXEYrDbCd+BJ5kYqqifMxdnrvMJXO4Q
        i8rNiWjg==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHX0-002cHb-14; Mon, 20 Sep 2021 11:32:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: [PATCH 2/2] sparc32: use DMA_DIRECT_REMAP
Date:   Mon, 20 Sep 2021 13:31:08 +0200
Message-Id: <20210920113108.1299996-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920113108.1299996-1-hch@lst.de>
References: <20210920113108.1299996-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Use the generic dma remapping allocator instead of open coding it.
This also avoids setting up page tables from irq context which is
generally dangerous and uses the atomic pool instead.

Note that this changes the kernel virtual address at which the
dma coherent memory is mapped from the DVMA_VADDR region to the general
vmalloc pool.  I could not find any indication that this matters
for the hardware.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/Kconfig         |  3 ++-
 arch/sparc/kernel/ioport.c | 54 --------------------------------------
 2 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index b120ed947f50b..66fc08646be5e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -53,8 +53,9 @@ config SPARC32
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

