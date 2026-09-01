Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5F36196B
	for <sparclinux@vger.kernel.org>; Tue,  1 Sep 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299200; cv=none; b=lvmqlEISJop36QCIRTicVd0dkCjxamB6v0ntpS+FolmpjVd4koXysXQsK7wHMGG9cMVCs/JzpcEMGZqOjRwZTOayzA/0SnOYmyyzOo6BurC3thUTDxi9X9imrMbicD/iVi+ZBzGD6k9jXVqE0WAatORVNlh6zOhsCggA67EJErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299200; c=relaxed/simple;
	bh=K1Wl/C/kiCwsRppKYsbDUf5OBFrVx/C5S3UJ3x2cFWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsRKPAKncoQBIIe3xe9CXTf/WlSIJsO8eIexs4KvGiaOHdkXLIMiXNo+NYTxQnG9L6eI9+a9L2WAoB5s+zXozfhlb9VFzXFPtusTuBIORPGa+LB/1zo0IDcoLniAmLF13PRefAFKN/WvU0/gDlLw1SwcsyGwH2Njvvu3R7DTlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGdXuGWX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGdXuGWX"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15e2dab83eso48463566b.1
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788299197; x=1788903997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvfhRVJLik6BIqM90QcnUBNMu0LkZxv6XmlGLkglzY0=;
        b=IGdXuGWXNBAnBqxs0sX9JV23rnUHpmPRmPMLZ70pi9t2FgwnlaZbcXKspGlsw3Iw49
         U5N9XpJke3wsHjR1hwcBqsoFR1eY00M8RQlodKs6FtvAHvk1CuLWomhplzOI9ju9fn/6
         XKV27DrCGYHsnnzlEjdNcg+HyADqPyxQQs4nHWT/mA2PuOTwPt2oNlPCwJwa3JxYVeZp
         VqmDVjujAoQ45uy2Kfz1YZ6/lJTCriqEBnJ92uc3ogJxUagGCLVqDBktqrALCe420D9c
         /YUZ4POMgv2/PxgGwtOh5TUj2ahDLyRjmZGIeWJp/eqjG0ed8hcYt2qZQmcevgk1tw2O
         KNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299197; x=1788903997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvfhRVJLik6BIqM90QcnUBNMu0LkZxv6XmlGLkglzY0=;
        b=ronruOvgk+zE9Fw6OXFZAlXQBDyHCnaeFDnXVgg08uCWtCYSza5SiaS3uor7yY1Oyx
         GVPn11ndz3iDscGBB6J3JhBzEb/RncqZjhyT83dG241q0OMSras25m7RkgMP8lHsIpym
         wju8jJxuJ2c/J1tSPDTfhWSBN6i1gg2t7Dn8XH1/+vOajKZMJFHQMqqvGL+BLHi+FOjw
         eHS2G8laYrbia4KkYK8HbpDuKNDrnWSQ6QluyV7QWPD2Up0L14vO3qjNWVPr8XObm++F
         1OCUp6+X68Jgu3sPh77EaUdl2JwTUb1K2HhDe3EuWyIeteew/xcNombbm9r1lLheeTQD
         6eTQ==
X-Gm-Message-State: AFuF++lSN2lyytY5dbIrBAzfm+Z08JJ47J0RQoeOY+JRm9GP1xNPi6XM
	EyyZboA/WkMinrzF1Gsvnq9g0eWYQxswg6m6S38IOOLsCqkCMHEm9KLJ9q7KMw==
X-Gm-Gg: AR+sD13nWl+xi1HTLbj1lfQ4tp2Ywyo+QgOKtnL9UgwfTCTCY1nxt3702r94S81BN8/
	FJMtF/9RaYr2uxo8Q4tD5vbtiJK2tjEtSnpBXKOiolUDWpJH4Ep6tMGe6swFQAnDBsB3sHfxkU1
	6rzjmfTzoOSb3Df97syK5C3xZGtV+4dyqJ4xu9jO/KRNzMtlYzJ1d73EZZKLPXwP0v27lduIkjo
	tt83fv5AOplUfTeGo1DXryRqUFHwszdOT8ME9ihK5mo+NNjFitAnqx+5LpUXSqrD5Tkr7UQY1Qv
	aKhM0AJn8mLm8FGLtkqhcmklhqBxCQzfJotI9kFLacKPCCoJqAHZGavO1pnj/yGxS0XYgiu4iFs
	w6gUjln+fwF7OSC+odiN3d5Ui0aOO5LD+B93T5/KL3gTQSIjmR4eWrElx2u+WOUi6ODITuvSRjf
	/ZaooF3jwdZov6QFnJe+FlHLiFLJf+MDDqTh+PX8u+HGfmuuWzJ7+MoKvyKgOecOFhzhfEfYA4z
	XR1jI3HtfAmlI6bVrchKQVC1wNiR7MyU1IBgmrXjQ==
X-Received: by 2002:a17:907:c1b:b0:c25:8878:3e09 with SMTP id a640c23a62f3a-c25d561620amr12442066b.22.1788299197377;
        Tue, 01 Sep 2026 14:46:37 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc70fdsm27500866b.4.2026.09.01.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:46:36 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v3 1/6] sparc32: use memblock when mapping the kernel
Date: Tue,  1 Sep 2026 23:45:45 +0200
Message-ID: <20260901214611.60560-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901214611.60560-1-linmag7@gmail.com>
References: <20260901214611.60560-1-linmag7@gmail.com>
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
index 1b24c5e8d73d..23a6383feb15 100644
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

