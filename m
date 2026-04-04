Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02D1B4223
	for <sparclinux@vger.kernel.org>; Sat,  4 Apr 2026 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775287105; cv=none; b=iNz2KDjLtFFjv2jdAJIVc2kHXS0aL3kFUZ+NY3aU+PMGCM8m7RPUhiEGZeoCyqz1k4rfw9EpVtkZdMM9wEGyKSsnBF937XCcXX3mAK7hUr9VlD9of+NAHKEgkIBnpIsa0zcx60vDzx3vWwDekafT4QqQqCQE8Tj9z5V4aCh35Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775287105; c=relaxed/simple;
	bh=w6hr2fger12ipP4mMrn/hi71iV0xtfKYCOSttrgEhLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ti8N1n4xcpu8eafEUZeeyEvMqujmwl2Lu0txMurGm5oIUUe1jX7qorfySE81oDMv+PP47agQxBZzITJ9r0pk3ol8KaqM3tZVrowwKP99pmhx7UWN7baQgjppBR1S3DpSl9kOaM1jOd0ttNNG/Xm3jl7nzggHoeAzz319E0yqFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IIIaYFXe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IIIaYFXe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b258576d8cso15752565ad.0
        for <sparclinux@vger.kernel.org>; Sat, 04 Apr 2026 00:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775287104; x=1775891904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y4Zwv844O5BRtbiO3p0keEYr5wdjmq4nDT8xkCMxlw=;
        b=IIIaYFXec13OBi/5+SRIoiJMD5W7qPja4iENG3y2se2t4N5KUD9me+yNAr3Ua/M+kG
         3C5JxNkGEfLBuNbP9ICOPAe5R+VAP3WsQ6ybpn0Gt0w/3ONXaVpmcnCYu5GFr435o9eO
         kLkveDBXy0Ru55y+/xAiPTTw3TMwyvRcti8HA744XE2Kymw8zFMe/IvKpqsRHdjW5dNZ
         D2pFQHWOUddHB7sXGwUqAq1fV4uPaNKsBWL4VuRkdaJ/1U9S0elmfPQ04iCGAm+EU0/6
         7GhpXW+HLv2aMy1TV6yfMNricC8tyqFqjXVeyAYZS7QaQKX5rhJq1MHVz4hnU/aJxYm8
         tetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775287104; x=1775891904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Y4Zwv844O5BRtbiO3p0keEYr5wdjmq4nDT8xkCMxlw=;
        b=k2ma24jh8POza7kvwpZnVRfAY/opJ6b0N7cSLI9r+k6r/cpvKMy5PKxe932XM7As1h
         a5SbBHcMNZ/HquyiyGw9akrIgOpmt4vfme2DzwaATMY0KMqnBIA8TMzQMUopO6TEwOyL
         UCgFT2CSf2XoR4HRCQJmMuFPWsI/8ksoa0UJ3LxKcT/DkbRgINPDoCmbn5G6ErKGfxp8
         mApgJwvah7zLV4I4KW7++oQNteSgIJg1sdIDa4Am1EteKtuh8pg2cgOo67/Az0+QoYic
         5AHAOh3HysUza29sm1pNh3IkGeG35L66/2nzTFr2wvbb+SxukzJlzBTEwZkgKxV0Obs6
         hR2w==
X-Forwarded-Encrypted: i=1; AJvYcCUBJntNBxA2ZzmdDV9Y5x7KhtIMeo/4c/L7jwMzIu9BnsvvAM/erGzos0u9reeiXQXtSh3QQBT0WpSS@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOzOD5zPEd7j1FfSVGUSjB24cv8XlbVCgsUXOl130BdHIsHXc
	vg7pS+a5AcQ9Nzf5l0SxueIHxlhPS2DDn/0U3Wn54njyQqTW7bHNgEOUMQbhfK9Pt+A=
X-Gm-Gg: AeBDieuSPLGRJnvirFoRyoLd7AgWZ+jRbVS4A2CuCxDCezUVVXkmR2y0aDZKW7dLHa6
	9/+Pz8YHHU3PN3RitKqfySpz8CZr/tSatX1V/tLiCAqsm/3nNbYKqmxMTiX6n4LrKatyBp5Nvh8
	dDhjg0i5oRwP2VrXxKXm+O363mfRFl3KbaD1SVRn9thH7K95ayxh4HwfZ27N4DfwKLZqp9uW7nE
	P85SbSN9Em/R2E9pVCNPVnz5nZUcby3unY35Khaqq8Zm0DotVoGFgsHaeBKQcu0rpYtMG5OOKhi
	O67xOvk1MGct7Lt3feSrP0DQh5hUw9MoFJJNIYXesXN70J665qli4HtW6qifNFT3Bbn5xj24JZw
	Ld1i+5MF7bDZluK4eFxPZ21Js2u2RBPqIOUjxpmQdhqqb04dEfmWi2rB30k80YBqFYXSnTFuvkp
	9hvZMIxiTik9FkVUB0gI3WCos3/aABA/jMwig29riEslI=
X-Received: by 2002:a17:903:37c4:b0:2b0:7b57:830f with SMTP id d9443c01a7336-2b2818e4f2amr53951005ad.33.1775287103580;
        Sat, 04 Apr 2026 00:18:23 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979525sm94675115ad.45.2026.04.04.00.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 00:18:23 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Chengkaitao <chengkaitao@kylinos.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sparc/mm: drop vmemmap_check_pmd helper and use generic code
Date: Sat,  4 Apr 2026 15:17:12 +0800
Message-Id: <20260404071720.3577290-9-songmuchun@bytedance.com>
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

