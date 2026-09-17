Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718253A7D81
	for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631955; cv=none; b=t8dqj5nbVpETmgd/rfDFzDF5RtcONhfseR8hkEni319BvIw0XZNOkYk1G3u2vyzUQbORMwU3JotBt51PD0ENVst9sEN3rB1fa0cSnEAOi33fG2hRb3zD/Yd0HiSs2RhrLq8eBjaiaGn2WYsCJdI5kIqgXNS7gkY/zS3sBaDPTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631955; c=relaxed/simple;
	bh=7Ik6RNXht4CE7m8csmsavzcBqjTJ804Tukv6a6/SmPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCWopJcFiC+CCK3P7Rv3AkTF1hm2FkARvKq3mz3Oj4XG9UekS7aE/G2Su//HUSqo6yope1NgDWjJ23NSIYlfUX9aSpvYUIXf9V+iXCkF9ZHSaJ5HCHhqVC6D0o+R1K3uIbLMfdqn2PHPkqfoA3OwbhVJxzZ/bpgRfi5T3xSlztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koDBfnii; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koDBfnii"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so83775866b.0
        for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789631951; x=1790236751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xSmWH+6AZu6fZ1/csJcotZOXMdRtqkzNiwAxVzsnuk=;
        b=koDBfniiRAb1SrViwvc2llyeA09meUM4MoTsKp+vGRMsDjg8MEOTf8yxHY9KWgytMu
         uD/ud6Cnxojrsq+KoAnK8KEtXldcxJ+7/noLcmslZZnkcQnJlEm8g8Wg5marGlGsUgeY
         jcXHGpgAPOUXtoApRF1kYi+iTA8fc7Jy2gyJnksTYVRqrxeS6pOXlKCiq9qgzFgkjMPY
         IWXdx3N6rCSBYWelf0X3RdHVr1jV46VXTQ7kkccbyL5hkSlIaEdq6Ej/m+I/Nsq7mYQC
         EdirLI88gYQMvE587tOlAwTyC0EgT+NUWM/op/xLbYsmtTCm8x8XVRYlS5jWoQMzzEBi
         a+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789631951; x=1790236751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xSmWH+6AZu6fZ1/csJcotZOXMdRtqkzNiwAxVzsnuk=;
        b=Bd7PZ9v+KTfx8Xytdg0PnMhQkLxIdtmA8uU4agCxaZjuBmKdL/2Ky82Ba5q3c54Vha
         QTqXChhwGqLPfcilCPVdcQ/JKqYrIHdGUObNsnQEPoKVOF28jT8zX7ZectJIgyRQYyn1
         7iqFTz1IIVQdBJVRJb+bEsNeuGOfG3+C9DUU6jkUUkSu7zpihGkDWTnXhaFDjQT6w/Fs
         2sO2hXYShSI1zDbv7Cz94PR+6/BFqFgmKr61c1SjOjjkIUmb6Son27Bnd37owOSGKbfe
         ePqgOWfSv1mPVHdI3LQUbRj2EjceSIrlNEHDmmY3XGq9jwIdIDVUKfQhLh6MgYAJmG6/
         ueEA==
X-Forwarded-Encrypted: i=1; AKwUvBx1F3QHYD6shVxhT1rEczRWMo4Q+vj/PpEa6wZ+0jlMEZ5ZM/2Ucp1EYjc43N1OSyafe+fbggglWoeu@vger.kernel.org
X-Gm-Message-State: AFuF++l/Bh8S42i1SHefh85e5c4xF7TT9f8dUFPT2yZiAQeGpNAvkJSP
	u82VzW2j0ixBzXyFOI8a9NJ87IAVdRcLExpafMxhKsEMw3+V602YWc0H
X-Gm-Gg: AYBFou2c37t1wn7gbxWaWLVV0zVS8vpD4O9ChT4mGGWsc91vESkx0u3lI884A0YgRLm
	tdPSu1gum/XgsWhyOyzyb/JJpR0LC0zxUdErwG0PAHFHr6NI1fOBALoCDKMByb69ql/jR9hSzI/
	5wuWnfLzjkKAFe8vUlPj7bVPPSIbAOIhvg/+CCe/E8YoN3P9c2QLrdXiBnxSbuhm7flKBfKMZdv
	yYPRgWKhISIUDMAr07XFQQszYrvkpUZix2/MrsLSLgTH8tmr22J/iN6whk8V9xqfOxGfl9GjKzH
	2c/nxvQYEklBt5yhVvCNHdxWzVp9b0+BIep/xlrU1rM6HDB7eMbS6bhFuy8SeLSWIljGvuk8SdJ
	MmMfkPdsuEA+ih+f1+kZLzrfKem7Wv8k1wevjI5omij+FHCz2QkHfl5XeCTH5zuMD1tCPE0nS/1
	qR9tAzYrdPWf046jlxeODZzNY/okpdwz879D0oaBVTIENvWE2cON8bGXY8ckUFwQmX6VkVXnZEn
	2tLbez2U+9kUcDbjQ/n4ugRxNm93znyX1l+x4yNKkJVtMzrpblA
X-Received: by 2002:a17:907:c49a:b0:c25:8e53:45ca with SMTP id a640c23a62f3a-c29e52bf59bmr597546566b.21.1789631951489;
        Thu, 17 Sep 2026 00:59:11 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de453ea0sm250287766b.11.2026.09.17.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:59:11 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v2 2/2] sparc32: synchronize SuperSPARC instruction updates
Date: Thu, 17 Sep 2026 09:57:05 +0200
Message-ID: <20260917075842.784996-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917075842.784996-1-linmag7@gmail.com>
References: <20260917075842.784996-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SuperSPARC keeps its instruction cache coherent by snooping bus
transactions, so no remote processor has to be told about modified
instructions. A FLUSH is still required on the processor that wrote them:
the store buffer is not snooped, so FLUSH is what pushes the new
instructions into the coherent hierarchy, and it clears that processor's
own pipeline and instruction buffer.

Two Viking paths performed no flush at all.

viking_flush_sig_insns() was an empty stub, so it provided no explicit
instruction-update synchronization after the kernel wrote a signal
trampoline. Implement it.

flush_icache_range() was defined as do { } while (0) on sparc32, so it
provided no explicit instruction-update synchronization after the module
loader or a kernel text-modification path wrote executable code. Implement
it for Viking.

Both operations remain local. Hardware snooping maintains instruction-cache
coherence on the other processors, so no remote FLUSH is needed for that
purpose. Retain the existing Viking bypass of the SMP sig_insns wrapper.

Safe execution during a text update is the caller's responsibility. For
example, the module loader calls flush_module_icache() before
complete_formation() and do_init_module(). KGDB normally requests a CPU
roundup before modifying text, but that mechanism has exceptions and a
timeout; it is not an unconditional guarantee that every other CPU is
parked. A later cross-call cannot prevent an old instruction from executing
before it arrives, and cannot by itself make an otherwise unsafe concurrent
text modification safe.

The manual is explicit that FLUSH is not scoped to the address given to it:
"No cached information is explicitly flushed by the instruction ... FLUSH
operations simply cause an exact synchronization of all pending activity"
(section 7.4). One FLUSH therefore covers however many words were written
before it, which is why the two-instruction trampoline needs only one.

This follows SuperSPARC Family User's Manual sections 7.4, Flush (IFLUSH),
and 10.2.5, Instruction Cache Consistency, and SuperSPARC II Addendum
section A.8.2, Store Buffer & Snoops.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/cacheflush_32.h |  2 +-
 arch/sparc/mm/srmmu.c                  | 10 ++++++++++
 arch/sparc/mm/viking.S                 |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

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
index ea0cc3683ad2..093c543b734e 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1784,6 +1784,16 @@ static struct sparc32_cachetlb_ops smp_cachetlb_ops __ro_after_init = {
 };
 #endif
 
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	if (start >= end || poke_srmmu != poke_viking)
+		return;
+
+	/* One local FLUSH synchronizes all preceding instruction stores. */
+	__asm__ __volatile__("flush %0" : : "r" (start) : "memory");
+}
+EXPORT_SYMBOL(flush_icache_range);
+
 /* Load up routines and constants for sun4m and sun4d mmu */
 void __init load_mmu(void)
 {
diff --git a/arch/sparc/mm/viking.S b/arch/sparc/mm/viking.S
index 8b4e251bbba2..92c80426bca6 100644
--- a/arch/sparc/mm/viking.S
+++ b/arch/sparc/mm/viking.S
@@ -201,7 +201,12 @@ viking_flush_tlb_page:
 
 viking_flush_page_to_ram:
 viking_flush_page_for_dma:
+	retl
+	 nop
+
 viking_flush_sig_insns:
+	/* FLUSH is not address scoped here, so one covers both words. */
+	flush	%o1
 	retl
 	 nop
 
-- 
2.43.0

