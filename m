Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0D3C456F
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790545436; cv=none; b=LDG+mzAYfTLpXM2Om2JHrATzb1uv65brmyKZL1ULRVA3WOSw9z7y7mixYq4GyqVJ1UA6SgAayLBmYhAKR5wnsqdQAsVB6u3zDxm3ucAyuGaOlDTxicReYPASTc9wLviIywWpx9Be5/6H2H/M5SYVFBTSNr8X/0Vg5SV/YJ1Mpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790545436; c=relaxed/simple;
	bh=1531Yq/nVppQGrlAquxN2x1KLWXV3EHMaR/ahEcKkNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ6zcVbkN3ZKcbrgeSZeYNgxncswYjOHGqbCyLbrnu8GTFXTL1KNLxphBNoN7fBEjMuuPhdblcUGCYqZ7qr857BvHvXhvqBt6piNcs81jDtYv4tms9o0r9tzjEO3mBIYsiHGIzA9JfL1buzOSk9xT/Q/P9+XRIso7StrzZwcG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6yRiXMi; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6yRiXMi"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so349950266b.1
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790545432; x=1791150232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCuCzlksNfjrgkZXx3iznj1+OuURI9PaCP0uSZRfzi0=;
        b=S6yRiXMiMyMZeV8tRHFus12pwjI0dhnHHeLmI4YZmMjNkhFD9C6W1Oxe+837kWnXhV
         dfdRzcuAaIrGj78K9GKIqnCrBbtHl23YkjhjkvS1on3HUIByvq1aduekiHTxpTwmQO1m
         9ht1hFqxYEstex+N8d5U/hWbVgLYEcCvs7rVJtn+Dj0NdrbF/EOa/QKt4jQCyOdn+2iQ
         C+GO+9LEyQkA2eSBUdHS5EsuTv6Gu6FaV9V9DHoYxiiWPpcsoowU9S3adS8S4jYBpAs+
         04Hh3J0qK5eP3ecQecWSeEsJ4sl8in6ZRkpBO791ttKoXAarzq9F3LQXSwFO6l2uGypd
         yr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790545432; x=1791150232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cCuCzlksNfjrgkZXx3iznj1+OuURI9PaCP0uSZRfzi0=;
        b=IqZP8c9aZqCxmpUaAhSv7HISyOzY1IvDPUnHNo/2pHawGYjla2ZxFPBfUmRm3gmGBR
         n3tV6h3vVt/r1x1tEDZeyUrlZLM02yskR6g76A+XHmetZGWjd2whHejKmVVETd+2Y74z
         7nSLLA1N2alo2vW540Hc8tl8pwDMty9C+A4Mz3rNZvVFxMbz71e40zzgypWgSAQpMxsq
         TUfAFoXvAJiOzes/34Ox6jbQi6eWLU14I8F2xLtV0Y6GmHlLvC2gEAT2U8FkrFmX1UFd
         /cLw1AcSsfQ97y06Raj+d3M5Q8Xyvg67vML1K7MW/gGBDirfuKJgt1/eFSM2X86GG4V1
         DQ2Q==
X-Forwarded-Encrypted: i=1; AKwUvBw0k0eqjr5ATGhDZJ5MceUPLRPPQp42tno7DYCVOcBBXSAKonrXNcbWzTDostUjZ1FSgoBBoqRNUA5X@vger.kernel.org
X-Gm-Message-State: AFuF++maPtoVA03/7LeXs5Ma4+O4/IXXu51fVzQukHwfuKQITZQBNO+B
	4qZI9d1s9ICK2YAVFfXQ/zMMsyxjcgwk6eXORplxBJc1+dBPGyhn164L
X-Gm-Gg: AYBFou2QJDlZnh4plsJS6gHiz4HfHIdIeCYLNfbagTHtFBN+SmTp82VKtJelTCBXpcL
	9ftBNcieFnGppZzKZuUqycTtyDPNkfyoodBBKGBk0QYxkbpDv70ORQM/TPMOJWR77T10Qd7D7Pb
	1OMsYInkOWVxYWBbks1XMiRDfEuPzU8ygiHt+E3+7m1SzrnKl2w2Q0LIbfblZc8pwcXwUHZULtz
	HmO7A8HsFw9KlXibaR+N9XMDCL7I/ovDxulHI+ArZtY+vg3VmL2M/tbcRHaZFmSwfzNoGy1YlrP
	KteKAlczc/JOUxLA8zH+EVg8WdZl5UY219fFpxKxy0ykQYEOxQzcqrj+ulma76sggt/9NfEsG/t
	ANH/Ql5G4tC6Nypd2CihTawshgNUmG9dsGd6DgFLkeWKMoObAwAveFcT230udsARLDCxwqphG8X
	aloBnoqQGhZU640u8sEsgTBavrSx0K7NmcoqnZL4Fsa0Xv28wib2uJHD8kwoKMxqW4odN6NBifw
	oVz4xerMg4OaFFzPI1Prc+YIKjL9eKHE4Wm7rZ4oA==
X-Received: by 2002:a17:907:7ba6:b0:c26:19de:9ac8 with SMTP id a640c23a62f3a-c2ae9f31589mr606632666b.32.1790545431599;
        Sun, 27 Sep 2026 14:43:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm376091866b.33.2026.09.27.14.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:43:51 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v4 6/6] sparc32: drop sp_banks
Date: Sun, 27 Sep 2026 23:43:17 +0200
Message-ID: <20260927214334.886582-7-linmag7@gmail.com>
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

All memory-map consumers now use memblock. Stop duplicating the PROM map
in sp_banks and remove the array, its type, and its fixed bank limit.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/page_32.h | 16 -----------
 arch/sparc/mm/init_32.c          |  2 --
 arch/sparc/prom/memory.c         | 48 ++++----------------------------
 3 files changed, 6 insertions(+), 60 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 9f0b54f70908..7429291fb118 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -28,22 +28,6 @@
 		(void)(vaddr);			\
 	} while (0)
 
-/* The following structure is used to hold the physical
- * memory configuration of the machine.  This is filled in
- * prom_meminit() and is later used by mem_init() to set up
- * mem_map[].  We statically allocate SPARC_PHYS_BANKS+1 of
- * these structs, this is arbitrary.  The entry after the
- * last valid one has num_bytes==0.
- */
-struct sparc_phys_banks {
-  unsigned long base_addr;
-  unsigned long num_bytes;
-};
-
-#define SPARC_PHYS_BANKS 32
-
-extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
-
 /* passing structs on the Sparc slow us down tremendously... */
 
 /* #define STRICT_MM_TYPECHECKS */
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index ac4462f1cf76..2f693b70dbd8 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -35,8 +35,6 @@
 
 #include "mm_32.h"
 
-struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
-
 /* Initial ramdisk setup */
 extern unsigned int sparc_ramdisk_image;
 extern unsigned int sparc_ramdisk_size;
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 59962bc0bc82..3f65bde2bb89 100644
--- a/arch/sparc/prom/memory.c
+++ b/arch/sparc/prom/memory.c
@@ -8,30 +8,21 @@
 
 #include <linux/kernel.h>
 #include <linux/memblock.h>
-#include <linux/sort.h>
 #include <linux/init.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 #include <asm/page.h>
 
-static int __init prom_meminit_v0(void)
+static void __init prom_meminit_v0(void)
 {
 	struct linux_mlist_v0 *p;
-	int index;
 
-	index = 0;
-	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more) {
-		sp_banks[index].base_addr = (unsigned long) p->start_adr;
-		sp_banks[index].num_bytes = p->num_bytes;
+	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more)
 		memblock_add(p->start_adr, p->num_bytes & PAGE_MASK);
-		index++;
-	}
-
-	return index;
 }
 
-static int __init prom_meminit_v2(void)
+static void __init prom_meminit_v2(void)
 {
 	struct linux_prom_registers reg[64];
 	phandle node;
@@ -41,51 +32,24 @@ static int __init prom_meminit_v2(void)
 	size = prom_getproperty(node, "available", (char *) reg, sizeof(reg));
 	num_ents = size / sizeof(struct linux_prom_registers);
 
-	for (i = 0; i < num_ents; i++) {
-		sp_banks[i].base_addr = reg[i].phys_addr;
-		sp_banks[i].num_bytes = reg[i].reg_size;
+	for (i = 0; i < num_ents; i++)
 		memblock_add(reg[i].phys_addr, reg[i].reg_size & PAGE_MASK);
-	}
-
-	return num_ents;
-}
-
-static int sp_banks_cmp(const void *a, const void *b)
-{
-	const struct sparc_phys_banks *x = a, *y = b;
-
-	if (x->base_addr > y->base_addr)
-		return 1;
-	if (x->base_addr < y->base_addr)
-		return -1;
-	return 0;
 }
 
 /* Initialize the memory lists based upon the prom version. */
 void __init prom_meminit(void)
 {
-	int i, num_ents = 0;
-
 	switch (prom_vers) {
 	case PROM_V0:
-		num_ents = prom_meminit_v0();
+		prom_meminit_v0();
 		break;
 
 	case PROM_V2:
 	case PROM_V3:
-		num_ents = prom_meminit_v2();
+		prom_meminit_v2();
 		break;
 
 	default:
 		break;
 	}
-	sort(sp_banks, num_ents, sizeof(struct sparc_phys_banks),
-	     sp_banks_cmp, NULL);
-
-	/* Sentinel.  */
-	sp_banks[num_ents].base_addr = 0xdeadbeef;
-	sp_banks[num_ents].num_bytes = 0;
-
-	for (i = 0; i < num_ents; i++)
-		sp_banks[i].num_bytes &= PAGE_MASK;
 }
-- 
2.43.0

