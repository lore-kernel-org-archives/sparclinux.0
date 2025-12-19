Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6F32D0DA
	for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145519; cv=none; b=YSfArdqwz66Ipst/fVQFfFAOlTkmzzEtO04x3zr/iOgYqamETLoTiM7FitndcPDYApz2EudobDPYSCYabISKpsy6BK7PI0Ir0wQTRed4RAlTlJLm2myLzOyfSG9pJBaAt43Bt1OQ8grf5s0aZqWDJBmOeQKx7JJjwr5mRW2J0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145519; c=relaxed/simple;
	bh=3pWw4P0odQo6+R2d7TtcfhVeRyfUHqzonKgWsY3PvHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vxzyg9aLhgmDdRNf0zMC8PnD4iaQQY/1G8SL5asRexn1ruKrMfzbzMbIoBqE7M0d7iCA5Cyy+Vupth8z4ULzCiF0OKpF0INGuFqUX+5SO+GteGZixP/qgk3lvpv5hLoKMFm3ew3e425YTjuF5eK5pBamO5nufc+1OIqt8oBft4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7GJz7VO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7GJz7VO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1127486b3a.2
        for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 03:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766145516; x=1766750316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKBIZ7X3YGqQjD1QrQoyKYVgf0OWXgKlCuUAkiD9UlQ=;
        b=K7GJz7VOfZ6fQMUy2/56+SzcOcM6Ts+w8/NEkoxrH4LIDueE7PpPryn3lPuOYzFH9C
         Gd7FpQI4MmL8oNwcIIoUHpMlyge1Pue9GgMCrboIAGJeXK2KR57pIZ0R7NcngJkEbgDz
         dPuiOFNZQCUrme59JUJEP8wHeDrrLqhh7oUu1RJ1Bpod2ipG5xB6nFYg6tg7rCXbdoLk
         U3jWdUMy5XykfHfEQueqkZ8qCUU31kTG+D5smG0/UXCYudDKyVpg6X2l/ruJpn3lunfS
         /dV4yWChbIraCzyU9daeyINdln/1N7WMS4W2k/VkV8VCqj/A/6mDcaS+QtR/EWI+lr+a
         1fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766145516; x=1766750316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XKBIZ7X3YGqQjD1QrQoyKYVgf0OWXgKlCuUAkiD9UlQ=;
        b=QWucaAEg+a+Fyr5RDXkwkCS5g6WrUC0S8DKJ6AexEqckpz6rxGR2moCKg55X4VBlXy
         gQ0hsDoPNj5BvIB4uXXr06qTRw9qwx44uN0sBhNttKbnujVO6wSaj+okl2FhQ/MVfH9s
         J3G5bu/jY2S4TA4R2oAy2wWxs0z7C/PySgmZ4AjEUgtk2ip1Zvd4meSGXUkaATAmkxRa
         8iqEWVOSLDQmDmw2Vc+s/h4/2mbkhWvBBbHRedoTHBQaOOAJ0B5aEpC8DPJj659I31mP
         mccMlxNTV6HUh8OBjVdk68RFOrvETCNeOUVdqWKTM/JbYH6AnnZGRBRxitZKRzfWgCkr
         zktg==
X-Forwarded-Encrypted: i=1; AJvYcCXftPtmzvZcp4U5S6lXlRi356rKjUeWs0Xl/Ll8ldm1CvoT7hG6lP2GH0zW972q1O2pBIAXfxfHaaf1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdl43t9WaV8wR/jlfeQ0ELN9XorC7w+oaKbRc5/ZM8vHYKr/Om
	YsiSKwJpVg4OC/BZ/PYzA9Rk5YnGmion0P66GgQGQ20y70JjrCWoIYYp
X-Gm-Gg: AY/fxX4FaK8pb9MzA3TwzZ4EEmARzcaEjgaF5jeio1kCTPVrHxWOgMafIMXvGstUb/F
	9cwZAmnYho0bqmkYoLlqu/mmc16mCKyyqtN4lIr4kEQmFR6eNGxaGVruujvQ4RIj5pR6meylpVO
	nbHkA39AK8wMmCOGtrWFgpi3um1q5Deg3uPjfzLrJhY88ZolhGFEyToyxp5HoeQC4fV+ZOiyGCZ
	I14ixBxoY6t7/FTR9tZT13FCLm/V1ARyZ27L3u/jgHWwIT7YG7rOySxAf7FFXKkcqhcgxqXCVC2
	alMM4PvJwmpiUmqkbpbWPy26HsI+3b3gZ7KEthJIf4upZHBwLp4NDDRUjdOvPJR84AxOc8NNKwc
	f6Ad4uVPy77lrdEZrVvfABHeSHUNGfqeoR8agAJIh2n0jq54GFnP/gIHnL9AT3UdrGM9GsYD7Qs
	mQivHobzUt72dLK+ZGiqbGi4AuzHuWm6AmZhxSwHd21IM9tIlBPJZQ
X-Google-Smtp-Source: AGHT+IGo8qcsBU7nnRMisHe+3/ZdYryGUHrh6G2oCtGYAIPB39ve/9QZxztOzFs0p/0RxiDANxcA3Q==
X-Received: by 2002:a05:6a00:801b:b0:7e8:4587:e8cf with SMTP id d2e1a72fcca58-7ff66a6ea42mr2101088b3a.66.1766145515736;
        Fri, 19 Dec 2025 03:58:35 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm2258560b3a.21.2025.12.19.03.58.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 03:58:35 -0800 (PST)
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
Subject: [PATCH v4 1/3] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
Date: Fri, 19 Dec 2025 19:58:10 +0800
Message-ID: <20251219115812.65855-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219115812.65855-1-pilgrimtao@gmail.com>
References: <20251219115812.65855-1-pilgrimtao@gmail.com>
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
 arch/sparc/mm/init_64.c | 47 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..858eaa6615ea 100644
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
 
@@ -2595,39 +2595,24 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 
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
+	pmd_val(*pmd) = pte_base | __pa(p);
+}
 
-		pmd = pmd_offset(pud, vstart);
-		pte = pmd_val(*pmd);
-		if (!(pte & _PAGE_VALID)) {
-			void *block = vmemmap_alloc_block(PMD_SIZE, node);
+int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
+				unsigned long addr, unsigned long next)
+{
+	int large = pmd_leaf(*pmdp);
 
-			if (!block)
-				return -ENOMEM;
+	if (large)
+		vmemmap_verify((pte_t *)pmdp, node, addr, next);
 
-			pmd_val(*pmd) = pte_base | __pa(block);
-		}
-	}
+	return large;
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

