Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB43B42DC
	for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091686; cv=none; b=cG/aY5kAgEoYz/siaE/FL8c/OeUZZAoKsaAVpxFMHLpM6jtFtViq6bigcBzbY3pioYvmMD9p/R0IRzRQsHrVxFJ/ccaWgNDJbQbzwm+4DdXJI76N1acsiY0sWD7ycFrzDdsidstYwtWM9bt3B2RaCk9eDi91t8PNdWXTdL1CC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091686; c=relaxed/simple;
	bh=z2qi+q5AJnkxlEfjpzpDgsmodaQkxj8lO318C99t39Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqANKaILm5btP+1oQpBfnrFKYg6oqL64ArQa9tgEzedXze6NWn2iH5MUUFZfrAAnUk3dxa0zU1iGDxhoeaBW8JBp1RbaitSVRRltjz+vTdwWxsfwPrKjJduMtZzAUIMsODj94fvZx33l5tt99KrJJ60+cF33ThsgejXrBTxpoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQHRUVz0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQHRUVz0"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c20ce3c118aso501239466b.0
        for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788091682; x=1788696482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s3Gsn95qnpdRU3YZCGZvsdQTe2c2T737LYOnz4pViig=;
        b=EQHRUVz0gmOjv2JeljJSN4Ip4fZFeYtMqml+pi8mjjEz7FtuDum0KDLF+37tyKvW1C
         GsCPgV8QLxV+nwGHFVL9Jjj5LQSknAm4qsbRmDurhXQXyRrVWRKWHmDLAEQHqWNbwZeY
         Lad8gze+4iyiJFJ7WpINDuuaBvuz+E2WmioiJ4ohhQ8ttz7xeIW1WBdwf53ZHocmSbiR
         +60iaWc0rCWxW6Ecem/Dz7VubZWkqyLmvTAF1ndRnPFN6Mg3+Gry03vsXYjo6OUCQHJ0
         zmmi96Wpncs9/XSGn6fZvvVwdcgp0iiPSd5Gd7Ub0s+8k/6kkl/V4GtnIWzfeHRWPaXz
         aAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788091682; x=1788696482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s3Gsn95qnpdRU3YZCGZvsdQTe2c2T737LYOnz4pViig=;
        b=QdoBsNYV8zGmSNioIww9F61mofGmtd7rhDVEFYq+8+cji0Dihcbat0/51x8aaviFgn
         w3bIHkOK+19X2Rh4WSEUIA4lAS5E1P1G0ACAw8KTLUrKJ0+Qho12ZPg0vI1AX3zwajhn
         gfkXY1ujTiwnlBl8eWM56ielLLLSXk6bibVrmhmfbz+74ztom1DPDLNsmrfVZZl090ET
         sLSKUdU7ONJlUCdcnFwA2wDGoIUKMMaLUM21vyT6ipDgFTiA1UVAEZw+xiGJEcHItsrB
         ST0fMi4x6ZemVcMJ68bTXJxCQgIv0kmJPS/KrFQ839C5mGblkiUZYOrfIs7z8r30+kup
         /R5Q==
X-Gm-Message-State: AFuF++mCMJJ1lhj0pANKk/ZHk0WDIa8iPWIfbYj2k8cMJ17FxeJ/Uuok
	2HQhd/3cspSL0OF/iWFySSRPSXpgDfJ8rtgDcn4Rfgd0ZjcOVHlFnwlgwVP5XbC0
X-Gm-Gg: AR+sD12LZVimdxu3YDd/wEDM2tz3EYBLFcYkkzakzSoXsTFumF0xVT8Tn9398eUgnDe
	Q/rnfB0UvyXTG65vRWmiakNloZ+AvbLeeOwH4f2IFtBgn3Jp40VR+Lq+UX5BzBWsu+efmPfFy/E
	QjcEny9eJZaNs56i+eDKkLntaDThX50bXk7DiZ54cy6X8VCPLIKEHsuabuQo8CEa0EqTvK2zJbi
	sVUFFSlDwlWV7/VPXLJKvqkqxzI2d/jLq3KWI+BDmN4DuWo7smTu1O0KaiF2C5ddLEI/eOZiKMm
	+W/FvvCL8s66uY4G7olrSYNCx6KZ0mv0jFYyyy7FlTscBhztDrG3LmiXt+ybDv30ITDjftEtmuT
	0phpCbEuakcLVQNB7UrJJAXudzABEIEE4ccy0wwwV4QXWNpwexA1NjVvHuzDIoL/j/yVW6yHx/J
	2bHVxDyQClJQhlUDf2VzKffcLh88Uh5SYzMJA8RtuPSN0Q7AXyq7CCuAPksLhyS//kLnpvV4y4/
	JxXT/z4EIYYg9HEdxKEqCa7eLnhC5M=
X-Received: by 2002:a17:906:eec6:b0:c20:7cb0:f33c with SMTP id a640c23a62f3a-c2596a15f75mr96669666b.16.1788091682244;
        Sun, 30 Aug 2026 05:08:02 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee09eb6sm304287966b.10.2026.08.30.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 05:08:01 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2 4/6] sparc32: drop unused valid address bitmap
Date: Sun, 30 Aug 2026 14:06:43 +0200
Message-ID: <20260830120742.20950-5-linmag7@gmail.com>
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

sparc_valid_addr_bitmap is populated during early memory setup but never
read. Remove the bitmap, its allocation and the population helper.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_32.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 75050dfbc2ea..6880d9cb30a5 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -13,7 +13,6 @@
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/mman.h>
@@ -24,7 +23,6 @@
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/pagemap.h>
-#include <linux/poison.h>
 #include <linux/gfp.h>
 
 #include <asm/sections.h>
@@ -37,8 +35,6 @@
 
 #include "mm_32.h"
 
-static unsigned long *sparc_valid_addr_bitmap;
-
 unsigned long phys_base;
 EXPORT_SYMBOL(phys_base);
 
@@ -218,27 +214,8 @@ void __init paging_init(void)
 	device_scan();
 }
 
-static void __init taint_real_pages(void)
-{
-	int i;
-
-	for (i = 0; sp_banks[i].num_bytes; i++) {
-		unsigned long start, end;
-
-		start = sp_banks[i].base_addr;
-		end = start + sp_banks[i].num_bytes;
-
-		while (start < end) {
-			set_bit(start >> 20, sparc_valid_addr_bitmap);
-			start += PAGE_SIZE;
-		}
-	}
-}
-
 void __init arch_mm_preinit(void)
 {
-	int i;
-
 	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
 		prom_printf("BUG: fixmap and pkmap areas overlap\n");
 		prom_printf("pkbase: 0x%lx pkend: 0x%lx fixstart 0x%lx\n",
@@ -248,19 +225,6 @@ void __init arch_mm_preinit(void)
 		prom_printf("Please mail sparclinux@vger.kernel.org.\n");
 		prom_halt();
 	}
-
-	i = last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
-	i += 1;
-	sparc_valid_addr_bitmap = (unsigned long *)
-		memblock_alloc(i << 2, SMP_CACHE_BYTES);
-
-	if (sparc_valid_addr_bitmap == NULL) {
-		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
-		prom_halt();
-	}
-	memset(sparc_valid_addr_bitmap, 0, i << 2);
-
-	taint_real_pages();
 }
 
 void sparc_flush_page_to_ram(struct page *page)
-- 
2.43.0

