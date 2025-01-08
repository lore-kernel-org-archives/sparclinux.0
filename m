Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893881A0739
	for <sparclinux@vger.kernel.org>; Wed,  8 Jan 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319637; cv=none; b=O/RML5ejvtGkTGTyJziC5b97uqq0O0BDM0dtiQfSytAfvyA4+5dAh+JJqoW4059/ODqIHr7zzv4Y09jiBosc1iSz6uOhMR1vlbsZ49snjHCvdTof97GFmn0ESJ5qVLM/BqS2n19OaFg0upWcjh3/0DTFJ/21kG8hFD6PFLosgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319637; c=relaxed/simple;
	bh=8PYWh2+orWwYf6986S1qPEzSyDMn0jEmjPeP/Gs1msM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9Z6BZI5FqlbYUN1Hh6PmZA4E5xQO1unyBsRkCPUikEeCMU01sgniitmxpNTO39DKwob0G/xmLNxZR06oHxfWn875NqgLwqim0fFgRUqzGtGvyi2XGriQWtn6o5BOSyAmyl2Y5VoBolOtIcBlZk1YPmCxw+VQ7/RZzIAS63S30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D36doFD2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D36doFD2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21654fdd5daso225077615ad.1
        for <sparclinux@vger.kernel.org>; Tue, 07 Jan 2025 23:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319635; x=1736924435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=D36doFD2eeEmR2bn6CJX8f5wpGnEPnzm3By1w8nWkBeMfXzl3kPPwr4mbqOkXEZhov
         VrwoHhOaSlU+az/WyLPiDSwtFodV/d7k98qHBI47BBbBmYjGz7mLnhwnUKtd9lRrnBFi
         bhczabQP8GmoHfwUxnHtM0Vh0K7nIolVZ4keO6qU+QqCEJjqJ1t+1kgiuPAylWLj3lf7
         OYlKkbHZQNSSaIU8ju8jUadGcCbCbdPcu1WPO2WK/TdX0ptilPW+h759vInIarzE90sV
         78hM/2Eyh7svckrSCheuAzoM3IR2SdV33HEvReFeV1KYoQqUzwFE4/vjdTllVFU7wCtY
         0s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319635; x=1736924435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=jUIsofl7BhdeOil2S0u5yTGr7bJQETFtgw060gi1AVNPKq9c1l1tjMHFX8/lOmx2mJ
         tvfm0DE1e8CgxWFlP6wollO+Dw9kZWqP4BjSen1xvkCklT2AwM7TIe9CnBJvmVwJ47aI
         K1kVGHiEtOApyAcYLCWKhOqLESvMJzYc5RWghsmtJVA33FqJLwJD2GOALf7CZuqODta2
         jkqYzUfuDJUWrMQhDsuWO21NtZSsfmAjoDRqz/bQCH9lxJoQ1JlRsWfhVmXFwRsIcmjS
         ZQhBo1b84/GyrfNL8Swr6wxmyWp7X5t50LGjTNROpvLXOKE7AwESeLKxRCCNZ7O47m6x
         F6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdv05l/jiruBwl/nSKdZqfxutdSsqOU9VnCPasNmswZdM6Fx5Qd+gipIEHwCZ8EbZtH7fWzJ8/ZEGV@vger.kernel.org
X-Gm-Message-State: AOJu0YxAN6AMKgESJNoQpu8C725GSy411PuA9ytkSH3aqpsDiPnmzOCT
	o7WZSfOaQ/tdmgHtyIxNcn8culCPVIZu1Vv5hWucIqLBIhEUXMSD8YS9OYps1T8=
X-Gm-Gg: ASbGncv7HYqkKX2ODGKxeQxTG1ttaLBW67ve8E6VHSIPFqc6v0hZHA5JggaxgZPHZk3
	NLb9Kw7yLvEDcZ/FSdsaQzhzfZ9K+pbtEMfEoAVQaBBH3Rrz4R40JWWkBb+MXrMOYHIDDQ7IqIR
	VVnJOibjCjLye7v6GCKjw4kMVPkEFPczHUJYb8zib+uRCqfDYOkjiB4zMM9wMMuuv/e4iowX6UG
	ewnBeeU1enFKCozeiJSgy50Z/CZo2INztQM7Vvx9nmygwJT+KO5H/7MI31Ec1LMMtG7kh+Mm/QS
	iqSo1oIwmxVcdcAv4qNnvEA0KVo=
X-Google-Smtp-Source: AGHT+IFQatZJEh1vMaYN2M2lTtxd4TB3DgwS5fDlIHVUeP0cQjVCzCSP2sGAFE7qJT7hKS5hKn1bKA==
X-Received: by 2002:a17:902:d4d2:b0:215:9642:4d6d with SMTP id d9443c01a7336-21a83f55157mr23731385ad.17.1736319635015;
        Tue, 07 Jan 2025 23:00:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:34 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d level page table
Date: Wed,  8 Jan 2025 14:57:21 +0800
Message-Id: <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1

