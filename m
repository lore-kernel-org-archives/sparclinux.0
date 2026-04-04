Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DE21A447
	for <sparclinux@vger.kernel.org>; Sat,  4 Apr 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775305309; cv=none; b=rDKg2492Eqi2D8bZvJTWf8Wk3xKffS0dZ+2+rxJGVky84aiA2Vb/3depu6v8N0Xx01q9NffXtSMqn0Mvnn9WXt3cxrinYdA622FnS5QOW9rrPQwAmicwgnoizaA35tIdw4KsplZBrvrpcxgyV4cscmE9Z/8P2r+1Wa05FKmKSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775305309; c=relaxed/simple;
	bh=w6hr2fger12ipP4mMrn/hi71iV0xtfKYCOSttrgEhLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vux8nvZdzgXkMsq/UiF5q9gx8Xt3oI7ePYqrIk3fVda8J4/0ubgxtnrdTPtnTZCLNZqQBVof0uCP4t6SuVW+nrbOLm1FKFHx3n7HDTL/QRTDQsYLLnOM4/A/mVEAM48lCXEvtK4hZlRKEE6+NR0Pmy8b48zcpy4o96xVPteBBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SsIKU/97; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SsIKU/97"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so956628a12.0
        for <sparclinux@vger.kernel.org>; Sat, 04 Apr 2026 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775305306; x=1775910106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y4Zwv844O5BRtbiO3p0keEYr5wdjmq4nDT8xkCMxlw=;
        b=SsIKU/97RXE6gNQsSkQ9w53pEBxGXLfc6fdhsGgMhrk8PjZXVKUoHu6/0ADAogojmY
         aE25zaEfdCU8vGbUSSfU6UcQf+poN+FgepTFlwGI74sq1zkfagBQEdOQ2KOPFbDOwv6i
         4a9+HBWci54X5rID8a3z5cn2eZlyEGRsU3TKqwen5wMk2yJZfKxdE6rov9ikhcWJGaWl
         TEiH79aD6zVW6tLALvssZi8T4k7MMokhl0DpKeQgigkkeJN+FxZZ8RuB1K0rvQaBn2L2
         y8nu0s3RuxfnCdANdf3rcSQZUXav+N4n+qIU+wZZ55A7k//ct2gjNlpYkCAqCWJ9k+Uc
         DEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775305306; x=1775910106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Y4Zwv844O5BRtbiO3p0keEYr5wdjmq4nDT8xkCMxlw=;
        b=SyKN7JbTb4nyqE9gtfThD3/d6Jm62tyawXO3tq86wBA2vy5G5ZtFCZTtPeL56DAsmc
         KzbwMWrhdlFSWLe3MnsT7jYkV1t33dCKkBZ6mYqvgvXtnIPYCE0IchulC42QpkQlHF4t
         G2fJxcL40SOHtQPEePDRe7RoFW6/ai2Pt3cvOD0Au7OnShpoxjywNoH0dlADGRfZZ8LE
         UBdiuHn2ZhjTLI9qWMqcMc2SES4Cp4MRf/WvJP83kCvwJo+hCOUfocOPaDUS9+Sqv/6p
         mRm1ZJSduMqhMN9K7G0DF1YtrXmapVSJ+4uXmhSJ7WidWwGnETKgwpd75nt63zgUwzCF
         jXFw==
X-Forwarded-Encrypted: i=1; AJvYcCV5pdZI+xB8rz1VVD545AuOFJRWA4KRG55gUGWrTe1f0iW1r6o/cd+dc03Do1aETkUpMo9BEIOnXm6P@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxdi8ziJYg894H6UmxBddYxj3MW/Iro3m951SQOcmnM+QzvzAk
	6HON8ad8Eca6Za3FqoA6Is2X0EyTQFx7i27cMTwYjKA4KRsEJIslGUWMPdxBe2HV+jE=
X-Gm-Gg: AeBDieslpyP/lK2xLAEMC3eVXA0RO29BJorj4KtHHA9cmE9+k/iCuF+K/nOHYrFbLMs
	D7O6dHyyx+3D6zAY2q0Xq+dc16HnPmUgg0HvGzBoZRvLFskXy9MPMItuh9YZQm2dgxWJ3Kdk3ZY
	on3RWrvbyh2wO683mRwucoTeH/9p+XhPNYhf5BmaZUalPa8QTIVtKPTKlsdpP3HW3XoaJRss9AY
	fHZcQgB8CIAUKbt4QkacSwykwFK5CIb+dfJXPZxa7eE5KRnEKIXoCCQtz0EYJWpQQzQKKRtCoGz
	vZmeqp60AfANvNc5x1CuAjR1vyrCxQ+wTvArwOgo+NThzh1Ega5ztjqY6k4He54Zzll9JGFmrzi
	rEjwYKEGnlm6UWUcQsX7OlDskrwGn1i6TFiVJCQv3ghD0Adej+8udMoeEvprLKNTjY7EmfkVdBF
	12f90/BolkEaJhXqwC+xAACw2LURV9gQRzRTCuZgZysEc=
X-Received: by 2002:a05:6300:2109:b0:39c:c07:1450 with SMTP id adf61e73a8af0-39f2f20dfd2mr5649641637.42.1775305306320;
        Sat, 04 Apr 2026 05:21:46 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cfebe5b23sm8327063b3a.59.2026.04.04.05.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:21:45 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengkaitao <chengkaitao@kylinos.cn>,
	Alex Shi <alexs@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] sparc/mm: drop vmemmap_check_pmd helper and use generic code
Date: Sat,  4 Apr 2026 20:20:58 +0800
Message-Id: <20260404122105.3989557-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260404122105.3989557-1-songmuchun@bytedance.com>
References: <20260404122105.3989557-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic implementations now suffice; remove the sparc copies.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/sparc/mm/init_64.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 367c269305e5..4a089da0a490 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2579,17 +2579,6 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 	pmd_val(*pmd) = pte_base | __pa(p);
 }
 
-int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
-				unsigned long addr, unsigned long next)
-{
-	int large = pmd_leaf(*pmdp);
-
-	if (large)
-		vmemmap_verify((pte_t *)pmdp, node, addr, next);
-
-	return large;
-}
-
 int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 			       int node, struct vmem_altmap *altmap)
 {
-- 
2.20.1

