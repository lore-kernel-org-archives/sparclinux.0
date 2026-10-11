Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E145C71D
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748681; cv=none; b=U4vvG21+lnZm7LuP3v99vqSeXBO4E6elh3GjJ1rT3eUzM6Gw5yId8gjvCkEolEY1Pok+y2AQjI1c1Yw5o9lKphpocKR3s3MgUDWaMgv0XRkkQTx7X0PN8BrVUJ+Gl4DLGzi5qw6eGtWbskNDiP17iTvWPodMj69eO0BjSOGXczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748681; c=relaxed/simple;
	bh=q/kaqH0NJuwkt2lnyvmJXyH48rKP4gvCpd/rucX8egQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtH+xa+gA9s+y+VTIdOBm9G4a1pec/luwSilNUIfE9qXrJ7cHJQiEBdDmDuo2YTzKgpxst3+LI2H/+jsB7ktLn3k03noZVgB4dKdn+ShhG07Ii55QJBsAkEFweCW5kpUAUmtinDjjo54WQKJ4QfoKlqCBCL6SFknUfj2OiICdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXqMbqVK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXqMbqVK"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1af232df4so463835a12.0
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748676; x=1792353476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gFicFhMFOiZdadPIml2IafLC2zhV61kmcuAZSomfBQ=;
        b=VXqMbqVKZyDR3+b5q5/fxED3+YO43uf2cCWl0UlS8LAJ2mrADkALCeqv9Q1bCZODqG
         WnrSV2SBtWJVZRwTsPx5xruJCNvS+nMgwOnvsS9ijIhupA3W+R6hCCxI+GruRLFmWjA/
         OHLhdhYaH0eUGjcjkJ3L9oTi+tCnBRGKVCvb5sq7Jq0AGpQPcaLh6PuPF7kexDMGOb3J
         cGQJBySMOTk8M5/dEsomgAiA72RrRoAB/iWUlGnTvJUC4NfT8C7ekps5GC9ULvvjWgtg
         0S4zVhEuVURlCeA5JZ7M3ZtC9vMD52l4ZcUxV52utZSfonWiljt6yH2Lese0WcOxO+6y
         /s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748676; x=1792353476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4gFicFhMFOiZdadPIml2IafLC2zhV61kmcuAZSomfBQ=;
        b=J4HBGcGCQfbEL3p56+V5VY1ULTw6GTqgbY/qO6SdrkDjmtdQMVBFyNrVOncUkYQ4mP
         m+bDP4dwK7qfjW45hKuGRfKIsalFjfTHCHUaj8I7Vmvzle2f3iwBqjaQOhHc9cTqL5yi
         i2llNrn1x6KkIbodaxRoDkdVyjsZgm0fslI3xLJZNBW7cC9tXUa1/AU4IDrReQKGRSwi
         4vsoRe8LI+ZERGeXiXyUfp/LH4LaWpHpW5BpkSnS1NaEVnnyPC6Idh42JzqxpgbGf/SB
         S46lPOp0C0aCvOZ+JskuPAVdBxpOJcTGvi5YEXk5W1Hja0nnU2521ZB11y4JR5HG/vBW
         rQWA==
X-Forwarded-Encrypted: i=1; AKwUvBxty/Pqi/qeASJ3gdhMiIXWTCMomsgFcSc2m/jNQ8YRNPqJkxY9LnUtzgaeaz0TaxAJf+j0azYh5DWa@vger.kernel.org
X-Gm-Message-State: AFq9FYJFaLdkHE7+5M3kzLLtp898CXXaVdOLTt5btd2K8/KecCX2rtg4
	87Cb/XMfds+WFZLGlRWO/cd5GEEGuhm871ZNLHcGzIDuUgaPdvbJLUOH
X-Gm-Gg: AYBFou2OKx5z4Aoyq2SPytvTBpWBy+QwWZ7SdPNN2Zm7hkwGC/h2SGpHvQeYtmqQf32
	vI/DoIl1TwwB+GYkNegiKaK8XFzTQ1rDAUWCQoowPHNqkVxKeRbFBf8gY9TEX8PN20qGSlrSBAw
	vHsexgqd6LKR0hBY7rfPPzY7yLZDvNHIe0ELW/QYWWb11v2tsl5ivNXEvgJfjLAnQndfQRHnOUH
	/nG1+M21U0QEfi9Pr0oRH0NRTKUBrqu+FrdNx/ulU9RvWw/CH/Ea0flJEYQ2R9SSdR1iLecAdGV
	yyOvdHWGJc8LZgqnDux/lLu131boeB+wsCO3YCVe3gR5OtTrWNPC2LoMmlcl4eYfizeGoEBVsil
	mcLWIwtyHEJO2yWSK2LJ0V8ySOSy0ZBIEqU3oMsKtMQZdzit33GrHwaoH2skvXV5xbFDW4jKfXR
	U8p/9k2h+wnfXJuvNSHaCcRB8AgNtmxQ7VbxtafQNKaRlqQTv+ZPgzJ7ZfZczt9XAVpAG3dPsea
	8XIJQXd4hSWmeepokL9Ze/fDv7q3gS3wswd/SO/fTjcLcaq/4c=
X-Received: by 2002:a17:907:2d88:b0:c25:541:fd3a with SMTP id a640c23a62f3a-c31a9a07db1mr734461466b.7.1791748675559;
        Sun, 11 Oct 2026 12:57:55 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:54 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v2 5/6] sparc64: add M3000 Oberon PCIe support
Date: Sun, 11 Oct 2026 21:55:57 +0200
Message-ID: <20261011195729.981243-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recognize Oberon while preserving firmware link setup. Flush DVMA
translations and changed noncoherent IOTSB cache lines, and route legacy
interrupts using the bridge's ten-bit target ID.

Cache the bridge type and share target encoding. Leave MSI queues
uninitialized so the existing architecture path uses legacy interrupts
even with CONFIG_PCI_MSI=y; native bridge error handling is not provided.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/Kconfig                | 10 +++++++
 arch/sparc/include/asm/iommu_64.h |  1 +
 arch/sparc/include/asm/irq_64.h   |  1 +
 arch/sparc/kernel/iommu.c         | 44 +++++++++++++++++++++++++++
 arch/sparc/kernel/irq_64.c        | 50 ++++++++++++++++++++++++-------
 arch/sparc/kernel/pci_fire.c      | 31 +++++++++++++++++--
 arch/sparc/kernel/pci_impl.h      |  1 +
 arch/sparc/kernel/prom_irqtrans.c |  7 +++++
 8 files changed, 132 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 1263150a5702..96aa140815fe 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -387,6 +387,16 @@ endif
 endmenu
 
 menu "Bus options (PCI etc.)"
+
+config SPARC64_OBERON
+	bool "Fujitsu M3000 Oberon PCIe bridge"
+	depends on SPARC64_VII && PCI
+	help
+	  Support Oberon enumeration, translated DMA and legacy interrupts.
+	  Firmware link configuration is preserved. MSI and native bridge
+	  error interrupt handling are not supported on Oberon.
+	  Enable this option for the M3000 on-board network and disk devices.
+
 config SBUS
 	bool
 	default y
diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iommu_64.h
index 0ef6dedf747e..abd7bb0fa615 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -62,6 +62,7 @@ struct iommu {
 	unsigned long		iommu_tsbbase;
 	unsigned long		iommu_flush;
 	unsigned long		iommu_flushinv;
+	unsigned long		iommu_cache_flush; /* Oberon IOTSB cache */
 	unsigned long		iommu_tags;
 	unsigned long		iommu_ctxflush;
 	unsigned long		write_complete_reg;
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 8c4c0c87f998..c3e88f2f8e80 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -45,6 +45,7 @@ void irq_install_pre_handler(int irq,
 			     void *arg1, void *arg2);
 #define irq_canonicalize(irq)	(irq)
 unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap);
+unsigned int oberon_build_irq(int inofixup, unsigned long iclr, unsigned long imap);
 unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino);
 unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino);
 unsigned int sun4v_build_msi(u32 devhandle, unsigned int *irq_p,
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 7613ab0ffb89..9132f0535ce4 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -52,6 +52,8 @@ static void iommu_flushall(struct iommu_map_table *iommu_map_table)
 	struct iommu *iommu = container_of(iommu_map_table, struct iommu, tbl);
 	if (iommu->iommu_flushinv) {
 		iommu_write(iommu->iommu_flushinv, ~(u64)0);
+		if (iommu->iommu_cache_flush)
+			(void)iommu_read(iommu->write_complete_reg);
 	} else {
 		unsigned long tag;
 		int entry;
@@ -67,6 +69,30 @@ static void iommu_flushall(struct iommu_map_table *iommu_map_table)
 	}
 }
 
+/*
+ * Oberon's noncoherent IOTSB needs each changed 64-byte cache line flushed
+ * along with its DVMA translations. Call only for device-inactive mappings.
+ */
+static void iommu_sync_mapping(struct iommu *iommu, iopte_t *base,
+			       unsigned long npages)
+{
+	unsigned long slot, i;
+
+	if (!iommu->iommu_cache_flush || !npages)
+		return;
+	slot = base - iommu->page_table;
+	/* Publish IOPTE stores before invalidating the hardware caches. */
+	wmb();
+	for (i = 0; i < npages; i++, slot++) {
+		iommu_write(iommu->iommu_flush,
+			    iommu->tbl.table_map_base + (slot << IO_PAGE_SHIFT));
+		if ((slot & 7) == 7 || i == npages - 1)
+			iommu_write(iommu->iommu_cache_flush,
+				    __pa(iommu->page_table + slot));
+	}
+	(void)iommu_read(iommu->write_complete_reg);
+}
+
 #define IOPTE_CONSISTENT(CTX) \
 	(IOPTE_VALID | IOPTE_CACHE | \
 	 (((CTX) << 47) & IOPTE_CONTEXT))
@@ -240,6 +266,8 @@ static void *dma_4u_alloc_coherent(struct device *dev, size_t size,
 		first_page += IO_PAGE_SIZE;
 	}
 
+	iommu_sync_mapping(iommu, iopte - (size >> IO_PAGE_SHIFT),
+			   size >> IO_PAGE_SHIFT);
 	return ret;
 }
 
@@ -253,6 +281,15 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu = dev->archdata.iommu;
 
+	if (iommu->iommu_cache_flush) {
+		iopte_t *base = iommu->page_table +
+			((dvma - iommu->tbl.table_map_base) >> IO_PAGE_SHIFT);
+		unsigned long i;
+
+		for (i = 0; i < npages; i++)
+			iopte_make_dummy(iommu, base + i);
+		iommu_sync_mapping(iommu, base, npages);
+	}
 	iommu_tbl_range_free(&iommu->tbl, dvma, npages, IOMMU_ERROR_CODE);
 
 	order = get_order(size);
@@ -316,6 +353,7 @@ static dma_addr_t dma_4u_map_phys(struct device *dev, phys_addr_t phys,
 
 	for (i = 0; i < npages; i++, base++, phys += IO_PAGE_SIZE)
 		iopte_val(*base) = iopte_protection | phys;
+	iommu_sync_mapping(iommu, base - npages, npages);
 
 	return ret;
 
@@ -432,6 +470,7 @@ static void dma_4u_unmap_phys(struct device *dev, dma_addr_t bus_addr,
 	/* Step 2: Clear out TSB entries. */
 	for (i = 0; i < npages; i++)
 		iopte_make_dummy(iommu, base + i);
+	iommu_sync_mapping(iommu, base, npages);
 
 	iommu_free_ctx(iommu, ctx);
 	spin_unlock_irqrestore(&iommu->lock, flags);
@@ -523,6 +562,9 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			paddr += IO_PAGE_SIZE;
 		}
 
+		iommu_sync_mapping(iommu, iommu->page_table + entry,
+				   base - (iommu->page_table + entry));
+
 		/* If we are in an open segment, try merging */
 		if (segstart != s) {
 			/* We cannot merge if:
@@ -577,6 +619,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 
 			for (j = 0; j < npages; j++)
 				iopte_make_dummy(iommu, base + j);
+			iommu_sync_mapping(iommu, base, npages);
 
 			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
 					     IOMMU_ERROR_CODE);
@@ -653,6 +696,7 @@ static void dma_4u_unmap_sg(struct device *dev, struct scatterlist *sglist,
 
 		for (i = 0; i < npages; i++)
 			iopte_make_dummy(iommu, base + i);
+		iommu_sync_mapping(iommu, base, npages);
 
 		iommu_tbl_range_free(&iommu->tbl, dma_handle, npages,
 				     IOMMU_ERROR_CODE);
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3f55c69d5f3b..b0f3b26656d4 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -206,6 +206,7 @@ struct irq_handler_data {
 	struct ino_bucket bucket;
 	unsigned long	iclr;
 	unsigned long	imap;
+	bool		oberon;
 };
 
 static inline unsigned int irq_data_to_handle(struct irq_data *data)
@@ -364,6 +365,16 @@ static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
 	real_hard_smp_processor_id()
 #endif
 
+/* Oberon IMAP destination is a ten-bit interrupt target ID. */
+#define OBERON_IMAP_TID_SHIFT	21
+#define OBERON_IMAP_TID_MASK	(0x3ffUL << OBERON_IMAP_TID_SHIFT)
+
+static unsigned long oberon_imap_target(unsigned long val, unsigned int cpuid)
+{
+	return (val & ~OBERON_IMAP_TID_MASK) |
+		((cpuid << OBERON_IMAP_TID_SHIFT) & OBERON_IMAP_TID_MASK);
+}
+
 static void sun4u_irq_enable(struct irq_data *data)
 {
 	struct irq_handler_data *handler_data;
@@ -377,12 +388,16 @@ static void sun4u_irq_enable(struct irq_data *data)
 				       irq_data_get_affinity_mask(data));
 		imap = handler_data->imap;
 
-		tid = sun4u_compute_tid(imap, cpuid);
-
 		val = upa_readq(imap);
-		val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
-			 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
-		val |= tid | IMAP_VALID;
+		if (handler_data->oberon) {
+			val = oberon_imap_target(val, cpuid);
+		} else {
+			tid = sun4u_compute_tid(imap, cpuid);
+			val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
+				 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
+			val |= tid;
+		}
+		val |= IMAP_VALID;
 		upa_writeq(val, imap);
 		upa_writeq(ICLR_IDLE, handler_data->iclr);
 	}
@@ -401,12 +416,16 @@ static int sun4u_set_affinity(struct irq_data *data,
 		cpuid = irq_choose_cpu(data->irq, mask);
 		imap = handler_data->imap;
 
-		tid = sun4u_compute_tid(imap, cpuid);
-
 		val = upa_readq(imap);
-		val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
-			 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
-		val |= tid | IMAP_VALID;
+		if (handler_data->oberon) {
+			val = oberon_imap_target(val, cpuid);
+		} else {
+			tid = sun4u_compute_tid(imap, cpuid);
+			val &= ~(IMAP_TID_UPA | IMAP_TID_JBUS |
+				 IMAP_AID_SAFARI | IMAP_NID_SAFARI);
+			val |= tid;
+		}
+		val |= IMAP_VALID;
 		upa_writeq(val, imap);
 		upa_writeq(ICLR_IDLE, handler_data->iclr);
 	}
@@ -642,6 +661,17 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	return irq;
 }
 
+unsigned int oberon_build_irq(int inofixup, unsigned long iclr,
+			      unsigned long imap)
+{
+	unsigned int irq = build_irq(inofixup, iclr, imap);
+	struct irq_handler_data *data = irq_get_handler_data(irq);
+
+	if (data)
+		data->oberon = true;
+	return irq;
+}
+
 static unsigned int sun4v_build_common(u32 devhandle, unsigned int devino,
 		void (*handler_data_init)(struct irq_handler_data *data,
 		u32 devhandle, unsigned int devino),
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index c35a8e3c1eae..1921996298af 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -46,11 +46,21 @@ static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 	iommu->iommu_tsbbase  = pbm->pbm_regs + FIRE_IOMMU_TSBBASE;
 	iommu->iommu_flush    = pbm->pbm_regs + FIRE_IOMMU_FLUSH;
 	iommu->iommu_flushinv = pbm->pbm_regs + FIRE_IOMMU_FLUSHINV;
+	if (pbm->is_oberon) {
+		/*
+		 * 0x40100 flushes an IOTSB cache line by physical address;
+		 * 0x40010 flushes a translated DVMA page.
+		 */
+		iommu->iommu_flush = pbm->pbm_regs + 0x40010UL;
+		iommu->iommu_cache_flush = pbm->pbm_regs + 0x40100UL;
+		iommu->write_complete_reg = iommu->iommu_control;
+	}
 
 	/* We use the main control/status register of FIRE as the write
 	 * completion register.
 	 */
-	iommu->write_complete_reg = pbm->controller_regs + 0x410000UL;
+	if (!iommu->iommu_cache_flush)
+		iommu->write_complete_reg = pbm->controller_regs + 0x410000UL;
 
 	/*
 	 * Invalidate TLB Entries.
@@ -62,6 +72,8 @@ static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 	if (err)
 		return err;
 
+	/* Make initialized IOPTEs visible before publishing the table base. */
+	wmb();
 	upa_writeq(__pa(iommu->page_table) | 0x7UL, iommu->iommu_tsbbase);
 
 	control = upa_readq(iommu->iommu_control);
@@ -70,6 +82,10 @@ static int pci_fire_pbm_iommu_init(struct pci_pbm_info *pbm)
 		    0x00000002 /* Bypass enable */		|
 		    0x00000001 /* Translation enable */);
 	upa_writeq(control, iommu->iommu_control);
+	if (iommu->iommu_cache_flush) {
+		upa_writeq(~(u64)0, iommu->iommu_flushinv);
+		(void)upa_readq(iommu->iommu_control);
+	}
 
 	return 0;
 }
@@ -419,6 +435,7 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	int err;
 
 	pbm->numa_node = NUMA_NO_NODE;
+	pbm->is_oberon = of_device_is_compatible(dp, "pciex108e,80f8");
 
 	pbm->pci_ops = &sun4u_pci_ops;
 	pbm->config_space_reg_bits = 12;
@@ -439,13 +456,18 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 
 	pci_get_pbm_props(pbm);
 
-	pci_fire_hw_init(pbm);
+	if (pbm->is_oberon)
+		pr_info("%s: experimental Oberon; preserving firmware link setup\n",
+			pbm->name);
+	else
+		pci_fire_hw_init(pbm);
 
 	err = pci_fire_pbm_iommu_init(pbm);
 	if (err)
 		return err;
 
-	pci_fire_msi_init(pbm);
+	if (!pbm->is_oberon)
+		pci_fire_msi_init(pbm);
 
 	pbm->pci_bus = pci_scan_one_pbm(pbm, &op->dev);
 
@@ -505,6 +527,9 @@ static const struct of_device_id fire_match[] = {
 		.name = "pci",
 		.compatible = "pciex108e,80f0",
 	},
+#ifdef CONFIG_SPARC64_OBERON
+	{ .name = "pci", .compatible = "pciex108e,80f8" },
+#endif
 	{},
 };
 
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 83718876f1d4..92505fcc3cf3 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -117,6 +117,7 @@ struct pci_pbm_info {
 	/* State of 66MHz capabilities on this PBM. */
 	int				is_66mhz_capable;
 	int				all_devs_66mhz;
+	bool				is_oberon;
 
 #ifdef CONFIG_PCI_MSI
 	/* MSI info.  */
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 5752bfd73ac0..60fd6b0f47e1 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -481,6 +481,7 @@ static void __init pci_sun4v_irq_trans_init(struct device_node *dp)
 struct fire_irq_data {
 	unsigned long pbm_regs;
 	u32 portid;
+	bool oberon;
 };
 
 #define FIRE_IMAP_BASE	0x001000
@@ -537,6 +538,8 @@ static unsigned int fire_irq_build(struct device_node *dp,
 	 */
 	ino |= (irq_data->portid << 6);
 	ino -= int_ctrlr;
+	if (irq_data->oberon)
+		return oberon_build_irq(ino, iclr, imap);
 	return build_irq(ino, iclr, imap);
 }
 
@@ -553,6 +556,7 @@ static void __init fire_irq_trans_init(struct device_node *dp)
 	regs = of_get_property(dp, "reg", NULL);
 	dp->irq_trans->data = irq_data;
 
+	irq_data->oberon = of_device_is_compatible(dp, "pciex108e,80f8");
 	irq_data->pbm_regs = regs[0].phys_addr;
 	irq_data->portid = of_getintprop_default(dp, "portid", 0);
 }
@@ -778,6 +782,9 @@ static struct irq_trans __initdata pci_irq_trans_table[] = {
 	{ "pci108e,a801", tomatillo_irq_trans_init },
 	{ "SUNW,sun4v-pci", pci_sun4v_irq_trans_init },
 	{ "pciex108e,80f0", fire_irq_trans_init },
+#ifdef CONFIG_SPARC64_OBERON
+	{ "pciex108e,80f8", fire_irq_trans_init },
+#endif
 };
 #endif
 
-- 
2.43.0

