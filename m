Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD33C5857
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790545436; cv=none; b=XgDUkeY/S1eYYpTA/PmPHqjhOEXzW+U3sY0MT7lm2Q4tLgFbS8JZggyWSjN5LC6CZbMkFa10QGI5LLMpNVZ/Bbck50JE+k8J9+qyV4wT2JBh827SJom6LmLi7HLImAbfi1VgOOgdT/7jOTT/fN9UEvOWr6BwOvhjn23AYON0LnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790545436; c=relaxed/simple;
	bh=rHuHrAyuEjJSqJIqC9zJ6YYEatMKk6rnjWU97Dixo6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mt9xTR2vT5DA2CAqiZmNMH8HOfdBqbQW2uGczxWlD1D7D7wIGuNYlyrlo6KIDDPFcsN6tKb+TjxO2wMHzmYrrlbqf5bjc8XwrlBxZJYvDXoyzsnS/oAZMb0yavn5c3b15MAplxH9HVR9kJkCKAQnvwuAj8hgZ8ZmjAlVwoXpQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5mFbKqQ; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5mFbKqQ"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbdcb4f59so157274266b.0
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790545430; x=1791150230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kQM3L5ONL8A+jCWhcUzOr2lF9Mv/EAI1temkvSPaPEg=;
        b=c5mFbKqQllXyQlaWWCN3Um9w1MigeQQLbbCC0Isp5NIHHqQGlG4YFfTP5BXxwzPXvM
         8+cdyxC9hn83Sj/IiNYzcZHyRPq1YifBVT0+F4R1NtWMWYblW/WjqsJ3YUfIx86aFjkL
         B5v2QcKoEWXwSFB7Ck0ggjLuxfZGUwlSv+Fm7OTwounnNWh+NYEGG8nAJu/vFbi+u0Pl
         5gakUqEV0n7hYzgAV/oQ7NU8FiBOr4fbPAOkSNCfcM05xRmwA77W8cJE67Si8poUo8Bl
         6JSkE3+T32gvvsJi23rwScyxdIBLSVAUqSJY3q+mfZBZWcifr/BkUOekjz6BLvlNaCEY
         KexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790545430; x=1791150230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kQM3L5ONL8A+jCWhcUzOr2lF9Mv/EAI1temkvSPaPEg=;
        b=mMbuuaH7cY/k+Gc+IX3I5SjBv7f2j7b8ukxeQfbBTOULGNYscB44yy5iJMQrMhkzkN
         CdwHEJ74B/Dk43bYjeQwPdxuKyZGHn2q9Q0J5aiZBN3bpjm5AE9zQM3WLgGsS1A0iaRw
         f7FTc468AZkOOfpuPoBm/7IXGhjV+mvHDTByuY5Y7YXh+bb9pwRWjMZLmJo4QkMF3ZS7
         5iFvP2HHloINzv5Si2ojJ2qvzBBClhSGeXYGPx1C/ndrBDxoxhaFfQV/fILv8OPa9y7i
         ifzkwHIqxwyIKjf/55MNHkIv4w3Vtb6neOkqFwXINRSZIbnTW6wSZdgZFCLQlfPuUNQV
         VV/A==
X-Forwarded-Encrypted: i=1; AKwUvByTL6P30S2h4P5I9sneKFtCVCL+Rmga4eJm3XLBSeNAkoQrR0+wb9W1QnZb3MQb88mlvpmN70N44oGV@vger.kernel.org
X-Gm-Message-State: AFq9FYLLvLMUzVBB+ecY5/15m0Fys93zhsjPm9rNnCSojDV7Fw4SPpPG
	YTqQwFzK0Xu63yNEblE5AICKwUdjmP3EVhnsJmGkRAocMtMPSb3RFvQE
X-Gm-Gg: AYBFou1QFz8RTjtDWEST6H+uz89oxU8DDuERaYVgJEqoj6qJEA/Nw/QTZP+tXdZ7kJD
	RCzNX24qaaeUJDvS8fnOBtJeyOoMM4tnF0rWxaM24vCbpo5N5LnLGfz96Co3BKOJC9SRsQ7kOcv
	I/WfiT3dQudgkKjSu943Lr8Chh7AeC0oDy1+B57Nbo+XS0GFPNe9n/mEtb4gijWx++dXvZEg4Mh
	M3+NB3ulHReIrXc/sbBQUBHS6jsi8+wKSNZBc0zHGF6W4jDEqp5iybl0BxEeRDnYXKAE04hvHql
	XCDZVon0lnTja4Nk+9K/ZPzsRYLCj4QUrW+25B0yNd+cJ9m4CykCQQv1f+qu/J5Lj+ueBOvON5x
	erkj2v/ZXtZe4hk1oa/VxYH4nFW+/zioEBF7J6gxNhW7DaOXJKzqKcNdPDe/Bln+CtPhGjY/R+t
	5jmIH5PQzh7pgETZ/8pN8uqv8GvjGMhEZVgwVU5BTkWu13EokTQKE70n70il3yw4nV48qJIIQel
	Ws+BoxA/HfxxG82ws4yKsPfXe0WbKHNj6cEOrOn
X-Received: by 2002:a17:907:608a:b0:c29:51c2:ba69 with SMTP id a640c23a62f3a-c2ac23e5379mr933300566b.22.1790545430268;
        Sun, 27 Sep 2026 14:43:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm376091866b.33.2026.09.27.14.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:43:49 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v4 5/6] sparc32: move early memory setup to setup_arch
Date: Sun, 27 Sep 2026 23:43:16 +0200
Message-ID: <20260927214334.886582-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927214334.886582-1-linmag7@gmail.com>
References: <20260927214334.886582-1-linmag7@gmail.com>
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

Use for_each_mem_pfn_range() to find the lowmem boundary and set the
standard max_pfn variable to the end of physical memory. Use max_pfn as
the highmem zone limit and replace last_valid_pfn with max_pfn in LEON's
_pfn_valid() check, preserving its existing bounds, including highmem.

The removed bootmem code also printed a private HIGHMEM summary. Generic
memory initialization already reports the highmem zone, so do not retain
the duplicate message.

When PAGE_OFFSET maps a relocated kernel, remove memory below phys_base
from memblock because it cannot be reached through the linear map. This
replaces the equivalent trimming of sp_banks.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/highmem.h    |   3 -
 arch/sparc/include/asm/leon.h       |   2 +-
 arch/sparc/include/asm/pgtable_32.h |   3 +-
 arch/sparc/include/asm/pgtsrmmu.h   |   1 -
 arch/sparc/kernel/setup_32.c        | 112 ++++++++++++-----------
 arch/sparc/mm/init_32.c             | 132 +---------------------------
 arch/sparc/mm/leon_mm.c             |   1 +
 arch/sparc/mm/srmmu.c               |   8 +-
 8 files changed, 67 insertions(+), 195 deletions(-)

diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index c7b2e208328b..b1b915ac604d 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -26,9 +26,6 @@
 #include <asm/vaddrs.h>
 #include <asm/pgtsrmmu.h>
 
-/* declarations for highmem.c */
-extern unsigned long highstart_pfn, highend_pfn;
-
 #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
 extern pte_t *pkmap_page_table;
 
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 053a24b67aed..2a1bdc2c2f1d 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -251,7 +251,7 @@ extern int leon_ipi_irq;
 
 /* macros used in leon_mm.c */
 #define PFN(x)           ((x) >> PAGE_SHIFT)
-#define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
+#define _pfn_valid(pfn)	 ((pfn < max_pfn) && (pfn >= PFN(phys_base)))
 #define _SRMMU_PTE_PMASK_LEON 0xffffffff
 
 /*
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
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index a265822a475e..a2a6c8564c3e 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -98,7 +98,6 @@
 	 restore %g0, %g0, %g0;
 
 #ifndef __ASSEMBLER__
-extern unsigned long last_valid_pfn;
 
 /* This makes sense. Honest it does - Anton */
 /* XXX Yes but it's ugly as sin.  FIXME. -KMW */
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 795714959da6..6ad85538964d 100644
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
@@ -254,28 +255,71 @@ static __init void leon_patch(void)
 
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
+static unsigned long __init calc_max_low_pfn(void)
 {
-	int i, j = 0;
+	unsigned long limit = pfn_base + PHYS_PFN(SRMMU_MAXMEM);
+	unsigned long start_pfn, end_pfn;
+	unsigned long last_pfn = 0;
+	int i;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
+		if (start_pfn >= limit) {
+			if (last_pfn < limit)
+				limit = last_pfn;
+			break;
+		}
 
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start = sp_banks[i].base_addr;
-		unsigned long end = start + sp_banks[i].num_bytes;
+		last_pfn = end_pfn;
+	}
 
-		if (end <= base)
-			continue;		/* wholly below - drop it */
-		if (start < base)
-			start = base;		/* straddles - trim the front */
+	return limit;
+}
 
-		sp_banks[j].base_addr = start;
-		sp_banks[j].num_bytes = end - start;
-		j++;
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
 	}
-	sp_banks[j].base_addr = 0;
-	sp_banks[j].num_bytes = 0;
+
+	if (cmdline_memory_size)
+		memblock_enforce_memory_limit(cmdline_memory_size);
+
+	min_low_pfn = PFN_DOWN(memblock_start_of_DRAM());
+	pfn_base = PHYS_PFN(phys_base);
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_low_pfn = max_pfn;
+
+	if (max_low_pfn > pfn_base + PHYS_PFN(SRMMU_MAXMEM))
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
@@ -306,9 +350,6 @@ void __init sparc32_start_kernel(struct linux_romvec *rp)
 
 void __init setup_arch(char **cmdline_p)
 {
-	int i;
-	unsigned long highest_paddr;
-
 	sparc_ttable = &trapbase[0];
 
 	/* Initialize PROM console and command line. */
@@ -343,36 +384,7 @@ void __init setup_arch(char **cmdline_p)
 
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
index 6880d9cb30a5..ac4462f1cf76 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -35,66 +35,13 @@
 
 #include "mm_32.h"
 
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
-unsigned long last_valid_pfn;
-
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
@@ -124,83 +71,6 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
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
diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index 1dc9b3d70eda..a43c5ffbbbe5 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <asm/asi.h>
 #include <asm/leon.h>
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 7b57a10c961f..444295c20b94 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -59,8 +59,6 @@ int vac_line_size;
 
 extern struct resource sparc_iomap;
 
-extern unsigned long last_valid_pfn;
-
 static pgd_t *srmmu_swapper_pg_dir;
 
 const struct sparc32_cachetlb_ops *sparc32_cachetlb_ops;
@@ -842,7 +840,7 @@ void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
 {
 	max_zone_pfns[ZONE_DMA] = max_low_pfn;
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
-	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
+	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
 }
 
 void __init srmmu_paging_init(void)
@@ -855,7 +853,6 @@ void __init srmmu_paging_init(void)
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long pages_avail;
 
 	init_mm.context = (unsigned long) NO_CONTEXT;
 	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
@@ -881,9 +878,6 @@ void __init srmmu_paging_init(void)
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

