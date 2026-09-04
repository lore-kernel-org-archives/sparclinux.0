Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990404189DD
	for <sparclinux@vger.kernel.org>; Fri,  4 Sep 2026 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501260; cv=none; b=MUSpl3aA4Hq5higC4Wzf+4oyQxueBxEZ/tQn98MfFyWO9Zrr+iNke5XbYXFeF9tU2lARw5Oo0GEcMUy6DjoDCYaxCZOvDfmEbOSqv+BSBHp3bzqDYfVTckhHjYDoKQYubjlCDOM+UBVOFOeixmOTYYMp+lHW+xB5lZcGeQn6diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501260; c=relaxed/simple;
	bh=gf439ipy8lHAeMJ9F3rjEidACfFu71T5txhISSsUX4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHeHjJWPnMsgVA+huhj+BoFDxOn/YVvHXV/1/a2/R99OiKRvbxhcwVmOkVzfmxoJtIrSPE0ugFe+dtqQMv/HtA8cNBa1Zl6dRwiG7X+Z/2lgkzeapm7Pr6yq3X/pfFPn8QvRQQ6frIHkD5vunT88/q7XKjelmAIT+Z1gFPhwwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKb5jk92; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKb5jk92"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so54152866b.1
        for <sparclinux@vger.kernel.org>; Thu, 03 Sep 2026 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788501257; x=1789106057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DtFHURINp2QDG0NqvpfsgEjNqOA/EnH/sE+PCXtfaZE=;
        b=QKb5jk92dKYb73pJ6lPDF2Y9Pe+9gpMswX4IzJxSx1y3skK0ZAVGyrF89hdI2iTMRy
         RScBRh5TNCn9pW/NZgimCVs48evrHKKK41bZG5O3QDnQFyrgRJ7rdT1J7ExPWS2u3kFt
         f328C0C8mqMAuvHf61fyGQND8atRihCjckrwUGqhlPjnnDLMclV3J1tQO1V/gRzTebg1
         FKFY1KJxtEMqUPxLuXofTmcb8NtjYhVQtmqk+p1HKEKEGoFxBR6wW+hCG40RjWFCFuet
         jc3LF9ZJAnqp6bHG/Uk4e9CAV5rHvCLMFp8D0YXLwuvML+QyNABCvkT6q1mame9ae6P/
         SAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788501257; x=1789106057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DtFHURINp2QDG0NqvpfsgEjNqOA/EnH/sE+PCXtfaZE=;
        b=ezsYZy0Ry970X9oPY9g88d4BEvO6/kDHpeEQHcqlxWzWVK2JLP1fUwQtBF71aD4+rN
         ZZioxSTiw1d6+2G1UGrumTA8u/ySrIcvvMvx2/e/IOLV0nVYz4hRgCwNnvnLKZnuNfqR
         ESSE6fLYH4lDVVTG0QTvBDV+HDoTr+vjKzQRjKhAOPNa2xkWlaExGVFmqoWQ+EBcb0iV
         fagr0FH6q6RHs4D4TDlQq/jd7pPLxCBNMvSFr2JHyKcMjx7nkdDyBcoTMkISZE0rQfxo
         P68RmETbo4PXzsYzbXDKf2TeUgrFzn6r6BXfszzw2rhQkO4Y5ty8wmpPTcQ9BmrtnSRj
         gNRg==
X-Forwarded-Encrypted: i=1; AKwUvByl39NnKbdPw9xpSHcB0vqcte0QfxTVBd94GKQRoD981a2c2r62hRoDtgwsG4I3AhLriM22rCqgMtjb@vger.kernel.org
X-Gm-Message-State: AFuF++nY+LRES11FoT8vBRXpojLr6R9v49fyL+Sxrl+XRWrCzzPXcseu
	hOAAgLwrQ0EGuJSorm1VtojprqIqrSJjSS5uYmWM61KtnJOl9/RTZg7NKPDGAiVf
X-Gm-Gg: AYBFou31aocZ40nmYXrawUiq+FEbpOXA9IYYrN/hSE1PsvWMjHdaSukCnBvACV1BYGD
	yftLc9x2AOyPHTG26MJW23NdXplPsi3vJ1+m2fZswrAmAW56jC6frh2piQJjyEzfKzQEF3mazSX
	5BsGpU7LAz8ywF5ILUzfCFp9hEbULUkuuoPwdO0qPSiQ6WIMs8sFg+2PrR7UHXHeWbwFo+xaYq3
	1ccUWc7PQHU8Sj0oHpPOr8pGOYgSVfC53dEOB7KUyFp55ujFamEFzokCh/86EsQK0QEYjrc/Orb
	qYD0TX85QRU2uszF137KI6ILsmXck3uE0I0YCznTMIgaiVlmB2rq+HbraBgv9T9ln7ePyUlNjOX
	POZHquv6tcdqTa5ZMvkZDpGJ38BnphjzCreqgS+s1l/g5sU622n1cPrA6EBGABJHXAP6atbj7v7
	oAZKtY49S+IVpHpSx5u/sZANaVLu3iF6nrHBVmgZJQPxg+HViCgukT/+NkFzlW6QXG2vMG6OoaX
	9FnRbCJlWFLfkynH1H5r8F+ilPdC/Q=
X-Received: by 2002:a17:907:e00c:10b0:c26:18be:6982 with SMTP id a640c23a62f3a-c2618be6dabmr29853966b.11.1788501256591;
        Thu, 03 Sep 2026 22:54:16 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c01sm55918466b.62.2026.09.03.22.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 22:54:15 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 2/2] sparc32: synchronize SuperSPARC instruction updates
Date: Fri,  4 Sep 2026 07:53:06 +0200
Message-ID: <20260904055359.327050-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904055359.327050-1-linmag7@gmail.com>
References: <20260904055359.327050-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SuperSPARC keeps its instruction cache coherent by snooping bus
transactions, but a FLUSH is still required after modifying instructions.
It drains the local store buffer, completes pending coherency traffic and
clears the local pipeline and instruction buffer. FLUSH affects only the
processor which executes it.

The SuperSPARC II addendum also states that the store buffer cannot be
snooped. The writer's FLUSH is therefore required to make buffered stores
reach the coherent hierarchy before remote processors clear their own
pipelines.

Implement the previously empty Viking signal-instruction operation and
stop bypassing the SMP wrapper. Run a local FLUSH on the writing CPU
before asking remote processors to clear their pipelines.

Also implement the generic flush_icache_range() hook for Viking. The
module loader and kernel text modification paths use this hook after
publishing executable code. One FLUSH on each processor is sufficient:
Viking invalidates instruction-cache entries through hardware snooping,
while FLUSH provides the required store and pipeline synchronization.
The manual is explicit that FLUSH is not scoped to the address given to
it: "No cached information is explicitly flushed by the instruction ...
FLUSH operations simply cause an exact synchronization of all pending
activity" (section 7.4). A single FLUSH per processor therefore covers
however many words were written before it, which is also why the
sig_insns hook above needs only one FLUSH for its two-instruction
trampoline.

This follows SuperSPARC Family User's Manual sections 7.4, Flush
(IFLUSH), and 10.2.5, Instruction Cache Consistency, and SuperSPARC II
Addendum section A.8.2, Store Buffer & Snoops.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/cacheflush_32.h |  2 +-
 arch/sparc/mm/srmmu.c                  | 32 ++++++++++++++++++++++++--
 arch/sparc/mm/viking.S                 |  4 ++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 9fee0ccfccb8..4249663efacc 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -15,7 +15,7 @@
 	sparc32_cachetlb_ops->cache_range(vma, start, end)
 #define flush_cache_page(vma,addr,pfn) \
 	sparc32_cachetlb_ops->cache_page(vma, addr)
-#define flush_icache_range(start, end)		do { } while (0)
+void flush_icache_range(unsigned long start, unsigned long end);
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do {							\
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 3b87e6f53fca..2cf26285e50f 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1816,9 +1816,12 @@ static void smp_flush_page_to_ram(unsigned long page)
 
 static void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
 {
+	preempt_disable();
+	/* Publish the stores before remote CPUs discard prefetched insns. */
+	local_ops->sig_insns(mm, insn_addr);
 	if (any_other_mm_cpus(mm))
 		xc2(local_ops->sig_insns, (unsigned long)mm, insn_addr);
-	local_ops->sig_insns(mm, insn_addr);
+	preempt_enable();
 }
 
 static struct sparc32_cachetlb_ops smp_cachetlb_ops __ro_after_init = {
@@ -1836,6 +1839,32 @@ static struct sparc32_cachetlb_ops smp_cachetlb_ops __ro_after_init = {
 };
 #endif
 
+static void local_viking_flush_icache_range(unsigned long start,
+					    unsigned long end)
+{
+	if (start >= end)
+		return;
+
+	/* Viking snoops the I-cache; FLUSH drains stores and the pipeline. */
+	__asm__ __volatile__("flush %0" : : "r" (start) : "memory");
+}
+
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	if (start >= end || poke_srmmu != poke_viking)
+		return;
+
+	/* Keep the locally flushed CPU as the CPU omitted by the cross-call. */
+	preempt_disable();
+	/* Make the modified instructions visible before flushing remotes. */
+	local_viking_flush_icache_range(start, end);
+#ifdef CONFIG_SMP
+	xc2(local_viking_flush_icache_range, start, end);
+#endif
+	preempt_enable();
+}
+EXPORT_SYMBOL(flush_icache_range);
+
 /* Load up routines and constants for sun4m and sun4d mmu */
 void __init load_mmu(void)
 {
@@ -1868,7 +1897,6 @@ void __init load_mmu(void)
 		smp_cachetlb_ops.cache_page = local_ops->cache_page;
 
 		smp_cachetlb_ops.page_to_ram = local_ops->page_to_ram;
-		smp_cachetlb_ops.sig_insns = local_ops->sig_insns;
 		smp_cachetlb_ops.page_for_dma = local_ops->page_for_dma;
 	}
 
diff --git a/arch/sparc/mm/viking.S b/arch/sparc/mm/viking.S
index 8b4e251bbba2..f8cdd399d26b 100644
--- a/arch/sparc/mm/viking.S
+++ b/arch/sparc/mm/viking.S
@@ -201,7 +201,11 @@ viking_flush_tlb_page:
 
 viking_flush_page_to_ram:
 viking_flush_page_for_dma:
+	retl
+	 nop
+
 viking_flush_sig_insns:
+	flush	%o1
 	retl
 	 nop
 
-- 
2.43.0

