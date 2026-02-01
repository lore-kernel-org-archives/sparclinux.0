Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1620459A
	for <sparclinux@vger.kernel.org>; Sun,  1 Feb 2026 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769927757; cv=none; b=joiB/z8stVlcpHEvL7qlpneqyYetfWwQm79vWN9jsJGyDX2PafZ7z/+sZoy9tvVZOO7+omUKXpT4GKrjx2+zchk50EZB3jsdzn4v048XKLUyQukNvr4BGrWX7nI/Il9Wef9z8I1hSGtOkJyHkOrmRWxbo9pJ5EYk7fPlnHYx/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769927757; c=relaxed/simple;
	bh=C+apFGFIBagzKzCME1/KFpsVUJDOqSILLOFYxYu0L7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftYLa8BF912BTlvZwLFCAqmv3IQGEUN2B/oOSq78YWR4XQwte49peGlOlO3Tc5DdV3/VcSRYSHZ/0iL3PQDJ+nkoaVWLVrrzdc+trkbK0jO8vJ4muOv9Stcg3l7ow24vWkSo//kR91mvuyUFuN6p83RBnGAOwKBNpE6uEXDoybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMYYQqjb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMYYQqjb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823210d1d8eso1738243b3a.1
        for <sparclinux@vger.kernel.org>; Sat, 31 Jan 2026 22:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769927755; x=1770532555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8AdoB6sry4rs5wh+etYdnccb09faRPmAEKL/AFwYIU=;
        b=FMYYQqjb2g7feftXCtFDYauM5tTZfEyHwQYaR01MW3Jh1D5rePMZu94fj3lnVrM22/
         MECVksiH/jGkvj80LFT8NiQUkF/OCppLC08q0/PzGuydFmiawwpn2z6yCYrlRjIVqAIh
         9zGHk2pOEr+j1EJbCWt/FV9M1XM25/Y9ET19udYgWmm9ld5lknz6pbi06hfnrpdycYAc
         JRz/ZOwSRKUxqpMCu9FATKpsOBz7+gWn3Vi2AynVLbmiZGaUdRkg23enUEvtpYNPDJ74
         G6rRi8WYl7b+2z19ELnjXX7sRkDt4h5+iUsNpltYwgOMuPgNx5dfSVw1Ian3g6sl33iJ
         LHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769927755; x=1770532555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z8AdoB6sry4rs5wh+etYdnccb09faRPmAEKL/AFwYIU=;
        b=aFKrA6QcSOQiapiRzncTiRHizes0J5ALUJpCb/GB0TWO+dbL5vwGp5JjkP6sGyBc/G
         EzmfuAvmDVJOy8pFNvn4MB+NHXVBC/GjATahUMnUZJMncAkHup32Fn08vUHH4GNeIEgb
         BVcQH2SatWX0oTxuwJ4mvXDgurA/yJaGzInTQYFhbxKC0SMXeFLn0iLRNyhughWBMau5
         jBN47+/NimeCsBvkQH9+K42XBLHnQR+5SI92TuRd52pQzr+fA+4Zqcvbe891u3yI5fsA
         oKMGEGtnBvaKhfm+MPPZRxUt31XzZZ+wx85m5N8E6X++u7co3eM610YJhQFfdnlejBD6
         0sCA==
X-Forwarded-Encrypted: i=1; AJvYcCV872a3z+sjunPIrWeFh1SdO5G2PdIgJgBlGycSd6xxgo2oQWE/xlKPe7FwLLmt0sXGPgK2mlII5E15@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dnclROh+XJrmYJkes1DDWRZDeHl8aoJXlrpmr/HzLB70qKSM
	xqsZAkpRF1Jm5ot2k2kz6MuVts4kqIql16v1xK2TElX82n6dSLqnDDEA
X-Gm-Gg: AZuq6aKQjiTEIDLnpyEEeQ9RuXWBhX9t2qmOtDLrzDERiDqVGFCexo6KVAPG6/MQ1YT
	a6cdBE6/aoIHNActPaxSAl9h2RVX12m0sfd74n2rzzi0tVlp1L/ikEXDJyOZbr1cUMb1K9CX5AA
	+sBPmZM9F1Ylv7PAPf8NOJZTOX2a/VQbudZk5oCj+eJOuJ5p5J5x0u17vPsyDF+lnAeIRt5OQVz
	3YtYRfDAFGg7oXs5kbijuZiu9W/gXb9I6ZMN9LJiUvA7grdf52fO0szu4AwBpnaD3zXm3NZir69
	OTMqsRcwhQutaOiBdGutmuZ41WDx4ZaA8OrhT7vW9Kwo7I+mXrZfTnEzXJNmjMGKOuCtUNA4bVE
	9RoE9JYr0GR//UU8vFc6N4/AtxLc58K2bT33taTebCe1ZwJzVTFNJAynArky8cQq1jD4H3YXHhT
	a2kbr08CllvJX9ZF1swMVebXmJLkWlM/N7B4B7zYTLCQ==
X-Received: by 2002:a05:6a00:12d1:b0:7a4:460e:f86a with SMTP id d2e1a72fcca58-823aa634e4fmr8121991b3a.25.1769927755539;
        Sat, 31 Jan 2026 22:35:55 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b2bdsm12149294b3a.30.2026.01.31.22.35.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 22:35:55 -0800 (PST)
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
Subject: [PATCH v6 2/2] mm: Convert vmemmap_p?d_populate() to static functions
Date: Sun,  1 Feb 2026 14:35:32 +0800
Message-ID: <20260201063532.44807-3-pilgrimtao@gmail.com>
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

Since the vmemmap_p?d_populate functions are unused outside the mm
subsystem, we can remove their external declarations and convert
them to static functions.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 include/linux/mm.h  |  7 -------
 mm/sparse-vmemmap.c | 10 +++++-----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0d5be9dc736..10a0664b4ce2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4238,13 +4238,6 @@ unsigned long section_map_size(void);
 struct page * __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
-pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
-p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
-pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
-pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
-pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-			    struct vmem_altmap *altmap, unsigned long ptpfn,
-			    unsigned long flags);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 37522d6cb398..67f9a08c2376 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -151,7 +151,7 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 			start, end - 1);
 }
 
-pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
+static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 				       struct vmem_altmap *altmap,
 				       unsigned long ptpfn, unsigned long flags)
 {
@@ -195,7 +195,7 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 	return p;
 }
 
-pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
+static pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
@@ -208,7 +208,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 	return pmd;
 }
 
-pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
+static pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 {
 	pud_t *pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
@@ -221,7 +221,7 @@ pud_t * __meminit vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node)
 	return pud;
 }
 
-p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
+static p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 {
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
@@ -234,7 +234,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 	return p4d;
 }
 
-pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
+static pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd)) {
-- 
2.50.1 (Apple Git-155)

