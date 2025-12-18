Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934171ADC7E
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080093; cv=none; b=VYdp7JNadpGfl+ph0K4aRy+CApsg1VPMOjcFTQZXKd54I16/PjTlcgKTUzqHEYynj4iP2JKAUtNUSjQXKM89BOPbEfmb6dvZBkXkv0bDUBqbA0douvlWon3yAh+tBxPriE1DVKO42QChaiVFceZb4SO0x/xbnmfAnpiqrLw5ov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080093; c=relaxed/simple;
	bh=XVzPit8Wju3h/YR4QKLJrZBR3QKJTeR1B/yoSC7sPF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKCT4JZy9HUeafIzVwBHMWgJXXYkpvUJLMUbc2F45ou0xsvq9L3JpLAzz/dHBafy7wMYJHum3Nlh30hfS0iB1ThZXG0FL0kQaLU24lU1kH8Fehq4Odub6LlkkwxuI4LYagYmbzeqcMs4B7V6MZnz6aDyk1oEmWAHIEN7Sh/bGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK0aun8g; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK0aun8g"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso807904b3a.0
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 09:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080091; x=1766684891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a/4Q9iM3UvOXiUx1Ukt0rzePZxlPvy/hVaPhme1T4U=;
        b=iK0aun8g5mH23VIOjZJ6u0nXUvBNhQeYpKHHp+DhvxgmcT4vXqLvgSCYwPtMjzhUhV
         Z6fHyX6mlnn0sU9OTrWAUY8UPN3IqqIkmz67N5HpgqB/8l9cmyIdBokW3kDWCPBodv3t
         dfbhJ08GSccVEGHNEvv1wsUooNm/197scCssYQSLo3TFOcCf5EinNdBlttIH3Sx1n+Di
         nc8rePwNe4v5Ocsj/u7FGmEBAom1kPYMxVNyazsCrzuk6wt80hD2OG4pzQhVy78mRIaM
         xL/vnwXZ38yCOkxhyCSuEt1196NzLc590Q0jm1PTK46GLyYn98F0Kt5i6Yh0cgq933y+
         SQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080091; x=1766684891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9a/4Q9iM3UvOXiUx1Ukt0rzePZxlPvy/hVaPhme1T4U=;
        b=oRxRosQJhDLNKJDh32fyTo2sbiCXz61QLuJWaGYuLmCKLknLCQDNpfEwr6AIXJGXGN
         f7/1GgDwZ5BmRY8LqZtyV1lDFTXhhzgP+Vagj6pYJhCH2z5T6xuWSEXJGXT8tffpgknA
         dWcwLN2qJQc4gjLoBoWDzqAoTtKTjgkh33ih0DPubeRnLtZnO/0cnjG0gHHHEwmpMKpg
         M/LolQv79TMmuyPKK0zv0LEA4quWWXu4ryx92jyFypRh35vytiaVXquQWr/jD/+tvFtf
         pkaI9/9qfy+2nA8gpwqDnckk5/Lm2+M/TSTYnGan5TyWqMCGm7v/ugIc0RSmxbbmsJXB
         uslg==
X-Forwarded-Encrypted: i=1; AJvYcCUFdG5hY3FL8yw3W/x2pPNU7g5IXZjZoX4x9xEfn/JB7O0W2uNZyzx//TRaUwNKWF2z/xjxqFNyncFu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kyEPj81nd6KrHkLdFBnVSaamnwx32uGF3y0xxHghqoZ7+32Z
	7ELfJ0i8HrcKjmdiDsIeaImXJEsKQ78/SynPZisaW1b7ZCqpWlwZReEM
X-Gm-Gg: AY/fxX5B9Uke7yp1VORU1/hnXpvCI3rfBMzSKleymJbzOkVxjwxvMzit90265l66JDi
	TrqK5bp5goc9BygNahaqer7r+vBtayngf52/uGogBl38f+wi4bwWYa3dukhl0SRw9ysttK4Cryj
	ciAMBsGoj5IVH2N7r9Ac6LOs/hzv9XEpVM+mp3bm3Jv37g5zGGNJdzdctX13hLvJAwg+pirjJRO
	apkkr0Deyg/TPa1irdY7ickqbz/g3o+yl7ReJxcmYWlKB/UKqQSzr4BH6d6sjMSU2YZuR5NOwL3
	61vu9B+AAFPRSuIe/JD45GQMNu3xg+uzSGCSpMrhLYpB2dvKrdtmF8NCVvvaVDWTseK2s0awLsm
	sUhhOr47LmD9/gebY0iQmp5WQ17cbRIxiTxcnos84t+lys6D2Vcxtn9Ijul9aDslvKhAWuYaUyW
	qqo7Uq2AqaJTWdpKoAXbSSFX/hQiIkRPVVunTqP+f8eIM=
X-Google-Smtp-Source: AGHT+IGfR2lFl+VRcbKc2jOFwOYw8g8R1rmbfL3f0XS3RZAPvpW2FkBK4dNPKqBXwbIN07Xw1mOU8g==
X-Received: by 2002:a05:6a21:3290:b0:35e:4017:3f32 with SMTP id adf61e73a8af0-376a96b9a7bmr226011637.38.1766080090692;
        Thu, 18 Dec 2025 09:48:10 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2fffa3e7sm2847400a12.24.2025.12.18.09.48.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 09:48:10 -0800 (PST)
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
Subject: [PATCH v3 2/3] mm: Convert vmemmap_p?d_populate() to static functions
Date: Fri, 19 Dec 2025 01:47:48 +0800
Message-ID: <20251218174749.45965-3-pilgrimtao@gmail.com>
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

Eliminate the external declarations of vmemmap_p?d_populate functions
and convert them to static functions.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 include/linux/mm.h  |  7 -------
 mm/sparse-vmemmap.c | 10 +++++-----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15076261d0c2..d98a38a6ac0e 100644
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

