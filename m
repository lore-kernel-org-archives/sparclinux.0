Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9333EAE7
	for <sparclinux@vger.kernel.org>; Wed, 17 Dec 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973354; cv=none; b=QrTmjGVXDDoAuzy22zT338tlR1F0jKJg1anug+JXtjNjbMdzdWJbi4+mUXGWDi8xswb/VzznzMPi92AfDfkcqUCfsD+/4F7B+38JJCzY0DY9sy+d2t+DCxF1O4YKpN0bZhX3O6yK3QoUz4oeG44vMDxGk/LQWSova35zjautJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973354; c=relaxed/simple;
	bh=hkv62bbtPSznPbHCWR/dYDb1hZQAXG9B5jFgDlFcYaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJfJHIZEG/nYQXZyT9nkTLf+p2Y2j3ZABqFVyCAkNrNydY4xz+dEQnOERGf1mjwk56jdiLX9NPLuwfrTUirH/lFkJQpqhCvjiuFCT4m2F2PW7HS2uvdG7+JkwAMZrjefT6MEqF407YN9zjeaiV4dOX1gLtM5I6elpbG8Wttyg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxWbGrXM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxWbGrXM"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so350037a91.1
        for <sparclinux@vger.kernel.org>; Wed, 17 Dec 2025 04:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765973351; x=1766578151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MO3Q5T5gWjRjMPEnUZXPC/z7hpENtdSyL6rsjX0H9U=;
        b=WxWbGrXMWhcpHI5zUPxquIbVECuHIM6npTb5BE+fpplSaa3WV9qLtuPODmFk9dwUmf
         Al0EkLUOfbJ0N9SUGrqJ96+c0b3C6qWxmoa1viUHQORKJZjyYnBy+d4810sYRrPtCScv
         k6pN15Qx4Ac3PAeIT9siRIbagzY0lssANk58HsTXcwoFvNIdg4cgWnKTVbFcpLIWD2mM
         cKx8ZGixsl4xEV53EfzcETUSRZMykNoI5s3VTDbXZrbbl/79dWvhCUaE/Mdmyc9xyKOP
         NzTVS6fS3M0c3vWQzTEQiyvE7+kC3odJ4GrF60atiYkrNHDirAkJJGHMdrLxK6VLngvv
         1I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765973351; x=1766578151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MO3Q5T5gWjRjMPEnUZXPC/z7hpENtdSyL6rsjX0H9U=;
        b=TdH9XWMkBokeILmTeVOmdszqaAPBG7ea5QYW2mqj1iP6P2vPDk7aL7ls0453ONvFtK
         N5t3G+zwYlrR6ki/hPXa3A+6Om1m3bU7mrbQeopXEkF8DH4Y+VlKb0FJTlypU5UWtA8P
         7llTTBrvLlUVgoBmNECvTNeilDjf0ZYM6vSW+oFeqSdL1IwhN1+sC0/ukifp8xGMs9VQ
         1141cbVb1Qt1BTW5H8YyMiepjNweR4SYeXml7L5yxnf9foiX0pCQko2rugm1b47/2rsU
         H1b1hs8hDHEiELiBsxfw/IpB3Q8BScJtvjuZzd3X3Iug5u3UGAh8lkewnwBUTkTypcps
         awEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq9VwbSQ79D3JX/TXd2g3bdK+iT9cy0MBMlw3DMrjJWv12HUkv126ZAUu2IEgBw10OehfZ3xa3IpU+@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwkPiYHStgxZe6q+ZHPzZ5wgWBKdUPvDVSBnZNvtmEUx0ZijA
	zdjUpIUZj1bj9KClLvzNxhVhgsl/T3pYPW0Xw4I7DWGEB93OYhhJ8rxd
X-Gm-Gg: AY/fxX5kCaWikr9xLcIWTkGabgdQPmn/ROS4IaExB0pGisFlD/A5cYUL4BrwnTDrPN9
	Mqy6gcdWdkQmvvu0Atsqf+2zXu6TakWzXPhL5+b6GuLsLZ/sS/kc6/ejdb6rSgB8vA2ikF2xfDS
	tvpJ+5T64hxEauNjdWOoZT6VZyOrYSTDVacMphaXP55XaEfQRLezpnbYRLWtHINSTsdLwX/Q6N0
	vJ+VkLSVyuA4bYVvghqiU1iSF/45I15LCpML6ABdJVb5HsgAIqRPCXn4OzASulp1gG3kf+NYTJA
	bK5hnBHdTctlGTDj4o99xM0i45ALzQjxTnsyQ9/s99L+xFWxnyz3TGBVIwehMG/5PmQgz7uXowr
	dqpaRuMafhEEV4rsQT7dgDyLpf0545MsQu80uG2g3nASpQIfdHa37838dvtv0i+PtR5m1PfS7Qu
	unuMgj00n7u296eU6EIMFJgtqdaEBrUuugychpNiVd5Cw=
X-Google-Smtp-Source: AGHT+IH03HXWxu7yczO0LADVUezeFbBUy3RsqSFlgZLDhzDggYMtvvDz8ILuMy4Gs6BIFYfX1kB8kQ==
X-Received: by 2002:a17:90b:48c5:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-34abdf40c33mr17148583a91.15.1765973350612;
        Wed, 17 Dec 2025 04:09:10 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd9aaaf2csm1683105a91.5.2025.12.17.04.09.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Dec 2025 04:09:10 -0800 (PST)
From: chengkaitao <pilgrimtao@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Cc: kevin.brodsky@arm.com,
	dave.hansen@linux.intel.com,
	ziy@nvidia.com,
	chengkaitao@kylinos.cn,
	willy@infradead.org,
	zhengqi.arch@bytedance.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
Date: Wed, 17 Dec 2025 20:08:58 +0800
Message-ID: <20251217120858.18713-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

1. Added the vmemmap_false_pmd function to accommodate architectures
that do not support basepages.
2. In the SPARC architecture, reimplemented vmemmap_populate using
vmemmap_populate_hugepages.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 arch/sparc/mm/init_64.c | 56 ++++++++++++++++-------------------------
 include/linux/mm.h      |  1 +
 mm/sparse-vmemmap.c     |  7 +++++-
 3 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..a80cdfa6ba98 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -5,7 +5,7 @@
  *  Copyright (C) 1996-1999 David S. Miller (davem@caip.rutgers.edu)
  *  Copyright (C) 1997-1999 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
- 
+
 #include <linux/extable.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -2397,11 +2397,11 @@ void __init paging_init(void)
 	 * work.
 	 */
 	init_mm.pgd += ((shift) / (sizeof(pgd_t)));
-	
+
 	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
 
 	inherit_prom_mappings();
-	
+
 	/* Ok, we can use our TLB miss and window trap handlers safely.  */
 	setup_tba();
 
@@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
 EXPORT_SYMBOL(_PAGE_CACHE);
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
-			       int node, struct vmem_altmap *altmap)
+void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+			       unsigned long addr, unsigned long next)
 {
 	unsigned long pte_base;
 
@@ -2595,39 +2595,25 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 
 	pte_base |= _PAGE_PMD_HUGE;
 
-	vstart = vstart & PMD_MASK;
-	vend = ALIGN(vend, PMD_SIZE);
-	for (; vstart < vend; vstart += PMD_SIZE) {
-		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
-		unsigned long pte;
-		p4d_t *p4d;
-		pud_t *pud;
-		pmd_t *pmd;
-
-		if (!pgd)
-			return -ENOMEM;
-
-		p4d = vmemmap_p4d_populate(pgd, vstart, node);
-		if (!p4d)
-			return -ENOMEM;
-
-		pud = vmemmap_pud_populate(p4d, vstart, node);
-		if (!pud)
-			return -ENOMEM;
-
-		pmd = pmd_offset(pud, vstart);
-		pte = pmd_val(*pmd);
-		if (!(pte & _PAGE_VALID)) {
-			void *block = vmemmap_alloc_block(PMD_SIZE, node);
+	pmd_val(*pmd) = pte_base | __pa(p);
+}
 
-			if (!block)
-				return -ENOMEM;
+bool __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
+{
+	return true;
+}
 
-			pmd_val(*pmd) = pte_base | __pa(block);
-		}
-	}
+int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
+				unsigned long addr, unsigned long next)
+{
+	vmemmap_verify((pte_t *)pmdp, node, addr, next);
+	return 1;
+}
 
-	return 0;
+int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
+			       int node, struct vmem_altmap *altmap)
+{
+	return vmemmap_populate_hugepages(vstart, vend, node, altmap);
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15076261d0c2..5e005b0f947d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4248,6 +4248,7 @@ void *vmemmap_alloc_block_buf(unsigned long size, int node,
 void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
 void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 		     unsigned long addr, unsigned long next);
+bool vmemmap_false_pmd(pmd_t *pmd, int node);
 int vmemmap_check_pmd(pmd_t *pmd, int node,
 		      unsigned long addr, unsigned long next);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 37522d6cb398..bd54b8c6f56e 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -407,6 +407,11 @@ void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 {
 }
 
+bool __weak __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
+{
+	return 0;
+}
+
 int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 				       unsigned long addr, unsigned long next)
 {
@@ -446,7 +451,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			if (p) {
 				vmemmap_set_pmd(pmd, p, node, addr, next);
 				continue;
-			} else if (altmap) {
+			} else if (altmap || vmemmap_false_pmd(pmd, node)) {
 				/*
 				 * No fallback: In any case we care about, the
 				 * altmap should be reasonably sized and aligned
-- 
2.50.1 (Apple Git-155)

