Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C69442B3B
	for <sparclinux@vger.kernel.org>; Mon, 17 Aug 2026 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980769; cv=none; b=cE49c+Ocasi3hM91WyGmrB3UsTpTsz8gbLsM67W71Yfuvi7tF4zR+bYl9AF5ekAC8VP1Lgziw/ilIIqujI/7dNhvXnxXxQWXZJYnS2MEPu6Lwk9c+0X59XV7s+dTPrnnoDQu6lau17OAwHX7MrQmayF/X5/4QsCFEgzADbsu6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980769; c=relaxed/simple;
	bh=//ruPAMAed3vEzOulP+2qtZjw7/QZvGwaESJPVpEiik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VACrpbzjhkwavN2jhgsqbo6b4E28l2FO/Y4pt02C4vRvYxyN2LOOSL1wjd0Kc9tLaYn4SdxedfPDXpwWo5yJSGRO+HLkTwXc/S+PW1yVdkukNKaVktIYnZPIUdhCQe16s22MAf8Fgxn1RzEA5kjmLtScvFgP7egenI4zCSyokek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=OhGLdduP; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=x0qOcTlS; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="OhGLdduP";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="x0qOcTlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786980760; x=1787585560;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=aazLE0bu0DGUdb10q0LFvZUWYbh9eq3jpXVW+luwO7E=;
	b=OhGLdduPYjWqpiR9HLCHSqqIf0apCuQvOqChV6WlP9M3LR0flLmt9Qury+GPekhOXRCGQUY1a3gKW
	 IUa6zo4/PuvyJtJBDKSJ07IqdV6+qymj8MH2NfqxImQv6bJ6SmRZPw6Ys7CA13BZotI77kN9vNGMHs
	 AdNZQy+D24GtZ+0x2Wyl4tbhWEetfI/L9hQcG+z7n1HifxoIj6lH2hQezGsDAzdwafZabxh4BZYrx9
	 ihy3Hl9orh5seHFDQEfcwwHfQ8ji2NJDy9lsXetcrNHCHz2nvLMWR67W+CI9c98NxvOBKDfh5NITto
	 r16Y4q0170arW+loQwGb/pPQKr9DZGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786980760; x=1787585560;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=aazLE0bu0DGUdb10q0LFvZUWYbh9eq3jpXVW+luwO7E=;
	b=x0qOcTlSEX4oHTOEeOSFXZDuKuNZMd6cwYSUP1zbToVU32o59mmZ0gePP4ZuIsSaIr5veuOopdp+q
	 2ViKWMADg==
X-HalOne-ID: dfedf6f3-9a50-11f1-aa4a-55bb5426428c
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:bc8d:955b:a5f8:4c36])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id dfedf6f3-9a50-11f1-aa4a-55bb5426428c;
	Mon, 17 Aug 2026 15:32:38 +0000 (UTC)
Date: Mon, 17 Aug 2026 17:32:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sparc32: derive phys_base from the PAGE_OFFSET
 mapping
Message-ID: <20260817153237.GA702187@ravnborg.org>
References: <20260816075141.3489194-1-linmag7@gmail.com>
 <20260816075141.3489194-3-linmag7@gmail.com>
 <20260816195456.GA660273@ravnborg.org>
 <CA+=Fv5SfLQo+LMoEH2gtmuuw814hjcjfnd551E7Og4t=JsFWug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JT2ezVoPwppFeaz"
Content-Disposition: inline
In-Reply-To: <CA+=Fv5SfLQo+LMoEH2gtmuuw814hjcjfnd551E7Og4t=JsFWug@mail.gmail.com>


--7JT2ezVoPwppFeaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Magnus.

> Moving sparc32 off sp_banks and onto memblock sounds like the right
> direction, setup_arch() already had the array to hand, which is the only
> reason this patch reaches for it. I'd be glad to pick up your old patches
> and take them for a spin, just point me at where I can find them.

The patches are likely online somewhere, but I found the relevant ones
that I have attached here.

These are from the middle of my sun4m/sun4d removal patches, expect
parts to be missed out and for sure they do not apply in your tree.

I recall they were tested one-by-one via QEMU, but I did not test on
real HW.

Feel free to claim full authorship on patches where you do anything
than trivial edits.

I hope you will have fun working on this.

	Sam

--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-sparc32-Use-memblock-when-mapping-the-kernel.patch"

From 6fdce3fcdc4f504b27366c56c53df337631d31b1 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 09:06:19 +0100
Subject: [PATCH 1/8] sparc32: Use memblock when mapping the kernel

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/mm/srmmu.c | 48 ++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index fc2012eb7606..d22b5f09ba20 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -695,39 +695,35 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 	*__nocache_fix(pgdp) = __pgd(big_pte);
 }
 
-/* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
-static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
-{
-	unsigned long pstart = (sp_banks[sp_entry].base_addr & PGDIR_MASK);
-	unsigned long vstart = (vbase & PGDIR_MASK);
-	unsigned long vend = PGDIR_ALIGN(vbase + sp_banks[sp_entry].num_bytes);
-	/* Map "low" memory only */
-	const unsigned long min_vaddr = PAGE_OFFSET;
-	const unsigned long max_vaddr = PAGE_OFFSET + SRMMU_MAXMEM;
-
-	if (vstart < min_vaddr || vstart >= max_vaddr)
-		return vstart;
-
-	if (vend > max_vaddr || vend < min_vaddr)
-		vend = max_vaddr;
-
-	while (vstart < vend) {
-		do_large_mapping(vstart, pstart);
-		vstart += PGDIR_SIZE; pstart += PGDIR_SIZE;
-	}
-	return vstart;
-}
-
 static void __init map_kernel(void)
 {
-	int i;
+	phys_addr_t start, end;
+	u64 i;
 
 	if (phys_base > 0) {
 		do_large_mapping(PAGE_OFFSET, phys_base);
 	}
 
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		map_spbank((unsigned long)__va(sp_banks[i].base_addr), i);
+	for_each_mem_range(i, &start, &end) {
+		unsigned long vbase = (unsigned long)__va(start);
+		unsigned long pstart = start & PGDIR_MASK;
+		unsigned long vstart = vbase & PGDIR_MASK;
+		unsigned long vend = PGDIR_ALIGN(vbase + (end - start + 1));
+
+		/* Map "low" memory only */
+		const unsigned long min_vaddr = PAGE_OFFSET;
+		const unsigned long max_vaddr = PAGE_OFFSET + SRMMU_MAXMEM;
+
+		if (vstart < min_vaddr || vstart >= max_vaddr)
+			continue;
+		if (vend > max_vaddr || vend < min_vaddr)
+			vend = max_vaddr;
+
+		while (vstart < vend) {
+			do_large_mapping(vstart, pstart);
+			vstart += PGDIR_SIZE;
+			pstart += PGDIR_SIZE;
+		}
 	}
 }
 
-- 
2.53.0


--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-sparc32-Use-memblock-to-find-the-available-system-me.patch"

From fbd887c2f0b372e1a8326e0dec24c2208de9ecdf Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 09:12:49 +0100
Subject: [PATCH 2/8] sparc32: Use memblock to find the available system memory

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/mm/srmmu.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d22b5f09ba20..67a4f1f74dc3 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -186,25 +186,13 @@ void srmmu_free_nocache(void *addr, int size)
 static void srmmu_early_allocate_ptable_skeleton(unsigned long start,
 						 unsigned long end);
 
-/* Return how much physical memory we have.  */
-static unsigned long __init probe_memory(void)
-{
-	unsigned long total = 0;
-	int i;
-
-	for (i = 0; sp_banks[i].num_bytes; i++)
-		total += sp_banks[i].num_bytes;
-
-	return total;
-}
-
 /*
  * Reserve nocache dynamically proportionally to the amount of
  * system RAM. -- Tomas Szepe <szepe@pinerecords.com>, June 2002
  */
 static void __init srmmu_nocache_calcsize(void)
 {
-	unsigned long sysmemavail = probe_memory() / 1024;
+	unsigned long sysmemavail = memblock_phys_mem_size() / 1024;
 	int srmmu_nocache_npages;
 
 	srmmu_nocache_npages =
-- 
2.53.0


--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-sparc32-Move-bootmem_init-to-setup_memory.patch"

From 33f6bfc6be9152c529adb9d7ce18e6db2c57c3dd Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 13:19:42 +0100
Subject: [PATCH 3/8] sparc32: Move bootmem_init to setup_memory

Move it away from srmmu, so we can have more of the memory handling in
one place.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/pgtable_32.h | 2 +-
 arch/sparc/kernel/setup_32.c        | 2 ++
 arch/sparc/mm/init_32.c             | 5 +----
 arch/sparc/mm/srmmu.c               | 4 ----
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 40cdca44ea63..d353fdfa1c61 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -38,7 +38,7 @@ struct page;
 
 void load_mmu(void);
 unsigned long calc_highpages(void);
-unsigned long __init bootmem_init(unsigned long *pages_avail);
+void __init bootmem_init(void);
 
 #define pte_ERROR(e)   __builtin_trap()
 #define pmd_ERROR(e)   __builtin_trap()
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 0ec597b2a567..75c36f734dfb 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -209,6 +209,8 @@ static void __init setup_memory(void)
 	/* Lowest address available */
 	phys_base = memblock_start_of_DRAM();
 	pfn_base = min_low_pfn;
+
+	bootmem_init();
 }
 
 void __init setup_arch(char **cmdline_p)
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index bd42fb1611e7..ebaa2ba2f318 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -118,7 +118,7 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
 #endif
 }
 
-unsigned long __init bootmem_init(unsigned long *pages_avail)
+void __init bootmem_init(void)
 {
 	unsigned long start_pfn, bytes_avail, size;
 	unsigned long end_of_phys_memory = 0;
@@ -178,12 +178,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	memblock_add(phys_base, size);
 
 	size = memblock_phys_mem_size() - memblock_reserved_size();
-	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
 
 	/* Only allow low memory to be allocated via memblock allocation */
 	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
-
-	return max_pfn;
 }
 
 /*
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 67a4f1f74dc3..dfe5bae5aee9 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -727,7 +727,6 @@ void __init srmmu_paging_init(void)
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long pages_avail;
 
 	init_mm.context = (unsigned long) NO_CONTEXT;
 	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
@@ -749,9 +748,6 @@ void __init srmmu_paging_init(void)
 		prom_halt();
 	}
 
-	pages_avail = 0;
-	bootmem_init(&pages_avail);
-
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
 	srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM - PAGE_SIZE));
-- 
2.53.0


--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-sparc32-Drop-printing-HIGHMEM-available.patch"

From d60b1c299e23d7f77b14ed3a36b0b1db2f89d409 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 13:26:49 +0100
Subject: [PATCH 4/8] sparc32: Drop printing HIGHMEM available

The kernel will tell us, there is no need to print it twice.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/pgtable_32.h |  1 -
 arch/sparc/mm/init_32.c             | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index d353fdfa1c61..533f842ef5fe 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -37,7 +37,6 @@ struct vm_area_struct;
 struct page;
 
 void load_mmu(void);
-unsigned long calc_highpages(void);
 void __init bootmem_init(void);
 
 #define pte_ERROR(e)   __builtin_trap()
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index ebaa2ba2f318..b5dd819dc314 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -45,27 +45,6 @@ extern unsigned int sparc_ramdisk_size;
 
 unsigned long highstart_pfn, highend_pfn;
 
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
 static unsigned long calc_max_low_pfn(void)
 {
 	int i;
@@ -122,7 +101,6 @@ void __init bootmem_init(void)
 {
 	unsigned long start_pfn, bytes_avail, size;
 	unsigned long end_of_phys_memory = 0;
-	unsigned long high_pages = 0;
 	int i;
 
 	bytes_avail = 0UL;
@@ -165,9 +143,6 @@ void __init bootmem_init(void)
 	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
 		highstart_pfn = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
 		max_low_pfn = calc_max_low_pfn();
-		high_pages = calc_highpages();
-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-		    high_pages >> (20 - PAGE_SHIFT));
 	}
 
 	find_ramdisk(end_of_phys_memory);
-- 
2.53.0


--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0005-sparc32-Use-memblock-when-freeing-highmem-pages.patch"

From a982b119e333c09a99d82cc3b6e9b5cec25c218e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 13:56:43 +0100
Subject: [PATCH 5/8] sparc32: Use memblock when freeing highmem pages

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/mm/init_32.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index b5dd819dc314..a55d34c94d12 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -171,21 +171,10 @@ void __init paging_init(void)
 	device_scan();
 }
 
-static void map_high_region(unsigned long start_pfn, unsigned long end_pfn)
-{
-	unsigned long tmp;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	printk("mapping high region %08lx - %08lx\n", start_pfn, end_pfn);
-#endif
-
-	for (tmp = start_pfn; tmp < end_pfn; tmp++)
-		free_highmem_page(pfn_to_page(tmp));
-}
-
 void __init mem_init(void)
 {
-	int i;
+	phys_addr_t range_start, range_end;
+	u64 i;
 
 	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
 		prom_printf("BUG: fixmap and pkmap areas overlap\n");
@@ -202,20 +191,25 @@ void __init mem_init(void)
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	max_mapnr = max_pfn - pfn_base;
+
 	high_memory = __va(max_low_pfn << PAGE_SHIFT);
 	memblock_free_all();
 
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
-		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+				&range_start, &range_end, NULL) {
+		unsigned long start = PFN_UP(range_start);
+		unsigned long end = PFN_DOWN(range_end);
 
-		if (end_pfn <= highstart_pfn)
+		/* Ignore complete lowmem entries */
+		if (end <= max_low_pfn)
 			continue;
 
-		if (start_pfn < highstart_pfn)
-			start_pfn = highstart_pfn;
+		/* Truncate partial highmem entries */
+		if (start < max_low_pfn)
+			start = max_low_pfn;
 
-		map_high_region(start_pfn, end_pfn);
+		for (; start < end; start++)
+			free_highmem_page(pfn_to_page(start));
 	}
 }
 
-- 
2.53.0


--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0006-sparc32-Drop-mem-support.patch"

From 7fe5051929add5ef30982c174434e7d7cff52a2e Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 19:05:24 +0100
Subject: [PATCH 6/8] sparc32: Drop mem= support

If there is a need to limit the memory available the feature
can be added later using early_param support etc.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/setup.h |  3 ---
 arch/sparc/kernel/setup_32.c   | 18 ------------------
 arch/sparc/mm/init_32.c        | 32 +++-----------------------------
 3 files changed, 3 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 72205684e51e..e6f7eb383b1f 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -37,9 +37,6 @@ extern unsigned long pdma_areasize;
 
 int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler);
 
-/* setup_32.c */
-extern unsigned long cmdline_memory_size;
-
 /* devices.c */
 void __init device_scan(void);
 
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 75c36f734dfb..c8b3e19472af 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -88,9 +88,6 @@ static void prom_sync_me(void)
 static unsigned int boot_flags __initdata = 0;
 #define BOOTME_DEBUG  0x1
 
-/* Exported for mm/init.c:paging_init. */
-unsigned long cmdline_memory_size __initdata = 0;
-
 /* which CPU booted us (0xff = not set) */
 unsigned char boot_cpu_id = 0xff; /* 0xff will make it into DATA section... */
 
@@ -148,21 +145,6 @@ static void __init boot_flags_init(char *commands)
 				process_switch(*commands++);
 			continue;
 		}
-		if (!strncmp(commands, "mem=", 4)) {
-			/*
-			 * "mem=XXX[kKmM] overrides the PROM-reported
-			 * memory size.
-			 */
-			cmdline_memory_size = simple_strtoul(commands + 4,
-						     &commands, 0);
-			if (*commands == 'K' || *commands == 'k') {
-				cmdline_memory_size <<= 10;
-				commands++;
-			} else if (*commands=='M' || *commands=='m') {
-				cmdline_memory_size <<= 20;
-				commands++;
-			}
-		}
 		while (*commands && *commands != ' ')
 			commands++;
 	}
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index a55d34c94d12..cd16e9ae81b6 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -99,33 +99,7 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
 
 void __init bootmem_init(void)
 {
-	unsigned long start_pfn, bytes_avail, size;
-	unsigned long end_of_phys_memory = 0;
-	int i;
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
-					sp_banks[i+1].num_bytes = 0;
-					sp_banks[i+1].base_addr = 0xdeadbeef;
-				}
-				break;
-			}
-		}
-	}
+	unsigned long start_pfn, size;
 
 	/* Start with page aligned address of last symbol in kernel
 	 * image.
@@ -135,7 +109,7 @@ void __init bootmem_init(void)
 	/* Now shift down to get the real physical page frame number. */
 	start_pfn >>= PAGE_SHIFT;
 
-	max_pfn = end_of_phys_memory >> PAGE_SHIFT;
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 
 	max_low_pfn = max_pfn;
 	highstart_pfn = highend_pfn = max_pfn;
@@ -145,7 +119,7 @@ void __init bootmem_init(void)
 		max_low_pfn = calc_max_low_pfn();
 	}
 
-	find_ramdisk(end_of_phys_memory);
+	find_ramdisk(memblock_end_of_DRAM());
 
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
-- 
2.53.0


--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0007-sparc32-Move-memory-config-to-setup_32.patch"

From 3afe806edfda93fcdf137e55b2653c74c5e54b66 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 19:27:15 +0100
Subject: [PATCH 7/8] sparc32: Move memory config to setup_32

Move all early memory configuration to setup_memory.
Replace sp_banks use with memblock.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/pgtable_32.h |  2 +-
 arch/sparc/kernel/setup_32.c        | 44 ++++++++++++++++++++-
 arch/sparc/mm/init_32.c             | 61 +----------------------------
 3 files changed, 45 insertions(+), 62 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 533f842ef5fe..ac92e4801d10 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -37,7 +37,7 @@ struct vm_area_struct;
 struct page;
 
 void load_mmu(void);
-void __init bootmem_init(void);
+void __init find_ramdisk(unsigned long end_of_phys_memory);
 
 #define pte_ERROR(e)   __builtin_trap()
 #define pmd_ERROR(e)   __builtin_trap()
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c8b3e19472af..79dcd564a919 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -172,14 +172,41 @@ void __init sparc32_start_kernel(struct linux_romvec *rp)
 	start_kernel();
 }
 
+static unsigned long calc_max_low_pfn(void)
+{
+	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
+	unsigned long last_pfn = 0;
+	unsigned long curr_pfn;
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end) {
+		curr_pfn = PFN_DOWN(start);
+
+		if (curr_pfn >= tmp) {
+			if (last_pfn < tmp)
+				tmp = last_pfn;
+			break;
+		}
+
+		last_pfn = PFN_DOWN(start + end + 1);
+	}
+
+	return tmp;
+}
+
 unsigned long phys_base;
 EXPORT_SYMBOL(phys_base);
 
 unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
 
+unsigned long highend_pfn;
+
 static void __init setup_memory(void)
 {
+	unsigned long size;
+
 	memblock_set_bottom_up(true);
 	memblock_allow_resize();
 
@@ -187,12 +214,27 @@ static void __init setup_memory(void)
 
 	/* Setup memblock globals */
 	min_low_pfn = PFN_DOWN(memblock_start_of_DRAM());
+	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_low_pfn = max_pfn;
 
 	/* Lowest address available */
 	phys_base = memblock_start_of_DRAM();
 	pfn_base = min_low_pfn;
 
-	bootmem_init();
+	highend_pfn = max_pfn;
+
+	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT))
+		max_low_pfn = calc_max_low_pfn();
+
+	find_ramdisk(memblock_end_of_DRAM());
+
+	/* Reserve the kernel text/data/bss. */
+	size = __pa(PAGE_ALIGN((unsigned long) &_end)) - phys_base;
+	memblock_reserve(phys_base, size);
+	memblock_add(phys_base, size);
+
+	/* Only allow low memory to be allocated via memblock allocation */
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
 }
 
 void __init setup_arch(char **cmdline_p)
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index cd16e9ae81b6..74174d20e566 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -43,31 +43,7 @@ struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
 
-unsigned long highstart_pfn, highend_pfn;
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
@@ -97,41 +73,6 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
 #endif
 }
 
-void __init bootmem_init(void)
-{
-	unsigned long start_pfn, size;
-
-	/* Start with page aligned address of last symbol in kernel
-	 * image.
-	 */
-	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
-
-	/* Now shift down to get the real physical page frame number. */
-	start_pfn >>= PAGE_SHIFT;
-
-	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
-
-	max_low_pfn = max_pfn;
-	highstart_pfn = highend_pfn = max_pfn;
-
-	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
-		highstart_pfn = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
-		max_low_pfn = calc_max_low_pfn();
-	}
-
-	find_ramdisk(memblock_end_of_DRAM());
-
-	/* Reserve the kernel text/data/bss. */
-	size = (start_pfn << PAGE_SHIFT) - phys_base;
-	memblock_reserve(phys_base, size);
-	memblock_add(phys_base, size);
-
-	size = memblock_phys_mem_size() - memblock_reserved_size();
-
-	/* Only allow low memory to be allocated via memblock allocation */
-	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
-}
-
 /*
  * paging_init() sets up the page tables: We call the MMU specific
  * init routine based upon the Sun model type on the Sparc.
-- 
2.53.0


--7JT2ezVoPwppFeaz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0008-sparc32-Drop-sp_banks.patch"

From 8befec09894be332e50de7d14a846e50083f5667 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 31 Dec 2023 19:34:43 +0100
Subject: [PATCH 8/8] sparc32: Drop sp_banks

memblock is now used all over as replacement for sp_banks.
Delete the remaining left-overs of sp_banks.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/page_32.h | 16 -----------
 arch/sparc/mm/init_32.c          |  2 --
 arch/sparc/prom/memory.c         | 47 ++++----------------------------
 3 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 9977c77374cd..557c0240d7e6 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -28,22 +28,6 @@
 		sparc_flush_page_to_ram(page);	\
 	} while (0)
 
-/* The following structure is used to hold the physical
- * memory configuration of the machine.  This is filled in
- * prom_meminit() and is later used by mem_init() to set up
- * mem_map[].  We statically allocate SPARC_PHYS_BANKS+1 of
- * these structs, this is arbitrary.  The entry after the
- * last valid one has num_bytes==0.
- */
-struct sparc_phys_banks {
-  unsigned long base_addr;
-  unsigned long num_bytes;
-};
-
-#define SPARC_PHYS_BANKS 32
-
-extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
-
 /* passing structs on the Sparc slow us down tremendously... */
 
 /* #define STRICT_MM_TYPECHECKS */
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 74174d20e566..8c9f17731aee 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -37,8 +37,6 @@
 
 #include "mm_32.h"
 
-struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
-
 /* Initial ramdisk setup */
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 68cbad8f7ebf..d3e07e161ebc 100644
--- a/arch/sparc/prom/memory.c
+++ b/arch/sparc/prom/memory.c
@@ -15,23 +15,15 @@
 #include <asm/oplib.h>
 #include <asm/page.h>
 
-static int __init prom_meminit_v0(void)
+static void __init prom_meminit_v0(void)
 {
 	struct linux_mlist_v0 *p;
-	int index;
 
-	index = 0;
-	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more) {
-		sp_banks[index].base_addr = (unsigned long) p->start_adr;
-		sp_banks[index].num_bytes = p->num_bytes;
-		index++;
+	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more)
 		memblock_add(p->start_adr, p->num_bytes);
-	}
-
-	return index;
 }
 
-static int __init prom_meminit_v2(void)
+static void __init prom_meminit_v2(void)
 {
 	struct linux_prom_registers reg[64];
 	phandle node;
@@ -41,51 +33,24 @@ static int __init prom_meminit_v2(void)
 	size = prom_getproperty(node, "available", (char *) reg, sizeof(reg));
 	num_ents = size / sizeof(struct linux_prom_registers);
 
-	for (i = 0; i < num_ents; i++) {
-		sp_banks[i].base_addr = reg[i].phys_addr;
-		sp_banks[i].num_bytes = reg[i].reg_size;
+	for (i = 0; i < num_ents; i++)
 		memblock_add(reg[i].phys_addr, reg[i].reg_size);
-	}
-
-	return num_ents;
-}
-
-static int sp_banks_cmp(const void *a, const void *b)
-{
-	const struct sparc_phys_banks *x = a, *y = b;
-
-	if (x->base_addr > y->base_addr)
-		return 1;
-	if (x->base_addr < y->base_addr)
-		return -1;
-	return 0;
 }
 
 /* Initialize the memory lists based upon the prom version. */
 void __init prom_meminit(void)
 {
-	int i, num_ents = 0;
-
 	switch (prom_vers) {
 	case PROM_V0:
-		num_ents = prom_meminit_v0();
+		prom_meminit_v0();
 		break;
 
 	case PROM_V2:
 	case PROM_V3:
-		num_ents = prom_meminit_v2();
+		prom_meminit_v2();
 		break;
 
 	default:
 		break;
 	}
-	sort(sp_banks, num_ents, sizeof(struct sparc_phys_banks),
-	     sp_banks_cmp, NULL);
-
-	/* Sentinel.  */
-	sp_banks[num_ents].base_addr = 0xdeadbeef;
-	sp_banks[num_ents].num_bytes = 0;
-
-	for (i = 0; i < num_ents; i++)
-		sp_banks[i].num_bytes &= PAGE_MASK;
 }
-- 
2.53.0


--7JT2ezVoPwppFeaz--
