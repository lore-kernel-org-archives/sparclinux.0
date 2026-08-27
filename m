Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC04749E2
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842502; cv=none; b=AvEdYWz7IziXcyx8uCusXG8HIHHOet7ROEBRm+kLb0PxU0w/TCynhLoavB4+N3McizVwAyYYpip2qydNjONYCOxwDGMILTuyAPo5jDGCIC9db9jzzBSjOqSPQi+rSrB8BsGxVMnmE2SXpo2ueuMbx/ahJut5cq5mL08e9z9Zf1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842502; c=relaxed/simple;
	bh=G2x9ITkmgaQ7ftG3op1tzZ7VUpu181fs0yW5zmt0d0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgSJIlquwNhZ0g1pDF8C/d+6+5lfDtg3o4fXXlrUM2r4laXj8Lg3oXpNIfNmPe636PyRNLRRZpMHRu1UP//Q4cndWLFTzaZVhj/9tnxmzZnYwFuzEi4wSzLK7zvbrwTjii5z42Nmnge2XLQkOIEmZgjE71ZfaJ/YOOQDjYb5/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU7BQQ8G; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU7BQQ8G"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d72ae08fa1so7237275ad.2
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842492; x=1788447292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZoOxuIaHS7V5bxkfafbNTQhPHSEQfYqrvpRkI+Xt/E=;
        b=WU7BQQ8GPo1LaYDzHq/pzr5cQ4u1zDvqQrala49hVaCz9HJojOQ0b1IRLGaIg7MHiF
         YJcZ/DffJe73xfq8w4Myg9a+pnZJdLYzilV5Uwumg6kdJpfHGe+P5til/2wzxTUreorD
         JNXvicJh/1bx4beCq7EnrPOxPI5ltswaZX88OdcxTd+/RDIg5G69Cr//x7Jk4VviTTev
         Pz9+YUU3JmJT3XyTOdTyV/7wKYZbIREP7LKAVXhSDk+Cl7VcYlVayhPfGTHYQ2ALLB4y
         Fuq8Vf3Kee5hvPXK0ktQEXlDO55jqguyD/7PGM3t79xGr/KxsYuVUv9A5OLCm2avJCnP
         Jx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842492; x=1788447292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZoOxuIaHS7V5bxkfafbNTQhPHSEQfYqrvpRkI+Xt/E=;
        b=ivCm9+vrHbcAUyF7nqIUKneWNjoOxeTswRSJdX/iLeFn0qfZfbI9QxZplnBur6Fa7L
         wKmj5EWa/Kd7S87aiMK5k5EdVyeVbSkf2zqg87v0YWWo7bs2hi9kHYE/e4M+8oIu8VjK
         2t3KmhGW950fqXPrnCeH45G/KTlCFxYAjQ7sUD8+WwMGCnvdxevwa6GK5pdeYhhUZ33N
         Zwsf0lHhaY3qVGXFsgeaDcisQM41xg8nN5d7+gKMCwbek6SckFY8NRL9df0BXz21mIHh
         fXo/FMxZj3Ao4TAaGm0SWcVJJMePRIfmgB0HrFqsWSUjAqVj2Qvj7YskxC4tJXWnqr89
         Tszg==
X-Forwarded-Encrypted: i=1; AHgh+RqmhoYqbPYjbcP/fZ6XcJf74WuKUoFR3KeGrI8Xh6qyZtyhAl92prCn32nenQGcEFsVZOBKIPcLujEl@vger.kernel.org
X-Gm-Message-State: AFuF++mJIbGIN2tOGvE11ooLV3OQTjwrtAv0KO7uY/lm8hNT1OAd4K7z
	9sOMq5sN0xW41x+DdpOIM/wKbP0/oM5f2IxhzbHV29GHyHKgxFNvfwMg
X-Gm-Gg: AR+sD10g9WeDuTa/5JQ8Er8+z0qCbQ4yBNTvuJuhjFqGgDaZcfShS9SLaybRCrSDFIa
	p5BNNWQ89QHMEh0RP9S/AXBVDBFG5oubcTNJQaQXapBU1OymjFpXu2ZuTOaLuP/IFaT0ZLXCUk7
	YjCvOmZD8FFflWHMIULtrDjNTUKa9YLBInZiiJEAsE8R5hglKEhgF5q8WXCWaE1G+qjw6IRMOf7
	p3EsXxtcb9H5TJH9pTgkJSwdqpUVLRkwqyu6DPrecxaK2j1U6JgXsL3EVMOkg8nICjngemhBDjP
	HxPvdYy97ddQYj6zv9RVQ18MsONbawoM3VITCl7O+Twrx/hYEFCLoHy4uEkoB+c9pp0HJGuiVeH
	AvWMZ0jwcfqfG/1qNqNCFYJ23U4+POu0qOdyRa+Qknv3aRTkseWdes0ZgcJYlnQxXdZfzH+/UOO
	qk5ppGT3ZORgAg3Qr2KeLwcOjijitWwag1jFbkIb4slELV0BjIC+VFKBg=
X-Received: by 2002:a17:903:46c5:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d707a5d142mr295443945ad.8.1787842491290;
        Thu, 27 Aug 2026 07:54:51 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704b9f555sm18725405ad.40.2026.08.27.07.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:54:50 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 1/2] sparc32: remove redundant memset in arch_mm_preinit()
Date: Thu, 27 Aug 2026 23:54:33 +0900
Message-ID: <20260827145437.490605-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827145437.490605-1-ekffu200098@gmail.com>
References: <20260827145437.490605-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_alloc() returns zeroed memory, so the memset after the
allocation is redundant.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/sparc/mm/init_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e0e66f91ceeb..b4f31d41d665 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -255,7 +255,6 @@ void __init arch_mm_preinit(void)
 		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
 		prom_halt();
 	}
-	memset(sparc_valid_addr_bitmap, 0, i << 2);
 
 	taint_real_pages();
 }
-- 
2.43.0

