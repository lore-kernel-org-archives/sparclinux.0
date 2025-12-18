Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903733BBC0
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063411; cv=none; b=clvgQODDq5rZRE+TKEupwgmMPzaAyMoPe0rC6fa3Xc3iWYYdLOOhcZzXqn3/+AstM4LYTmji1JlpCjrFoYqMJ8DpHYZvDq5WK7ASJsqweeQY5mj7eU/2d0NChidHTz5KeYWT6TQWgwifzYD+kLlwpfTeLOp6AV4nDly+SZ4Rvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063411; c=relaxed/simple;
	bh=FWK55CrKQxqqJF07xpBROWBCTj7q20BnUv6oWg7F4Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr/3VaRPqKN4cjtTp84UsEhdDwdTjlQO/Yto9V2s2cosKmkHU99aI5HeQBgCg8Z/Bi/6xxBUwNKHeCajmByoJiD+BpdE+ZySjrB1LmUsSdjYXke/xe0KpkwbDuedCa/HMwkN1yjukgfSkd7OrH0OBN/OMJcUXHUXezjw/nsubZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlDswGu2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlDswGu2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0c20ee83dso7715795ad.2
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 05:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766063408; x=1766668208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3TCENr0pwf1AEzmfzATzYgD/ncjqU5Y+gUYLbJJ/50=;
        b=MlDswGu2frE2F5iDGUguX8ORnRnAJZs5hhQyY078WSg/QP/w7gI6zGpSuJXxyAEJ6b
         SxKHG/4c6q+iXQfSES44lHnpLLxzFWhQb8rw8hNYp9Ls/wY4ZWxXn2Iz25X3+2SBNL6v
         fH7mTkg9qPSWgZKcibmMwmgzBL+GH7zb+oXvonhBaT1+mzG6X1IF7uwIzyxweKzNUvZz
         2jhTW9Dj4xBatkFkMhw7XZYvXO0BhE5pnrCAzBdXVD5yJB++oRS8vByMcXMqNSjcK0NY
         OST4bPiqgIl4mf5zstm/e7cKbKX7fH2QzfqsdrVrm/TGQeRdU3OQqgqjoWr7DTZyDagM
         i8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063408; x=1766668208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3TCENr0pwf1AEzmfzATzYgD/ncjqU5Y+gUYLbJJ/50=;
        b=PHPnJmT90jUpa+WJrx57qJt2OlpGxYy9UpygkkuEZK4iY419xpP/j+3ScY3sAGI1mG
         I8GSxW9ytwlo/ZWWRCM7M/eAQeUAzHrEuFdMvX9K0ZEoR5iyXTQdSDZbOMPup0i2+h+z
         eKJUVkg8KIShK+kIpNdECCt5YO/kuQSspLyn6EMKjFcaNUWjoYdpySJN9eQhh0h5AcYl
         6q76huSmF72Z+Eb/fh2iBx+5VnqHpjVPxl8p+mJ/F5kLFIFSsaDp8TmKjnM8C087aLs8
         7CHELuSwba3FHuy2+IcstMEbYOU6xvLlj4J0gOA0uJj9XxHyWfx+3vykSEzSPUmRxJu8
         Hz7g==
X-Forwarded-Encrypted: i=1; AJvYcCUncPx7hXXibMIhlnRHlVa7o0hWiZM0kfA+7HBk/gqXWGv+WdbB2skR6akpURKJQmqZfXSSS1/0+4UA@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbU2Q+TGusOCixd9n8KOvHaIo/faUSdpXDP/QjP4OVhehX7Bv
	3LZnNxVxlVPiHr1sZCUZkez+oKhyx4GeAqinxN2VgrGLJpq3oSq+PUgd
X-Gm-Gg: AY/fxX5NgnMIgB/sjrsKeaKNZWgI6o/shDOZQWbXX70TBkaymzKtlF8rsBTT45pbVnR
	7nRzXbGKzMlScglPeB9nUamKQqNoP9FjiF9ANCUJNiI1Nz7G3xXW9ei1tgS1Xui9XqU01xDVK5e
	xAdOEils0g8ShCjCH4FH8hDuoX3tb3vivkSQTK/nMONcHChDhUqSJQzKYGOcLo6nHIaGciuVL5J
	4mMWYzdyHS7WX2oVYw4Miiti0FinhgGO7+ZEeaxR5f5EMoCZd/jnQ7cYOPCHD41P8k7A6/rGskj
	IuJoFtr7pDNo199/aTXe/bB6S0O8roNS+Z8UrcHMGQ/klSihERlphBjj3ROXK5ZXW56b3NJtHW0
	qL/VOOItqL10FfbzKKVXnAagqxr+cul6IfG4i0cNyuflaLuEU2AMwJSaht/Y4Q593+vLNx4ce/v
	X83uCfPWTg30UXg8xbQm1fYbA90HI67E0qb8OLB3F/jg==
X-Google-Smtp-Source: AGHT+IFaf6sCWgD75/ILIq3bALtZPi+pj1h/4krEFrOW2ZcgvzVOSmifnnbQZGCeJL5QUhBwf7aNiQ==
X-Received: by 2002:a17:903:46c7:b0:2a0:8966:7c9a with SMTP id d9443c01a7336-2a0896681ecmr172355385ad.58.1766063408168;
        Thu, 18 Dec 2025 05:10:08 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d089cf0bsm25475205ad.40.2025.12.18.05.10.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 05:10:07 -0800 (PST)
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
Subject: [PATCH v2] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
Date: Thu, 18 Dec 2025 21:09:57 +0800
Message-ID: <20251218130957.36892-1-pilgrimtao@gmail.com>
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
v2:
1. Revert the whitespace deletions
2. Change vmemmap_false_pmd to vmemmap_pte_fallback_allowed

Link to V1:
https://lore.kernel.org/all/20251217120858.18713-1-pilgrimtao@gmail.com/

 arch/sparc/mm/init_64.c | 50 +++++++++++++++--------------------------
 include/linux/mm.h      |  1 +
 mm/sparse-vmemmap.c     |  7 +++++-
 3 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..86b11150e701 100644
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
+bool __meminit vmemmap_pte_fallback_allowed(void)
+{
+	return false;
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
index 15076261d0c2..ca159b029a5d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4248,6 +4248,7 @@ void *vmemmap_alloc_block_buf(unsigned long size, int node,
 void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
 void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 		     unsigned long addr, unsigned long next);
+bool vmemmap_pte_fallback_allowed(void);
 int vmemmap_check_pmd(pmd_t *pmd, int node,
 		      unsigned long addr, unsigned long next);
 int vmemmap_populate_basepages(unsigned long start, unsigned long end,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 37522d6cb398..45eb38048949 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -407,6 +407,11 @@ void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 {
 }
 
+bool __weak __meminit vmemmap_pte_fallback_allowed(void)
+{
+	return true;
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
+			} else if (altmap || !vmemmap_pte_fallback_allowed()) {
 				/*
 				 * No fallback: In any case we care about, the
 				 * altmap should be reasonably sized and aligned
-- 
2.50.1 (Apple Git-155)

