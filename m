Received: from mail-ej2-f40.google.com (mail-ej2-f40.google.com [74.125.228.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F14E3259
	for <sparclinux@vger.kernel.org>; Fri,  2 Oct 2026 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957802; cv=none; b=Xu+S/JIHTvXhqrQl+s6FeQm/tPNVlzWaJYn01qF7Z06sFlP9WI/UAxfuMeBL4iFUfXKfIO/aHmoXybCucRDyE62aZYdi82RTNTaFLrn1MaNXrVvUlQKqKI4QM/Im3LCcoeNZaG7xhuM/e4MzCiiEPpUWsjEzsqwOQqJ+g+4DODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957802; c=relaxed/simple;
	bh=sdU6+MEgN/AXXVvfv9f5jsVvXam6p7dAAp0Oj9mvtxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt8nBsOpT8IonGWSyTNsp1b0/icjdjRJJ10CLe1+5m+qi1qrTimRwcEgYsVIT7AZgziBB0lPsMgCQKA1ZJ6WQDPGaloTzhNTFfxLNOQ2DTf+/WrfT0p7v7QxMA9YuYnXx6HVLkc4toCowIigjUBwCByJlD3hATlYABQton0t1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kla3uzfW; arc=none smtp.client-ip=74.125.228.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kla3uzfW"
Received: by mail-ej2-f40.google.com with SMTP id a640c23a62f3a-c2e417a5a81so11119766b.3
        for <sparclinux@vger.kernel.org>; Fri, 02 Oct 2026 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957797; x=1791562597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/uhsmKwVD0R6owh25OCYS7ZMsd6I91VxDlBXicP0uY=;
        b=Kla3uzfWKxgi32MfKs4k2kSYnOBFSl2kFFCFOrepGAoOpii412pC91P8aU0iRpejgf
         DwmLaNc+pgANbn0QtAXvSdFTcfLnRhDTxomPS8B9uJtayfFWX3YOt1a1Yv6DjalzJf2A
         NsWW92xAyZBbhNSjyimUqpk2xxhMpZIH8iidz1JXATMykyXFAY6tKH5YOy/wwK54IYCY
         ZuZw1gh3/5cfiK735m52lk5/MHC6BFB4sRAegl4xc/T0+NbAlc+1NF90XfPYwEye3JjT
         jPs1xq7I9xpoClbqoXlYJj5iLjUEpVE7ipEYdOWBX0n9N7ti2+GRuz3qqfUAwVmU+ewK
         pTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957797; x=1791562597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B/uhsmKwVD0R6owh25OCYS7ZMsd6I91VxDlBXicP0uY=;
        b=RIqq3P6FRqhFEkVxePVkUu3c0lHLnGQrAYWPMRaMxDlTU/EjXs5EUZFmjpBt22/EUA
         ubv8HTZ+LdMgWh8gOq2ReQ9iayZKevAByAQaHdfANkc2UvlixgbWSXrWOit8ilBYfUUU
         LwzLzQi1HvO0T7ZCdjYYxLkHtGGhB0MNX3Pw3wMhm+ErB0y0VGqaxymTD5SJLDpca2X0
         o7KWFK0u1VqdYFk2mb8iGMEI9P6Gv/WEYb1Q+o69A86pEMKB1x9qpaqUSVJxv0Xhhgtw
         xtM8Fbe2xY9BmUH9FBB4nhxEdjpgUpqJmAdQuR/+CF5DW4VbFILSxy3E1Bg2Rl9unFzM
         80NQ==
X-Gm-Message-State: AFuF++lHnM1CaBjnwxkTwhE0G6SpBALCUJTlx4UuspeFxArbuUUHWqyD
	S7PjfS0WXgIEXFVqAnPCeDdkfQhIxFVaK54JBDCva5VMiG0kGUT3Gc6IBNACeWcb
X-Gm-Gg: AYBFou10luIEyEpbtsmAHBZe+rAkvcLOyT8ZNpn2/uU0ryAbznGldWZI+wC9yFpJng4
	XBzedxG/9TwXoYzNETVV/VuqPLPtPYMEXOYKopmVrci+2U6+rBmJgmdcSRdAteiXxcyGKbmZbgo
	ZpKIXu5iFTJRBNqQgywvfl5nA6AKXR37BHoDaX9Uq6FCJfdNfnEStLoWAlPigcMdN5+iM9AG3yc
	1IGax8M3v/bhjwdpPifPUwPMtiJaTb+oXrphu9vHvj0rs7Xo4LCp8dOCxsj7VbA59x0E9hbYsoZ
	QsNYAceFqDVi1eDWzr4GtzhU8su61FE99GKtgiIh6+3o09BvTTd4mTMGdnvJkyyR2eazZfxguBX
	/6S2v6Jg5CW8Q+rixdWcYdWSreXrJmEshm33R1VXLviNyiMoY8YBQ9/e3No3RY5F6lcZfnLXLZr
	vi1IDczVU50y5vV3Rr3w+c0dATgWgYzRy7XlNiPkhknBaQCjcyCA2zOoU0BULR39b2IzsMULFD9
	6YXfm9UHE6NhTS4faUsGIruSEhmJO62mhaa9VENGB1zggRW33s=
X-Received: by 2002:a17:907:7286:b0:c2e:4292:d27e with SMTP id a640c23a62f3a-c2e4ad73044mr258624866b.22.1790957797085;
        Fri, 02 Oct 2026 09:16:37 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5f4e4sm106437166b.42.2026.10.02.09.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:16:35 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 4/7] sparc64: add SPARC64 VII CPU, MMU and SMP support
Date: Fri,  2 Oct 2026 18:14:26 +0200
Message-ID: <20261002161515.932316-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002161515.932316-1-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recognize implementation 7 and add the M3000 CPU/MMU/SMP path, including
topology, serialized interrupt dispatch and restrainable ECC handling.
Use physical TSB accesses to avoid sibling aliases in the shared TLB;
synchronize context writes and instruction demaps while preserving
supported firmware modes and the existing non-VII demap routines.
CPU offlining, HugeTLB and THP remain unsupported on this path.
Keep VII demap routines separate: similar Cheetah assembly does not
establish the same hardware synchronization requirement on Cheetah.

Hardware references (printed sections/pages):
- SPARC64 VII Extensions v1.0: 8.4.7 pp.42-43 (coherence), A.30 pp.64-65
  (physical loads), F.10 pp.109-110 (MCNTL), F.10.4 (indexed TLBs),
  F.12 p.129 (sibling sharing).
- VII N.1 pp.155-156, N.4.2/N.4.3 p.158, R.3 (IPIs/target IDs);
  P.3.1 and P.7.1/P.7.4 pp.198-200 (error registers).
- JPS2 Common r1.0 F.10.1 p.488, F.10.11 pp.500-502 (MMU ordering).

JPS2 Commonality F.10.1 also requires a final instruction flush after
demap-all so subsequent instruction fetches observe the invalidation.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/Kconfig                  |  10 ++
 arch/sparc/include/asm/head_64.h    |  15 ++
 arch/sparc/include/asm/setup.h      |   5 +
 arch/sparc/include/asm/smp_64.h     |   4 +
 arch/sparc/include/asm/spitfire.h   |   1 +
 arch/sparc/include/asm/trap_block.h |   6 +
 arch/sparc/kernel/cpu.c             |   3 +
 arch/sparc/kernel/entry.h           |   2 +
 arch/sparc/kernel/head_64.S         |  18 +++
 arch/sparc/kernel/helpers.S         |  41 +++++
 arch/sparc/kernel/prom_64.c         |   6 +
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  55 +++++++
 arch/sparc/kernel/smp_64.c          |  82 +++++++++-
 arch/sparc/kernel/trampoline_64.S   |  19 +++
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/mm/init_64.c             | 102 +++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 19 files changed, 642 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ab77d3f2536e..1263150a5702 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -250,6 +250,16 @@ config US3_MC
 
 	  If in doubt, say Y, as this information can be very useful.
 
+config SPARC64_VII
+	bool "Fujitsu SPARC64 VII and VII+ support"
+	depends on SPARC64
+	depends on !HUGETLB_PAGE && !TRANSPARENT_HUGEPAGE
+	help
+	  Support SPARC64 VII and VII+ processors in the Fujitsu M3000.
+	  Firmware must leave context hashing and multiple-page-size
+	  context mode disabled. HugeTLB and transparent huge pages are
+	  not supported by this CPU path.
+
 # Global things across all Sun machines.
 config GENERIC_LOCKBREAK
 	bool
diff --git a/arch/sparc/include/asm/head_64.h b/arch/sparc/include/asm/head_64.h
index 69a2062d992c..62ea826f174b 100644
--- a/arch/sparc/include/asm/head_64.h
+++ b/arch/sparc/include/asm/head_64.h
@@ -20,6 +20,21 @@
 #define	RTRAP_PSTATE_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV)
 #define RTRAP_PSTATE_AG_IRQOFF	(PSTATE_TSO|PSTATE_PEF|PSTATE_PRIV|PSTATE_AG)
 
+#define __SPARC64_VII_ID 0x00040007
+
+#ifdef CONFIG_SPARC64_VII
+#define BRANCH_IF_SPARC64_VII(tmp1, tmp2, label) \
+	rdpr %ver, %tmp1; \
+	srlx %tmp1, 32, %tmp1; \
+	sethi %hi(__SPARC64_VII_ID), %tmp2; \
+	or %tmp2, %lo(__SPARC64_VII_ID), %tmp2; \
+	cmp %tmp1, %tmp2; \
+	be,pn %icc, label; \
+	 nop
+#else
+#define BRANCH_IF_SPARC64_VII(tmp1, tmp2, label)
+#endif
+
 #define __CHEETAH_ID	0x003e0014
 #define __JALAPENO_ID	0x003e0016
 #define __SERRANO_ID	0x003e0022
diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 21bed5514028..ef6ff1169ec0 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -49,6 +49,11 @@ unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
 #ifdef CONFIG_SPARC64
 void __init start_early_boot(void);
 
+extern unsigned int sparc64_ttable_tl0[], sparc64_ttable_tl1[];
+void sparc64_vii_fatal_trap(void);
+void sparc64_vii_ecc_trap(void);
+void sparc64_vii_ecc_trap_tl1(void);
+
 /* unaligned_64.c */
 int handle_ldf_stq(u32 insn, struct pt_regs *regs);
 void handle_ld_nf(u32 insn, struct pt_regs *regs);
diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 759fb4a9530e..bbf171c9d1e9 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -34,6 +34,10 @@
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
 extern cpumask_t cpu_core_map[NR_CPUS];
 
+#ifdef CONFIG_SPARC64_VII
+extern unsigned long vii_startup_mcntl;
+#endif
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
index 79cd6ccfeac0..015bf4e5ca10 100644
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
@@ -132,6 +133,7 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		CPU(3, "Texas Instruments, Inc. - SuperSparc 51"),
 		CPU(4, "Texas Instruments, Inc. - SuperSparc 61"),
 		CPU(5, "Texas Instruments, Inc. - unknown"),
+		CPU(7, "Fujitsu SPARC64 VII / VII+"),
 		CPU(-1, NULL)
 	},
 	.fpu_info = {
@@ -139,6 +141,7 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		FPU(0, "SuperSparc on-chip FPU"),
 		/* SparcClassic */
 		FPU(4, "TI MicroSparc on chip FPU"),
+		FPU(7, "Fujitsu SPARC64 VII integrated FPU"),
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
index cf0549134234..8f879abc07f0 100644
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
@@ -692,6 +695,20 @@ cheetah_tlb_fixup:
 
 	ba,a,pt	%xcc, tlb_fixup_done
 
+sparc64_vii_tlb_fixup:
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
@@ -841,6 +858,7 @@ setup_trap_table:
 	sllx	%o2, 32, %o2
 	wr	%o2, 0, %tick_cmpr
 
+	BRANCH_IF_SPARC64_VII(o2, o3, 1f)
 	BRANCH_IF_ANY_CHEETAH(o2, o3, 1f)
 
 	ba,a,pt	%xcc, 2f
diff --git a/arch/sparc/kernel/helpers.S b/arch/sparc/kernel/helpers.S
index 9b3f74706cfb..da5467db2de3 100644
--- a/arch/sparc/kernel/helpers.S
+++ b/arch/sparc/kernel/helpers.S
@@ -64,3 +64,44 @@ real_hard_smp_processor_id:
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
+	sethi %hi(0x56494900), %g2
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
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index aa4799cbb9c1..11437bbfc73b 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -564,6 +564,12 @@ static void *fill_in_one_cpu(struct device_node *dp, int cpuid, int arg)
 
 		cpu_data(cpuid).core_id = portid + 1;
 		cpu_data(cpuid).proc_id = portid;
+		if (tlb_type == sparc64_vii &&
+		    of_property_match_string(of_root, "model", "IKKAKU") >= 0) {
+			/* IKKAKU: two adjacent ITIDs per physical core. */
+			cpu_data(cpuid).core_id = (cpuid >> 1) + 1;
+			cpu_data(cpuid).proc_id = 0;
+		}
 	} else {
 		cpu_data(cpuid).dcache_size =
 			of_getintprop_default(dp, "dcache-size", 16 * 1024);
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
index 63615f5c99b4..0f1187fc775f 100644
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
@@ -349,6 +352,40 @@ static void __init pause_patch(void)
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
+			if (delta < -(1L << 23) || delta >= (1L << 23))
+				prom_halt();
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
@@ -358,6 +395,24 @@ void __init start_early_boot(void)
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
+		 * No context hashing, forced uncached instruction caching or
+		 * multiple-page-size context mode is supported by this path.
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
index 371460e34484..9717836bf441 100644
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
@@ -344,6 +343,11 @@ extern unsigned long sparc64_cpu_startup;
  */
 static struct thread_info *cpu_new_thread = NULL;
 
+#ifdef CONFIG_SPARC64_VII
+/* Written before the secondary validates its inherited MMU control. */
+unsigned long vii_startup_mcntl;
+#endif
+
 static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long entry =
@@ -354,6 +358,10 @@ static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 	int timeout, ret;
 
 	callin_flag = 0;
+#ifdef CONFIG_SPARC64_VII
+	if (tlb_type == sparc64_vii)
+		WRITE_ONCE(vii_startup_mcntl, ~0UL);
+#endif
 	cpu_new_thread = task_thread_info(idle);
 
 	if (tlb_type == hypervisor) {
@@ -381,6 +389,11 @@ static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 		ret = 0;
 	} else {
 		printk("Processor %d is stuck.\n", cpu);
+#ifdef CONFIG_SPARC64_VII
+		if (tlb_type == sparc64_vii)
+			pr_err("VII secondary CPU %u MCNTL=%lx (all ones: not reached)\n",
+			       cpu, READ_ONCE(vii_startup_mcntl));
+#endif
 		ret = -ENODEV;
 	}
 	cpu_new_thread = NULL;
@@ -390,6 +403,55 @@ static int smp_boot_one_cpu(unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
+/*
+ * VII manual Appendix N: dispatch using BUSY/NACK pair zero, one target
+ * at a time. No Spitfire UDB erratum access and no hypervisor operation.
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
@@ -1205,7 +1267,9 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 void __init smp_setup_processor_id(void)
 {
-	if (tlb_type == spitfire)
+	if (tlb_type == sparc64_vii)
+		xcall_deliver_impl = vii_xcall_deliver;
+	else if (tlb_type == spitfire)
 		xcall_deliver_impl = spitfire_xcall_deliver;
 	else if (tlb_type == cheetah || tlb_type == cheetah_plus)
 		xcall_deliver_impl = cheetah_xcall_deliver;
@@ -1256,8 +1320,14 @@ void smp_fill_in_sib_core_maps(void)
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
@@ -1326,6 +1396,10 @@ int __cpu_disable(void)
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
index 62f404b3079a..73838a021be6 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -40,6 +40,7 @@ tramp_stack:
 	.align		8
 	.globl		sparc64_cpu_startup, sparc64_cpu_startup_end
 sparc64_cpu_startup:
+	BRANCH_IF_SPARC64_VII(g1, g5, vii_startup)
 	BRANCH_IF_SUN4V(g1, niagara_startup)
 	BRANCH_IF_CHEETAH_BASE(g1, g5, cheetah_startup)
 	BRANCH_IF_CHEETAH_PLUS_OR_FOLLOWON(g1, g5, cheetah_plus_startup)
@@ -47,6 +48,23 @@ sparc64_cpu_startup:
 	ba,pt	%xcc, spitfire_startup
 	 nop
 
+#ifdef CONFIG_SPARC64_VII
+vii_startup:
+	/* Preserve firmware cache/MMU control, as on the boot CPU. */
+	mov		8, %g1
+	ldxa		[%g1] 0x45, %g5
+	sethi		%hi(vii_startup_mcntl), %g1
+	stx		%g5, [%g1 + %lo(vii_startup_mcntl)]
+	membar		#Sync
+	set		0x101c0, %g1
+	andcc		%g5, %g1, %g0
+1:	bne,pn		%xcc, 1b
+	 nop
+	ba,pt		%xcc, niagara_startup
+	 nop
+
+#endif /* CONFIG_SPARC64_VII */
+
 cheetah_plus_startup:
 	/* Preserve OBP chosen DCU and DCR register settings.  */
 	ba,pt	%xcc, cheetah_generic_startup
@@ -144,6 +162,7 @@ startup_continue:
 	lduw		[%l6 + %lo(num_kernel_image_mappings)], %l6
 
 	mov		15, %l7
+	BRANCH_IF_SPARC64_VII(g1,g5,2f)
 	BRANCH_IF_ANY_CHEETAH(g1,g5,2f)
 
 	mov		63, %l7
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
index 0ae97e616435..4918afdcc923 100644
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
@@ -495,6 +496,12 @@ EXPORT_SYMBOL(flush_dcache_folio);
 
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
@@ -530,6 +537,8 @@ void mmu_info(struct seq_file *m)
 		seq_printf(m, "MMU Type\t: Cheetah\n");
 	else if (tlb_type == cheetah_plus)
 		seq_printf(m, "MMU Type\t: Cheetah+\n");
+	else if (tlb_type == sparc64_vii)
+		seq_puts(m, "MMU Type\t: Fujitsu SPARC64 VII\n");
 	else if (tlb_type == spitfire)
 		seq_printf(m, "MMU Type\t: Spitfire\n");
 	else if (tlb_type == hypervisor)
@@ -666,6 +675,50 @@ static void __init hypervisor_tlb_lock(unsigned long vaddr,
 
 static unsigned long kern_large_tte(unsigned long paddr);
 
+/*
+ * Reserve two 4MB kernel mappings and an adjacent slot in the lower half
+ * of the fully associative bank. Check existing reservations, firmware
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
+	for (i = 15 - num_kernel_image_mappings; i <= 15; i++) {
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
+	unsigned long mask = _PAGE_VALID | _PAGE_SZ4MB_4U |
+		_PAGE_PADDR_4U | _PAGE_L_4U;
+	unsigned long d = cheetah_get_ldtlb_data(slot);
+	unsigned long t = cheetah_get_litlb_data(slot);
+	unsigned long dt = cheetah_get_ldtlb_tag(slot);
+	unsigned long it = cheetah_get_litlb_tag(slot);
+
+	if ((d & mask) != (tte & mask) || (t & mask) != (tte & mask) ||
+	    dt != va || it != va) {
+		prom_printf("VII-BOOT: mapping readback mismatch; halted\n");
+		prom_halt();
+	}
+}
+
 static void __init remap_kernel(void)
 {
 	unsigned long phys_page, tte_vaddr, tte_data;
@@ -677,6 +730,9 @@ static void __init remap_kernel(void)
 
 	kern_locked_tte_data = tte_data;
 
+	if (tlb_type == sparc64_vii)
+		vii_check_slots();
+
 	/* Now lock us into the TLBs via Hypervisor or OBP. */
 	if (tlb_type == hypervisor) {
 		for (i = 0; i < num_kernel_image_mappings; i++) {
@@ -687,8 +743,22 @@ static void __init remap_kernel(void)
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
@@ -724,6 +794,11 @@ void __flush_dcache_range(unsigned long start, unsigned long end)
 {
 	unsigned long va;
 
+	if (tlb_type == sparc64_vii) {
+		__asm__ __volatile__("membar #Sync" : : : "memory");
+		return;
+	}
+
 	if (tlb_type == spitfire) {
 		int n = 0;
 
@@ -2347,7 +2422,8 @@ void __init paging_init(void)
 	else
 		sun4u_pgprot_init();
 
-	if (tlb_type == cheetah_plus ||
+	/* VII supports ASI_QUAD_LDD_PHYS (0x34); avoid shared-TLB TSB aliases. */
+	if (tlb_type == cheetah_plus || tlb_type == sparc64_vii ||
 	    tlb_type == hypervisor) {
 		tsb_phys_patch();
 		ktsb_phys_patch();
@@ -2369,6 +2445,15 @@ void __init paging_init(void)
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
@@ -2402,7 +2487,7 @@ void __init paging_init(void)
 	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
 
 	inherit_prom_mappings();
-	
+
 	/* Ok, we can use our TLB miss and window trap handlers safely.  */
 	setup_tba();
 
@@ -2813,9 +2898,14 @@ void __flush_tlb_all(void)
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
index 70e658d107e0..c4a9647d6eb0 100644
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
+	/* VII uses 32-entry fTLBs: do not use the Spitfire 64-slot sweep. */
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

