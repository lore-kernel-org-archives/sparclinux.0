Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BB3ED5BB
	for <sparclinux@vger.kernel.org>; Wed,  7 Oct 2026 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394907; cv=none; b=jO1Qe+dy5xjjSaG2qvyR669kR2K9MD7VDI3zGqMhOsvKWpIItKjM7aUMw5BRyZ7oOt06At1b+0fPjcG+IYDBslLSw4kBbkKqiqqk4c0h86A7jOJ8WRd/6s6+P2LLh0dPPG+r4Y5zN0YURcV1lPq2OY3X9A+HNKqYXKGf9feUWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394907; c=relaxed/simple;
	bh=Xk5HW6iHgeHF8sKpghX9kJ+ATqknktzLKDmcmvhn+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRfSUeaersAIED6RfFMIAGZSRZDXox3FgUWePPebhgYG6oOF3YelbRtFlH9Nx7Wy4dbomKeSsAZduUKEkkE/jd0C8B4yGb86ijfZzGggYfMMo7cqlSLwqmzpLBsqX7Ilhc+xnX78LJ+SWpHfxWPfemSWHto7nRQA9x9G+2k9pes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKSbkNEi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKSbkNEi"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso334224866b.2
        for <sparclinux@vger.kernel.org>; Wed, 07 Oct 2026 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394903; x=1791999703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VgwIZlTH0lKclnCFBSlWFJ3rfoI779fFQpV/lMz8kts=;
        b=nKSbkNEiOPLK0GgBdIzbTT59ysTeYZ6ziL6+tHo8Kawx4L/Yl6aKk90y/lKk7Awxao
         Bbri2ZzYvH6k8qzPC51xTI1DY2RmFgvRylQskk+Ly7qeiWblRta8d6/IFYa1kNL0pVEb
         Ev5f4Qgiz88XZZ/UliN7RJEg0l2kHql7jOAkNKjkLvf5hLC0IA91RDlgay4xm9ZHmSxe
         fi1IFMPo0rrieiBsmYx/tj2hkjh+wXFHShVrc3rzMLFlNdsTVMT/sRvWZL6M3dh3upCM
         OsHLboRsTHogH5J3C+O1e2Gyr/lGk3xr0nCwoT4GTwz7CKaLRYj0ETbHuzViPOMbdziH
         4Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394903; x=1791999703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VgwIZlTH0lKclnCFBSlWFJ3rfoI779fFQpV/lMz8kts=;
        b=Px0bY7OFNDUbGDRnSdqLLbvGjJh2+USl5ApLUe+7vV8uLUysn+EpqM/nTfRSL54dgP
         7O+DmpVQ2QkJBy8DWnrB+4OMu5vsqDvpdeMXpobq60U+Nge5+RJ3c9gbFazaxo4x3HT+
         jrpD/fIwdh6bmPLVjv2T63NBoOMvk3NFrt7Boh5z0dqT85O/Ia7iO1cQeZ2HieauIsMr
         mwfh/kky9/CCPPHPO+HG7vkmsdZxyuT80/uPHr1E4T6oFJPfhSU9De0iA2wn2258sqoc
         DSGecZuDVCqnF56fjhsiSSTLQkmGXAqelOUrxUVAD3WzYRNYRfiUCY0iLNs0bvYZxe4T
         SCRA==
X-Forwarded-Encrypted: i=1; AKwUvBzVdkvjpyqKOoxGo9kWt5vsVn6TFciQLmHiLqsHIwfJN1W9vDhc5QsnhbBYs7BdtaFdLKPXNp3eypYx@vger.kernel.org
X-Gm-Message-State: AFuF++kB/Cisw4Y6NcDszp6k+XW2LIKjoBJRt1jNmnPOUSvN2y0DSZy2
	O1iId5xewUxYgdTP6wZYhDg6ztlI1Nl7jI4arW2ZG4KJV/M3O5UfaRKL
X-Gm-Gg: AYBFou3a+0BxMk+pIiFRy+YeEgTrCuOILDOuCYYA7QUrp+8GeAu9g5RTXab0ixeoroH
	aTzJmkYcmzyNYdxFv4lSZaUajBeBUrEFyqs9oLotBRCahXQtDD01f+oxL/lS18Ys9ng2jh7iHQH
	+Ch6eEvco/bnmwLxJkbFLsSu4L3EnH3kOg3170F3Z81abe0TkwHsqTxWr7dHjguM9IbytMB2hc+
	5N1yqPRDGOjdr/PEKbvcqNJruiLz0PV2rgefwuY/buyVJDOyJc4U28AHJ1/ll6CFDc8YJhOA7cs
	IJJlXJ7nkylhkZ//RBhrAYm7Bwxmi5oFCPN/6c8bmH0ZNqfSygp0hicEhpmzVouYNn4nrYsQVx+
	N87iOYcP25mj7YPuDCjSedP7g6ijZ0GH3mm+jThkkVzqjv1rUtkCYq/yBovg0078gdhtqSEoz9T
	xUdCFgPlnMDcUs+K3biWNMkkEB6KaU+WPjK7j9PO9Ozh4/TcX3HmGBOMBmfTvz5fGyRtpJxEaU/
	9K1w2QQdiXZ6xX0bloIkRAzdzkTp6w9LlfQp3qa
X-Received: by 2002:a17:907:86a3:b0:c2d:f76e:f030 with SMTP id a640c23a62f3a-c317bd4c293mr310630066b.13.1791394902899;
        Wed, 07 Oct 2026 10:41:42 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b009e80cd8sm356802a12.8.2026.10.07.10.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:41:42 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v5 1/6] sparc32: use memblock when mapping the kernel
Date: Wed,  7 Oct 2026 19:41:10 +0200
Message-ID: <20261007174128.959307-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007174128.959307-1-linmag7@gmail.com>
References: <20261007174128.959307-1-linmag7@gmail.com>
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

