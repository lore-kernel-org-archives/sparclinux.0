Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A932E14D
	for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145525; cv=none; b=W8hldGM3dz5Qhv+151EylnMbt/s/VzpzBkLif4TN9LRT+B+Fr+xUeKJzVJgRpfMu2ffl+oH4TUCGLYeIYk4og6zPeOlNmbhQQG0/vukqJlhx08h0tt1dmsSwUCt0FJH+qULI5G1nDYqPM27vfdOaeQlz/XBTfnS6ERhqBECFQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145525; c=relaxed/simple;
	bh=JSNCFCGCnTJ5C/s6JqxpKX2kZcgQfa5SddswCGob0dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn8BgDBaE+nj03JU5ynL9xoM9WtC8fBwkZ/wwvLExPhxM6cCeCfPsrk/Loq7F0Cx5UafhvlG0zNznnNxZlwlyg5R3/OpqPgJ/2umAk1rJduLHxHpJEeqiu0x1ChM7MRBbnXEb/+dQ0/lNkIohxIRjql+W1M1UTrZ2a2Us/ORHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgDIjA5x; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgDIjA5x"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1858779b3a.1
        for <sparclinux@vger.kernel.org>; Fri, 19 Dec 2025 03:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766145523; x=1766750323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVePrI9HNUUUrQXi6c3AiF1RzNZZo1pMhE3QtRBD0Es=;
        b=WgDIjA5x5ycgzUxrH9NKVaQ1T2vjigrdswo90qXMg/MY/aN+xJDukQSKInWsuwxcHE
         JqKjzZwFJ6BzZHRi2v1SRE8Qo0ZofiHhV240ReCj76Udonsw6I1zyJTe6VmGbm4o//W7
         xJZ3AVZ34qfwXK0vVo6hiW4JJrsC+MlEyOQHgBy4aZ5rwbcTCzI83B6qCOs/J4rx6s6k
         tIhD3pQ1QwifCruuG0/1/mqGgpjilbSv1mX1cWxgdC7bEzAWS15wxmUqL6ly+imY9D4O
         kJjAFzvf+QoZsiiHocoSNVWJukQm8qOOloJ7AXPkYZUywSVjPjzwvSQGLKGbhkc1Z4YI
         YB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766145523; x=1766750323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kVePrI9HNUUUrQXi6c3AiF1RzNZZo1pMhE3QtRBD0Es=;
        b=JnTr8g/YE7QqHeSQIsp5pQFc7sTECoE00CzD2jAQyJVUJ1iO9PzAthywfvA5h9/hKi
         GLc9K5enaNpQlnxLbJH2XVkWs4nu6b0FYHn6zElHEs2o3Bpar0K5EwBnMXv/xUanIJGb
         kqG6ub6C2JfddzmVsxusWPUfOCI/1lycoxoDfFvjrTwdjQ7fifwewFwUwcnFYTihOAyd
         GrtVRuJPm41/HmbEvEOsBWdgph6u/fx3WI9IjURGkP/UuNjfl763ceRjjf3rXJbZVFcJ
         DPuUjsjxHvGucvJ2+C1F7t3PDCnqoY1OS/h/vp/DAC8eUbbmlcRp7Jwv9Tz9HUjTG+gn
         R78Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7HSSVfE6DNN8/rF9pGX/e6C+VVD9lbKGwf7BCS0zslf69nzu8Lr1NXiWtsAnA4RC8Bzd8rWiDWWBg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+2pYU5pHR3PQt2tCftb6lxJzaaaBkzhRMroy7SjMh8lvQLxW
	wpMx46fvUDh5jdAsbsyPcZNiVUdcJ1GK4hsJ8lWqqLYUJ9D5fZw4fpxe
X-Gm-Gg: AY/fxX51DbMK316pgJXZbGSvg53y0lDUN57RtFxMpDFmJV5N1/YOElJ9sdg1jAYuxbt
	UWOdqis4XsnJNmt5qapuQAEzJo7Nrzbov/J7MNUYk2EGwiwUJXUJMvnXFiFF/smU2aelQBhJBWj
	qqGRtbIlSqDEGBXBaDEBDp3NBvGXm1AmFVjptniijylkG3WA584xOP7onhgLo9oXcfdiXZLKcVk
	fdW9+RC8tFnkyGBdTAoqOYwYlg2uyNbUXjHjJ6cBCL8UQr55OvQCmoEq9zKZLp0LJCm4leT4PQ3
	jNgl25s7rpnafeoSRJdYt/5zXnOSQmcS6FQr7PGbQNoU0Cgm2XAy0cI1Q35QQt2IY7bkgU+LkO4
	fWPG0fkV0DvqdJL7pbk0jsH846N551Bhz4idnbcnXUg3i8JG55ekQ+ZLrA/puRJK2xPcW8VbQHK
	ChLFOSJrIlU7Uw0/mDGJCbpUNsO1KMihvrUC0OlQujug==
X-Google-Smtp-Source: AGHT+IEssKL24IcA70xxc4mhVvvw4D6teK050VKbdzvFCYfVJoKpYEGbrW4olo5yzEO8AY5fL8eV1g==
X-Received: by 2002:a05:6a00:1bca:b0:7e8:4398:b358 with SMTP id d2e1a72fcca58-7ff6607b228mr1844327b3a.43.1766145523337;
        Fri, 19 Dec 2025 03:58:43 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm2258560b3a.21.2025.12.19.03.58.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 03:58:43 -0800 (PST)
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
Subject: [PATCH v4 2/3] mm: Convert vmemmap_p?d_populate() to static functions
Date: Fri, 19 Dec 2025 19:58:11 +0800
Message-ID: <20251219115812.65855-3-pilgrimtao@gmail.com>
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

Since the vmemmap_p?d_populate functions are unused outside the mm
subsystem, we can remove their external declarations and convert
them to static functions.

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

