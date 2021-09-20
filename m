Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345CEC433F5
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D95460FA0
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhITLdv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhITLdv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Sep 2021 07:33:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A4C061574
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=G0bIwG0s0R5HmnXRdo1m5ugvyiGKA8hcIxeIKAgekwA=; b=GfoUICJzwxaukBUu4IpQiKkz6o
        YDaBi9Qn13PsvrPiKjpIZ+CTf6eLIm2PtvkZ4D6IkDXQDmESOstTIhb8RHHFcI28Q8YSvjhUnnXLJ
        dN+FQ6dBewZjAh2ecOicpnDsBZAA5mSDo/D7Xfz0FF3QaiCfZ4u9HKJCA7YvytwfJkgs6dkInn1Gf
        tpNLn+ft02eItDyPccUZdkb1dTu0XfNp9NXhdj6ZcFcvIYBONwDT3dCWucacikAf6BS+GqhtGx+s9
        iRGmwSuN7zFISl/cD+u9+xZX5jJP5o3/C+2j3s3zssEVGqwCFlVcxFESPvpEQvMyUTAijM6lDXW/l
        IRqhf3Dw==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHWW-002cHB-Ov; Mon, 20 Sep 2021 11:31:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: [PATCH 1/2] sparc32: remove dma_make_coherent
Date:   Mon, 20 Sep 2021 13:31:07 +0200
Message-Id: <20210920113108.1299996-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920113108.1299996-1-hch@lst.de>
References: <20210920113108.1299996-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

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

