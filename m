Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C371E1A3D
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855302; cv=none; b=Ld3FL7NIzytKTvl73zZvQNGQoSljtdrUW10DM8uA15NXjztNlOgp4sceBQ2/DYvb7bSXbUVMqCAnyzUrlWnyGoD3/UEgQWAD64v1waVfOqjL3ZiieQYQT/hzSF4qao0oAb+3QmFuTkla2QYFWz5zKfLq9HhuiUki3MN6x/cegQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855302; c=relaxed/simple;
	bh=8FWA9AVOhWxmQZ3JjAGZ5b76UZEA8wc94gm4Jv7PZTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di+LWpxJHAMiQ0TSUTc4kXVNa3px2kcqxXiE/vCQn0/I0hd2WUO6rLcVdVk1/pKQObVnnxpPsW+LjEpUoxJ1fgS+Wpt70zymNCMpMKk76WceQ2Sgd4u1Phs+jWvd8jmRlul5qm4ADmnRAjSwsFbUqbdzEZNFnfj9cYAFbWeMO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG9xcFh2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9xcFh2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c160420289bso27340766b.0
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855299; x=1788460099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K7W0FYldKuHhAWB+T1mpyUsx45/uTv/Vu54VWOFp0Yo=;
        b=UG9xcFh2btOij8vEKcQX9VdHZBEVN0J7RipLkzAd7h9pr+Zq9gBMTMMT8Q9AQgC0/J
         OxdcLh6SG23Ei4sDblBWaBSbqx8Z/s+4Rc0afp/0ndm+OUzMCmWZvUGLHgNniGxNVqYT
         cNkIU2Im93A1c/kAqVS6jNvZIrvz+gxocoOyTNPqn0mJ8xlSHx3Ee3HeXS66GknLT44R
         g9A2O0x8qCrtonasx6Rr3Bxb24GLIewqc9yVAtLNqruZW7l6K7l8LFbIgrjcVk6X92MV
         jqd625FmIgeVUGf5JXRUhjx9U/MxUJUK88peyxjIqAbNTaS7l2nxb41svDTXeM7RbQWe
         DJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855299; x=1788460099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K7W0FYldKuHhAWB+T1mpyUsx45/uTv/Vu54VWOFp0Yo=;
        b=CeYRZQpjC55NtPMt3fJPa3iyRKFKrnj1lOdsUyfQl1T4BAgNs4HudaieaXoO/XMdFs
         k+uPof0heAVS20Ka+Kx4n8I4ixx92ks4/oA1Wa81P8P+1UV1+aBEFdkjCL/78fuAWMj8
         QoFNdu4Fu6ags/P/cp60xcNDhYvkhBjHx3LoH6AriURU2iX55E8uXOfnoTi4EkmOJtkA
         oy6FYePMrYqrJEuqzbym/lxSoqxWX8Ws8DB+/JaWuwG3N5TEaSB/0d5IClBQm4XAscRP
         tP40bZj/ro8okMF5CllfOoiJiKuVClwMCW5ZJVTMVlZaYoJrjLRso9/p7uJ/0oHP8ABj
         cK2w==
X-Gm-Message-State: AFuF++mRzgB0AFdt4/Qa6YIA1gmp2HDAqnHetcDpsGPDugVAgLbdH76g
	s77XL7FyqsXIAWJu89i1Uh4V8PIuSbZddmjJFFbt9Rpo6Thcv8LJ9rTOtd6KofvK
X-Gm-Gg: AR+sD10yjvYoE5sCfFm75MSpffTkNGr4WnIp7Hg2scAO/3McrTPjSPHr2GLLwHs54EC
	1EWu8xs2uCOaZJiu1ePfInGJcZEiNeSAdgGXJF9eStaFrMZ9Gcr2jUSYIvzorBhSfC77p4QTQpr
	tWll43I68ZenBS2nXiFJgC/k5ElP+4KZOepO9BBZ4s9gh0SOXkOEkkpoBNSRUbYTRoeSiTeqwbK
	ls0W9OYHSXyV5iceB33DP3xxXkCZlvwsnkK2T74d9qxO1DIx7Oz4U7gYUw+yD1tClPvBQwwFy+I
	4DJfKRFVJWIXLBRuFp2nWWMS3czoe3u+N/zaZySkhdi6lUK3yGGvlzCo8ZpQBON1u2pJxId6y4L
	/JePL8dKFYgg5zbwoMxJq/jwo0t1sF8qpmJpGYGSHYZgHd05UkCApnxTkDDKkfnaH1xX0m/LJBN
	k7fbPr/Po3Y+MC1yycdfC17+vgInHTr2Q7l4ASNzYqJQD5SAX19jDi10zMWbb/4KtjomIRdgWeN
	/jWzOQJygevwdjpPgT2nbpq69Znwa9djTN7xrURsA==
X-Received: by 2002:a17:907:1c90:b0:c25:362e:fb8b with SMTP id a640c23a62f3a-c2556d9cd56mr49465066b.7.1787855299269;
        Thu, 27 Aug 2026 11:28:19 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c254e4e736dsm61288266b.11.2026.08.27.11.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:28:18 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 1/5] sparc32: use memblock when mapping the kernel
Date: Thu, 27 Aug 2026 20:24:13 +0200
Message-ID: <20260827182757.6856-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827182757.6856-1-linmag7@gmail.com>
References: <20260827182757.6856-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock already contains the available memory ranges when map_kernel()
runs. Iterate those ranges directly and remove the sp_banks-specific
mapping helper. memblock range ends are exclusive, so use end - start as
the range size.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/srmmu.c | 47 +++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index f0fe09169528..483235458d69 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -846,39 +846,34 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
 	*__nocache_fix(pgdp) = __pgd(big_pte);
 }
 
-/* Map sp_bank entry SP_ENTRY, starting at virtual address VBASE. */
-static unsigned long __init map_spbank(unsigned long vbase, int sp_entry)
-{
-	unsigned long pstart = (sp_banks[sp_entry].base_addr & PGDIR_MASK);
-	unsigned long vstart = (vbase & PGDIR_MASK);
-	unsigned long vend = PGDIR_ALIGN(vbase + sp_banks[sp_entry].num_bytes);
-	/* Map "low" memory only */
-	const unsigned long min_vaddr = PAGE_OFFSET;
-	const unsigned long max_vaddr = PAGE_OFFSET + SRMMU_MAXMEM;
-
-	if (vstart < min_vaddr || vstart >= max_vaddr)
-		return vstart;
-
-	if (vend > max_vaddr || vend < min_vaddr)
-		vend = max_vaddr;
-
-	while (vstart < vend) {
-		do_large_mapping(vstart, pstart);
-		vstart += PGDIR_SIZE; pstart += PGDIR_SIZE;
-	}
-	return vstart;
-}
-
 static void __init map_kernel(void)
 {
-	int i;
+	phys_addr_t start, end;
+	u64 i;
 
 	if (phys_base > 0) {
 		do_large_mapping(PAGE_OFFSET, phys_base);
 	}
 
-	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		map_spbank((unsigned long)__va(sp_banks[i].base_addr), i);
+	for_each_mem_range(i, &start, &end) {
+		unsigned long vbase = (unsigned long)__va(start);
+		unsigned long pstart = start & PGDIR_MASK;
+		unsigned long vstart = vbase & PGDIR_MASK;
+		unsigned long vend = PGDIR_ALIGN(vbase + end - start);
+		const unsigned long min_vaddr = PAGE_OFFSET;
+		const unsigned long max_vaddr = PAGE_OFFSET + SRMMU_MAXMEM;
+
+		/* Map low memory only. */
+		if (vstart < min_vaddr || vstart >= max_vaddr)
+			continue;
+		if (vend > max_vaddr || vend < min_vaddr)
+			vend = max_vaddr;
+
+		while (vstart < vend) {
+			do_large_mapping(vstart, pstart);
+			vstart += PGDIR_SIZE;
+			pstart += PGDIR_SIZE;
+		}
 	}
 }
 
-- 
2.43.0

