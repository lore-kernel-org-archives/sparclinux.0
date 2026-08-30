Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BB3939A4
	for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091681; cv=none; b=sRDmHgUgVRMk253EUxe9aAh96Rx8cTvmPI3HuA5G1WfRNoeLmZl1li0iGq8yDgHsSF3TLTAov6U60XCBXgNQMnxbDc/5silGMt56BQPedZ6zmUcu9n+iMz1S44NYWDchYhPE8/Zp794xm5LB8xY9os4FDpuHwo+4iUZutwBRAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091681; c=relaxed/simple;
	bh=/L+B8tJRHS4R8Ad2CdPqQmMJuscZ3nYa9ow7BrVUDeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVHKAx286Pw1BoYFdbC9JdFTgRQ26CyW4fn60G1LtwdKd6SPH+Z5iostAk208n1gQ7i3lPaIuONA+uoBKxuEiFKQPnRAOFdgu+urg37ltRl+1prDXBCssVE6lAn7zXA0ouPV37t8HnsRB3b5LaeGnXMEi1LhS/SqUf7O9zQQtr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9h0D8M3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9h0D8M3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c20e70a0962so326473266b.2
        for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788091678; x=1788696478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3uv3O4cBZWmtlUcIzNA+n7dDtgG66MOQOoF5n5RkYY=;
        b=h9h0D8M3Eyf3m6EzTPomDeuKFKk73RXmbjhsh7yYdy+LK0xJ6o4T+uzv8lOgQ8ZcED
         YNBgqrei3QP5XY4+NbmsJrXt5tLxM3i5Hen72Fx3bjmHi3hr7wM+87IynnkIu4wyRO+E
         NzVS9acRjwRJ6rh/umCCbDH899AiITuQLEhrNmlp2X9X7iabqbnFBDDrwe5xi6judVFO
         rRiCsKgL9fo33roTEGXhYjFet/FXNslqM2RYb3GNmDyxca8AEifgiC/HPOrD/KjDY4ru
         w6BZRO9Dm340FfG7PJPCEa8hKfzKNOml6/2l3ThYtxZcUh/PQU2MJWbGiz0VKCvanq4t
         FMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788091678; x=1788696478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3uv3O4cBZWmtlUcIzNA+n7dDtgG66MOQOoF5n5RkYY=;
        b=pk01ADfIZ3Em+6wDYP1hybQBLPWptBcBp7B0o2/WimEpCy9REv+OH8bf1ooOpD0k6X
         yRBa3k40gKO5zWCTc98ghLTJcH12qOJ5pRR/5N+2HCKrO/nx2POk9NCLauecSbWz8DrP
         HG6RjzQG47CSOB7gn8EpWuUrtuKt49nealTdImpowrnGBS1ZmehN/gr3r7AG2nqCvAM9
         rnUTJbPb6YuLrffHXTA3hVMFv2GtWFa8aEIjpin3lLCr/shbsOEovBxiOPcvzy6gOw9p
         6Eo8FE6y85i9qN53+Ooa+HTFVkHT3o6rHFjl8wldsldbvCAoqeWHKcNqNgNoQbU443i1
         eZvA==
X-Gm-Message-State: AFuF++kd8XpZ2zQRaNWpveEGwn3+GKiw5j99DT6fX8BG7YaJx5bD3B6D
	nUv30Rlp4yMpLlbd90yVewrpoNJ5t+z2KLgJhKbij1o1ZuOZxHVUXxL9tVwRIAik
X-Gm-Gg: AR+sD13nLCgcJ0csJmW02so2sK3t8yW9c1tJkL5LqftdpK8X8JXenDbaYn73AzrrDKp
	c3qq4B9BP1Csd47wESA+hcq0EKaN7hKR/7a1GC8rJlBfrbg7OFxnmW8qkzubOfyetCz0zNjAhH/
	I/vuo5dyYqJlqk8TiQgHA4J3fB7jYJ3ycPTFavPFMxp+LotrJj3NZHe/Y4jE1j689FL7EO05uv5
	Wo5fNDQoA9AxGX7bPd1o8oeivPgndEQZMVTlF6YyJUcJmhh/38zfZlDY9dLjRYlcLwZUwh5vlth
	cpEkcA+Ty4vXTw9nyjGiv0XzzgMNutG84gie/5PkTnWWLyLEvq3BguEEGriFNTiYoNdWRbkyuV2
	9fyvx6cIQhVVRnuh6QoU3CpR2EhHfOUU6M+h5ysvczghHjhqYYng6Ou+O+1+iJEFDj/j3u3e0FA
	Ti6dx5yBE0UuWcZeRR5Pe7S/Wk4q8Trx8XWoxEPwAJcPJasvh9f4a9fczy8h43NL040ZdIMeXJV
	RI/QR4HZ2VGadxyocAJDV1EnwVQrfQ=
X-Received: by 2002:a17:907:72cc:b0:c21:2c32:e2da with SMTP id a640c23a62f3a-c2556d9fe3dmr1081954966b.8.1788091678234;
        Sun, 30 Aug 2026 05:07:58 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee09eb6sm304287966b.10.2026.08.30.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 05:07:57 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2 1/6] sparc32: use memblock when mapping the kernel
Date: Sun, 30 Aug 2026 14:06:40 +0200
Message-ID: <20260830120742.20950-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830120742.20950-1-linmag7@gmail.com>
References: <20260830120742.20950-1-linmag7@gmail.com>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
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

