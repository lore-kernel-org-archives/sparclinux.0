Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999646982A
	for <sparclinux@vger.kernel.org>; Tue,  1 Sep 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299207; cv=none; b=ZmN7TITEsVGqK0JMWWeHXj1JflHyVx1nQKh7wNpWzL/RBx/aEXkhWwJHDCnsZ3CCsWrS4sAliCXz09yU3CGgKYsz97IIu3bxSC/9zFPGXE4LT54uiSj1KumK9rH/cxNuUvF8KEuR3TvWqmMaGF6gFDfxESSTWAwIfybp5Edg5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299207; c=relaxed/simple;
	bh=GDJx9sH2sNSxbOwzq4dSkcb9spfCBs4Kvg21wjvIkiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7HHnNTofrGqJep2WXSBT4EHx21dhAbsK4yJV1fPuZozs2wrUyG5wcdIoXC1D1TvOuIGVzoZGs8G35oLv0pNQSbK+sbnK2CpzZ1iU6y75fi9DUUoStFcb+DVy7/mTTkbNu834lf+8PEyt9/Sg+tzdDgut0mxGxiFJs/Qi31AMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCcs465C; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCcs465C"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e592da74so34344066b.1
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788299204; x=1788904004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lUPNB03Hug6YvdWlUe1liatgYB+MaJgHVJDKZWHDKdE=;
        b=ZCcs465CWg0D90E4HsDKDpZQXFZye8tCUZOaH8P0vA/xC9XHetwfDDX0cbnsCQY97M
         hGqOFb5im7s/A/VAgJiysulu2osF1KL6k5MmVYQw+jW+egYSAUeBgOIzEtOvUbd1t1iH
         l8GjgMlW3T2ok6MFPaMMWR3tt1nALRT1fFawEl/wMAq5cL8c7Z3eqtj6S4ib1dHJHU4m
         U1TtOlU9efqubMzCLrHjClaZoF7iTeANm0ppmnTkzcdrkWlnsFH5+XpHD78wphqROZiK
         BTgNsiZJ67suVOykDZcfjKEJDcGumWD5xyheaVLIGhV9yjW1JoHa4PMJsrPFGz7RQa54
         soiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299204; x=1788904004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lUPNB03Hug6YvdWlUe1liatgYB+MaJgHVJDKZWHDKdE=;
        b=ZXIDMzYbUujsAaFyp0QMXw4HtMqhfK+LXTscRThHga3uCqdLiZKw0tDNfmcA23N//i
         wb9M/cz7XgtYesaQI410b11sj3x0ipeiGm7pZThiXGIOpbvUzNYhxoOI/5RH+3EFZ0T9
         E45LNIQPgKdbOVEAsD2fmOJsJewM4NpAWUU+sADGYhpDx77iFUMgYTS7TsN/qmxHN09H
         d6mpbH3dbopl5VdENdFp4KFDhzrMP4rIa1P8XDDzzNm2Al9GgXTI6Y2Nc+o3BQ3cHh7e
         bKiAXAMTuQ4m5IbfbN+ESUa7icOKuQzvnX2H5f4PVjDJBESsCwjw7quY4mjRrXfCDSs0
         Tqkw==
X-Gm-Message-State: AFuF++kh+JqsEL+ikBV/gL/vcwcGxpMSjRgbjGMTo+Qpd7Ew15nDiYS6
	FE0SIei7/vw6s6vIhrj/eo6ZZCQHE98aYlM8HNJZ8tArtkpIEoX8vMfoaClvNA==
X-Gm-Gg: AR+sD134aG59CRNwqbmlfzUkTrYz92SWNTYr3YZHADeLn6/Soxft8MAWVpwSj3wYTzT
	ykJvRZV3gVunCWu8YHm952Z9W4N9UZzkeyYFRhTjjB9Vj8Q52tFd2auca8ViGxLSPHYmwFoS8wf
	csGS49IXBTEfxARxRTPE5OIWSw5nDtI9ShPSXy3sawYafQhCfYk4TbKGLu2TVSKUFWB3LdZEB6Q
	S7pdtK+e087l5tE1awTe/bJUSzkowKl0P4D6D8JlNmi4SjOyvUoWw2AK6fatC+CW0FWogS+Imbk
	pO3vmwjNjo1/KH3QXH3GU+kqrZbxmd/hs67E77nSCSKL8KqA9X4OlIVnWKh0AKp4PZj06GOK37e
	mOrQYVAdw9MFUIJuYw3J1gES770jfOKVgcA6/t5tgND+D1n+ys3AkS/Le/BHoG1EbuHybWh4Xrh
	dNQHPP0LU4q1koWwPt5m8yOHx0FSkax+yXq6sFH8GEKDmHZGoeWHhd/mNmrd0wGixqJphpKPFnb
	TL8x4vD4Iu2TRYbv2QFrPCu76OeLymO
X-Received: by 2002:a17:907:d89:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c25d547b88amr14288366b.7.1788299203837;
        Tue, 01 Sep 2026 14:46:43 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc70fdsm27500866b.4.2026.09.01.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:46:43 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v3 6/6] sparc32: drop sp_banks
Date: Tue,  1 Sep 2026 23:45:50 +0200
Message-ID: <20260901214611.60560-7-linmag7@gmail.com>
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

All memory-map consumers now use memblock. Stop duplicating the PROM map
in sp_banks and remove the array, its type, and its fixed bank limit.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/page_32.h | 16 -----------
 arch/sparc/mm/init_32.c          |  2 --
 arch/sparc/prom/memory.c         | 48 ++++----------------------------
 3 files changed, 6 insertions(+), 60 deletions(-)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index c1bccbedf567..5daa5fd8eaa5 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -26,22 +26,6 @@
 		sparc_flush_page_to_ram(page);	\
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

