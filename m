Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724229D29D
	for <sparclinux@vger.kernel.org>; Sun,  1 Feb 2026 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769927751; cv=none; b=Bwo6LdPR7RGBtJDbXaaatwWidm79rykgLfQE4zMIGNRX0G1N7G5tVxekR8pkVIV06+iRk4yoEi6Pr6mBhk7Kyh6KPKLAt1YJU5m2uTOCu3CQ1/35OzQjCgILlobgI3/R9bqCnpxQLHTluc5N6DQDvIudyVpFhmravY8HHbg3zho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769927751; c=relaxed/simple;
	bh=3And2LhMsuiGESl8ELxQXs3/NkJV7CahODQ4j4lgPSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVs/Cj9JcLcA3bZmBRlpsgCreKSH0G3W3jIOhtPfLQTq+5sV/SDUI6I+7VXjEOTJ+r1Lu/2C5woDtYi+na2kKpnutzXCD/ul9laykzeeZ2CAZECWnpKMnyxAlZqFAdunqjLX5u4Nhhx5hQFzHjk9VGkeWBbOeGvt7kPksYwmrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIK9N5Jp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIK9N5Jp"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823081bb15fso1772227b3a.3
        for <sparclinux@vger.kernel.org>; Sat, 31 Jan 2026 22:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769927749; x=1770532549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+k5sDfrzGc/t0c0Zqa3NksQEBMmv727qk80IVOuHas=;
        b=jIK9N5JpWEO1euCr4de38lYDPUnNi8Pf0R7KCwPFLx/l9C4qtsacmrCbFqOtZjTe+X
         gEElGSAimIk2EBd7OBLp723tUgz/m+Ugrp36hHNpMEMbV/yP/mo/FN9igFzsEPbw3ySs
         vNb8BrxBA+qTnutZsQ8BhcJyt79JVvRCwQ/cgQmZnghcj9IV0wd4liUHsE4FxLnWupKd
         ay8s4maK7ldcwsSzi65W+gnDJCdKUcI64nwxGzF6Y2NGRmDFf7C7EU3RyE7d1n1AYBiK
         /ovNMvwVcyhNk/Id1KCudgJpe89cLxm6kceOJMkQpasdRlLhpplpGxxEtVS6d8mjebYE
         EL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769927749; x=1770532549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+k5sDfrzGc/t0c0Zqa3NksQEBMmv727qk80IVOuHas=;
        b=UKZVLiRjQQIk8VLplZXhpBGlPcbZADp3eYIa0oltguJg+4p5dAT9FAedSrHF7nZm8e
         Kcn5ekdbpSPGkb5S7JMCLiCZD8tk3iG1X12r8GYLtF8WVCXRlBPKlH2uC+Iy7GAC6M3i
         8XynHebnKCbyzKnvcIs1jnqMi9cKSaYYRM6Kso4Gwx2NvBDoyuh02/4tg/9fiHmZlgxU
         gpfHJ4WBMN7zxTBihqBWfQwB0Z1cKuoHa5+IucXKRkz433WyWFcAV3OF/AzYkcDzzBXb
         5cOMFydl/SQjXvsGxR3XsAymMuB56wcCjDJDrISnIwIawkTdb4yZsaBdswqtAEupG2O4
         2Zfw==
X-Forwarded-Encrypted: i=1; AJvYcCUTsWkhIZHIPD6YuL6MO7+UyVxuSCk4xFFVNEVdfnUwQwclViFXHcJzOPe6DZnSkJpfMWhfXdlssAOW@vger.kernel.org
X-Gm-Message-State: AOJu0YynI0myoPNr5d++Rdab8beppN9FZI/nVPB9FoUtnaRJRD58B+AI
	1LRg0s5leHsweBfI0YvhIzSI9UO1PvZfOnTnTNxLZ5k7XeZC2R3IxBuN
X-Gm-Gg: AZuq6aLulBw4qmp40TZpHI69Jx1GE+a80bzFhwOkO4L6tSb2fq0rd4I98pDJp8ODex2
	kSGmTKQ4vZsXy07suoGogHPhcGYIXXsV2R0EK5IkU6tW04PfaTYHAJHqP99ldGLLIwJQ37O+Bfd
	fNHcgZOkj8/6hyKQCyBI1IePSDt0UxU0+ovPCcyHEiWGCGNbJCsROCnzXXoYZya9qdHLTabDz4b
	j9sda0U2uoxD6Q2o0qSNsnjqCgNP4nhkuM8vnPrca7iePDNU6JqVDiIDEnUyRiwXuRVv94vWE82
	ZcDGlD51Ivma/2TmpAtaPGmbTknZDsHxBoYKPDTpJTnojf6IyqamRjVeJV3iuGmu9rDH/UCPGE6
	5TmwuDqh27Bf4OtcCJf5zHcqlhOFq9dke/3yTDzhZsym+sG2VX4BtvpcUkuDP3zUQSsMKpKKhh4
	WM2qmsuUQx7f0Jl+OGEZQ41QehbDduygioi2HrUTDIvg==
X-Received: by 2002:a05:6a00:4b46:b0:821:70e7:b10a with SMTP id d2e1a72fcca58-823aa40d7e9mr9263325b3a.8.1769927749584;
        Sat, 31 Jan 2026 22:35:49 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b2bdsm12149294b3a.30.2026.01.31.22.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 22:35:49 -0800 (PST)
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
Subject: [PATCH v6 1/2] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
Date: Sun,  1 Feb 2026 14:35:31 +0800
Message-ID: <20260201063532.44807-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201063532.44807-1-pilgrimtao@gmail.com>
References: <20260201063532.44807-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

1. In the SPARC architecture, reimplement vmemmap_populate using
vmemmap_populate_hugepages.
2. Allow the SPARC arch to fallback to vmemmap_populate_basepages(),
when vmemmap_alloc_block returns NULL.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 arch/sparc/mm/init_64.c | 47 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..f1981adc99ac 100644
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
+	return vmemmap_populate_hugepages(vstart, vend, node, NULL);
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-- 
2.50.1 (Apple Git-155)

