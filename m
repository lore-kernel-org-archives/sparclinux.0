Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C82D5436
	for <sparclinux@vger.kernel.org>; Sun, 11 Jan 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768117515; cv=none; b=Jh0DPDTq8blKl8trpywPUSD+t+GmmHy5PE7K+4qcUJoePpp6buoH/V5MjA4cR6+ivOvT7dpN8DUEz8KUW+2bluvWxG5/aAkC4lfhKdLGeoKSE4iNChcWX6+DGN9Vt3/2YO28MTJCHy/qeLaJRUfqqKCcoBfRKBcVkAwqikUCz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768117515; c=relaxed/simple;
	bh=Gs3m8L2qq+QH3AO0+Vqw9/jrUEa9x5rhE92DShVyB+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP09/gXcGrNWT12M3ngE3W8CtmqC2eZvFiRQMcssMF+Er6g/okHr34YtAhS+gn8gsTzvscIZzmHbwYyO03iEoFg2h9dchRjvjYhUdpGwvuHzTIYtedQDdAYr5N3+PlXbbGGtRuaEEucVtNSfjXQl3e1QkJvfWhgYdHC2HU9IoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnCVInmT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnCVInmT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a09757004cso51204105ad.3
        for <sparclinux@vger.kernel.org>; Sat, 10 Jan 2026 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768117513; x=1768722313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErDkSB/YcKlAv/NjNwMo8qsmxcHYpWxJ6GLrwPIMkds=;
        b=HnCVInmTiCeFJcLdA+Ev/0bWjSL+1wUb+QaZVvW3RAHd8xk/kPZr+J18LExTGwH3as
         EVDc6KyTxwGKdgewnMC2g+2KmYyo1gC5btpxtoQ8SwujsLrxdYx60ls8WuS5ike+Xia4
         3yEUJsR+/Wmh7tyJ63QvMReZGDchkJNKUyzfBed/Ir6qiM6px2Ooo/4lTrsER5P40fZ2
         LoS6Cuyu5BnlQMAjpG4U5t7TwlUMC3Mpf/1POtU8EMQc/QQw8sKSP1OwcGtos8NNHqsV
         D4aYABSia4fxZqfC+sEmhrBiet43+ED3PzYHF+sr177FCnq297HOQ3DS3ERWKi0uKF1/
         5nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768117513; x=1768722313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ErDkSB/YcKlAv/NjNwMo8qsmxcHYpWxJ6GLrwPIMkds=;
        b=oMcotxAfvfcfm9J9YEYdasC5kyco6n2fovamTLEho/yO3N61q+6kagr4DTsQv2fUG6
         HRh9W1jxPMbquAvcOpsxBX+0IIXrYiB5bTaIRvDDZ6Qe1AUNIIdVhef4/5dvSrRysJ2f
         FmzZcw7FcWReDxWjXS2HHKwp1CmUMWZEcL7/8MrgXpSwoaMXuKFnKBTdxKF2TosWzbGw
         7V1zoioJA/gl9azmnaR8+f/iFxUQo1h6lZBYuniSw9/Uc/jG9YZruqtuCfh97g7qBxmT
         AJ4n0A4aINLujL6IsPkxfkC5qA7WbTtqRuXDD2bUKofMI32+1Hpz7E4/Jo/a/+Xa4OUe
         3CZw==
X-Forwarded-Encrypted: i=1; AJvYcCWCjktz4Na0rlYgylH+lq7kcwW1iBm2bnVEMYlmcd9E68m+F+MQduQ27soXVn3ppwn/3Ir+Ek3kJyx+@vger.kernel.org
X-Gm-Message-State: AOJu0YwwHOwWAnqRzC4zpMjrOtRR+soJjJZgMC5QGAr1vAK5EH78J8w6
	VUCuvx+JMHssVsYuICBSmDMV5k0Y1ShHDlhcU5gzpagJzzkOtrhczo7v
X-Gm-Gg: AY/fxX7e91Vu+l0VnM6skYt+RrXT5tVp7xf8z7+Aipo+pMBAQ1w4fTIiF0qcz2vYBf1
	8TPf4vQv+fYuOnzie3dhSB9ZJRmVYqR9P/EHms+mQVfNPFXnS+/c/oeOHtCxBqs4Ma1Ltxh2+uj
	YRyQKD5iOcXYLwPSXns302io5ChfKT6LH2SPiuyyGkUFdpcP0N393/82bpWOOCWtjlVDiSjAxmm
	sVMZlRt3uC2vrfxPKfSWylooc9tbVH0R1H7DrdEZRCvzLOZhnBJnRxyVuEGrhJTCQ+oN7fJircT
	rHvCu9o+aE4IYXJ7J9TmMFYTv79gXlkB/t7G0Vfnn9mWZ/c5Yaa2BH50mZQZ+2/SX31jacTG5UP
	7h5249DyZXhzJnywv2NMLDMMLcdflvLuxNDTV84IfgWy4TwB1hyF5fSXhguk/TUgoQxUhnWoog5
	fbLhWdRJpThKWDwGM9TwIh2tFs/UBaGecxpnlB1mnE
X-Google-Smtp-Source: AGHT+IHEY2L02vHLsHgqVo8Ud9CELmE+U6IhLRIOoCjAfiREzCyIRITc84zZTfAj9tRvsfC/hMJRLg==
X-Received: by 2002:a17:903:1b4f:b0:2a3:bf5f:9269 with SMTP id d9443c01a7336-2a3ee4151f0mr155587325ad.3.1768117513511;
        Sat, 10 Jan 2026 23:45:13 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2f8asm145284015ad.57.2026.01.10.23.45.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 23:45:13 -0800 (PST)
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
Subject: [PATCH v5 1/2] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
Date: Sun, 11 Jan 2026 15:44:52 +0800
Message-ID: <20260111074453.66728-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260111074453.66728-1-pilgrimtao@gmail.com>
References: <20260111074453.66728-1-pilgrimtao@gmail.com>
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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

