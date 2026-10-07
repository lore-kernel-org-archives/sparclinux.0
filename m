Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440EF4279FE
	for <sparclinux@vger.kernel.org>; Wed,  7 Oct 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394916; cv=none; b=CauO0ynD12C4is2K2KY4j2UUdv6zwOJvbRMNKhXP4ofZHLftyy5sbDVbCSm/1KtoRmy8DOeaWmyubu1V7knqCZ+GQUr7FwSwIgQwI6/BjYEW3M1mX+z7bCjJCaBJgFiJAOw5wiRjNiqzERDzYj+CyLKJ9hNnDVFU3Z7YJrY3J3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394916; c=relaxed/simple;
	bh=e/JwH4H6AKKUhgmAstclEWbXtKxSKKI2YqvL2uxmdns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7wf6C3hk0Lpy7nnsine0shVBpEyY8w5L7L1XgaiZ5njHyoYS+XeBMiY4WY+Hn33X5ucNg8VuaV7wKm/XM1TfSVxstoFkg2UK5aSF57OqEDNMbGDWqaNZhfa6StChsn3Q7tFENQHKqMU66YSF+wkjFYbFUC7REmvTL+ikCA1mzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd9zjI03; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd9zjI03"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afa6bf3b45so3273681a12.3
        for <sparclinux@vger.kernel.org>; Wed, 07 Oct 2026 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394907; x=1791999707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQhGtzMgwy9AWrmX6AWN6p3vn8nB9a9DFQF2iiARHjs=;
        b=Zd9zjI033dX4fKJhHsjTq1x8qHcgFkPn0cbbKZWbzF+8eQyehuVlZgow/M0tdufK38
         CBxwN6LP14lV2mzreffFMGIzqZDbsjorMmIac2q78F4A7Nkr1/vpmljZn/FLDNBT/6my
         SSNBCMr7aIGdNlMv3KQgoKl/zXyxFiXAnjcMH/0wft3zHTGZIYr677iQDSSxnCqGseKX
         SeUv2LLfVHeWZC1kxhobq21UvTRDCDhQtNa8lQLftD2T4fEr1NoYDKJtayBtARoqmMfz
         ORNRMcIO/ip2PrP6SFa/RfrD1Bf4mAH32mJhev79/gRA5gGMb+/ULCYfhpwY3qRXLJGn
         c5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394907; x=1791999707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQhGtzMgwy9AWrmX6AWN6p3vn8nB9a9DFQF2iiARHjs=;
        b=2d3ibX+IOCLKuQSxAhOPlLO/N8X1Lo/80a2f1wZqHpupSvNhuKrctlHf6fARF0siIj
         agevcPtPSH+hi1beLLlavbP+a1n41jlL1VCNAJ7pyUrGAqFAdt6DPWuvXAA/oO/zjrYX
         Q3TMHdR6x7IgKmTKJ0JFMCg9Asifjc3xuIMmNlGaCKIx4Hdo3vYlHM+ppQUkTR9eurc6
         CCQXH17gcwjCei29mfwgUPbc5r/0Ad450uLiFeg4P4uA+CQG1W/EI7lnikGmusmHa3R5
         bEQrUYSfz4bF0HkEvJZtVeXMn4Hg13x/KfvxI8nZBw3ewa23+WmN532+/SNCWsT2up+y
         F0WQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvpGGJqU69OkQFxPmkLRB5gKaO/ktzjd5xhOF25xUhHpemFERVVuTrxJciak3jDTIKNxwFf9XI8ZNa@vger.kernel.org
X-Gm-Message-State: AFq9FYK3JXfbtdBiX3r55SvaeY4OTuSMxj71Rl10ldOQx3gSd2vI+c7c
	zcyrqPN/ZEl3OLC+m+Oi5rxQti8cmHB6S4tzJ6e9LwakYwIT5vYl/LvT
X-Gm-Gg: AYBFou3m4eQvopz//aZkF5hr8FvFHkVzobl2yk8TA+IQFwx3acafIbJKeSzu4jOtXmQ
	1+jncm0DSDFLbrIafq+Yf2C20wXJQRGtdWEVUfLGWuIiAKsJ/7SZe1Y3XRQQ0BUxGW/a5zbH7sQ
	dH6kkw6Sg23dutC19qPCYkiXJIhKqSBDy5HQfX6jqLjKWUOMzPO98TOratY6zngbjjtKzuMY1oo
	ugNiyeUtlYjIiZc8xfvbzkyAputql+9zNPKbpv/6l3QX7rysotoBJ64uvddn3lBk7Y84YtQ2GPl
	2y0VRz9X0OwWWMbK7QqhXWvN3im9BFDdIt1qmtzCBV88hkSAJigw+fP1Vdp+tyRTadjxI5Pg9zX
	VkazF74cG0ElZdfBR8BzifQ86HFsPiJ3VjmSicayJA6c1Mr+MF5KFf9OrSNuCFXvUFb+royYSdI
	Ajyu9+a91QdSPMKukZF5TZvsahGaYdlz0eLFPOMuxxMEql4SjN0HjMQGjdrV2/s4QuPbkyLurk8
	ZRQ5q9gwmZKxtG9YkdfI2k7+w0IKpktDnZLoL49
X-Received: by 2002:a05:6402:2b95:b0:6a9:93c7:ca57 with SMTP id 4fb4d7f45d1cf-6aff457d1a5mr3027431a12.22.1791394907223;
        Wed, 07 Oct 2026 10:41:47 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b009e80cd8sm356802a12.8.2026.10.07.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:41:46 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v5 5/6] sparc32: move early memory setup to setup_arch
Date: Wed,  7 Oct 2026 19:41:14 +0200
Message-ID: <20261007174128.959307-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007174128.959307-1-linmag7@gmail.com>
References: <20261007174128.959307-1-linmag7@gmail.com>
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
 arch/sparc/kernel/setup_32.c        | 117 +++++++++++++-----------
 arch/sparc/mm/init_32.c             | 132 +---------------------------
 arch/sparc/mm/leon_mm.c             |   1 +
 arch/sparc/mm/srmmu.c               |   8 +-
 8 files changed, 72 insertions(+), 195 deletions(-)

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
index 6d7d6fb5c49d..246533fba60d 100644
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
@@ -254,28 +255,76 @@ static __init void leon_patch(void)
 
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
 
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start = sp_banks[i].base_addr;
-		unsigned long end = start + sp_banks[i].num_bytes;
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
+		if (start_pfn >= limit) {
+			if (last_pfn < limit)
+				limit = last_pfn;
+			break;
+		}
 
-		if (end <= base)
-			continue;		/* wholly below - drop it */
-		if (start < base)
-			start = base;		/* straddles - trim the front */
+		last_pfn = end_pfn;
+	}
 
-		sp_banks[j].base_addr = start;
-		sp_banks[j].num_bytes = end - start;
-		j++;
+	return limit;
+}
+
+static void __init setup_memory(void)
+{
+	unsigned long ram_base = memblock_start_of_DRAM();
+	unsigned long size;
+
+	memblock_set_bottom_up(true);
+	memblock_allow_resize();
+
+	phys_base = ram_base;
+	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
+	if (sparc_cpu_model == sun4m || sparc_cpu_model == sun4d) {
+		unsigned long real_base = __get_phys(PAGE_OFFSET);
+
+		prom_printf("phys_base: RAM starts at 0x%lx, kernel is at 0x%lx\n",
+			    phys_base, real_base);
+
+		if (real_base && real_base != phys_base) {
+			phys_base = real_base;
+			memblock_remove(0, phys_base);
+			prom_printf("phys_base: adopted 0x%lx, RAM below it dropped\n",
+				    phys_base);
+		}
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
@@ -306,9 +355,6 @@ void __init sparc32_start_kernel(struct linux_romvec *rp)
 
 void __init setup_arch(char **cmdline_p)
 {
-	int i;
-	unsigned long highest_paddr;
-
 	sparc_ttable = &trapbase[0];
 
 	/* Initialize PROM console and command line. */
@@ -343,36 +389,7 @@ void __init setup_arch(char **cmdline_p)
 
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
-	if (sparc_cpu_model == sun4m || sparc_cpu_model == sun4d) {
-		unsigned long real_base = __get_phys(PAGE_OFFSET);
-
-		prom_printf("phys_base: RAM starts at 0x%lx, kernel is at 0x%lx\n",
-			    phys_base, real_base);
-
-		if (real_base && real_base != phys_base) {
-			phys_base = real_base;
-			trim_sp_banks_below(phys_base);
-			prom_printf("phys_base: adopted 0x%lx, RAM below it dropped\n",
-				    phys_base);
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

