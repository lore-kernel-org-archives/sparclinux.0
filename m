Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFFD4C8FF0
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855304; cv=none; b=KMzM7Zp85e7IzjmtPcPuB4pBZx/5f16FnvlwZpXtPvJ4DNbCs5E7mlQaTAVbxZ+yvdDfWTji9HVxCG0M3LgzqjJELoW9KbhctZBNG/U+NX2nDRIsEYWMl4fU10d6CB8qkHlVo+ossOH31Anagmrljk7e3jtA6lxQyb+jyDwXYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855304; c=relaxed/simple;
	bh=viX4jjItsK90zTlCcfaBZvb8khmRSizMKGI4tuVmIXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je9IujQKw5MF1GeDVFCpR0hJarMyIeHuVSveTbT6I5wj8Lx/SEVouApyTxgb5sUj29HvYvROEX3lYmV1iYV9iBffUQCHUNqsjmByRgX0sts4T+u2rWbv9YfUNuFtHk9dSHObyhiNcrOHZQBH5tGB5YZCFrLwm9QPald0KShQtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeLuOoOt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeLuOoOt"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2055573c8cso21032266b.3
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855301; x=1788460101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKiiL1nTCRECupJrUkk/zMnddPMRB/46RYLC+aZ136o=;
        b=CeLuOoOtVYaLooKONVIIUgwnpR/x7rtUeKYybdb1FZHGZrdn0NoFrdB3EUiGQIi+yE
         9pfKltnIGL4OMygqeb4ZYCS2XOYzlKP8GDrxkYsAJC+el+RBwkJj8UtGrLlLYs7PMNP7
         gj//5n1S8V+Z09axgEfYbGKVm32YTba+si+Q+8j16OL7uadkEA5JLnukKbl+ZM1GLZ8R
         DmZRHZfXBrjfaYs0hFvEm+Ws3qpYT9+Rwwo91DvviBgqQHg17MevSUN5TUVdVzQqMndb
         IdqWsd9XM2OGgrXbCBPApADkEeVCJL07uBNbJebm0MkyxCxl1nJ5oBW6QpqYkbKXDTJN
         ilKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855301; x=1788460101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKiiL1nTCRECupJrUkk/zMnddPMRB/46RYLC+aZ136o=;
        b=Nxs8uJEyzRN0Lnb5FtQQALbK3ipcdwn7z9E4etqgvix087RxygVeNhGlJALU2r60d5
         jaf7TxMraasVP9k6s95GSGsRFkLLwFvKtKDAEjB9p/BMxi6s0e8eOGYfA4EX8ZQETFv6
         dL6z1BwO4MgloyEuuwIa25zZdaGp1GMv8S1oc6PPQy8lUXClA7rOVzSGNIQoH0phhzBe
         Ff8FxpwcQ5pSTgGCIkLYGFHKQbCGvGiBakZQccWhxBLp5PqvVf/xK6mmSWnwNa7q+udT
         zc0CpYeJlBvGdxuanJEQzBS+4w/kcBof4O45ipgOD6d8H9D3CH/JkSLsly7JM9odbTY6
         VXkQ==
X-Gm-Message-State: AFuF++kNZNiQze8jBkqVTJsgnRd+f8d2OiVhOgvDaZTOHyfAgE37q6Sn
	Qk7tt++GSUZWekhvTYvxkp6UKoLwNUUbd2DBcscDFAqKP3knJNgkgAcQFWU4Xvg/
X-Gm-Gg: AR+sD10df03/ztuErkkp7o6VEfztVQTOHn9aI9YNyhiwoEHYDv1vpAYKDKE4FTLwtG8
	CLdGNrSMykPqHnJm9KmBxYJGGPjMgmn9L4M+tgBB0znjxaOo72oczdw7zRxcqzHjeCFOji01jv8
	Xe07j/q2YLy09lq4EtF8RbPIbhUay+zaOqkwI1L8rhljk9rFTtig9cvvfUCHU0mrg2fCFfqd+Np
	ZgZPeUJXtWUhOt5Ul+4+mqOukWm+Ksy4S+QoNlVXiY4Bo8cVf+pQWFi8xnNrc2SiC3fYligYWaa
	WKKi59+gQTzqiknxEQZVcY2xOkKBudhWpHXE7OOyjIqR2cqdWFeZ+Ws/IHkaWwImLkypFEKWOhq
	gLt7nUT9ft6VVnF0d7EARif8/qrccdMhlSF2f/rQbaeu4QU5FMgFKCxTd0P2U1zJ6x9y1hRrQ17
	b4vyWobTe/2k4+hyGiEg4UoZJGEX+w5EAOiRR+nIGPLvp1ImaYZbuY6kl5b2s8M1pd1u1GrTD+0
	IlGSp9AyKBpNq/Da/KPKzinjD00SEH8
X-Received: by 2002:a17:907:3c84:b0:c25:541:fd3a with SMTP id a640c23a62f3a-c2556c2f178mr55885566b.7.1787855301357;
        Thu, 27 Aug 2026 11:28:21 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c254e4e736dsm61288266b.11.2026.08.27.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:28:21 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 3/5] sparc32: populate memblock from the PROM memory map
Date: Thu, 27 Aug 2026 20:24:15 +0200
Message-ID: <20260827182757.6856-4-linmag7@gmail.com>
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

Add each available PROM memory range to memblock as it is discovered.
Keep populating sp_banks temporarily so the remaining users continue to
work while they are converted in the following patches.

Since the complete PROM map is now present before bootmem_init(), enforce
the mem= limit after the legacy bank processing. Adding a smaller
overlapping range would otherwise leave memory beyond the requested limit
in memblock during this intermediate commit.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_32.c  | 3 +++
 arch/sparc/prom/memory.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e0e66f91ceeb..75050dfbc2ea 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -165,6 +165,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		memblock_add(sp_banks[i].base_addr, sp_banks[i].num_bytes);
 	}
 
+	if (cmdline_memory_size)
+		memblock_enforce_memory_limit(cmdline_memory_size);
+
 	/* Start with page aligned address of last symbol in kernel
 	 * image.
 	 */
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 269d6ab5ef5e..59962bc0bc82 100644
--- a/arch/sparc/prom/memory.c
+++ b/arch/sparc/prom/memory.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/sort.h>
 #include <linux/init.h>
 
@@ -23,6 +24,7 @@ static int __init prom_meminit_v0(void)
 	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more) {
 		sp_banks[index].base_addr = (unsigned long) p->start_adr;
 		sp_banks[index].num_bytes = p->num_bytes;
+		memblock_add(p->start_adr, p->num_bytes & PAGE_MASK);
 		index++;
 	}
 
@@ -42,6 +44,7 @@ static int __init prom_meminit_v2(void)
 	for (i = 0; i < num_ents; i++) {
 		sp_banks[i].base_addr = reg[i].phys_addr;
 		sp_banks[i].num_bytes = reg[i].reg_size;
+		memblock_add(reg[i].phys_addr, reg[i].reg_size & PAGE_MASK);
 	}
 
 	return num_ents;
-- 
2.43.0

