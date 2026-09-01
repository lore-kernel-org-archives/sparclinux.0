Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968536196B
	for <sparclinux@vger.kernel.org>; Tue,  1 Sep 2026 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299204; cv=none; b=bb0884H/Bq8dpOxfDIAjhYY1yPb1BZjm41ig98yD1K5/VxgMchRyLURIrP63OMOHtYjw9N/oSaD9Fk3DVwey2D+m0Ezb8lHyChqAWdMVNZhIm+lFwWybVc0RabX7OjxWT/RkEXs/hupvBhmgEiDYGyOWo4qoHxU3d1HtHpbltwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299204; c=relaxed/simple;
	bh=z+smutewlOq/DVax40CqKK7q1Y7YvZUwgS3R4KOIJ/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGo4YoQx1vIslko0mIpJ71jqIYFerwj0/QqTasqcwAWJlGlwocdDA8bLylAdtAL+vDcs1aUQCOMgJz9Jor7X/W839Y+JW5kUREL49vunFYjfGwHeTesQjMo0duBXHYaAhTtfJ8gr8a1Zlea34gY+/CxSkSPKcI00wgSwup+croo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbd1D/hP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbd1D/hP"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c25344a8c6cso38696666b.0
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788299201; x=1788904001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yiQkNyFj/w6aOeqdi5RimSxmu3RrYESQzCuwF1FuMeo=;
        b=Wbd1D/hPpOGUfCMd3HsWyo0SWLBzdC3827/KrsQgdIU310mgnJsJnOgfw9JkLtGNnO
         DhteeuOmObBQs7D6iRUjZfDTh+Bt4Ufmqu89NEV2cqANrsMclw7hD2Jx+n0qahfSO8S8
         Lal2U4WN9GcLv7P1V6fZs1VC65NkVeJiLPkCL+Bs219Iz3GL/hwM4nmQQ6k75rQpgKQC
         hgxnxuBw7R0ajpQ+oboZMsXUs8pK2lLzbrTV7G8P/vwdbQFRibbtdxUUeNnnZuKE7j51
         4mFwAffBEaympy8wGgndRm6aBNqZoik3Mry0so7m11MD82Ots121AII1y+lGcgTOTeDr
         T/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299201; x=1788904001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yiQkNyFj/w6aOeqdi5RimSxmu3RrYESQzCuwF1FuMeo=;
        b=VowvwK85KoB6XEt+CFyDxDbfWc1XiqltKlxOWy/9lnF2JQSF+c4fjIH9hj5YNI09Nd
         22YIpx9nJG5z/ORZ6gjUn5mXXUS/K1b1uLRi+t2VWNA/1yzjjCGvmI9IlaLvfsVQatzy
         tnONKE6faeKDUD39ism5WuHhlPlFLk/nRJFSCCFLJk5uqCm1yGJ8CplebGV5DeulRvol
         0jWnGT86o4kesE7oN8PjEq5bzvaMNZHCFD59kZmd1YpoV44wq9fXJ7bz0ENxhEWtDpar
         KJXtgvYpzUrmAKVeVufRqV81nKjLkd4grfnC2A9q8Fr4Vqhj5g8d+BHHXVuhW9DXFP54
         s/dw==
X-Gm-Message-State: AFuF++mhIOL3seUysVMbpYEtloba2kAUXLOiFzejNXd5zIvDQf8CcnIo
	3OFER7buDkfjjI578dRR6hWGRTRSmwvGACRctxvQHLOmcccm5ot08OeHps6YvA==
X-Gm-Gg: AR+sD13T+d/+ebQvgP0cwZlVcWsdVuI3/K3O/1b7qmCcmSfC1AwMI4TH5SyrHYDKAnY
	kwT64jdTHskA8/Ba7T8nTnXQCoZjcMwNttJakpM/Bfre4OlthRCz6N9as2J5iqJzVexAdkL+Hql
	abAX+jlUuquxZaZBJQYcNHxs3nxw9N706O11+eIe//ceud+LKrmfsdC8s017u5FRPeHGsDoFcRu
	h3YfjAHVc7hll9UUK+5HN0E4UDzHYeY0oOvPZnApRts0HXY4KqpL+Mkb7gL8qTCWxnYVBMLwEqA
	0S0ZFJVfx4kVZgtpW2CqcZV/OSosgXRRTc8OByLguytFamcekwWS5f9GRBGp38s02Y42p/vcika
	35h7HMvCNo3aDzFVpWkHk9e0fR9z5kKWRtfpZbq+Imhurh1zcJErdw3rEwKFakiZq/NrNt3h3xs
	1y4lG/g3klmrsHlhOy6lsvBilCkQOf7iUYIcLS6N3wacCWJ8exsRZxaRudcXrVkRFURnja08/yO
	hDd8BZrzhgrv2tt+GtlcoTfng9KqhG1S7DBYMbgnA==
X-Received: by 2002:a17:906:478d:b0:c25:848a:4a8d with SMTP id a640c23a62f3a-c25d52875e3mr17277066b.5.1788299201163;
        Tue, 01 Sep 2026 14:46:41 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc70fdsm27500866b.4.2026.09.01.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:46:40 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v3 4/6] sparc32: drop unused valid address bitmap
Date: Tue,  1 Sep 2026 23:45:48 +0200
Message-ID: <20260901214611.60560-5-linmag7@gmail.com>
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

sparc_valid_addr_bitmap is populated during early memory setup but never
read. Remove the bitmap, its allocation and the population helper.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
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

