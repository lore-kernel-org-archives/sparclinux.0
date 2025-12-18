Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABD23BD1D
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080099; cv=none; b=WvrBJwgr0Q+DEV7fjG8PKjuGg+2eSL2qWPnjjqlq7o+R4gmvE8xgHqYUIgwjpM0lcPMYFQ3Cr/FzWeVp590/IMMHzwQ4RcOmSYO6sqp0vGZqYASyCf66t5wBQASRi9DZPLsidNJBSqsj4IGXctwFitHQ/zyU0oai9CNgppVFi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080099; c=relaxed/simple;
	bh=cxPI4s+0Lyq4HmxoFZgXSO2tt1jc8chQ1nkfDHsX+no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpuZNny1M5Wfiz/TDQiaV+Xlnvktsh6TcKUTHCrMv6LEZz607j7hhX/jkxuUtuDTt63XqMqBAbcYUSswZW+tv5pqtfkNq6cJ9vWcmwDdVM8VNFNcQWJIZojGWX2uXuz6E/7Won4YXo2sM0rUuSgx/dJf0FtURNePS1Or7Hfz+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgDBjfqM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgDBjfqM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso808041b3a.0
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080097; x=1766684897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5DOlf1Cpz2TADNVefb8b2aJKEHSeiEbRpZG5EwaNhQ=;
        b=OgDBjfqM6qZpAV22h4p7z8IFgb8CQLIcm+du8zKVK4/aIhw40eRJGWJ+iaXQUBtdlz
         V9Ec6db0kb+prMM1/Dk1kyW38ceRxUKteKoC9uNEF+P3wVmuKGeymZ2S0tLC/wZOPuV7
         BPPokhRHIDqNaZCnNp1WRDZcaHjMqbvzgIbUF9dZpJKwLiybWwINhoRGTJ2FHq+L52fs
         BNZXd9Y9md//nchpwFQ8MzecfUmQ7NcxnfwB9E28bZ/Y4t1opqIB7sXD0v/8OefBKLr4
         YG/GPpsotB9Hm7IP+vFemQqMCHY2nrdFpBRjnHOHjqve+xaYCcbXGi5GqxBYPSouMKE9
         SZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080097; x=1766684897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5DOlf1Cpz2TADNVefb8b2aJKEHSeiEbRpZG5EwaNhQ=;
        b=lq1Rke235yJswGBE8L6et/75xXOBvY6oDklpbqYuO9EoULFGymKbHuoF3O4J1YVeU9
         bXn+jsUXODqksvoLOZej28RKGXW0bknqg422JWH+zkT1jMe1sf8dSFiZ8oN3vwt6RfoK
         ReojVtKSiCXnyDq293fkcpTeZu5fV6gZ1iIvtuPooXPk/ChtMKr6/Us0fsMUVaHGlisZ
         EFcwRK5EdxkcpmF79sU8FH6xpHgIS1qGbihguw216mNw8nViIGsGTJ0vjOSt4ZbvXHEn
         tyMzncWqftw7gwD5laI/qjmzG1w+Uir+rHwgA0Xah4GMblTwQyqJ2SNRAdXmGdKRccwJ
         +VBg==
X-Forwarded-Encrypted: i=1; AJvYcCVxIm0QcMmKXJw2o7Kl+qDc8f3+W4KvHDAnxJBIHs74wpKr0ILs2PLW06fNJAlOhsffjaBnfp3cnGES@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RpOaMUYyUHaeNK48PwnARO/Ijf34ipW2k03fCDDQgLDRMKNK
	DfZUKKwrRt5bgmGeId0efSn52sc8jvoOXum4TgJ8s6MfoX5VNxJ22xBy
X-Gm-Gg: AY/fxX413YuMPcMCggXBtCrST8ppjarJAzeRt8xGEghjCsgvBAfLtlrlCI8A4l5nNRn
	YJ/6hvB7UMw1Htk5d29oqGSML4Muo7RLFnyx2mo7SiIRmr2+KpTdFq5AzuR+rKg9fhnwVHyjTjd
	DEZKB3rObeBbOW+sKvV6Gqrgw38saH+QTBa8slR1vK6ahfdVXS32a/ZtFMFKMiWz33ggFTCD6a0
	KyyXWkDz2aWYSz59zdoL5u8VtygmwDNZ33tol2rMSb3WbOu3kxRW3AndMeYyZneJyn0XtNQrEha
	CZhAl20zKtiw+6ZhjJXn/CD1WBIqU0SkgohE8J+9tpsHyDtWx36iLvQ7C1oKan21Y+WxoKiLul2
	Ma0rBUjbD2izW2oquY/2lrXWWg/gqNJZdFnI/Zp99KmpFCnf9w47KNjB4r/PTz1DlUa0v5ASPos
	J7rnPdpMuFLJNFu7oPySaSSNlxEAJAHmnDHoacHh0O48Q=
X-Google-Smtp-Source: AGHT+IFxudTDy6PHM/19N5nVub112fNrYCxZ70+830+nWbKCk8yxVcY0v9o4EOCLfhGvU4EKSePVLw==
X-Received: by 2002:a05:6a20:7d9b:b0:355:1add:c291 with SMTP id adf61e73a8af0-376a75f5bb2mr315421637.10.1766080096505;
        Thu, 18 Dec 2025 09:48:16 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2fffa3e7sm2847400a12.24.2025.12.18.09.48.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 09:48:16 -0800 (PST)
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
Subject: [PATCH v3 3/3] sparc: Remove unnecessary whitespace
Date: Fri, 19 Dec 2025 01:47:49 +0800
Message-ID: <20251218174749.45965-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251218174749.45965-1-pilgrimtao@gmail.com>
References: <20251218174749.45965-1-pilgrimtao@gmail.com>
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
index f477ab1b4f08..1c36448b95eb 100644
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

