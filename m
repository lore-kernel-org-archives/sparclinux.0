Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0904D2ECD
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855307; cv=none; b=ainIGMP5YT6gNbwLrwddgAcwVZIoEBcPJM0oGWHLkdzel6noY5wPprQKFswWL7t+He8qLnWTKBDVlh3Zbs3iw0CxDs4ILWOQPFeRVvkmBwFT5oXKCDQ/BlEDPZAiAqHKz+hMnHpm6ROEV8WMk8tGHipetFR61ONRsjXTluHaJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855307; c=relaxed/simple;
	bh=kfvcDNFLDvpPA7sqXYTXffon/3kHbf04QAWcOZvY6gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ+DbgT7Xipo+iIRVwJbCq4Nj8aXKuxo0Xn08GUXa8rsYQj82MypfMb98E+Osti5sJ/p8+GFASnUP8d2B/+WWBTCx70ZksMSUvmh/tU7r1o+t1U1ptFJdaIb17/jrgKVEdqFprhwOanJPsxrz2J7BaenV7QHfnr1XO8a80hxcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4Os7gYj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4Os7gYj"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c20ce3c118aso23704066b.0
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787855303; x=1788460103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6wG70SWFyuhXCTUL7tySjRNucUOB8Zz4p1m/bUcF7/Y=;
        b=W4Os7gYjFiHKGhjaAR1ueRi0aTApjuofo6gmDP5rUncm5wO2q82eudYvIJWn7c51lx
         FEiBMv/5GM6tUYYtSxZGGnJljyH5fE9cnOY3H+bmerw0RDxSuoAJxirQ+NmdfKbfQvJC
         Mv9xPzoLrJ0bQw3e2a05VQbQxgmRFJfk/GN4WezAf5gOznQQ5qRkqKnIEGWKFGscHmYl
         46l5KvczLnRYajQ1NInsX1+PUPqXLRJXsN4gLEyKdngOy3juu5qxnVO3/M7xbTh/o4Xy
         UMf22l0fl+OJDxsfDgJkzagNIEC2xsXjeXwnEfPvFxVubLiMxueIf0301acgqvRatdOy
         eaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855303; x=1788460103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6wG70SWFyuhXCTUL7tySjRNucUOB8Zz4p1m/bUcF7/Y=;
        b=NYUsiLyyxKDvs77rAG+ek3PGiYM4F42veLChKz5pXU3ofVnaykeekP3JvL5iTFwBip
         GIccWui2tgUw5Fp9HPngeznhISz4NUMLECASkh3TiQEvehnxQjOh0NZmu/ti0dqrG2PH
         U5D7rIG4wEFYO1+hQE+HdmawVsY8brRGk3E+1BZiteeG2sNdfTXnMgXGImWEhCVbGBtV
         tY+e6Ia0fWzq4CSvFbBG8vDynbgjgL67BQsSes+SEtr7En9SWhcnmsmpmvVJ+R6RKboV
         03isCWoAzvKr2PuNUObwmqt39VopN7/FHQZaLjtpKq0svKWw7IFOXjpgZqJb79XesGyk
         2iTw==
X-Gm-Message-State: AFuF++nQRAiIyq0t5qY976Xm4PFAIdPq5VQDPq6Jr1wP35exL5sn1hji
	eIl4n6UWNnQkVFxhXRdxi2fVfdiP9z6+e9nJnxw1TCnHNaBUGFmEb2FYbPQe/Ymo
X-Gm-Gg: AR+sD10bar/xvdPrWP3B/5PX+4LVPisHYUi4M/Q3ZcczFkSeK0PAt9kXPVErQsjgTnI
	KdKkJjBP9K5bC28YKfZ6gTW0IrRWdcpPoP+5p+qYqjlrRHzoE6fP7QXdPUc9fBbjXSYbMvzGoWI
	p9kHdVzhnWt3zpLuEqFjvXYn/CAezTZcuu916N1mAOuZWkK/ThGUgxtQfeLD6ThpzBg76JMsllG
	td71MlHGXDylzlX/i2/MYpFm8smxC5JRt1p84yprbp+/CUpIGLiwjysmg0/XKiCSeMk1BgDencx
	KYxHzBB34HEZ0aGoIS1zraLhX/gdJGIRC6Xh5FoTBZy2mIfpf9Ueu8V2b8GqhpO7fD9F56GTNlZ
	f3hndamuhbWpvFwxaNn8e6457oVA2otVlgy5Gq1Ne7R85e3HJmwsdu8EEVhbJAQgAdikmC6EHyT
	sp/uUR3WJK4WPc7BGwzsFPJ/ZN8QD+mzVXckl+4wTEH+CByy+Q+PzU2Dl5pZ1YMlFrK04ZtkEzw
	OjOpypIOU6WtzOPJdCEPl792TYtpo0=
X-Received: by 2002:a17:906:4784:b0:c1c:49d9:4c34 with SMTP id a640c23a62f3a-c25360ae6f6mr650715066b.11.1787855303372;
        Thu, 27 Aug 2026 11:28:23 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c254e4e736dsm61288266b.11.2026.08.27.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:28:22 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 5/5] sparc32: drop sp_banks
Date: Thu, 27 Aug 2026 20:24:17 +0200
Message-ID: <20260827182757.6856-6-linmag7@gmail.com>
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

All memory-map consumers now use memblock. Stop duplicating the PROM map
in sp_banks and remove the array, its type, and its fixed bank limit.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
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
index 62c41d896421..4fc77ccedcbd 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -39,8 +39,6 @@
 
 static unsigned long *sparc_valid_addr_bitmap;
 
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

