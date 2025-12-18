Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C927FB28
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080088; cv=none; b=qvqiCwMh6TZcUQepsUH/5u5P8uFEn/b+rgyK7qb8SYDetCHUfJ/ohCj74u4CNHWFsJreXp0gI+eKNB6TO/88eUxhCipv0bkKa7AxkVcEEZQwTyOTMrj7qe2f/+m4l+M//AyUZcGtIUejvsk5ec1Kt34hrVKbdkdr8SG3eAWnZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080088; c=relaxed/simple;
	bh=s4cCCS7+53aBAfAU+iJDG0p56Na23P8Zw1+3qZqdqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar6x6/S7PXo1c3gwzy6KeCR0j68FdrsVv1MjRvJ90JsoE4rpGGzISxm+UQoMUxyNwPb1Jx1SVewq2nKVYi/mQ9Z+dvCDMwb2oxadm2igxpSSuBhdR+SxRrc0bBsnu4vXkD6mRSAvAGFQnWG/KwdMs8oc3FLtkHxb8j+h0lDc9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYO/ZFNu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYO/ZFNu"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1550506b3a.1
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080085; x=1766684885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epYK/hDqdjWsYGExN15M5ZNaIRiA4fpEDtVX6uPFKD4=;
        b=DYO/ZFNuLP+IQgXVi/R9oNwLHLKia/tmAZABjdREcoMmJgiuQRbJYjzZ5iP1vJIUmh
         W+ZzeUGUWN3Y0Ylok/3cXo4f+Mm7q8qLgUvsL2yVTHiLElJYmqg3PUg8KkM0vnwO2Bp2
         ARLJgTCgmZcFpwYFG3JgaM5TrDWmdQC8Cm8NsXsVqDXK70hRQEE2kairivao4sutL2P6
         XkIZNONY/niWJnV719DwfxSCg/1tREwi5ZL+smyGwTKSY86C5xc2NlLIk2GdCHkRXpvg
         gGW1B2l3f0y00dBE5UzQ5TwWiqksuXDsxFqtqTj9rvQDzl7Mq6fGPtOLIWJzN6h9Z1sd
         JqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080085; x=1766684885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=epYK/hDqdjWsYGExN15M5ZNaIRiA4fpEDtVX6uPFKD4=;
        b=v5bqX5j2G11h/PKPx4fryHpJ270DxSazc2+bcmuMYY6Iat/cmsmZJU+XeptKJL6js4
         74Ooy/K0W3TX27HhuHyzfGV7wXULRiiYXqA4MGO4ZJ4C0JpUCuwvj2nZ6dv6xELZJL5T
         2iKwNe6sL4Jddee1pyPsjcz/P6SrfSciy1CwteHjBtb8XG7kHZG1XLwpuScr8+9G2zpO
         cjDRPa3bCV8cdH4DZgxnloGDEuXXIK7Tn3spRnpvitH7ZS5P99IlYXRl/zzyHrV12ybZ
         sxB2zv4KCriVIg/Cqw/lRD2PCwr47+ESHataiwm+FJAV+lBoDikcU544Cdb9j66js4nI
         Zb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCgYkC0vBrxuBpohkCgduTQSBYTmnj7ju1ftfB2mjkPh/5kXGQF89JdTqs5+4jZkNXx+woDXgVm/0/@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiC/8WFPV6DpddSF53MUFrsiMeYVyEb0/jiZbCtp/WjsE+55c
	7mlLW3L35yc+Gz9cq5fVxJZ1FjIkI0UP6JkobrADuTHcnPbjr2IgvGqY
X-Gm-Gg: AY/fxX5hluWgSVwW+QHi6oc9HONrf4PIAZPQVLDiFkbiUfg95EblvCvlSlswuHqDE9B
	afpETCOOfvngdocAGAxr9Uoz8aW/oLmDJwf3tmKLSYjpFuHCRnGhYKkGvMQM7pLzuiNavheVYav
	pSeH4jv6C0Csznnc+vBMZNalYfJo3+cEhJnGzvVQkxFsKgtJVe29xiOz4ai8hHqNxsWAcmtXD/+
	YDM8A3ryFQ7bMWwN07OL8/C6ybYGaCxIphSzV+rqZfpiBpavw+CG1IdjVI3N00yiCGpRVim6ABV
	sdjLfm9MgPdijtMipmdQtZG2IuAcm9LbwiHS9jgVyPbvCdKHwoa80moGzAGLgBgUHjyR11yz7rc
	zU7Se8n+FKFfXr2dGE577e1rH+f1VFxipbSK4Q8xEGthKa/gc7nvvj6qGPiHCTc1kOOgMPLSMTn
	zj0x6haP2P4+izA9PmQJpzUAhiu1um7ENgD+ExQQe31Xc=
X-Google-Smtp-Source: AGHT+IEiUJb9RR+h+zWjnVgNYIE3LIavRn+FigrW0373Cgz4UkWlOkBrVQuLtzTTA20/OyG5rizoPg==
X-Received: by 2002:a05:6a20:258c:b0:366:2476:db4a with SMTP id adf61e73a8af0-376aabfb668mr280882637.59.1766080084881;
        Thu, 18 Dec 2025 09:48:04 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2fffa3e7sm2847400a12.24.2025.12.18.09.47.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 09:48:04 -0800 (PST)
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
Subject: [PATCH v3 1/3] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
Date: Fri, 19 Dec 2025 01:47:47 +0800
Message-ID: <20251218174749.45965-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251218174749.45965-1-pilgrimtao@gmail.com>
References: <20251218174749.45965-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

1. In the SPARC architecture, reimplemented vmemmap_populate using
vmemmap_populate_hugepages.
2. Allow the SPARC arch to fallback to vmemmap_populate_basepages(),
when vmemmap_alloc_block returns NULL.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 arch/sparc/mm/init_64.c | 47 ++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..f477ab1b4f08 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
 EXPORT_SYMBOL(_PAGE_CACHE);
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
-			       int node, struct vmem_altmap *altmap)
+void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
+			       unsigned long addr, unsigned long next)
 {
 	unsigned long pte_base;
 
@@ -2595,39 +2595,20 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 
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
-
-			if (!block)
-				return -ENOMEM;
+	pmd_val(*pmd) = pte_base | __pa(p);
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
 
-- 
2.50.1 (Apple Git-155)

