Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53A4C754C
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331391; cv=none; b=DJxtW24phVLmXHnS2/ihwTcl8xCYYYPsHrfWsq0ds9GuS2K9bkJrnEWJfaF/8GmdeSeVR24wVdRCqRj4+paDSof3gr6eJFn8lCQxX5/hM1ux36DRE5NmJQ2jfjU1M87CQ7F8Y4oolewFB0X87wrCwoT9q4EZ5ljLR+8MfKy1gFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331391; c=relaxed/simple;
	bh=pIR79lR70xH763W4XqZAYDRYzJqNG5LhPHyHhK2hVtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaySm/mS7rqwR1YzqG17GOGIYnLVBQd7LBSjAvfnfy2UurX/FcM9ri/0c0i74mVwa6XoSppRL+l2Ck7d7lrRt3PdwiSb+/V/fq27WGzNlpKbwJ6PlL+i1VtVPqmifuot3Sa3k0FMflLXL20s9KIMVZeUyP9Mcnwlg255rzXyMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th1E/43t; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th1E/43t"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40e9aff12fso16434466b.3
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331385; x=1792936185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gcni1JNfshj4AvP+erjOn+eiQ35v29HbKMTwTNfpa3I=;
        b=Th1E/43t0nKjinSNiVJI3OzaKv7TTSCLoF/4rlm3c+OBtyK5sQnwRR1BDxZ9JD48LZ
         SOCpCVUCZDTw0l46pl8VEDIxohGTCD23BLpN1ok2d+5XbtovJWUTJuf5cWOuj3xVP2dM
         D/hqq0xEqzNxKp8F0q/XXtg+/GYq920D9IRUsbqMddr/Ln75mZ4WqaD/k/Eh0ugIrTej
         DN0Oy1T5J1zXjhuYUikxnlffQjsNdenv6Rviz0ZSNDvWFLCkecZqDzttR5ibwSR7syTq
         alL0Hwm6Lt2tGLYUvSBWxGsJRhXOuR+5ndR5/5VuscWFg43mHv+uw7kEnwax09QBw06l
         IsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331385; x=1792936185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gcni1JNfshj4AvP+erjOn+eiQ35v29HbKMTwTNfpa3I=;
        b=LzCy5D5UFfJZCggkHryxjfFrnyaMuBKYmFqDEbG0zm1uespEZn4tlgkyrlrEtZSOdt
         RS49HvnvOQ9xFWHqov2PJWa3kh04auSJOf7WyUb0+fDvJ7bgtA2dg/XTomdG4WwB053K
         td1Ii/CW0MLzwTga15jeZHvhQOuoq6Rip+BR+B/Un5GiHwXOK+VzW4tg0ciT4H60x+WB
         C4aH0bdIf56Y/cNDXTzpdBeusLHjDjMn3OcYG6OMNUK3P98fqDt/qpvQ/7PUnR0BFUHk
         ZNNID6lYjegibsl7v3ByE9Zw137abDiCn7zJZYwHG0B5Orio8MfkxQJPvkFJFQLO31uU
         MX4g==
X-Forwarded-Encrypted: i=1; AKwUvBysd05mZFodjQywXoz0ttQa0b0lqZxHTkJjSo0Mq5yF8r+bvDD+sWA3BNsHn5Pyn1c2iaxfcK3YeHkk@vger.kernel.org
X-Gm-Message-State: AFq9FYJyXM1A88FOJxQ5uYx1WbudrjCJCBvlD+oWzKHxknaCylg4t0Nt
	8XsK4Z2DNkLvKkrEPxEcKLkMiAeRl8XzoB8k8QAN01rSu58mwy+x5Q/t
X-Gm-Gg: AYBFou0E6T0WgNV/wuEYIMkyKlekGjW220dOrwbWhxNLtplzAbGeXzjzKp7+hDOuPpb
	bsqIn/yrs033oKVfNFLeEQxRpdskxPd2d2lvqF9j8pLsHkBGdk4YG5ePEayd9C0CQMwHOABfYdC
	wlwqgPK1WixKzUWh/lquP2K830JaFM4kKhKWjw+shraHSE+s9hHSykeRBNRMuZwjPo0Qgxtud6y
	vrDjM2Tk0c5YVbP5Dt3JpCK0uLlA7F38m7RNaS+PNVp+rAMLbyl01E5kbGVEZ7MfTDEy5oKr/CI
	vPFsIC+XbcNGpnwAyVR5Mkz7TR79auEzVe+6qJYjvwhdmzI6lFpl689Jz4+OSV+tQRCHOZG1S/P
	iLOGZfG3Riuwu+MMHtCUJaefVDM/XxBOlasyQbL15CltLrtUOpNcIDvdiBiKpScQAk0eSeMoRrT
	Gz5yTHTkbx6tCvj3yivYd6AIn8weJwfKaKcAMwwrgWLHif1GK/bJaDk1pSSaCsh02VKcie+TpW0
	hZNBEklSQisPNLfCJJwezcYST30vXV0paqPnsVy
X-Received: by 2002:a17:907:7f86:b0:c40:b59:f with SMTP id a640c23a62f3a-c41a05eb7eamr371737466b.47.1792331385018;
        Sun, 18 Oct 2026 06:49:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:43 -0700 (PDT)
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
Subject: [PATCH v4 08/10] sparc64: add SPARC64 VII CPU, MMU and SMP support
Date: Sun, 18 Oct 2026 15:45:10 +0200
Message-ID: <20261018134738.1016106-9-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recognize implementation 7 and add the M3000 CPU/MMU/SMP path, including
topology, serialized interrupt dispatch and restrainable ECC handling.
Derive core and package identities from compatible core nodes and their
firmware ancestry instead of the root model or adjacent CPU numbers.
Use physical TSB accesses to avoid sibling aliases in the shared TLB;
synchronize context writes and instruction demaps while preserving
supported firmware modes and the existing non-VII demap routines.
Preserve all 47 physical-address bits in PTE helpers and check every
page-size bit in locked-mapping readback. Keep the PTE masks specific to
VII rather than treating reserved bits as address bits on every sun4u
CPU; this adds a runtime check to the PTE helpers.
Require disabled shared-context and TSB-prefetch valid bits at CPU entry
and firmware handoffs, including callbacks. Unsupported state is recorded
and halted without reentering a potentially locked PROM path.
Select VII at runtime from %ver without a CPU Kconfig option. Reject
unsupported HugeTLB and THP mappings at runtime, before page-size setup
side effects, while retaining huge pages on other CPUs. CPU offlining
remains unsupported on VII.
JPS1 F.10.1 p.458 states the same MMU ordering rule as JPS2. Keep the
new demap routines scoped to VII while Cheetah implementation guarantees
and affected paths receive a separate audit and regression test.

Hardware references (printed sections/pages):
- SPARC64 VII Extensions v1.0: 5.2.9 Table 5-1 p.18 (CPU identification),
  8.4.7 pp.42-43 (coherence), A.30 pp.64-65
  (physical loads), F.2 pp.103-104 (TTEs), F.10 pp.109-110 (MCNTL),
  F.10.2 p.114 (shared context), F.10.4 (indexed TLBs),
  F.10.13 pp.127-128 (TSB prefetch),
  F.12 p.129 (sibling sharing).
- VII N.1 pp.155-156, N.4.2/N.4.3 p.158, R.3 (IPIs/target IDs);
  P.3.1 p.187 and P.7.1/P.7.4 pp.198-200 (error registers).
- JPS2 Common r1.0 F.10.1 p.488, F.10.11 pp.500-502 (MMU ordering).

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/head_64.h    |  11 ++
 arch/sparc/include/asm/hugetlb.h    |   3 +
 arch/sparc/include/asm/pgtable_64.h |  13 +-
 arch/sparc/include/asm/setup.h      |   7 +
 arch/sparc/include/asm/smp_64.h     |   2 +
 arch/sparc/include/asm/spitfire.h   |   1 +
 arch/sparc/include/asm/trap_block.h |   6 +
 arch/sparc/kernel/cpu.c             |   7 +
 arch/sparc/kernel/entry.h           |   2 +
 arch/sparc/kernel/head_64.S         |  20 +++
 arch/sparc/kernel/helpers.S         | 126 +++++++++++++++
 arch/sparc/kernel/prom_64.c         |  28 +++-
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  57 +++++++
 arch/sparc/kernel/smp_64.c          |  83 +++++++++-
 arch/sparc/kernel/trampoline_64.S   |  34 ++++
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/mm/init_64.c             | 113 ++++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 20 files changed, 783 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/include/asm/head_64.h b/arch/sparc/include/asm/head_64.h
index 69a2062d992c..a977db986ad8 100644
--- a/arch/sparc/include/asm/head_64.h
+++ b/arch/sparc/include/asm/head_64.h
@@ -20,6 +20,17 @@
 #define	RTRAP_PSTATE_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV)
 #define RTRAP_PSTATE_AG_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV|PSTATE_AG)
 
+#define __SPARC64_VII_ID 0x00040007
+
+#define BRANCH_IF_SPARC64_VII(tmp1, tmp2, label) \
+	rdpr %ver, %tmp1; \
+	srlx %tmp1, 32, %tmp1; \
+	sethi %hi(__SPARC64_VII_ID), %tmp2; \
+	or %tmp2, %lo(__SPARC64_VII_ID), %tmp2; \
+	cmp %tmp1, %tmp2; \
+	be,pn %icc, label; \
+	 nop
+
 #define __CHEETAH_ID	0x003e0014
 #define __JALAPENO_ID	0x003e0016
 #define __SERRANO_ID	0x003e0022
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index d3bc16fbcbbd..53b087562851 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -3,8 +3,11 @@
 #define _ASM_SPARC64_HUGETLB_H
 
 #include <asm/page.h>
+#include <asm/spitfire.h>
 
 #ifdef CONFIG_HUGETLB_PAGE
+#define hugepages_supported() (tlb_type != sparc64_vii)
+
 struct pud_huge_patch_entry {
 	unsigned int addr;
 	unsigned int insn;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 0837ebbc5dce..b6dda7b731da 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -146,6 +146,9 @@ bool kern_addr_valid(unsigned long addr);
 #define _PAGE_P_4U	  _AC(0x0000000000000004,UL) /* Privileged Page      */
 #define _PAGE_W_4U	  _AC(0x0000000000000002,UL) /* Writable             */
 
+/* SPARC64 VII Extensions F.2: physical address bits 46:13. */
+#define _PAGE_PADDR_VII	  _AC(0x00007FFFFFFFE000, UL) /* pa[46:13]           */
+
 /* SUN4V pte bits... */
 #define _PAGE_NFO_4V	  _AC(0x4000000000000000,UL) /* No Fault Only        */
 #define _PAGE_SOFT2_4V	  _AC(0x3F00000000000000,UL) /* Software bits, set 2 */
@@ -224,6 +227,8 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define has_transparent_hugepage() (tlb_type != sparc64_vii)
+
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
 	pte_t pte = pfn_pte(page_nr, pgprot);
@@ -232,11 +237,14 @@ static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 }
 #endif
 
-/* This one can be done with two shifts.  */
+/* Extract the physical page number using the processor's TTE format. */
 static inline unsigned long pte_pfn(pte_t pte)
 {
 	unsigned long ret;
 
+	if (tlb_type == sparc64_vii)
+		return (pte_val(pte) & _PAGE_PADDR_VII) >> PAGE_SHIFT;
+
 	__asm__ __volatile__(
 	"\n661:	sllx		%1, %2, %0\n"
 	"	srlx		%0, %3, %0\n"
@@ -309,6 +317,9 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t prot)
 	       _PAGE_CP_4V | _PAGE_E_4V |
 	       _PAGE_SPECIAL | _PAGE_PMD_HUGE | _PAGE_SZALL_4V));
 
+	if (tlb_type == sparc64_vii)
+		mask |= _PAGE_PADDR_VII;
+
 	return __pte((pte_val(pte) & mask) | (pgprot_val(prot) & ~mask));
 }
 
diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 21bed5514028..507776ee3b4d 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -49,6 +49,13 @@ unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
 #ifdef CONFIG_SPARC64
 void __init start_early_boot(void);
 
+extern unsigned int sparc64_ttable_tl0[], sparc64_ttable_tl1[];
+void sparc64_vii_fatal_trap(void);
+void sparc64_vii_check_mmu_state(void);
+extern unsigned long sparc64_vii_mmu_fault[4];
+void sparc64_vii_ecc_trap(void);
+void sparc64_vii_ecc_trap_tl1(void);
+
 /* unaligned_64.c */
 int handle_ldf_stq(u32 insn, struct pt_regs *regs);
 void handle_ld_nf(u32 insn, struct pt_regs *regs);
diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 759fb4a9530e..21aa4c209895 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -34,6 +34,8 @@
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
 extern cpumask_t cpu_core_map[NR_CPUS];
 
+extern unsigned long vii_startup_mcntl;
+
 void smp_init_cpu_poke(void);
 void scheduler_poke(void);
 
diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 79b9dd5e9ac6..9bfa9348dd5a 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -75,6 +75,7 @@ enum ultra_tlb_layout {
 	cheetah = 1,
 	cheetah_plus = 2,
 	hypervisor = 3,
+	sparc64_vii = 4,
 };
 
 extern enum ultra_tlb_layout tlb_type;
diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 6cf2a60a0156..04f3d5826e16 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -67,6 +67,7 @@ struct cpuid_patch_entry {
 	unsigned int	cheetah_jbus[4];
 	unsigned int	starfire[4];
 	unsigned int	sun4v[4];
+	unsigned int	vii[4];
 };
 extern struct cpuid_patch_entry __cpuid_patch, __cpuid_patch_end;
 
@@ -146,6 +147,11 @@ extern struct sun4v_2insn_patch_entry __sun_m7_2insn_patch,
 	ldxa		[REG] ASI_SCRATCHPAD, REG;	\
 	nop;						\
 	nop;						\
+	/* SPARC64 VII: Jupiter ITID is bits 9:0. */ \
+	ldxa		[%g0] ASI_UPA_CONFIG, REG; \
+	and		REG, 0x3ff, REG; \
+	nop; \
+	nop; \
 	.previous;
 
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 79cd6ccfeac0..19cf910ac41d 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -123,6 +123,7 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		FPU(-1, NULL)
 	}
 },{
+	/* SPARC64 Fujitsu %ver manufacturer 4 shares the sparc32 TI value. */
 	PSR_IMPL_TI,
 	.cpu_info = {
 		CPU(0, "Texas Instruments, Inc. - SuperSparc-(II)"),
@@ -132,6 +133,9 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		CPU(3, "Texas Instruments, Inc. - SuperSparc 51"),
 		CPU(4, "Texas Instruments, Inc. - SuperSparc 61"),
 		CPU(5, "Texas Instruments, Inc. - unknown"),
+#ifdef CONFIG_SPARC64
+		CPU(7, "Fujitsu SPARC64 VII / VII+"),
+#endif
 		CPU(-1, NULL)
 	},
 	.fpu_info = {
@@ -139,6 +143,9 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		FPU(0, "SuperSparc on-chip FPU"),
 		/* SparcClassic */
 		FPU(4, "TI MicroSparc on chip FPU"),
+#ifdef CONFIG_SPARC64
+		FPU(7, "Fujitsu SPARC64 VII integrated FPU"),
+#endif
 		FPU(-1, NULL)
 	}
 },{
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index c746c0fd5d6b..517eb1a054f2 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -249,5 +249,7 @@ extern unsigned long ivector_table_pa;
 void init_irqwork_curcpu(void);
 void sun4v_register_mondo_queues(int this_cpu);
 
+void sparc64_vii_ecc_error(struct pt_regs *regs);
+
 #endif /* CONFIG_SPARC32 */
 #endif /* _ENTRY_H */
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index cf0549134234..365ca8198ea0 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -485,6 +485,8 @@ EXPORT_SYMBOL(sun4v_chip_type)
 
 80:
 	BRANCH_IF_SUN4V(g1, jump_to_sun4u_init)
+	/* Preserve Fujitsu firmware cache/MMU control, not Spitfire LSU. */
+	BRANCH_IF_SPARC64_VII(g1,g7,jump_to_sun4u_init)
 	BRANCH_IF_CHEETAH_BASE(g1,g7,cheetah_boot)
 	BRANCH_IF_CHEETAH_PLUS_OR_FOLLOWON(g1,g7,cheetah_plus_boot)
 	ba,pt	%xcc, spitfire_boot
@@ -574,6 +576,7 @@ sun4v_init:
 	ba,a,pt		%xcc, niagara_tlb_fixup
 
 sun4u_continue:
+	BRANCH_IF_SPARC64_VII(g1,g7,sparc64_vii_tlb_fixup)
 	BRANCH_IF_ANY_CHEETAH(g1, g7, cheetah_tlb_fixup)
 
 	ba,a,pt	%xcc, spitfire_tlb_fixup
@@ -692,6 +695,22 @@ cheetah_tlb_fixup:
 
 	ba,a,pt	%xcc, tlb_fixup_done
 
+sparc64_vii_tlb_fixup:
+	call	sparc64_vii_check_mmu_state
+	 nop
+	mov	4, %g2
+	sethi	%hi(tlb_type), %g1
+	stw	%g2, [%g1 + %lo(tlb_type)]
+	call	generic_patch_copyops
+	 nop
+	call	generic_patch_bzero
+	 nop
+	call	generic_patch_pageops
+	 nop
+	call	sparc64_vii_patch_cachetlbops
+	 nop
+	ba,a,pt	%xcc, tlb_fixup_done
+
 spitfire_tlb_fixup:
 	/* Set TLB type to spitfire. */
 	mov	0, %g2
@@ -841,6 +860,7 @@ setup_trap_table:
 	sllx	%o2, 32, %o2
 	wr	%o2, 0, %tick_cmpr
 
+	BRANCH_IF_SPARC64_VII(o2, o3, 1f)
 	BRANCH_IF_ANY_CHEETAH(o2, o3, 1f)
 
 	ba,a,pt	%xcc, 2f
diff --git a/arch/sparc/kernel/helpers.S b/arch/sparc/kernel/helpers.S
index 9b3f74706cfb..b4ea0ca95a37 100644
--- a/arch/sparc/kernel/helpers.S
+++ b/arch/sparc/kernel/helpers.S
@@ -64,3 +64,129 @@ real_hard_smp_processor_id:
 #endif
 	.size		real_hard_smp_processor_id,.-real_hard_smp_processor_id
 EXPORT_SYMBOL_GPL(real_hard_smp_processor_id)
+
+	.align 32
+	.globl sparc64_vii_ecc_trap
+sparc64_vii_ecc_trap:
+	TRAP(sparc64_vii_ecc_error)
+	.globl sparc64_vii_ecc_trap_tl1
+sparc64_vii_ecc_trap_tl1:
+	TRAPTL1(sparc64_vii_ecc_error)
+
+	.align 32
+	.globl sparc64_vii_fatal_trap
+sparc64_vii_fatal_trap:
+	wrpr %g0, 15, %pil
+	sethi %hi(sparc64_vii_fault_record), %g1
+	or %g1, %lo(sparc64_vii_fault_record), %g1
+	rdpr %tpc, %g2
+	stx %g2, [%g1 + 8]
+	rdpr %tnpc, %g2
+	stx %g2, [%g1 + 16]
+	rdpr %tstate, %g2
+	stx %g2, [%g1 + 24]
+	rdpr %tl, %g2
+	stx %g2, [%g1 + 32]
+	rdpr %tt, %g2
+	stx %g2, [%g1 + 40]
+	/* VII Appendix P: state-change error information, read-only here. */
+	mov 0x18, %g2
+	ldxa [%g2] 0x4c, %g2
+	stx %g2, [%g1 + 48]
+	set 0x56494900, %g2
+	stx %g2, [%g1]
+	membar #Sync
+1:	ba,pt %xcc, 1b
+	 nop
+
+	.data
+	.align 64
+	.globl sparc64_vii_fault_record
+sparc64_vii_fault_record:
+	.xword 0, 0, 0, 0, 0, 0, 0, 0
+	.previous
+
+/*
+ * Require disabled shared-context/prefetch valid bits (VII F.10.2/F.10.13).
+ * Failures populate sparc64_vii_mmu_fault; a locked PROM cannot report them.
+ */
+	.align	32
+	.globl	sparc64_vii_check_mmu_state
+	.type	sparc64_vii_check_mmu_state,#function
+sparc64_vii_check_mmu_state:
+	/* Preserve %o0, which carries the secondary startup cookie. */
+	mov	0x68, %o1
+	ldxa	[%o1] 0x58, %o2
+	sethi	%hi(0x8000), %o3
+	sllx	%o3, 32, %o4
+	or	%o3, %o4, %o3
+	andcc	%o2, %o3, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	1, %o1
+	mov	0x0, %o1
+	ldxa	[%o1] 0x61, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	2, %o1
+	mov	0x8, %o1
+	ldxa	[%o1] 0x61, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	3, %o1
+	mov	0x40, %o1
+	ldxa	[%o1] 0x61, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	4, %o1
+	mov	0x48, %o1
+	ldxa	[%o1] 0x61, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	5, %o1
+	mov	0x0, %o1
+	ldxa	[%o1] 0x62, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	6, %o1
+	mov	0x8, %o1
+	ldxa	[%o1] 0x62, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	7, %o1
+	mov	0x40, %o1
+	ldxa	[%o1] 0x62, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	8, %o1
+	mov	0x48, %o1
+	ldxa	[%o1] 0x62, %o2
+	andcc	%o2, 0x100, %g0
+	bne,pn	%xcc, .Lvii_mmu_bad
+	 mov	9, %o1
+	retl
+	 nop
+.Lvii_mmu_bad:
+	/* PROM may already be locked; record the failure without reentering it. */
+	wrpr	%g0, 15, %pil
+	rdpr	%pstate, %o3
+	andn	%o3, PSTATE_IE, %o3
+	wrpr	%o3, 0, %pstate
+	sethi	%hi(sparc64_vii_mmu_fault), %o3
+	or	%o3, %lo(sparc64_vii_mmu_fault), %o3
+	stx	%o1, [%o3 + 8]
+	stx	%o2, [%o3 + 16]
+	stx	%o7, [%o3 + 24]
+	set	0x56494d4d, %o2
+	stx	%o2, [%o3]
+	membar	#Sync
+1:	ba,pt	%xcc, 1b
+	 nop
+	.size	sparc64_vii_check_mmu_state,.-sparc64_vii_check_mmu_state
+
+	.data
+	.align	32
+/* Fault record: magic, register (1 shared, 2-5 I, 6-9 D), value, caller. */
+	.globl	sparc64_vii_mmu_fault
+sparc64_vii_mmu_fault:
+	.xword	0, 0, 0, 0
+	.previous
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index aa4799cbb9c1..c4448ec6e919 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -501,7 +501,30 @@ void __init of_populate_present_mask(void)
 	of_iterate_over_cpus(record_one_cpu, 0);
 }
 
-static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
+static void __init vii_cpu_topology(struct device_node *dp, int cpuid)
+{
+	struct device_node *core = dp->parent;
+	struct device_node *package;
+
+	cpu_data(cpuid).core_id = 0;
+	cpu_data(cpuid).proc_id = -1;
+	cpu_data(cpuid).sock_id = cpuid;
+	if (!core || !of_node_is_type(core, "core") ||
+	    !of_device_is_compatible(core, "FJSV,SPARC64-VII"))
+		return;
+	package = core->parent;
+	if (!package || !of_node_name_eq(package, "cmp"))
+		return;
+	if (core->unique_id >= USHRT_MAX || package->unique_id > SHRT_MAX)
+		return;
+
+	/* Node IDs distinguish equal core addresses in different packages. */
+	cpu_data(cpuid).core_id = core->unique_id + 1;
+	cpu_data(cpuid).proc_id = package->unique_id;
+	cpu_data(cpuid).sock_id = package->unique_id;
+}
+
+static void * __init fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
 {
 	struct device_node *portid_parent = NULL;
 	int portid = -1;
@@ -585,6 +608,9 @@ static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
 		cpu_data(cpuid).proc_id = -1;
 	}
 
+	if (tlb_type == sparc64_vii)
+		vii_cpu_topology(dp, cpuid);
+
 	return NULL;
 }
 
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 825ddf55fece..0d537ae7bef3 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -109,6 +109,13 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 {
 	BUG_ON(len > PAGE_SIZE);
 
+	if (tlb_type == sparc64_vii) {
+		/* VII caches are coherent; ASI_DCACHE_INVALIDATE is not valid. */
+		flush_icache_range((unsigned long)kaddr,
+				   (unsigned long)kaddr + len);
+		return;
+	}
+
 	if (tlb_type == hypervisor)
 		return;
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b4..ee8a79565ff5 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -184,6 +184,9 @@ static void __init per_cpu_patch(void)
 			else
 				insns = &p->cheetah_safari[0];
 			break;
+		case sparc64_vii:
+			insns = &p->vii[0];
+			break;
 		case hypervisor:
 			insns = &p->sun4v[0];
 			break;
@@ -349,6 +352,42 @@ static void __init pause_patch(void)
 	}
 }
 
+/*
+ * Route restrainable ECC (0x63) to the VII C handler.
+ * Other patched errors record state and halt without touching Spitfire
+ * error/cache registers, including at TL>1.
+ */
+static void __init vii_patch_error_traps(void)
+{
+	static const unsigned int traps[] = { 0x0a, 0x32, 0x40, 0x63 };
+	unsigned int *tables[] = { sparc64_ttable_tl0, sparc64_ttable_tl1 };
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(tables); i++) {
+		for (j = 0; j < ARRAY_SIZE(traps); j++) {
+			unsigned int *slot = tables[i] + traps[j] * 8;
+			void (*handler)(void) = sparc64_vii_fatal_trap;
+			long delta;
+
+			if (traps[j] == 0x63)
+				handler = i ? sparc64_vii_ecc_trap_tl1 :
+					      sparc64_vii_ecc_trap;
+			delta = (long)handler - (long)slot;
+
+			/* ba (disp22), followed by nop. */
+			if (delta < -(1L << 23) || delta >= (1L << 23)) {
+				prom_printf("VII: error-trap handler is out of branch range.\n");
+				prom_halt();
+			}
+			slot[1] = 0x01000000;
+			slot[0] = 0x10800000 | ((delta >> 2) & 0x3fffff);
+			/* Publish the trap instructions before synchronizing fetch. */
+			wmb();
+			__asm__ __volatile__("flush %0" : : "r" (slot));
+		}
+	}
+}
+
 void __init start_early_boot(void)
 {
 	int cpu;
@@ -358,6 +397,24 @@ void __init start_early_boot(void)
 	sun4v_patch();
 	smp_init_cpu_poke();
 
+	if (tlb_type == sparc64_vii) {
+		unsigned long mcntl;
+
+		vii_patch_error_traps();
+
+		__asm__ __volatile__("ldxa [%1] 0x45, %0"
+				     : "=r" (mcntl) : "r" (8UL));
+		/*
+		 * Reject context hashing, forced instruction caching of noncacheable
+		 * addresses and multiple-page-size contexts (VII Table F-4).
+		 * Preserve firmware state; stop if a mode transition is required.
+		 */
+		if (mcntl & 0x101c0UL) {
+			prom_printf("VII-BOOT: incompatible inherited MCNTL; halted\n");
+			prom_halt();
+		}
+	}
+
 	cpu = hard_smp_processor_id();
 	if (cpu >= NR_CPUS) {
 		prom_printf("Serious problem, boot cpu id (%d) >= NR_CPUS (%d)\n",
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 371460e34484..ab010c2f77bc 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -288,7 +288,6 @@ static void smp_synchronize_one_tick(int cpu)
 static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg,
 				void **descrp)
 {
-	extern unsigned long sparc64_ttable_tl0;
 	extern unsigned long kern_locked_tte_data;
 	struct hvtramp_descr *hdesc;
 	unsigned long trampoline_ra;
@@ -344,6 +343,9 @@ extern unsigned long sparc64_cpu_startup;
  */
 static struct thread_info *cpu_new_thread = NULL;
 
+/* Written before the secondary validates its inherited MMU control. */
+unsigned long vii_startup_mcntl;
+
 static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long entry =
@@ -354,6 +356,8 @@ static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 	int timeout, ret;
 
 	callin_flag = 0;
+	if (tlb_type == sparc64_vii)
+		WRITE_ONCE(vii_startup_mcntl, ~0UL);
 	cpu_new_thread = task_thread_info(idle);
 
 	if (tlb_type == hypervisor) {
@@ -381,6 +385,9 @@ static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 		ret = 0;
 	} else {
 		printk("Processor %d is stuck.\n", cpu);
+		if (tlb_type == sparc64_vii)
+			pr_err("VII secondary CPU %u MCNTL=%lx (all ones: MCNTL not captured)\n",
+			       cpu, READ_ONCE(vii_startup_mcntl));
 		ret = -ENODEV;
 	}
 	cpu_new_thread = NULL;
@@ -390,6 +397,55 @@ static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
+/*
+ * Serialize targets through BUSY/NACK pair zero for simple retry handling.
+ * VII Extensions N.4.3 permits pipelining through multiple pairs.
+ */
+static void vii_xcall_deliver(struct trap_per_cpu *tb, int cnt)
+{
+	u64 *data = __va(tb->cpu_mondo_block_pa);
+	u16 *cpus = __va(tb->cpu_list_pa);
+	unsigned long pstate, disabled;
+	int i;
+
+	__asm__ __volatile__("rdpr %%pstate, %0" : "=r" (pstate));
+	disabled = pstate & ~PSTATE_IE;
+	for (i = 0; i < cnt; i++) {
+		unsigned long target = ((unsigned long)cpus[i] << 14) | 0x70;
+		unsigned long status = 0;
+		int retry;
+
+		for (retry = 0; retry < 10000; retry++) {
+			int polls = 1000000;
+
+			__asm__ __volatile__("wrpr %0, 0, %%pstate\n\t"
+				"stxa %1, [%4] %7\n\t"
+				"stxa %2, [%5] %7\n\t"
+				"stxa %3, [%6] %7\n\t"
+				"membar #Sync\n\t"
+				"stxa %%g0, [%8] %7\n\t"
+				"membar #Sync"
+				: : "r" (disabled), "r" (data[0]), "r" (data[1]),
+				"r" (data[2]), "r" (0x40UL), "r" (0x50UL),
+				"r" (0x60UL), "i" (ASI_INTR_W), "r" (target)
+				: "memory");
+			do {
+				__asm__ __volatile__("ldxa [%%g0] %1, %0"
+					: "=r" (status) : "i" (ASI_INTR_DISPATCH_STAT));
+			} while ((status & 1) && --polls);
+			__asm__ __volatile__("wrpr %0, 0, %%pstate"
+				: : "r" (pstate) : "memory");
+			if (!polls)
+				panic("VII IPI busy timeout target=%u status=%lx", cpus[i], status);
+			if (!(status & 2))
+				break;
+			udelay(2);
+		}
+		if (retry == 10000)
+			panic("VII IPI NACK timeout target=%u status=%lx", cpus[i], status);
+	}
+}
+
 static void spitfire_xcall_helper(u64 data0, u64 data1, u64 data2, u64 pstate, unsigned long cpu)
 {
 	u64 result, target;
@@ -1205,7 +1261,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 void __init smp_setup_processor_id(void)
 {
-	if (tlb_type == spitfire)
+	if (tlb_type == sparc64_vii)
+		xcall_deliver_impl = vii_xcall_deliver;
+	else if (tlb_type == spitfire)
 		xcall_deliver_impl = spitfire_xcall_deliver;
 	else if (tlb_type == cheetah || tlb_type == cheetah_plus)
 		xcall_deliver_impl = cheetah_xcall_deliver;
@@ -1241,8 +1299,13 @@ void smp_fill_in_sib_core_maps(void)
 			    cpu_data(j).max_cache_id)
 				cpumask_set_cpu(j, &cpu_core_sib_cache_map[i]);
 
-			if (cpu_data(i).sock_id == cpu_data(j).sock_id)
+			if (tlb_type == sparc64_vii) {
+				if (i == j || (cpu_data(i).proc_id >= 0 &&
+				    cpu_data(i).proc_id == cpu_data(j).proc_id))
+					cpumask_set_cpu(j, &cpu_core_sib_map[i]);
+			} else if (cpu_data(i).sock_id == cpu_data(j).sock_id) {
 				cpumask_set_cpu(j, &cpu_core_sib_map[i]);
+			}
 		}
 	}
 
@@ -1256,8 +1319,14 @@ void smp_fill_in_sib_core_maps(void)
 		}
 
 		for_each_present_cpu(j) {
-			if (cpu_data(i).proc_id ==
-			    cpu_data(j).proc_id)
+			bool sibling;
+
+			/* VII proc_id identifies the package, not the core. */
+			if (tlb_type == sparc64_vii)
+				sibling = cpu_data(i).core_id == cpu_data(j).core_id;
+			else
+				sibling = cpu_data(i).proc_id == cpu_data(j).proc_id;
+			if (sibling)
 				cpumask_set_cpu(j, &per_cpu(cpu_sibling_map, i));
 		}
 	}
@@ -1326,6 +1395,10 @@ int __cpu_disable(void)
 	cpuinfo_sparc *c;
 	int i;
 
+	/* VII secondary startup does not implement offline/restart. */
+	if (tlb_type == sparc64_vii)
+		return -EOPNOTSUPP;
+
 	for_each_cpu(i, &cpu_core_map[cpu])
 		cpumask_clear_cpu(cpu, &cpu_core_map[i]);
 	cpumask_clear(&cpu_core_map[cpu]);
diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 447334730122..664d69b84b83 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -21,6 +21,18 @@
 #include <asm/hypervisor.h>
 #include <asm/cpudata.h>
 
+/* Validate each direct firmware return without reading %ver on sun4v. */
+	.macro VII_CHECK_MMU_STATE
+	BRANCH_IF_SUN4V(g1, .Lvii_mmu_done\@)
+	BRANCH_IF_SPARC64_VII(g1, g5, .Lvii_mmu_check\@)
+	ba,pt	%xcc, .Lvii_mmu_done\@
+	 nop
+.Lvii_mmu_check\@:
+	call	sparc64_vii_check_mmu_state
+	 nop
+.Lvii_mmu_done\@:
+	.endm
+
 	.data
 	.align	8
 call_method:
@@ -41,12 +53,29 @@ tramp_stack:
 	.globl		sparc64_cpu_startup, sparc64_cpu_startup_end
 sparc64_cpu_startup:
 	BRANCH_IF_SUN4V(g1, niagara_startup)
+	BRANCH_IF_SPARC64_VII(g1, g5, vii_startup)
 	BRANCH_IF_CHEETAH_BASE(g1, g5, cheetah_startup)
 	BRANCH_IF_CHEETAH_PLUS_OR_FOLLOWON(g1, g5, cheetah_plus_startup)
 
 	ba,pt	%xcc, spitfire_startup
 	 nop
 
+vii_startup:
+	/* Preserve firmware cache/MMU control, as on the boot CPU. */
+	mov		8, %g1
+	ldxa		[%g1] 0x45, %g5
+	sethi		%hi(vii_startup_mcntl), %g1
+	stx		%g5, [%g1 + %lo(vii_startup_mcntl)]
+	membar		#Sync
+	call		sparc64_vii_check_mmu_state
+	 nop
+	set		0x101c0, %g1
+	andcc		%g5, %g1, %g0
+1:	bne,pn		%xcc, 1b
+	 nop
+	ba,pt		%xcc, niagara_startup
+	 nop
+
 cheetah_plus_startup:
 	/* Preserve OBP chosen DCU and DCR register settings.  */
 	ba,pt	%xcc, cheetah_generic_startup
@@ -144,6 +173,7 @@ startup_continue:
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
 
 	mov		15, %l7
+	BRANCH_IF_SPARC64_VII(g1,g5,2f)
 	BRANCH_IF_ANY_CHEETAH(g1,g5,2f)
 
 	mov		63, %l7
@@ -182,6 +212,7 @@ startup_continue:
 	ldx		[%g2 + 0x08], %o1
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
+	VII_CHECK_MMU_STATE
 
 	/* Lock into D-MMU */
 	sethi		%hi(call_method), %g2
@@ -215,6 +246,7 @@ startup_continue:
 	ldx		[%g2 + 0x08], %o1
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
+	VII_CHECK_MMU_STATE
 
 	add		%l5, 1, %l5
 	cmp		%l5, %l6
@@ -396,6 +428,7 @@ after_lock_tlb:
 	ldx		[%g2 + 0x08], %o1
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
+	VII_CHECK_MMU_STATE
 
 	ba,pt		%xcc, 3f
 	 nop
@@ -413,6 +446,7 @@ after_lock_tlb:
 	ldx		[%g2 + 0x08], %o1
 	call		%o1
 	 add		%sp, (2047 + 128), %o0
+	VII_CHECK_MMU_STATE
 
 3:	sethi		%hi(prom_entry_lock), %g2
 	/*
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 28cb0d66ab40..3c693b7bd32b 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2716,6 +2716,33 @@ void do_privact(struct pt_regs *regs)
 	do_privop(regs);
 }
 
+/* SPARC64 VII Extensions, Appendix P.7.1 and P.7.4. */
+#define VII_AFSR_DEGRADATION	((1UL << 12) | (1UL << 11) | (1UL << 10))
+
+void sparc64_vii_ecc_error(struct pt_regs *regs)
+{
+	enum ctx_state prev_state = exception_enter();
+	unsigned long afsr;
+
+	__asm__ __volatile__("ldxa [%%g0] 0x4c, %0" : "=r" (afsr));
+	/* An ECC trap without a sticky error indication is explicitly allowed. */
+	if (!afsr)
+		goto out;
+
+	/* No data recovery is implemented for raw UE or store bus errors. */
+	if (afsr & ~VII_AFSR_DEGRADATION)
+		panic("SPARC64 VII: unhandled ECC error, CPU %u AFSR=%lx TPC=%lx",
+		      smp_processor_id(), afsr, regs->tpc);
+
+	/* Hardware has already reduced the affected cache/TLB associativity. */
+	__asm__ __volatile__("stxa %0, [%%g0] 0x4c; membar #Sync"
+			     : : "r" (afsr) : "memory");
+	pr_warn_ratelimited("SPARC64 VII: CPU %u cache/TLB degradation, AFSR=%lx\n",
+			    smp_processor_id(), afsr);
+out:
+	exception_exit(prev_state);
+}
+
 /* Trap level 1 stuff or other traps we should never see... */
 void do_cee(struct pt_regs *regs)
 {
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index f3f7eba08469..f4f3e3d1e9b0 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -271,7 +271,8 @@ static inline void tsb_insert(struct tsb *ent, unsigned long tag, unsigned long
 {
 	unsigned long tsb_addr = (unsigned long) ent;
 
-	if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+	if (tlb_type == cheetah_plus || tlb_type == hypervisor ||
+	    tlb_type == sparc64_vii)
 		tsb_addr = __pa(tsb_addr);
 
 	__tsb_insert(tsb_addr, tag, pte);
@@ -329,6 +330,9 @@ static void __update_mmu_tsb_insert(struct mm_struct *mm, unsigned long tsb_inde
 #ifdef CONFIG_HUGETLB_PAGE
 static int __init hugetlbpage_init(void)
 {
+	if (!hugepages_supported())
+		return 0;
+
 	hugetlb_add_hstate(HPAGE_64K_SHIFT - PAGE_SHIFT);
 	hugetlb_add_hstate(HPAGE_SHIFT - PAGE_SHIFT);
 	hugetlb_add_hstate(HPAGE_256MB_SHIFT - PAGE_SHIFT);
@@ -356,6 +360,9 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 	unsigned int hugepage_shift = ilog2(size);
 	unsigned int hv_pgsz_mask;
 
+	if (!hugepages_supported())
+		return false;
+
 	switch (hugepage_shift) {
 	case HPAGE_16GB_SHIFT:
 		hv_pgsz_mask = HV_PGSZ_MASK_16GB;
@@ -495,6 +502,12 @@ EXPORT_SYMBOL(flush_dcache_folio);
 
 void __kprobes flush_icache_range(unsigned long start, unsigned long end)
 {
+	if (tlb_type == sparc64_vii) {
+		/* Coherent caches still require instruction-stream synchronization. */
+		__asm__ __volatile__("membar #Sync\n\tflush %0"
+				     : : "r" (start) : "memory");
+		return;
+	}
 	/* Cheetah and Hypervisor platform cpus have coherent I-cache. */
 	if (tlb_type == spitfire) {
 		unsigned long kaddr;
@@ -530,6 +543,8 @@ void mmu_info(struct seq_file *m)
 		seq_printf(m, "MMU Type\t: Cheetah\n");
 	else if (tlb_type == cheetah_plus)
 		seq_printf(m, "MMU Type\t: Cheetah+\n");
+	else if (tlb_type == sparc64_vii)
+		seq_puts(m, "MMU Type\t: Fujitsu SPARC64 VII\n");
 	else if (tlb_type == spitfire)
 		seq_printf(m, "MMU Type\t: Spitfire\n");
 	else if (tlb_type == hypervisor)
@@ -666,6 +681,52 @@ static void __init hypervisor_tlb_lock(unsigned long vaddr,
 
 static unsigned long kern_large_tte(unsigned long paddr);
 
+/*
+ * Reserve the kernel image mappings in the lower half of the fully
+ * associative bank. Check existing reservations, firmware
+ * status and physical slot readback before using the mappings.
+ */
+static void __init vii_check_slots(void)
+{
+	int i;
+
+	if (num_kernel_image_mappings > 2) {
+		prom_printf("VII-BOOT: kernel exceeds initial 8MB mapping budget\n");
+		prom_halt();
+	}
+	for (i = 16 - num_kernel_image_mappings; i <= 15; i++) {
+		unsigned long d = cheetah_get_ldtlb_data(i);
+		unsigned long t = cheetah_get_litlb_data(i);
+
+		if (((d & (_PAGE_VALID | _PAGE_L_4U)) ==
+		      (_PAGE_VALID | _PAGE_L_4U)) ||
+		     ((t & (_PAGE_VALID | _PAGE_L_4U)) ==
+		      (_PAGE_VALID | _PAGE_L_4U))) {
+			prom_printf("VII-BOOT: reserved slot %d occupied; halted\n", i);
+			prom_halt();
+		}
+	}
+}
+
+static void __init vii_check_mapping(int slot, unsigned long va,
+				     unsigned long tte)
+{
+	/* VII F.2 #238 leaves PA/VA bits 21:13 arbitrary on 4MB TLB reads. */
+	unsigned long offset_mask = GENMASK(21, 13);
+	unsigned long mask = (_PAGE_VALID | _PAGE_SZALL_4U |
+		_PAGE_PADDR_VII | _PAGE_L_4U) & ~offset_mask;
+	unsigned long d = cheetah_get_ldtlb_data(slot);
+	unsigned long t = cheetah_get_litlb_data(slot);
+	unsigned long dt = cheetah_get_ldtlb_tag(slot);
+	unsigned long it = cheetah_get_litlb_tag(slot);
+
+	if ((d & mask) != (tte & mask) || (t & mask) != (tte & mask) ||
+	    ((dt ^ va) & ~offset_mask) || ((it ^ va) & ~offset_mask)) {
+		prom_printf("VII-BOOT: mapping readback mismatch; halted\n");
+		prom_halt();
+	}
+}
+
 static void __init remap_kernel(void)
 {
 	unsigned long phys_page, tte_vaddr, tte_data;
@@ -677,6 +738,9 @@ static void __init remap_kernel(void)
 
 	kern_locked_tte_data = tte_data;
 
+	if (tlb_type == sparc64_vii)
+		vii_check_slots();
+
 	/* Now lock us into the TLBs via Hypervisor or OBP. */
 	if (tlb_type == hypervisor) {
 		for (i = 0; i < num_kernel_image_mappings; i++) {
@@ -687,8 +751,22 @@ static void __init remap_kernel(void)
 		}
 	} else {
 		for (i = 0; i < num_kernel_image_mappings; i++) {
-			prom_dtlb_load(tlb_ent - i, tte_data, tte_vaddr);
-			prom_itlb_load(tlb_ent - i, tte_data, tte_vaddr);
+			long ret;
+
+			ret = prom_dtlb_load(tlb_ent - i, tte_data, tte_vaddr);
+			if (ret && tlb_type == sparc64_vii) {
+				prom_printf("SUNW,dtlb-load failed: idx=%d va=%lx tte=%lx rc=%lx\n",
+					    tlb_ent - i, tte_vaddr, tte_data, ret);
+				prom_halt();
+			}
+			ret = prom_itlb_load(tlb_ent - i, tte_data, tte_vaddr);
+			if (ret && tlb_type == sparc64_vii) {
+				prom_printf("SUNW,itlb-load failed: idx=%d va=%lx tte=%lx rc=%lx\n",
+					    tlb_ent - i, tte_vaddr, tte_data, ret);
+				prom_halt();
+			}
+			if (tlb_type == sparc64_vii)
+				vii_check_mapping(tlb_ent - i, tte_vaddr, tte_data);
 			tte_vaddr += 0x400000;
 			tte_data += 0x400000;
 		}
@@ -713,6 +791,9 @@ static void __init inherit_prom_mappings(void)
 
 void prom_world(int enter)
 {
+	if (tlb_type == sparc64_vii)
+		sparc64_vii_check_mmu_state();
+
 	/*
 	 * No need to change the address space any more, just flush
 	 * the register windows
@@ -724,6 +805,11 @@ void __flush_dcache_range(unsigned long start, unsigned long end)
 {
 	unsigned long va;
 
+	if (tlb_type == sparc64_vii) {
+		__asm__ __volatile__("membar #Sync" : : : "memory");
+		return;
+	}
+
 	if (tlb_type == spitfire) {
 		int n = 0;
 
@@ -2347,7 +2433,8 @@ void __init paging_init(void)
 	else
 		sun4u_pgprot_init();
 
-	if (tlb_type == cheetah_plus ||
+	/* VII supports ASI_QUAD_LDD_PHYS (0x34); avoid shared-TLB TSB aliases. */
+	if (tlb_type == cheetah_plus || tlb_type == sparc64_vii ||
 	    tlb_type == hypervisor) {
 		tsb_phys_patch();
 		ktsb_phys_patch();
@@ -2369,6 +2456,15 @@ void __init paging_init(void)
 	read_obp_memory("available", &pavail[0], &pavail_ents);
 	read_obp_memory("available", &pavail[0], &pavail_ents);
 
+	if (tlb_type == sparc64_vii) {
+		for (i = 0; i < pall_ents; i++) {
+			if (pall[i].phys_addr >= (1UL << 40) ||
+			    pall[i].reg_size > (1UL << 40) - pall[i].phys_addr) {
+				prom_printf("VII-BOOT: RAM exceeds initial PA layout\n");
+				prom_halt();
+			}
+		}
+	}
 	phys_base = 0xffffffffffffffffUL;
 	for (i = 0; i < pavail_ents; i++) {
 		phys_base = min(phys_base, pavail[i].phys_addr);
@@ -2402,7 +2498,7 @@ void __init paging_init(void)
 	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
 
 	inherit_prom_mappings();
-	
+
 	/* Ok, we can use our TLB miss and window trap handlers safely.  */
 	setup_tba();
 
@@ -2813,9 +2909,14 @@ void __flush_tlb_all(void)
 				spitfire_put_itlb_data(i, 0x0UL);
 			}
 		}
-	} else if (tlb_type == cheetah || tlb_type == cheetah_plus) {
+	} else if (tlb_type == cheetah || tlb_type == cheetah_plus ||
+		   tlb_type == sparc64_vii) {
 		cheetah_flush_dtlb_all();
 		cheetah_flush_itlb_all();
+		/* JPS2 F.10.1 requires instruction visibility after demap-all. */
+		if (tlb_type == sparc64_vii)
+			__asm__ __volatile__("flush %0"
+					     : : "r" (KERNBASE) : "memory");
 	}
 	__asm__ __volatile__("wrpr	%0, 0, %%pstate"
 			     : : "r" (pstate));
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 5fe52a64c7e7..ba5dec3cb0f7 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -126,7 +126,8 @@ void flush_tsb_user(struct tlb_batch *tb)
 	if (tb->hugepage_shift < REAL_HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
-		if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+		if (tlb_type == cheetah_plus || tlb_type == hypervisor ||
+		    tlb_type == sparc64_vii)
 			base = __pa(base);
 		if (tb->hugepage_shift == PAGE_SHIFT)
 			__flush_tsb_one(tb, PAGE_SHIFT, base, nentries);
@@ -140,7 +141,8 @@ void flush_tsb_user(struct tlb_batch *tb)
 	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_HUGE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
-		if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+		if (tlb_type == cheetah_plus || tlb_type == hypervisor ||
+		    tlb_type == sparc64_vii)
 			base = __pa(base);
 		__flush_huge_tsb_one(tb, REAL_HPAGE_SHIFT, base, nentries,
 				     tb->hugepage_shift);
@@ -159,7 +161,8 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
 	if (hugepage_shift < REAL_HPAGE_SHIFT) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_BASE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_BASE].tsb_nentries;
-		if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+		if (tlb_type == cheetah_plus || tlb_type == hypervisor ||
+		    tlb_type == sparc64_vii)
 			base = __pa(base);
 		if (hugepage_shift == PAGE_SHIFT)
 			__flush_tsb_one_entry(base, vaddr, PAGE_SHIFT,
@@ -174,7 +177,8 @@ void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr,
 	else if (mm->context.tsb_block[MM_TSB_HUGE].tsb) {
 		base = (unsigned long) mm->context.tsb_block[MM_TSB_HUGE].tsb;
 		nentries = mm->context.tsb_block[MM_TSB_HUGE].tsb_nentries;
-		if (tlb_type == cheetah_plus || tlb_type == hypervisor)
+		if (tlb_type == cheetah_plus || tlb_type == hypervisor ||
+		    tlb_type == sparc64_vii)
 			base = __pa(base);
 		__flush_huge_tsb_one_entry(base, vaddr, REAL_HPAGE_SHIFT,
 					   nentries, hugepage_shift);
@@ -270,7 +274,9 @@ static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsign
 	}
 	tte |= pte_sz_bits(page_sz);
 
-	if (tlb_type == cheetah_plus || tlb_type == hypervisor) {
+	/* VII siblings share TLBs: per-mm TSBs cannot reuse a fixed VA/slot. */
+	if (tlb_type == cheetah_plus || tlb_type == hypervisor ||
+	    tlb_type == sparc64_vii) {
 		/* Physical mapping, no locked TLB entry for TSB.  */
 		tsb_reg |= tsb_paddr;
 
@@ -502,7 +508,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 		unsigned long old_tsb_base = (unsigned long) old_tsb;
 		unsigned long new_tsb_base = (unsigned long) new_tsb;
 
-		if (tlb_type == cheetah_plus || tlb_type == hypervisor) {
+		if (tlb_type == cheetah_plus || tlb_type == hypervisor ||
+		    tlb_type == sparc64_vii) {
 			old_tsb_base = __pa(old_tsb_base);
 			new_tsb_base = __pa(new_tsb_base);
 		}
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 70e658d107e0..4942b793badb 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -981,6 +981,242 @@ xcall_kgdb_capture:
 
 #endif /* CONFIG_SMP */
 
+/*
+ * Synchronize VII MMU stores before noninternal memory access or the end
+ * of a control-transfer delay slot (JPS2 F.10.1, p. 488).
+ * Instruction visibility also requires FLUSH or trap return (F.10.11,
+ * pp. 500-502); MEMBAR alone is insufficient.
+ */
+/*
+ * Absolute jumps preserve patch-slot sizes and caller return addresses
+ * without branch relocation. Local entries may clobber %g1; the xcall
+ * stub uses %g4 to preserve its address/context arguments in %g1/%g5.
+ */
+	.type		__vii_flush_tlb_page_patch, #function
+__vii_flush_tlb_page_patch:
+	sethi		%hi(__vii_flush_tlb_page), %g1
+	jmpl		%g1 + %lo(__vii_flush_tlb_page), %g0
+	 nop
+	.size		__vii_flush_tlb_page_patch, .-__vii_flush_tlb_page_patch
+	.if		(. - __vii_flush_tlb_page_patch) - 12
+	.error		"VII TLB jump template must contain three instructions"
+	.endif
+
+	.type		__vii_flush_tlb_page, #function
+__vii_flush_tlb_page:
+	/* %o0 = context, %o1 = vaddr */
+	rdpr		%pstate, %g7
+	andn		%g7, PSTATE_IE, %g2
+	wrpr		%g2, 0x0, %pstate
+	wrpr		%g0, 1, %tl
+	mov		PRIMARY_CONTEXT, %o4
+	ldxa		[%o4] ASI_DMMU, %g2
+	srlx		%g2, CTX_PGSZ1_NUC_SHIFT, %o3
+	sllx		%o3, CTX_PGSZ1_NUC_SHIFT, %o3
+	or		%o0, %o3, %o0	/* Preserve nucleus page size fields */
+	stxa		%o0, [%o4] ASI_DMMU
+	membar		#Sync
+	andcc		%o1, 1, %g0
+	be,pn		%icc, 1f
+	 andn		%o1, 1, %o3
+	stxa		%g0, [%o3] ASI_IMMU_DEMAP
+1:	stxa		%g0, [%o3] ASI_DMMU_DEMAP
+	membar		#Sync
+	stxa		%g2, [%o4] ASI_DMMU
+	sethi		%hi(KERNBASE), %o4
+	flush		%o4
+	wrpr		%g0, 0, %tl
+	retl
+	 wrpr		%g7, 0x0, %pstate
+	.size		__vii_flush_tlb_page, .-__vii_flush_tlb_page
+
+	.type		__vii_flush_tlb_pending_patch, #function
+__vii_flush_tlb_pending_patch:
+	sethi		%hi(__vii_flush_tlb_pending), %g1
+	jmpl		%g1 + %lo(__vii_flush_tlb_pending), %g0
+	 nop
+	.size		__vii_flush_tlb_pending_patch, .-__vii_flush_tlb_pending_patch
+	.if		(. - __vii_flush_tlb_pending_patch) - 12
+	.error		"VII TLB jump template must contain three instructions"
+	.endif
+
+	.type		__vii_flush_tlb_pending, #function
+__vii_flush_tlb_pending:
+	/* %o0 = context, %o1 = nr, %o2 = vaddrs[] */
+	rdpr		%pstate, %g7
+	sllx		%o1, 3, %o1
+	andn		%g7, PSTATE_IE, %g2
+	wrpr		%g2, 0x0, %pstate
+	wrpr		%g0, 1, %tl
+	mov		PRIMARY_CONTEXT, %o4
+	ldxa		[%o4] ASI_DMMU, %g2
+	srlx		%g2, CTX_PGSZ1_NUC_SHIFT, %o3
+	sllx		%o3, CTX_PGSZ1_NUC_SHIFT, %o3
+	or		%o0, %o3, %o0	/* Preserve nucleus page size fields */
+	stxa		%o0, [%o4] ASI_DMMU
+	membar		#Sync
+1:	sub		%o1, (1 << 3), %o1
+	ldx		[%o2 + %o1], %o3
+	andcc		%o3, 1, %g0
+	be,pn		%icc, 2f
+	 andn		%o3, 1, %o3
+	stxa		%g0, [%o3] ASI_IMMU_DEMAP
+2:	stxa		%g0, [%o3] ASI_DMMU_DEMAP
+	membar		#Sync
+	brnz,pt		%o1, 1b
+	 nop
+	stxa		%g2, [%o4] ASI_DMMU
+	sethi		%hi(KERNBASE), %o4
+	flush		%o4
+	wrpr		%g0, 0, %tl
+	retl
+	 wrpr		%g7, 0x0, %pstate
+	.size		__vii_flush_tlb_pending, .-__vii_flush_tlb_pending
+
+	.type		__vii_flush_tlb_kernel_range_patch, #function
+__vii_flush_tlb_kernel_range_patch:
+	sethi		%hi(__vii_flush_tlb_kernel_range), %g1
+	jmpl		%g1 + %lo(__vii_flush_tlb_kernel_range), %g0
+	 nop
+	.size		__vii_flush_tlb_kernel_range_patch, .-__vii_flush_tlb_kernel_range_patch
+	.if		(. - __vii_flush_tlb_kernel_range_patch) - 12
+	.error		"VII TLB jump template must contain three instructions"
+	.endif
+
+	.type		__vii_flush_tlb_kernel_range, #function
+__vii_flush_tlb_kernel_range:
+	/* %o0=start, %o1=end */
+	cmp		%o0, %o1
+	be,pn		%xcc, 2f
+	 sub		%o1, %o0, %o3
+	srlx		%o3, 18, %o4
+	brnz,pn		%o4, 3f
+	 sethi		%hi(PAGE_SIZE), %o4
+	sub		%o3, %o4, %o3
+	or		%o0, 0x20, %o0		! Nucleus
+1:	stxa		%g0, [%o0 + %o3] ASI_DMMU_DEMAP
+	stxa		%g0, [%o0 + %o3] ASI_IMMU_DEMAP
+	membar		#Sync
+	brnz,pt		%o3, 1b
+	 sub		%o3, %o4, %o3
+2:	sethi		%hi(KERNBASE), %o3
+	flush		%o3
+	retl
+	 nop
+3:	mov		0x80, %o4
+	stxa		%g0, [%o4] ASI_DMMU_DEMAP
+	membar		#Sync
+	stxa		%g0, [%o4] ASI_IMMU_DEMAP
+	membar		#Sync
+	sethi		%hi(KERNBASE), %o3
+	flush		%o3
+	retl
+	 nop
+	.size		__vii_flush_tlb_kernel_range, .-__vii_flush_tlb_kernel_range
+
+#ifdef CONFIG_SMP
+	.type		__vii_xcall_flush_tlb_page_patch, #function
+__vii_xcall_flush_tlb_page_patch:
+	sethi		%hi(__vii_xcall_flush_tlb_page), %g4
+	jmpl		%g4 + %lo(__vii_xcall_flush_tlb_page), %g0
+	 nop
+	.size		__vii_xcall_flush_tlb_page_patch, .-__vii_xcall_flush_tlb_page_patch
+	.if		(. - __vii_xcall_flush_tlb_page_patch) - 12
+	.error		"VII TLB jump template must contain three instructions"
+	.endif
+
+	.type		__vii_xcall_flush_tlb_page, #function
+__vii_xcall_flush_tlb_page:
+	/* %g5=context, %g1=vaddr */
+	mov		PRIMARY_CONTEXT, %g4
+	ldxa		[%g4] ASI_DMMU, %g2
+	srlx		%g2, CTX_PGSZ1_NUC_SHIFT, %g4
+	sllx		%g4, CTX_PGSZ1_NUC_SHIFT, %g4
+	or		%g5, %g4, %g5
+	mov		PRIMARY_CONTEXT, %g4
+	stxa		%g5, [%g4] ASI_DMMU
+	membar		#Sync
+	andcc		%g1, 0x1, %g0
+	be,pn		%icc, 2f
+	 andn		%g1, 0x1, %g5
+	stxa		%g0, [%g5] ASI_IMMU_DEMAP
+2:	stxa		%g0, [%g5] ASI_DMMU_DEMAP
+	membar		#Sync
+	stxa		%g2, [%g4] ASI_DMMU
+	retry
+	.size		__vii_xcall_flush_tlb_page, .-__vii_xcall_flush_tlb_page
+
+#endif /* CONFIG_SMP */
+
+	.globl		sparc64_vii_patch_cachetlbops
+sparc64_vii_patch_cachetlbops:
+	save		%sp, -128, %sp
+
+	sethi		%hi(__flush_tlb_mm), %o0
+	or		%o0, %lo(__flush_tlb_mm), %o0
+	sethi		%hi(__cheetah_flush_tlb_mm), %o1
+	or		%o1, %lo(__cheetah_flush_tlb_mm), %o1
+	call		tlb_patch_one
+	 mov		19, %o2
+
+	sethi		%hi(__flush_tlb_page), %o0
+	or		%o0, %lo(__flush_tlb_page), %o0
+	sethi		%hi(__vii_flush_tlb_page_patch), %o1
+	or		%o1, %lo(__vii_flush_tlb_page_patch), %o1
+	call		tlb_patch_one
+	 mov		3, %o2
+
+	sethi		%hi(__flush_tlb_pending), %o0
+	or		%o0, %lo(__flush_tlb_pending), %o0
+	sethi		%hi(__vii_flush_tlb_pending_patch), %o1
+	or		%o1, %lo(__vii_flush_tlb_pending_patch), %o1
+	call		tlb_patch_one
+	 mov		3, %o2
+
+	sethi		%hi(__flush_tlb_kernel_range), %o0
+	or		%o0, %lo(__flush_tlb_kernel_range), %o0
+	sethi		%hi(__vii_flush_tlb_kernel_range_patch), %o1
+	or		%o1, %lo(__vii_flush_tlb_kernel_range_patch), %o1
+	call		tlb_patch_one
+	 mov		3, %o2
+
+#ifdef CONFIG_SMP
+	sethi		%hi(xcall_flush_tlb_page), %o0
+	or		%o0, %lo(xcall_flush_tlb_page), %o0
+	sethi		%hi(__vii_xcall_flush_tlb_page_patch), %o1
+	or		%o1, %lo(__vii_xcall_flush_tlb_page_patch), %o1
+	call		tlb_patch_one
+	 mov		3, %o2
+
+	/* The Spitfire sweep misses VII sTLBs (VII Extensions F.10.4). */
+	sethi		%hi(xcall_flush_tlb_kernel_range), %o0
+	or		%o0, %lo(xcall_flush_tlb_kernel_range), %o0
+	sethi		%hi(__cheetah_xcall_flush_tlb_kernel_range), %o1
+	or		%o1, %lo(__cheetah_xcall_flush_tlb_kernel_range), %o1
+	call		tlb_patch_one
+	 mov		44, %o2
+#endif
+
+#ifdef DCACHE_ALIASING_POSSIBLE
+	sethi		%hi(__flush_dcache_page), %o0
+	or		%o0, %lo(__flush_dcache_page), %o0
+	sethi		%hi(__vii_flush_dcache_page), %o1
+	or		%o1, %lo(__vii_flush_dcache_page), %o1
+	call		tlb_patch_one
+	 mov		3, %o2
+#endif /* DCACHE_ALIASING_POSSIBLE */
+
+	ret
+	 restore
+
+/* VII caches are strongly coherent (VII manual section 8.4.7). */
+#ifdef DCACHE_ALIASING_POSSIBLE
+__vii_flush_dcache_page:
+	membar		#Sync
+	retl
+	 nop
+#endif
+
 	.globl		cheetah_patch_cachetlbops
 cheetah_patch_cachetlbops:
 	save		%sp, -128, %sp
-- 
2.43.0

