Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC312D6E68
	for <sparclinux@vger.kernel.org>; Sun, 11 Jan 2026 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768117522; cv=none; b=Ubm6E0H97/eEFD6vzoP2JRRTTXJdMpFz+K2rb2onyOI9dMjM+yy7tGFj8D0rZMPYOyh+5qHmoPAK/Kv2bXcDJg6rFbZVPKNShqtCg290AzZ96OaeUjuA0IKBJY3lKfeaf7+SxQXFLP6TSCbZPqDRcXJ33xMNdVhB6fB7sJR0UwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768117522; c=relaxed/simple;
	bh=ftOvATG5TQoFVZofhRiW6lDAK89ZL2/+jXBI/hCnadc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBtgq6U232NwWi/Ej6vL1CQekw8f/H92LyZFGQSaDUdxqbuPYINxcp0xMt4HJs+An0eu1YRV46TiL8Lkj/lX0g5l6tY7GBEfNUnF1omz7nm9HIaaB5eYcPTlTn7UeHrYnBj6GlQ8VQM5lvHFbfOctIheOPdF5spXnSwV83rhVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9R44GW5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9R44GW5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0833b5aeeso55563805ad.1
        for <sparclinux@vger.kernel.org>; Sat, 10 Jan 2026 23:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768117520; x=1768722320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W1VRgdJWZtP/35+X4BFxHc1/Q/0kqoYu2dyr3n8ICY=;
        b=j9R44GW54bTdBJlOS7ugf86EmDN5T0FczdON3ei7DmBmCQ24z3cLzgkaG93tHtDDUs
         mMb5KlKa3kHS6c4YR8CyrFhNdKVZkmVbaVxppphY8puyO5I2/SPrgZxfXCAuPJhK9lrZ
         yYriOlsXGw+ivLrFSdjoild6xoRIoiZE9eA14TStoRky0bRt4Fjasez7l2Zerc/dJ31e
         VLOXWc6A89fc8t1asC6IISaGnsEyNdJAR+5BSjoOTDfrVzYry7x718GrqSjHs9JPR22A
         id2IfMydryFhtmmEAeVYM0K4SQU6FS5HevIEoZnHwOMRqc4io8NTMtol1suQyiOIwt/o
         h/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768117520; x=1768722320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3W1VRgdJWZtP/35+X4BFxHc1/Q/0kqoYu2dyr3n8ICY=;
        b=uf5Mczou6nbLLpwHjHbiNrYTKjrIbXlUYZKqZrWx2vxTcNt3hyamGDNbdpqPJF5Pi2
         7LF6wqQaW3hU3njfZ1jA+d88qWr8aowVgneLsq6oROOKiGuYoNNm80puNWjCT/bPibYJ
         mxIAubNfwrq8WU3k0FQwdtc/k62vTJH7fQsH+sT3TAEpJUvHT/VHptKC51dn0V3D89DV
         bxrOqkONYu7c6PIJHRbMok+XCr9p96iqkgu4MTfml1pJq9WeZ34drXOgikUFCt8MOtQk
         xNxcPH8qvwrj2m5RMp45QspRbqCxBnjC8bKJAK/kW97tX7eRfGeoyOerD6t3kUOwf1/4
         KxBg==
X-Forwarded-Encrypted: i=1; AJvYcCVIMFLau1ysWxsN6k52DHytm4gU3FAKParOd93avvD1Ss67TgvpQfIEYqYi7zRHsf14+AzHijlnnF0v@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/wyOUcgXKU5Uw6AOybyR0ARra0Z8L2HicX0aLGnkTyL5o0Cr
	hingFLXtnFP5Y3QJWNVT0g/H5OTB7LrdUqS5cLZhYazbVwCYuK2A4XT9azKXPQ==
X-Gm-Gg: AY/fxX5QGp8wFtdRvSqPAXBY93ggNtt9IbGoMVFD6hjep/d0vDmLbwurlAz+cf3Fp+Q
	OBvaVXZEFk+DuFbtX4RM89+clfQK1L4VLpysl/xygCA7iL42Q16QnXtYC6v426gZzWt34kYu0Gm
	kR0zhV81/CNWcj8mLV0c2QhJ40C3VW9o+JcfkxFqWfG1yNk7rtch7o1F6jdTdIcSNRMr9aeaEMI
	ofltYqGcAxiESkHvBNkJNigqqwr8uPffShJgstRI86Vogo0lyMHUen+ZnjGccUuI0/eWy68Sdda
	ASoaDrymlLXUtTQQFR/282wf6JIEG6oqv9DJQLWEwiTToZdqclBjAv+buJljakFOdzYNkbqAZ1f
	ovke5U6m5HHFivl8GlcWg7LvFzgJJgygJbwZsDtGL3nqww03xlRvUyGOm+gAy1pAm/IEMsX29Kd
	dtKHQ7C8GNE/4yR0U2KmNJNAi1zOaovmnPU5r5tdTM
X-Google-Smtp-Source: AGHT+IFOxUt1YWvqb3kir1Ky7DSpkYbp7DHua/UbMFooiLjcrZeFDAph0g0fbWDK+tgumDDxk8azBQ==
X-Received: by 2002:a17:903:2348:b0:2a0:d431:930 with SMTP id d9443c01a7336-2a3ee4b244dmr150938675ad.47.1768117520166;
        Sat, 10 Jan 2026 23:45:20 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2f8asm145284015ad.57.2026.01.10.23.45.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 23:45:19 -0800 (PST)
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
Subject: [PATCH v5 2/2] mm: Convert vmemmap_p?d_populate() to static functions
Date: Sun, 11 Jan 2026 15:44:53 +0800
Message-ID: <20260111074453.66728-3-pilgrimtao@gmail.com>
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

Since the vmemmap_p?d_populate functions are unused outside the mm
subsystem, we can remove their external declarations and convert
them to static functions.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm.h  |  7 -------
 mm/sparse-vmemmap.c | 10 +++++-----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f959d8ca4b4..322fe72b6ebd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4234,13 +4234,6 @@ unsigned long section_map_size(void);
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

