Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341D2877CF
	for <sparclinux@vger.kernel.org>; Sat,  4 Apr 2026 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775287112; cv=none; b=fxJhdxoWQz5MKFbBLt4+pZ+is8EchHH+A0nHD6eHRnhV+1Dxv02xg7BBD5NRI/2+bL99U6bf0LWSmq+CWxlzMQ5Ppi8YuXrrOCURa60iNE+IdLugssCmaioFNMSOGQjbA0hl/XM1W0/BaP8TnpwpnAj57zGyCj73htNhK8w0WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775287112; c=relaxed/simple;
	bh=w6hr2fger12ipP4mMrn/hi71iV0xtfKYCOSttrgEhLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5z1p8UWYwmh1INqFWapZMDrmn+8VW912u7CMlBBKIRPOVpwxIGEogydYosy7gXG+YxeEHqrVzel9jCqItKIQZO32mOPgATDXrfMLFOpv1l30JPU/mk3c9a38mSxlaRdu264x/NrMvrD79zr+/76BaILfb/JTHrUx56S3RUVcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Bo5he7Ml; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bo5he7Ml"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a8fba3f769so9775145ad.2
        for <sparclinux@vger.kernel.org>; Sat, 04 Apr 2026 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775287111; x=1775891911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y4Zwv844O5BRtbiO3p0keEYr5wdjmq4nDT8xkCMxlw=;
        b=Bo5he7MlCzaQXPUfPZyzIUSBuj9zraceTd6IB43d7R9YMAls9Ne1c8JwdQqU2JYDmE
         3NhsL0Yx3rdJLzRXlyIytnZAaAmbyal9duQvVTUNaer+LFJ6gfOXTddjgwCUA/kF31N4
         9q9U2NTtRfHOXqRSYcTdZPOo6MpQv5NsF7jsBvNJCc5mmtOEAyEKE5LglRVM/7tJG7Lf
         KrJkNTrs+NhwhOAcN4BmjzrR/VYHrFwEyr6cjGkxDCNtNtEK9nlppBc65AKEoBSAqlM4
         7GNzyJk9376LFBaxsyjEYZB8bFItIApW/X/VexFXC42SYaDIV59u3c2Uf3ERYZ6kIb/P
         uF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775287111; x=1775891911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Y4Zwv844O5BRtbiO3p0keEYr5wdjmq4nDT8xkCMxlw=;
        b=SEdRqS1LzGbV6XG0oYh1uBEreyMehw63x7uDbt5RtrYKqch4L9l4gNc5F4dEbgNitX
         MWSt7b8W4Zyx2h19+M7ss6Pk6dobWJPX/AOSHL3T+hYn/Vz98DCriHLSYjVkj7lYpNb4
         t4gvAz8/c4g6R+TEoKwy4qYg49yWGktJhwxzQSXJc5JWHplE5HajgWHcIICcyG15vKgO
         6bmQrFpKgZHJol3TaQS6zvgJUDzbc3AUMz73K3jo7C+62uCUX0dpbYxQhNsRKk0S8+t8
         LcLsfjAyvQHZY8WrKFDRf6syCuY7ZDPJm4GRGYHXzubAji6hzuHiRrbqGmeqjV9/wt6B
         hgtA==
X-Forwarded-Encrypted: i=1; AJvYcCUDSbLX8TRuo56xCaiSwwRlkd9WY0dSby5kGDsphxLPRSMFVz/UjljhlEj2LEwsSb1k3+gLZmee8Uis@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DiAjjPBinbkDRSD5Ws8j0gc9XyeiNlwBQfHgzZejEqWYME2F
	Igrd1h8yi8yjMRFix0pIrUeuQe8wBAA17qKlTTuf0YDsiG+Rvc9TV884314TnQip7qU=
X-Gm-Gg: AeBDieuGJmEAmYzPD+mCftFUgGfV3Zy0FFGinOp5tuo0JX/67sEtZ7XAwaVz4ZVJwPd
	Upgm2GhqPel0qNjF55K7VKmJkzKCd+B7G/ZMP5nq0BIBBeYZJd+StaIvTfOXxD17fGMvQ6mgDru
	AGW7y7AZLhU5NAFIniB0Bsca58GmNej/YVfzdpLXOfOeozp5fXDGC1a7NkYqiXUGxkFFhzNDkZ8
	HB40jiGEIukSFQ65JXry3S0iRqlgJD640r5ZtRU7C+NQn34R4xvCL/BKNAFczAmSpo05+5pdFFR
	bZduPKdLk9/0SHJp0s49nXaVqX3YgwaqlEfCSEFlAyrKox1e4p0k1wT/fAmAC3tDxbFJvc2bBIj
	tD7v2QkuXUbeVg8955Cokt+ADzAzG2KKxcZHb3Yntth63dl1o8988vKHl5/i5fPi1gLtgaeKujv
	FlPVLwWJ4jUTKgKlBQhhos1mhEZuL/PLV8RmGiRteC2lU=
X-Received: by 2002:a17:903:38d0:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b281833d73mr54978555ad.26.1775287110736;
        Sat, 04 Apr 2026 00:18:30 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979525sm94675115ad.45.2026.04.04.00.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 00:18:30 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Kees Cook <kees@kernel.org>,
	Chengkaitao <chengkaitao@kylinos.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] sparc/mm: drop vmemmap_check_pmd helper and use generic code
Date: Sat,  4 Apr 2026 15:17:13 +0800
Message-Id: <20260404071720.3577290-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260404071720.3577290-1-songmuchun@bytedance.com>
References: <20260404071720.3577290-1-songmuchun@bytedance.com>
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

