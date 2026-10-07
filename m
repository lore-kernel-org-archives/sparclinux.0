Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE573F107E
	for <sparclinux@vger.kernel.org>; Wed,  7 Oct 2026 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394911; cv=none; b=G+yNpQYKTqtKHYi1RB+u3XtAgDFno/nAK2ZdPsblfJBCwz/tenIURKIcjRW3F6nKI4L7RbzXTkXT2d3MBBOCvxLTWPQ+Vl3j8L1V/GXwd+O/lN3bo0VpW1UH+ev8E30ixpP3AJrcFD9c61mYxy4PcVoQkY9FzdqFINKqOdOAumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394911; c=relaxed/simple;
	bh=/dsZPKgs3LiEVy3t0FVgwAqo7s2V/HbIC3nNFSOG314=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVjdu+HE2ik+1KrcjHP4MuvAWBecebusxnEnI/7GVAZHaeQ+nit8qWaphgT3gijMsQB1l/QefG+xFJP0f4d4Q6/q6mOQFlPKTcP6HKqbAjI7fTWRB1UmTPQO2PI5hVfZaN3gX74xdBsdPDKasEJEs0N4kedY/32Krkh4OOieS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+QnFvTf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+QnFvTf"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so7398311a12.0
        for <sparclinux@vger.kernel.org>; Wed, 07 Oct 2026 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394906; x=1791999706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMyYSrhfIYHYqjp8mHUnXor+qxDuOXc+/5yPGSD7oKw=;
        b=M+QnFvTf6GT2IMpxUj2uG0YBnpBTbpdmqfQ6Svld8LmGA1pQalZiloNvUxRpeNfm5Z
         Q2TPC3k4XRNwkxTJCQtxTUStzfqINPaNSKmTWMmwmQpUXG2+i0tz4QZ++IjEiru1xA+V
         yGqNBcG0gZlEbQfaEoMVHX5/sFO0X532GC0l7tpruexiimpNuLk0KM6f2eqXFg9RtO7v
         kJzEmcGSAGWeYKWSbHWzEfTUsfjs2YHnYDXgTvFmrjmWXoNKgsJvQmnxnuJ414FUdUUs
         J0j3TUv+Q5hQzva5xpQj2fftrVFKwsGcEqbsmUwU+FhdGsNNGFn70wX4JLcRKfw7w3Uv
         UDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394906; x=1791999706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMyYSrhfIYHYqjp8mHUnXor+qxDuOXc+/5yPGSD7oKw=;
        b=tBXRvUjjcwEI90iPnhKOH/AP0SSvRxqlzHx7s1RmOUVKFxk6MzDwNiSS/CNW/b2TQa
         Lo7oqsUTOe9R0stwZ4YwAggZY6G1qvdipNwvxPT4hWeMwA9jNpHhp+i+DYAGqA2HsfSr
         VbhsEyaNMJUQik43x8z+6r1Ql7QJbhyUf4nIUh9aaCXtSiYjFlYqKsO6UQ1wYUlgTw49
         NkMyt+L9C5WFyz/pxy5V0hOwh27IzGbE3Z5jCOe3C2S1lqOXBbk7pAvKy1xv0OFzU/OH
         PsNFNMJON6gng2klDdZ5NWyHhtYr7uPsMdzp98VVHhUvTLy/dZuhxBSPk0P9JF7+xGKR
         ZTww==
X-Forwarded-Encrypted: i=1; AKwUvBwfR4ERszhr0ykrFYEwXKONrahYVTPQ+KH1XxdsA5P9OZJ/QfwnP30jO7ikAfElh9FJiz0noIar/xJ6@vger.kernel.org
X-Gm-Message-State: AFq9FYIfF2+cz30RYnwKVXU1TPWWaSr5Ai3tnQg3qTXzwsKy7UMcZqxd
	6PeKvhNx2o5j8hVj86fikZT3tQuVzpkBbKe+mjYJWY69lwqSq6JA9sr3
X-Gm-Gg: AYBFou2gRifYMWK924Rddn2Vd34PODA4cbnwNxdDR/olljdtbJY+gxA7BSUtLDzTQAx
	AMKNXl3aKWLbRBAe10g90o3z/ye/9Z62xsiaTl+067n4Kvh45mTB/idAZy2HldWYYRZmbsCPKQP
	Qw2jdGMRIlJSwvMH7ndJMDXrYDGVyRab1HmFxvs8qVwckK4CP6XOek7dPBvwu990i+b6Qu0+9lS
	Sgwfo65/8HvZ0DbWlM1jUGgYKZSbuAmPKQUkodatAChtLlARPgixqWRUAO4F3DnDokqpVpGDK9w
	R59RkfW/FnnHSmnIotKyQGZC9a+qK8fbCl+9QDh6D9oGyskuFhE22Yn96lGkdfdjfGFI8AwZt0j
	Tw42TTyJ0MwD22jHQiHPUKJwzBehlgOhkKJnT3sosN6+Umv/CGc92i8KfPTlKwmK7Fmy4RVpUJF
	vv0+WR8e6vHhFa7eGi9jSkviKe8N9nPMRWO3/E6le3ZCz2eaYZZI0hbS9WTErYYp2hwT5+hfW9J
	FCt6bOd5Z+0KmR7Z6ejLfoNfo0MdzLmfwAyJK7j
X-Received: by 2002:a05:6402:52d6:b0:6aa:f129:b193 with SMTP id 4fb4d7f45d1cf-6aff458de1emr2912087a12.22.1791394906156;
        Wed, 07 Oct 2026 10:41:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b009e80cd8sm356802a12.8.2026.10.07.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:41:45 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v5 4/6] sparc32: drop unused valid address bitmap
Date: Wed,  7 Oct 2026 19:41:13 +0200
Message-ID: <20261007174128.959307-5-linmag7@gmail.com>
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

sparc_valid_addr_bitmap is populated during early memory setup but never
read. Remove the bitmap, its allocation and the population helper.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
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

