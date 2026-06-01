Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B8346E56
	for <sparclinux@vger.kernel.org>; Mon,  1 Jun 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303762; cv=none; b=eZJFmFapICFNSpYGhmWYvHYL9Gf07z/8PcZJk9yOncG/SpmCHFKXQGhqX5ED2sKxg4aQi8fLp5541KlH8Qo+4UPSNo04wCR+3XRwUQg/tVBkBjYyxFWn/FiMC1mDOAh0kaiEbOMAo47s8QgzQBPD1ry1bvaB9UGJO70/xBiIRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303762; c=relaxed/simple;
	bh=hVBoWuTqxj4bitzB4Qyn9047IWyGEV2cC0xTiRzqADs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taXIg5PfsXJtPnpIHpp0Xa5p48Hqei2LgMAIk7qFn9RGytihDjOzrJasB4kMU9PCLu0aeag135IJWcr2wRLmqQBmUvNJVZmfAaHn3v9WFdLqmnW8/VR/NY/g/UFTErdZbttyGLYU59c55siOmJ/IlWXj3TFjCN9jeIuWzUIE4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IOAJ3ElA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IOAJ3ElA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f626a65so351202b3a.2
        for <sparclinux@vger.kernel.org>; Mon, 01 Jun 2026 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780303761; x=1780908561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myBbZVt9pZizoKTbw79TdKlIez+dzWm6VMZTcEDpjws=;
        b=IOAJ3ElAV8npLZVWt5jVEvnVpotDWHgzpZf4ufgKp8ypyqBA5dPSEFbdQTaiW2fmzz
         28iYYhKLGtEKhSuLolXzj19oAv/e/TisrsgQGleB1Js5NqM7mIRNFG8EQtdPNgb8Y86z
         O2EVuMGI3VUKr4OCRkeA6pOridApEFfZ+O8juic0DsDxu5tL6Le66NX/PhKGcARA7rd/
         IF3fwEpFP0NfkrsFG1gngapCma0F7vkaQ3jQHoTBcH6F3zWJXwNAA8gNPWLPesoCZQxX
         kIlaRS6u1yabA2qhVXmV2TRYD59T5AN7CJMad2mJhP5Pr2wGjnaSK2m62nRNDL72GI4g
         BFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303761; x=1780908561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myBbZVt9pZizoKTbw79TdKlIez+dzWm6VMZTcEDpjws=;
        b=lK8c30G66r05HtIQ+SZQIiI67bZ5Cp4VT8PHOFJq/9sptASDJVUK7lIp5/whFXYUTt
         ORyZX8UP+paq4fk5fLGgu22HQ6ntkr+Fw2qFLXzRjDaHOkoyUGrZlL5YW5mTVQt2+aNC
         N6vjA9FQWq92t9ssb2dBxhW4HMiTMB2AoAWWXy5CVU/An61HBGWcu6/DJF4T2mp1UnP1
         Z1Ly4UbOs8oay/ZchP0TCZhl4c/rNxE4Qp4XROWl4biZtruiADJBBjhpvtgak7sKL52M
         z0BhBGdMopuIMWixTIVZOgHxH69lZ0VReXf5yDhDwEWRVoJSLs3bXWfeL32Uuwwolr6K
         4m7g==
X-Forwarded-Encrypted: i=1; AFNElJ9n1qj+l4uQHMeqGpqm5npVKwxsXkAe0yb8nHO9bKKaXXZbDLOeBV/WXaE0Vt2+6QSdMrkyZjA7+oxq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh58N70OEwk21AvI+oMt6Bi8Ei8UxrorjKlLJAtP54gEqBFz5c
	ip31k6n3V8dTTUYpIm4Oj7evhSVbWmlC8AiEErnc6sIewo08AuQ0bqX1ea4KH1tJ0/s=
X-Gm-Gg: Acq92OH/7JG+NGjZpkpqIuM1nNxQUDZlAY/veO4BSIDPxFevwIjAM6w0nghW7g6J2nW
	5BKNO09WXSfTCjhaMl1pGHQs/zZKmEzhnwrWbicBReYe10LXjnXH9ziNXHUwmat3nN8vQw7N3jW
	r1VU5XaKyLDhUAfZAm9PmWwJsdTu0dRTd0RFyHkBj/7cjOTGDJE29P29THgHSDL25Xkx1zl7XAU
	bgE1YAfHmSI0vrDaw24WFcbIW72TbJqS8ljgNBtAobBWHTO8/sfRMtXClcDfdVtE3cueUmb6hw2
	TFNJu/w9YoxwmmdxrwLj2OylutrPYliI1FgCZyhDEjU+4HS0RkFfzHB9kdVWdDxiMwvdeq1rJf1
	ESfC1g8ZA1L1BQaki4jDEKnOut3kS0lBOPU2qciakw4gG3ekgJWTkNxawcHaM0hGcDPi8vHijdY
	Ssx8LY5dfwLHrg0mkqVEqL5cchZr9brMm8FsbqG0i2rwzf/9YfgjmJeA==
X-Received: by 2002:a05:6a00:3a0e:b0:838:29b3:9ed1 with SMTP id d2e1a72fcca58-842255c8233mr8977076b3a.41.1780303760714;
        Mon, 01 Jun 2026 01:49:20 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm6316230b3a.12.2026.06.01.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:49:20 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>,
	WANG Xuerui <kernel@xen0n.name>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 4/5] loongarch/mm: drop vmemmap_check_pmd helper and use generic code
Date: Mon,  1 Jun 2026 16:48:43 +0800
Message-ID: <20260601084845.3792171-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084845.3792171-1-songmuchun@bytedance.com>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic implementations now suffice; remove the loongarch copies.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/loongarch/mm/init.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 687980b6e91f..3407030f3e7a 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -140,17 +140,6 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 	set_pmd_at(&init_mm, addr, pmd, entry);
 }
 
-int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
-				unsigned long addr, unsigned long next)
-{
-	int huge = pmd_val(pmdp_get(pmd)) & _PAGE_HUGE;
-
-	if (huge)
-		vmemmap_verify((pte_t *)pmd, node, addr, next);
-
-	return huge;
-}
-
 int __meminit vmemmap_populate(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap)
 {
-- 
2.54.0

