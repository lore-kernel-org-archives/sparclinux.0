Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FC4C954E
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855306; cv=none; b=FzaiQeBQyceOe3Eq0564whv9Y+uMd4DxRQtuaLKi6nsjaFJ8DSt5trhAuWU1TP5vEDrSGnv9pHRoTgj7uZpTH/X8wuFUvQQcvRlvuJz1RPfyjUizRG/3opCALJcfxEv77aN1Exib2yzWDZpScupsjczz6aL4szM7PV+s1bhnnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855306; c=relaxed/simple;
	bh=iEsRjwEUSqrwp9vZdLEJmW3AeOu26mivGzWCQnlVGgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4rhRs9w+2c9YNMLKLsUMHNH5vAjuFUQHwN6pWZSp4xHBwS+Lf9aJG0bvbGzbsS2jpxgtEG81li4225xW/Jxy9l/NfNPkb3K/5kbFpLeryOz5CkWWWrwCm6LA0EcxF9mcf4pMR3FbVk8IW1fONwz5zyFfVUdUKYgCFyifTTg7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUbCpCKN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUbCpCKN"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c26d7e951so31821666b.0
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855302; x=1788460102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kO9uBWpdFWzsJy0Q2RhUJUXZIAG66L2n/WEZUITN610=;
        b=GUbCpCKNWBY+1m+BpW43/rJMS6UOeGCeOYLfElVJqAg9ECwpQCu0huQ0NNsAZZRf6C
         BY+2emVn22aSpWqxOclinA1LqYO5K1ZOpJ1zdYq45d7q6AHgoYr2PNrPP5viTxrwxoR+
         nTZ5JOf/SqiwgFJhTYqDAsjvc6svH+7HVIB4+7psQgi9A6YOHsCnSzqNj/suk99MNFlJ
         bAnAdq1QYnzjz6M4zcEz4J0WUly3kZwG1TlxIo97mqwHAUb30nKG9fCYB9oe8GbVwaCq
         sEbFXBItO+zcwRrIEZS/IrCpB4hyyrB5jO81Cb9jniNrIV1K1YRXyc1ZiMD+W/DAZaO2
         Zb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855302; x=1788460102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kO9uBWpdFWzsJy0Q2RhUJUXZIAG66L2n/WEZUITN610=;
        b=CgV89E/eQmAzmldn+7Lsiq8U0xr/cPp0s6wZgjkAUShld7sZLQ4AEAQM27w/0uN2Yp
         P39NtcbRDZZycLGEVVZIrwAcve7TipRg1z44zyymiItYLUGhROdthmj61jGEZvNB5AFk
         Emc/pjnVN8zOgHG2OKgi1rFsQryl4N/l2txmVn/FEyxGK8N09oo4O1IiQsRXBS7JN5V0
         AKjUKRekLXe3FQU0UE+ljHVKhbaU0UoRTTnCbqGH5g+l5jHvurhVDhG/igf48m+Z8+3T
         AF9KbQf0/CelPxwue2EaYl7DLhSNUKpHU+dgDvGGs3awi9lzYBEu7DHCHrdiJh7bzkZ8
         9ATA==
X-Gm-Message-State: AFuF++luOGnZAdEUmPl8jcQ0JhSUjtK4QJkzxyD5LgSkDE0QUaDSdl/Z
	+7n+lLw9epg4lUVT1YCQKSpClZ0r4WqzjtyuzIQUmXYvrvMmswfDaRp90+Zr8wfg
X-Gm-Gg: AR+sD11l2VnTDEhNNHlNeufWqMxzOWrFvnp6zcg4b1kfABOqSzNMscai6qDxXU+unTI
	OXI1yrFnoiek0fINgxIhnwUoLalPSc4d2ST827ZXmzI19Qlf8GsTFIxjM9dl//n1oahELcV00fo
	B76xsHGH2Qf6b94/9FzgJZBosPrxiuEWIXq2iep/Mikb/ir75eHJDqZ2eVgiVtSvZDY1O9j5KJ5
	UcErGU+J6i/INEyn6Rici2ZhuhoUrchOmvxlScWUojTOnRGr6ZZ6wVLwz3/svSfDktCDNG2dYZr
	eWUe/taRDBtpSfO/LHE99XsnsK/yFaGMkBCxcOiLHlydmobnHUf2EJRlIpSI/JtWmk93f8P7uUk
	CNZhOIllntXXmtg0lF6ZhqBsDltloQuNSke9+2W/aIP4mpKacszJYKSDKDf2v4B8PRpdYGKBvgA
	znhmKv5WC8cs6cooZkbWe2L6sIorkMYwOD1t7M1NYo9mr9eGzilK8N/uhp1hgCCRJ8geB+ykiiD
	/IWCjWcesHUKWnLweP/iSdhhmL/yGA=
X-Received: by 2002:a17:906:6a18:b0:c25:2fb9:b88d with SMTP id a640c23a62f3a-c2556c46bf3mr51193166b.8.1787855302284;
        Thu, 27 Aug 2026 11:28:22 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c254e4e736dsm61288266b.11.2026.08.27.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:28:21 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 4/5] sparc32: move early memory setup to setup_arch
Date: Thu, 27 Aug 2026 20:24:16 +0200
Message-ID: <20260827182757.6856-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827182757.6856-1-linmag7@gmail.com>
References: <20260827182757.6856-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the early memory configuration out of SRMMU paging setup and next to
the rest of setup_arch(). Derive the PFN limits from memblock, reserve the
kernel and initrd there, and retain mem= support with
memblock_enforce_memory_limit().

When PAGE_OFFSET maps a relocated kernel, remove memory below phys_base
from memblock because it cannot be reached through the linear map. This
replaces the equivalent trimming of sp_banks.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/pgtable_32.h |   3 +-
 arch/sparc/kernel/setup_32.c        | 118 +++++++++++++----------
 arch/sparc/mm/init_32.c             | 140 +---------------------------
 arch/sparc/mm/srmmu.c               |   4 -
 4 files changed, 73 insertions(+), 192 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index f89b1250661d..91a6032cf6a2 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -37,8 +37,7 @@ struct vm_area_struct;
 struct page;
 
 void load_mmu(void);
-unsigned long calc_highpages(void);
-unsigned long __init bootmem_init(unsigned long *pages_avail);
+void __init find_ramdisk(unsigned long end_of_phys_memory);
 
 #define pte_ERROR(e)   __builtin_trap()
 #define pmd_ERROR(e)   __builtin_trap()
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 795714959da6..e5f1c3ee36df 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -23,6 +23,7 @@
 #include <linux/syscalls.h>
 #include <linux/kdev_t.h>
 #include <linux/major.h>
+#include <linux/memblock.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -254,28 +255,77 @@ static __init void leon_patch(void)
 
 struct tt_entry *sparc_ttable;
 
-/* Drop RAM below the kernel; the linear map runs upward from phys_base
- * and cannot reach it.
- */
-static void __init trim_sp_banks_below(unsigned long base)
+unsigned long phys_base;
+EXPORT_SYMBOL(phys_base);
+
+unsigned long pfn_base;
+EXPORT_SYMBOL(pfn_base);
+
+unsigned long highend_pfn;
+
+static unsigned long __init calc_max_low_pfn(void)
 {
-	int i, j = 0;
+	unsigned long limit = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
+	unsigned long last_pfn = 0;
+	phys_addr_t start, end;
+	u64 i;
 
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start = sp_banks[i].base_addr;
-		unsigned long end = start + sp_banks[i].num_bytes;
+	for_each_mem_range(i, &start, &end) {
+		unsigned long start_pfn = PFN_DOWN(start);
 
-		if (end <= base)
-			continue;		/* wholly below - drop it */
-		if (start < base)
-			start = base;		/* straddles - trim the front */
+		if (start_pfn >= limit) {
+			if (last_pfn < limit)
+				limit = last_pfn;
+			break;
+		}
 
-		sp_banks[j].base_addr = start;
-		sp_banks[j].num_bytes = end - start;
-		j++;
+		last_pfn = PFN_DOWN(end);
 	}
-	sp_banks[j].base_addr = 0;
-	sp_banks[j].num_bytes = 0;
+
+	return limit;
+}
+
+static void __init setup_memory(void)
+{
+	unsigned long ram_base = memblock_start_of_DRAM();
+	unsigned long real_base = __get_phys(PAGE_OFFSET);
+	unsigned long size;
+
+	memblock_set_bottom_up(true);
+	memblock_allow_resize();
+
+	phys_base = ram_base;
+	if (real_base && real_base != phys_base) {
+		prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
+			    (unsigned int)phys_base, (unsigned int)real_base);
+		phys_base = real_base;
+		memblock_remove(0, phys_base);
+		prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
+			    (unsigned int)phys_base);
+	}
+
+	if (cmdline_memory_size)
+		memblock_enforce_memory_limit(cmdline_memory_size);
+
+	min_low_pfn = PFN_DOWN(memblock_start_of_DRAM());
+	pfn_base = phys_base >> PAGE_SHIFT;
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	last_valid_pfn = max_pfn;
+	max_low_pfn = max_pfn;
+	highend_pfn = max_pfn;
+
+	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT))
+		max_low_pfn = calc_max_low_pfn();
+
+	find_ramdisk(memblock_end_of_DRAM());
+
+	/* Reserve the kernel text/data/bss. */
+	size = __pa(PAGE_ALIGN((unsigned long)&_end)) - phys_base;
+	memblock_reserve(phys_base, size);
+	memblock_add(phys_base, size);
+
+	/* Only allow low memory to be allocated by memblock. */
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 }
 
 /* Called from head_32.S - before we have setup anything
@@ -306,9 +356,6 @@ void __init sparc32_start_kernel(struct linux_romvec *rp)
 
 void __init setup_arch(char **cmdline_p)
 {
-	int i;
-	unsigned long highest_paddr;
-
 	sparc_ttable = &trapbase[0];
 
 	/* Initialize PROM console and command line. */
@@ -343,36 +390,7 @@ void __init setup_arch(char **cmdline_p)
 
 	idprom_init();
 	load_mmu();
-
-	phys_base = 0xffffffffUL;
-	highest_paddr = 0UL;
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long top;
-
-		if (sp_banks[i].base_addr < phys_base)
-			phys_base = sp_banks[i].base_addr;
-		top = sp_banks[i].base_addr +
-			sp_banks[i].num_bytes;
-		if (highest_paddr < top)
-			highest_paddr = top;
-	}
-
-	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
-	{
-		unsigned long real_base = __get_phys(PAGE_OFFSET);
-
-		if (real_base && real_base != phys_base) {
-			prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
-				    (unsigned int)phys_base,
-				    (unsigned int)real_base);
-			phys_base = real_base;
-			trim_sp_banks_below(phys_base);
-			prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
-				    (unsigned int)phys_base);
-		}
-	}
-
-	pfn_base = phys_base >> PAGE_SHIFT;
+	setup_memory();
 
 	if (!root_flags)
 		root_mountflags &= ~MS_RDONLY;
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 75050dfbc2ea..62c41d896421 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -39,66 +39,15 @@
 
 static unsigned long *sparc_valid_addr_bitmap;
 
-unsigned long phys_base;
-EXPORT_SYMBOL(phys_base);
-
-unsigned long pfn_base;
-EXPORT_SYMBOL(pfn_base);
-
 struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 
 /* Initial ramdisk setup */
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
 
-unsigned long highstart_pfn, highend_pfn;
-
 unsigned long last_valid_pfn;
 
-unsigned long calc_highpages(void)
-{
-	int i;
-	int nr = 0;
-
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
-
-		if (end_pfn <= max_low_pfn)
-			continue;
-
-		if (start_pfn < max_low_pfn)
-			start_pfn = max_low_pfn;
-
-		nr += end_pfn - start_pfn;
-	}
-
-	return nr;
-}
-
-static unsigned long calc_max_low_pfn(void)
-{
-	int i;
-	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
-	unsigned long curr_pfn, last_pfn;
-
-	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
-	for (i = 1; sp_banks[i].num_bytes != 0; i++) {
-		curr_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-
-		if (curr_pfn >= tmp) {
-			if (last_pfn < tmp)
-				tmp = last_pfn;
-			break;
-		}
-
-		last_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
-	}
-
-	return tmp;
-}
-
-static void __init find_ramdisk(unsigned long end_of_phys_memory)
+void __init find_ramdisk(unsigned long end_of_phys_memory)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	unsigned long size;
@@ -128,83 +77,6 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
 #endif
 }
 
-unsigned long __init bootmem_init(unsigned long *pages_avail)
-{
-	unsigned long start_pfn, bytes_avail, size;
-	unsigned long end_of_phys_memory = 0;
-	unsigned long high_pages = 0;
-	int i;
-
-	memblock_set_bottom_up(true);
-	memblock_allow_resize();
-
-	bytes_avail = 0UL;
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		end_of_phys_memory = sp_banks[i].base_addr +
-			sp_banks[i].num_bytes;
-		bytes_avail += sp_banks[i].num_bytes;
-		if (cmdline_memory_size) {
-			if (bytes_avail > cmdline_memory_size) {
-				unsigned long slack = bytes_avail - cmdline_memory_size;
-
-				bytes_avail -= slack;
-				end_of_phys_memory -= slack;
-
-				sp_banks[i].num_bytes -= slack;
-				if (sp_banks[i].num_bytes == 0) {
-					sp_banks[i].base_addr = 0xdeadbeef;
-				} else {
-					memblock_add(sp_banks[i].base_addr,
-						     sp_banks[i].num_bytes);
-					sp_banks[i+1].num_bytes = 0;
-					sp_banks[i+1].base_addr = 0xdeadbeef;
-				}
-				break;
-			}
-		}
-		memblock_add(sp_banks[i].base_addr, sp_banks[i].num_bytes);
-	}
-
-	if (cmdline_memory_size)
-		memblock_enforce_memory_limit(cmdline_memory_size);
-
-	/* Start with page aligned address of last symbol in kernel
-	 * image.
-	 */
-	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
-
-	/* Now shift down to get the real physical page frame number. */
-	start_pfn >>= PAGE_SHIFT;
-
-	max_pfn = end_of_phys_memory >> PAGE_SHIFT;
-
-	max_low_pfn = max_pfn;
-	highstart_pfn = highend_pfn = max_pfn;
-
-	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
-		highstart_pfn = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
-		max_low_pfn = calc_max_low_pfn();
-		high_pages = calc_highpages();
-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-		    high_pages >> (20 - PAGE_SHIFT));
-	}
-
-	find_ramdisk(end_of_phys_memory);
-
-	/* Reserve the kernel text/data/bss. */
-	size = (start_pfn << PAGE_SHIFT) - phys_base;
-	memblock_reserve(phys_base, size);
-	memblock_add(phys_base, size);
-
-	size = memblock_phys_mem_size() - memblock_reserved_size();
-	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
-
-	/* Only allow low memory to be allocated via memblock allocation */
-	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
-
-	return max_pfn;
-}
-
 /*
  * paging_init() sets up the page tables: We call the MMU specific
  * init routine based upon the Sun model type on the Sparc.
@@ -220,14 +92,10 @@ void __init paging_init(void)
 
 static void __init taint_real_pages(void)
 {
-	int i;
-
-	for (i = 0; sp_banks[i].num_bytes; i++) {
-		unsigned long start, end;
-
-		start = sp_banks[i].base_addr;
-		end = start + sp_banks[i].num_bytes;
+	phys_addr_t start, end;
+	u64 i;
 
+	for_each_mem_range(i, &start, &end) {
 		while (start < end) {
 			set_bit(start >> 20, sparc_valid_addr_bitmap);
 			start += PAGE_SIZE;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 3029527a5a9f..272e430f8bd8 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -884,7 +884,6 @@ void __init srmmu_paging_init(void)
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long pages_avail;
 
 	init_mm.context = (unsigned long) NO_CONTEXT;
 	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
@@ -910,9 +909,6 @@ void __init srmmu_paging_init(void)
 		prom_halt();
 	}
 
-	pages_avail = 0;
-	last_valid_pfn = bootmem_init(&pages_avail);
-
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
 	srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM - PAGE_SIZE));
-- 
2.43.0

