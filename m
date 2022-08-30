Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5ADECAAD4
	for <sparclinux@archiver.kernel.org>; Tue, 30 Aug 2022 20:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiH3U7B (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiH3U7A (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 Aug 2022 16:59:00 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0F8606B
        for <sparclinux@vger.kernel.org>; Tue, 30 Aug 2022 13:58:59 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id c2so12285389plo.3
        for <sparclinux@vger.kernel.org>; Tue, 30 Aug 2022 13:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Qttf07n2bddR56sE1MhSjAvgbGG7hFqx6gi5iqFwmxM=;
        b=C5nwOl5QpvlQqus35yzIR3t6gPmA6CALd54RU/me2Y1yLiOpHGPjc5JPROT8RLNBP9
         UItmBhNSdcuDCkDfN+wcRDwu7LfeIiuPeQmiomfIJnxNdVu4VtExu1s3WhphT0zz2Ydh
         b+lxPfCSxofsshJ+D0hNsX/jUO7P3+RP/glGVgLYlU2jVwjr6ubYCBw40zMyhBQFYNv6
         sWM6wOB9TCbxKBei2tklBeBDW3SsY6QZKGJdjF+OYXibSkwu00dBupICYjRkshpcZclY
         zGy884AUn3J8/pB8D2BK0zuUqhLaGi3nrTuVW5khcYK8RHKFFemLyBmiU9N3eI/hb3tE
         dnQg==
X-Gm-Message-State: ACgBeo2zfSP0W7/J42cBQVNwqXVMaXWya0PlW0lwiRU3wBWxW5K+UBdt
        a/gcCz2gVVOB8IU5LAE3bQI=
X-Google-Smtp-Source: AA6agR6QFWQ0kkHXo7nHjmDwkl7Kb1lC91pUe595qOsfF6EmqPo1jiJ1YRUrXWsd+H1EDAlW2E4/TQ==
X-Received: by 2002:a17:90b:23d0:b0:1fd:af26:cee9 with SMTP id md16-20020a17090b23d000b001fdaf26cee9mr83930pjb.23.1661893138604;
        Tue, 30 Aug 2022 13:58:58 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([12.219.165.6])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709027c8a00b00172f4835f53sm10060061pll.192.2022.08.30.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:58:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] sparc: Unbreak the build
Date:   Tue, 30 Aug 2022 13:58:42 -0700
Message-Id: <20220830205854.1918026-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Fix the following build errors:

arch/sparc/mm/srmmu.c: In function ‘smp_flush_page_for_dma’:
arch/sparc/mm/srmmu.c:1639:13: error: cast between incompatible function types from ‘void (*)(long unsigned int)’ to ‘void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)’ [-Werror=cast-function-type]
 1639 |         xc1((smpfunc_t) local_ops->page_for_dma, page);
      |             ^
arch/sparc/mm/srmmu.c: In function ‘smp_flush_cache_mm’:
arch/sparc/mm/srmmu.c:1662:29: error: cast between incompatible function types from ‘void (*)(struct mm_struct *)’ to ‘void (*)(long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)’ [-Werror=cast-function-type]
 1662 |                         xc1((smpfunc_t) local_ops->cache_mm, (unsigned long) mm);
      |
[ ... ]

Compile-tested only.

Fixes: 552a23a0e5d0 ("Makefile: Enable -Wcast-function-type")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/sparc/include/asm/smp_32.h | 15 ++++++---------
 arch/sparc/kernel/leon_smp.c    | 12 +++++++-----
 arch/sparc/kernel/sun4d_smp.c   | 12 +++++++-----
 arch/sparc/kernel/sun4m_smp.c   | 10 ++++++----
 arch/sparc/mm/srmmu.c           | 29 +++++++++++++----------------
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 856081761b0f..2cf7971d7f6c 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -33,9 +33,6 @@ extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern cpumask_t smp_commenced_mask;
 extern struct linux_prom_registers smp_penguin_ctable;
 
-typedef void (*smpfunc_t)(unsigned long, unsigned long, unsigned long,
-		       unsigned long, unsigned long);
-
 void cpu_panic(void);
 
 /*
@@ -57,7 +54,7 @@ void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
 struct sparc32_ipi_ops {
-	void (*cross_call)(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+	void (*cross_call)(void *func, cpumask_t mask, unsigned long arg1,
 			   unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4);
 	void (*resched)(int cpu);
@@ -66,28 +63,28 @@ struct sparc32_ipi_ops {
 };
 extern const struct sparc32_ipi_ops *sparc32_ipi_ops;
 
-static inline void xc0(smpfunc_t func)
+static inline void xc0(void *func)
 {
 	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, 0, 0, 0, 0);
 }
 
-static inline void xc1(smpfunc_t func, unsigned long arg1)
+static inline void xc1(void *func, unsigned long arg1)
 {
 	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, 0, 0, 0);
 }
-static inline void xc2(smpfunc_t func, unsigned long arg1, unsigned long arg2)
+static inline void xc2(void *func, unsigned long arg1, unsigned long arg2)
 {
 	sparc32_ipi_ops->cross_call(func, *cpu_online_mask, arg1, arg2, 0, 0);
 }
 
-static inline void xc3(smpfunc_t func, unsigned long arg1, unsigned long arg2,
+static inline void xc3(void *func, unsigned long arg1, unsigned long arg2,
 		       unsigned long arg3)
 {
 	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
 				    arg1, arg2, arg3, 0);
 }
 
-static inline void xc4(smpfunc_t func, unsigned long arg1, unsigned long arg2,
+static inline void xc4(void *func, unsigned long arg1, unsigned long arg2,
 		       unsigned long arg3, unsigned long arg4)
 {
 	sparc32_ipi_ops->cross_call(func, *cpu_online_mask,
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1eed26d423fb..991e9ad3d3e8 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -359,7 +359,7 @@ void leonsmp_ipi_interrupt(void)
 }
 
 static struct smp_funcall {
-	smpfunc_t func;
+	void *func;
 	unsigned long arg1;
 	unsigned long arg2;
 	unsigned long arg3;
@@ -372,7 +372,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void leon_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 			    unsigned long arg2, unsigned long arg3,
 			    unsigned long arg4)
 {
@@ -384,7 +384,7 @@ static void leon_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 
 		{
 			/* If you make changes here, make sure gcc generates proper code... */
-			register smpfunc_t f asm("i0") = func;
+			register void *f asm("i0") = func;
 			register unsigned long a1 asm("i1") = arg1;
 			register unsigned long a2 asm("i2") = arg2;
 			register unsigned long a3 asm("i3") = arg3;
@@ -444,11 +444,13 @@ static void leon_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 /* Running cross calls. */
 void leon_cross_call_irq(void)
 {
+	void (*func)(unsigned long, unsigned long, unsigned long, unsigned long,
+		     unsigned long) = ccall_info.func;
 	int i = smp_processor_id();
 
 	ccall_info.processors_in[i] = 1;
-	ccall_info.func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3,
-			ccall_info.arg4, ccall_info.arg5);
+	func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3, ccall_info.arg4,
+	     ccall_info.arg5);
 	ccall_info.processors_out[i] = 1;
 }
 
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index ff30f03beb7c..9a62a5cf3337 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -268,7 +268,7 @@ static void sun4d_ipi_resched(int cpu)
 }
 
 static struct smp_funcall {
-	smpfunc_t func;
+	void *func;
 	unsigned long arg1;
 	unsigned long arg2;
 	unsigned long arg3;
@@ -281,7 +281,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void sun4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -296,7 +296,7 @@ static void sun4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 			 * If you make changes here, make sure
 			 * gcc generates proper code...
 			 */
-			register smpfunc_t f asm("i0") = func;
+			register void *f asm("i0") = func;
 			register unsigned long a1 asm("i1") = arg1;
 			register unsigned long a2 asm("i2") = arg2;
 			register unsigned long a3 asm("i3") = arg3;
@@ -353,11 +353,13 @@ static void sun4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 /* Running cross calls. */
 void smp4d_cross_call_irq(void)
 {
+	void (*func)(unsigned long, unsigned long, unsigned long, unsigned long,
+		     unsigned long) = ccall_info.func;
 	int i = hard_smp_processor_id();
 
 	ccall_info.processors_in[i] = 1;
-	ccall_info.func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3,
-			ccall_info.arg4, ccall_info.arg5);
+	func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3, ccall_info.arg4,
+	     ccall_info.arg5);
 	ccall_info.processors_out[i] = 1;
 }
 
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 228a6527082d..056df034e79e 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -157,7 +157,7 @@ static void sun4m_ipi_mask_one(int cpu)
 }
 
 static struct smp_funcall {
-	smpfunc_t func;
+	void *func;
 	unsigned long arg1;
 	unsigned long arg2;
 	unsigned long arg3;
@@ -170,7 +170,7 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-static void sun4m_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
+static void sun4m_cross_call(void *func, cpumask_t mask, unsigned long arg1,
 			     unsigned long arg2, unsigned long arg3,
 			     unsigned long arg4)
 {
@@ -230,11 +230,13 @@ static void sun4m_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 /* Running cross calls. */
 void smp4m_cross_call_irq(void)
 {
+	void (*func)(unsigned long, unsigned long, unsigned long, unsigned long,
+		     unsigned long) = ccall_info.func;
 	int i = smp_processor_id();
 
 	ccall_info.processors_in[i] = 1;
-	ccall_info.func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3,
-			ccall_info.arg4, ccall_info.arg5);
+	func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3, ccall_info.arg4,
+	     ccall_info.arg5);
 	ccall_info.processors_out[i] = 1;
 }
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a9aa6a92c7fe..13f027afc875 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1636,19 +1636,19 @@ static void __init get_srmmu_type(void)
 /* Local cross-calls. */
 static void smp_flush_page_for_dma(unsigned long page)
 {
-	xc1((smpfunc_t) local_ops->page_for_dma, page);
+	xc1(local_ops->page_for_dma, page);
 	local_ops->page_for_dma(page);
 }
 
 static void smp_flush_cache_all(void)
 {
-	xc0((smpfunc_t) local_ops->cache_all);
+	xc0(local_ops->cache_all);
 	local_ops->cache_all();
 }
 
 static void smp_flush_tlb_all(void)
 {
-	xc0((smpfunc_t) local_ops->tlb_all);
+	xc0(local_ops->tlb_all);
 	local_ops->tlb_all();
 }
 
@@ -1659,7 +1659,7 @@ static void smp_flush_cache_mm(struct mm_struct *mm)
 		cpumask_copy(&cpu_mask, mm_cpumask(mm));
 		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 		if (!cpumask_empty(&cpu_mask))
-			xc1((smpfunc_t) local_ops->cache_mm, (unsigned long) mm);
+			xc1(local_ops->cache_mm, (unsigned long)mm);
 		local_ops->cache_mm(mm);
 	}
 }
@@ -1671,7 +1671,7 @@ static void smp_flush_tlb_mm(struct mm_struct *mm)
 		cpumask_copy(&cpu_mask, mm_cpumask(mm));
 		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 		if (!cpumask_empty(&cpu_mask)) {
-			xc1((smpfunc_t) local_ops->tlb_mm, (unsigned long) mm);
+			xc1(local_ops->tlb_mm, (unsigned long)mm);
 			if (atomic_read(&mm->mm_users) == 1 && current->active_mm == mm)
 				cpumask_copy(mm_cpumask(mm),
 					     cpumask_of(smp_processor_id()));
@@ -1691,8 +1691,8 @@ static void smp_flush_cache_range(struct vm_area_struct *vma,
 		cpumask_copy(&cpu_mask, mm_cpumask(mm));
 		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 		if (!cpumask_empty(&cpu_mask))
-			xc3((smpfunc_t) local_ops->cache_range,
-			    (unsigned long) vma, start, end);
+			xc3(local_ops->cache_range, (unsigned long)vma, start,
+			    end);
 		local_ops->cache_range(vma, start, end);
 	}
 }
@@ -1708,8 +1708,8 @@ static void smp_flush_tlb_range(struct vm_area_struct *vma,
 		cpumask_copy(&cpu_mask, mm_cpumask(mm));
 		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 		if (!cpumask_empty(&cpu_mask))
-			xc3((smpfunc_t) local_ops->tlb_range,
-			    (unsigned long) vma, start, end);
+			xc3(local_ops->tlb_range, (unsigned long)vma, start,
+			    end);
 		local_ops->tlb_range(vma, start, end);
 	}
 }
@@ -1723,8 +1723,7 @@ static void smp_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
 		cpumask_copy(&cpu_mask, mm_cpumask(mm));
 		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 		if (!cpumask_empty(&cpu_mask))
-			xc2((smpfunc_t) local_ops->cache_page,
-			    (unsigned long) vma, page);
+			xc2(local_ops->cache_page, (unsigned long)vma, page);
 		local_ops->cache_page(vma, page);
 	}
 }
@@ -1738,8 +1737,7 @@ static void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 		cpumask_copy(&cpu_mask, mm_cpumask(mm));
 		cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 		if (!cpumask_empty(&cpu_mask))
-			xc2((smpfunc_t) local_ops->tlb_page,
-			    (unsigned long) vma, page);
+			xc2(local_ops->tlb_page, (unsigned long)vma, page);
 		local_ops->tlb_page(vma, page);
 	}
 }
@@ -1753,7 +1751,7 @@ static void smp_flush_page_to_ram(unsigned long page)
 	 * XXX This experiment failed, research further... -DaveM
 	 */
 #if 1
-	xc1((smpfunc_t) local_ops->page_to_ram, page);
+	xc1(local_ops->page_to_ram, page);
 #endif
 	local_ops->page_to_ram(page);
 }
@@ -1764,8 +1762,7 @@ static void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
 	cpumask_copy(&cpu_mask, mm_cpumask(mm));
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 	if (!cpumask_empty(&cpu_mask))
-		xc2((smpfunc_t) local_ops->sig_insns,
-		    (unsigned long) mm, insn_addr);
+		xc2(local_ops->sig_insns, (unsigned long)mm, insn_addr);
 	local_ops->sig_insns(mm, insn_addr);
 }
 
