Received: from mail-ej2-f17.google.com (mail-ej2-f17.google.com [74.125.228.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8883B813D
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790545428; cv=none; b=cZYj8rlSI3WBLChG5XyFNURxjbsVzW89hqxdceIXZDY25P+2L094MaLlijitcak5TSZJJe43lujTLebmPrLwq/bH1Jdh2xAoaY2N/tp/0dzMtx6eG2+GFe15UPwz5wnXWcbn0rQjCek2dznmxElY7soOZrY4OyuBlB0sYOxBP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790545428; c=relaxed/simple;
	bh=Xk5HW6iHgeHF8sKpghX9kJ+ATqknktzLKDmcmvhn+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjQtNgUfZszCdICB4uWRWQHgePkx0bfBvp0LKldvU7B7wWqbWh/B/G237pCzesrJTaIv9j1CZMYkRgEKF1uwbMxg82SHR1oD0ROJ89WULNtX3EDs+bYCnQKGx1w7oOgGCepTdU4TsSIQz/W/htQEU53VxNyKVsN33c+GJan4rbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtM3vgHD; arc=none smtp.client-ip=74.125.228.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtM3vgHD"
Received: by mail-ej2-f17.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so354951766b.2
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790545425; x=1791150225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VgwIZlTH0lKclnCFBSlWFJ3rfoI779fFQpV/lMz8kts=;
        b=JtM3vgHDOPruojH6q/ZCXVMvPg0I2FJbrNk7eGEkeDl+7Hy7jdw8FqLr4GQAtRQsMT
         IXv3F7uk9BkklSl0jzzhKt/BI6MFrNys9+UHGotyWpVfi+Xm+SmrZXs+yfsUyBBw7DGS
         xU7mIBmUiRNr4InK3YKDI9LCyhPWrV062Oi2sN2r6JkYfojZN0Ou2gAeNlhsF8H1erQp
         menrfyvsMZbOEvzQyerg+wdllZaqxg79QPwi/Ae665p+zIFWGc7KGaZ+wEAEso2vmE1w
         5Y0O6opjRlM9HrsbP558LBTfY3r2sGlxYFKcbl6Naj5AwuyD7O1l36zVWrJJlKjxhOfx
         oWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790545425; x=1791150225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VgwIZlTH0lKclnCFBSlWFJ3rfoI779fFQpV/lMz8kts=;
        b=boLgeXC9yZGusKgA3OHAzVxsi4my5PfKqupHj1THlTHdjy8i8q50YdO+pdG5QkeC9I
         d5S0Fu3vYRLzXBSLmrBGEXliCGOyrv9gocoVZzhY5HOfGp+vrdd5J+r1sE2DLa0cC/GI
         8BIR/PZfyN6xm3A66A/aN1uX5/BCYVZk52ZDjlCBQ1mSo5UH878bYPCuDQcIwtuYcrNt
         MBo2QxZ3FxdH5vNdXH3Qak3DOp9KuaF45MOMrmpAjOTEGk0nuTsIcEHYcBqtUIR8GpeI
         IF9IsZQMb21uUNt32vi+ELkv774JjEZ1404vKch8wXKPb9H4RdujTNVWpHLEHW8Yc5S+
         vkEA==
X-Forwarded-Encrypted: i=1; AKwUvBx5MukBnsc2q00JOEe9WFXgTGS7hT0lDEJEn3lZosmm5r54Ltw5oiywcQE2DYeEZK11+LzSxIk/SBkd@vger.kernel.org
X-Gm-Message-State: AFuF++mlGjCPoNGYyVu2GKRHJmuEcQFasIpUd9WWM8iduvZBIVLStTCs
	C63onbTj+WvsdAcGpSBPoVVHbD8a94NSFvmm3do1R+Z2ycgckO9+K899
X-Gm-Gg: AYBFou2gf7pwlwQThDoyhifoe51C8ilz7uh6o5+imSglaErljLj51y2hRMTeo4zMbE6
	urjP1amkEf2/I+ghOe2zZJMspq/wlBvTuFUArWZTpqSy6XDvPuEdK+ms3kZDHqEmAMyiqRsKSi/
	rG58JKJt/3EBdkYBRixKFbQZpwwA8o7o+e6uKV7OBFYYjCy59rjvf3U7n9iymVdMdd5B9ieEsPI
	dndnwoWFM7cNPrs0w7+fqHcT84qNwlmu9G4oS5mEOsbAOUW+uXZdF8yXydywPCxy06j/kGUlW7A
	GIqdx9A4SMzYGrDfQrLYwHm6wnIqLc1D1NK+gY2y9TxMgDt/6+KFcKyZfi8PiOnyQgFGL7fV9zU
	78UX9rj/7PQR7yB6GUGVGuStZ2YHN3qV+0yfYSSCWdHktFC+8PL30rpdF5LXQk0GqkdKnxY6XHo
	EvkRDZRKn54ig38ycufp0OvFF9w8mzymLq//mZH7ZSQjKdf9J6qJRq1Fi/ObTvPbsrUgFBbXRqZ
	aV0P31WPTmOsiMYbe5LipomYxcFY27F73QDDjw/
X-Received: by 2002:a17:907:1999:b0:c26:19de:9126 with SMTP id a640c23a62f3a-c2ac2569975mr965081666b.25.1790545425094;
        Sun, 27 Sep 2026 14:43:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm376091866b.33.2026.09.27.14.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:43:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v4 1/6] sparc32: use memblock when mapping the kernel
Date: Sun, 27 Sep 2026 23:43:12 +0200
Message-ID: <20260927214334.886582-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927214334.886582-1-linmag7@gmail.com>
References: <20260927214334.886582-1-linmag7@gmail.com>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/srmmu.c | 47 +++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 9a74902ad181..110e2f248c60 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -817,39 +817,34 @@ static void __init do_large_mapping(unsigned long vaddr, unsigned long phys_base
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

