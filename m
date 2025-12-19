Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298332E13B
	for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145533; cv=none; b=n2yJcjuhYIPQBSyKTyfjZ6mh/1DOpmt1Fc3djr/btVl2f8VDrRFFHw0QMxkXmrVW4E4NtaCJ+n+aGw+EiAEg4dg9MKnfNk+ytZSZ2Vth6n9+YUG8JS/EJk71KWDxH2axX4geNoSkiYaSBQGUBNBcosZJPjAUFTehmcoomnjyd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145533; c=relaxed/simple;
	bh=bFwxR5OTrg7lbxjFx7fCNd9yJcjjIHw349Z07jIDKK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdmMiFqggeyRTB70s+KGRq87drYkqASUt8klMOlrfo6/hZaBAQQEvA6od98VOk08bxJ6UWp4Hii4DV8XisNlFoVbF802Y+aKxOMxKoV+xkrdrGga7+VgaNWAnyf0AsP2Wt84KzJR5vKthmpV5ukjcJUVzQ2ViyD9hgWGhjhxQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzo2WCHL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzo2WCHL"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1671388b3a.3
        for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766145531; x=1766750331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsWpa24lxI6xHk1ZPBUYj2BnfB01U6tPDq237TH7seo=;
        b=Bzo2WCHL/yJkJGg/SEbTXc+Ec1QGr5IOuUoaaGPEU2Qts+Dmnf3oXbVR2c1p2YTYDC
         8PeNQjW9D1/th2n3Ym3FAA0c6QbVsAQkaE7qjeyF5p/TNKe2Yu8Dw9rdKv+5tOydOM1K
         3OjlO3VM0mURqlkcqXA5JhcE5vv2dPcEcQBHG6GZ3tTtKgweu8sax82hpYxkebSJJ6c6
         Ia9LwOHjX3VrpY8HV8tTZ1cE+7SKVVtqXF5n7ug6kCGVKceiYwoSks2+zfgh1t+KaZ+6
         1n9BCTIK9prvJdftBgSBd8ct9WrcSeDbulYxwRHPG08OsV40Zgh73VX5DHnKv4Vco39T
         a5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766145531; x=1766750331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsWpa24lxI6xHk1ZPBUYj2BnfB01U6tPDq237TH7seo=;
        b=vk2yj+adSJR4S45MUgg781+SkVutiMRufenzSaEQMatP0QyDJjXypWBAcwUah6/SC2
         i+n0TWGL6OR5qq/5YUa7tjFh/D+q3f8a5XcSUrvKAccjNo3u7hZ4O5IbpAsMhLQtHAbq
         8cFY5/3S1qSXGhNVOmurqv/pFKqz5l5yU4Rm6o1sp0PDXY+ILZrlZBOfdb/9Gn3cUOzi
         pWZu4txnJu7UKO1l4XHei7z08Ht9CfVHHAKkkBkA+9kC6x0D3R1QwovvcBUHw4y+L+Ou
         qT6ijP98OWQJguqTE0nL+1Y40ed7sfsk9dO3l/2BXLm6P4RPALx1T9HRHnZwT0ikxOg5
         SjIA==
X-Forwarded-Encrypted: i=1; AJvYcCWhzLbR44jWRY/1ZqWAHEvsgn8kqTfi0019fdPsqmsqXWbe3cHxrhB6uNQaviZnmiNoKfFG6Rh/ReJ2@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6DKPjU3R6CxV8Zu8ztsqTLLJBiMfCVTjW6xs9qIEdZ+fQoUk
	EV1HaESIobV4pmR3TKc0sE9G+X/Xe7FU+Vqj2sxNLqYWTYu1tNrQGyDq
X-Gm-Gg: AY/fxX6VpCbhMcwRenPcud9Vbf0BZhCEk4GkxRUXumMwX5yHnUABTj8AIyxelqPkpKj
	+b+hOz0IxMgH4AZj8Mfz6WYUisMNgbeskOBHwO+TLeyvPYv41izfIFZQu2xNhnx9VgXVZtye6S/
	RB59SpDzXM9lImhjU/rl2ji9rrAUtCg6zYwPlS/IbuN3yenCzfc5z9mB6v+JqOovJXMqtwW0ium
	Yqax2YSBiVYX1YJ8c5y89XRQUxn6uw5CtuIlT1YF7HtgxlheS+YvGvcy5BDzZXW+DYXZBs0RbP9
	7nSUxZL3yOrk/GpuulIthmu/zI9kxImOKIX0kqUfpS6kduL3f7tUFEg7LKiP6E87uYvtqD4wAWd
	ar/Vrv+YlbB2tFs7GN3RyQKBs28RXGy4GUqZ066Q8PqKWdWFMGtNTtXy1Ka65sFHidtgyFwxmIG
	AuafCoLM6SFJkPCWavJ838mPt9B57Fc7NfHEr7/jqLfcWnNfyR2gmv
X-Google-Smtp-Source: AGHT+IF11NXTxykBJC+oLwlMsW0lPOQ7p7i34Dr/aL0JQHuQ9W6RwWlf8VZxMOhy6Q0w9LFlCexwYQ==
X-Received: by 2002:a05:6a00:884:b0:7ff:8cde:f202 with SMTP id d2e1a72fcca58-7ff8cdef2e8mr2140403b3a.15.1766145531015;
        Fri, 19 Dec 2025 03:58:51 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm2258560b3a.21.2025.12.19.03.58.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 03:58:50 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Cc: kevin.brodsky@arm.com,
	dave.hansen@linux.intel.com,
	ziy@nvidia.com,
	chengkaitao@kylinos.cn,
	willy@infradead.org,
	zhengqi.arch@bytedance.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 3/3] sparc: Remove unnecessary whitespace
Date: Fri, 19 Dec 2025 19:58:12 +0800
Message-ID: <20251219115812.65855-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219115812.65855-1-pilgrimtao@gmail.com>
References: <20251219115812.65855-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

This is purely a code formatting change with no functional impact.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 arch/sparc/mm/fault_64.c   |  4 ++--
 arch/sparc/mm/hypersparc.S |  4 ++--
 arch/sparc/mm/init_64.c    |  6 +++---
 arch/sparc/mm/io-unit.c    | 12 ++++++------
 arch/sparc/mm/iommu.c      |  2 +-
 arch/sparc/mm/swift.S      |  2 +-
 arch/sparc/mm/ultra.S      |  4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index e326caf708c6..963b2c4c87e2 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -201,7 +201,7 @@ static void __kprobes do_kernel_fault(struct pt_regs *regs, int si_code,
 				      unsigned long address)
 {
 	unsigned char asi = ASI_P;
- 
+
 	if ((!insn) && (regs->tstate & TSTATE_PRIV))
 		goto cannot_handle;
 
@@ -229,7 +229,7 @@ static void __kprobes do_kernel_fault(struct pt_regs *regs, int si_code,
 			return;
 		}
 	}
-		
+
 	/* Is this in ex_table? */
 	if (regs->tstate & TSTATE_PRIV) {
 		const struct exception_table_entry *entry;
diff --git a/arch/sparc/mm/hypersparc.S b/arch/sparc/mm/hypersparc.S
index 6c2521e85a42..bac194982498 100644
--- a/arch/sparc/mm/hypersparc.S
+++ b/arch/sparc/mm/hypersparc.S
@@ -30,7 +30,7 @@ hypersparc_flush_cache_all:
 	ld	[%g4 + %lo(vac_cache_size)], %g5
 	sethi	%hi(vac_line_size), %g1
 	ld	[%g1 + %lo(vac_line_size)], %g2
-1:	
+1:
 	subcc	%g5, %g2, %g5			! hyper_flush_unconditional_combined
 	bne	1b
 	 sta	%g0, [%g5] ASI_M_FLUSH_CTX
@@ -325,7 +325,7 @@ hypersparc_flush_tlb_page_out:
 	 sta	%g5, [%g1] ASI_M_MMUREGS
 
 	__INIT
-	
+
 	/* High speed page clear/copy. */
 hypersparc_bzero_1page:
 /* NOTE: This routine has to be shorter than 40insns --jj */
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 858eaa6615ea..cf30040db2bf 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -5,7 +5,7 @@
  *  Copyright (C) 1996-1999 David S. Miller (davem@caip.rutgers.edu)
  *  Copyright (C) 1997-1999 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
- 
+
 #include <linux/extable.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -2397,11 +2397,11 @@ void __init paging_init(void)
 	 * work.
 	 */
 	init_mm.pgd += ((shift) / (sizeof(pgd_t)));
-	
+
 	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
 
 	inherit_prom_mappings();
-	
+
 	/* Ok, we can use our TLB miss and window trap handlers safely.  */
 	setup_tba();
 
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index d409cb450de4..15f83e6d21e2 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 1997,1998 Jakub Jelinek    (jj@sunsite.mff.cuni.cz)
  */
- 
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -62,7 +62,7 @@ static void __init iounit_iommu_init(struct platform_device *op)
 		prom_printf("SUN4D: Cannot map External Page Table.");
 		prom_halt();
 	}
-	
+
 	op->dev.archdata.iommu = iounit;
 	iounit->page_table = xpt;
 	spin_lock_init(&iounit->lock);
@@ -109,9 +109,9 @@ static dma_addr_t iounit_get_area(struct iounit_struct *iounit,
 	case 2: i = 0x0132; break;
 	default: i = 0x0213; break;
 	}
-	
+
 	IOD(("%s(%pa,%d[%d])=", __func__, &phys, size, npages));
-	
+
 next:	j = (i & 15);
 	rotor = iounit->rotor[j - 1];
 	limit = iounit->limit[j];
@@ -150,7 +150,7 @@ static dma_addr_t iounit_map_phys(struct device *dev, phys_addr_t phys,
 	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long flags;
 	dma_addr_t ret;
-	
+
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
@@ -185,7 +185,7 @@ static void iounit_unmap_phys(struct device *dev, dma_addr_t vaddr, size_t len,
 {
 	struct iounit_struct *iounit = dev->archdata.iommu;
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&iounit->lock, flags);
 	len = ((vaddr & ~PAGE_MASK) + len + (PAGE_SIZE-1)) >> PAGE_SHIFT;
 	vaddr = (vaddr - IOUNIT_DMA_BASE) >> PAGE_SHIFT;
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index f48adf62724a..f43163a9a812 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -89,7 +89,7 @@ static void __init sbus_iommu_init(struct platform_device *op)
 	iommu->end = 0xffffffff;
 
 	/* Allocate IOMMU page table */
-	/* Stupid alignment constraints give me a headache. 
+	/* Stupid alignment constraints give me a headache.
 	   We need 256K or 512K or 1M or 2M area aligned to
            its size and current gfp will fortunately give
            it to us. */
diff --git a/arch/sparc/mm/swift.S b/arch/sparc/mm/swift.S
index f414bfd8d899..cfcc48b6c5c7 100644
--- a/arch/sparc/mm/swift.S
+++ b/arch/sparc/mm/swift.S
@@ -243,7 +243,7 @@ swift_flush_tlb_page:
 	 nop
 #if 1
 	mov	0x400, %o1
-	sta	%g0, [%o1] ASI_M_FLUSH_PROBE	
+	sta	%g0, [%o1] ASI_M_FLUSH_PROBE
 #else
 	lda	[%g1] ASI_M_MMUREGS, %g5
 	sta	%o3, [%g1] ASI_M_MMUREGS
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 70e658d107e0..66cbfbb1d3cd 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -284,7 +284,7 @@ __cheetah_flush_tlb_page:	/* 22 insns */
 	be,pn		%icc, 1f
 	 andn		%o1, 1, %o3
 	stxa		%g0, [%o3] ASI_IMMU_DEMAP
-1:	stxa		%g0, [%o3] ASI_DMMU_DEMAP	
+1:	stxa		%g0, [%o3] ASI_DMMU_DEMAP
 	membar		#Sync
 	stxa		%g2, [%o4] ASI_DMMU
 	sethi		%hi(KERNBASE), %o4
@@ -312,7 +312,7 @@ __cheetah_flush_tlb_pending:	/* 27 insns */
 	be,pn		%icc, 2f
 	 andn		%o3, 1, %o3
 	stxa		%g0, [%o3] ASI_IMMU_DEMAP
-2:	stxa		%g0, [%o3] ASI_DMMU_DEMAP	
+2:	stxa		%g0, [%o3] ASI_DMMU_DEMAP
 	membar		#Sync
 	brnz,pt		%o1, 1b
 	 nop
-- 
2.50.1 (Apple Git-155)

