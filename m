Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BB345CD8
	for <sparclinux@vger.kernel.org>; Mon,  1 Jun 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303749; cv=none; b=WYEPciO1ul0LS243oLDc6JvcA9e/UEULRA4ptDOXur2U6R9a3ylqPPUAMB643pEcBLOkkBXz1NdzdvrS4vqmyWkU9KGLkt90jJateLcMm4EqxyOXr+9L/Z+p9DTLDFI220fNV3iCP+5riG2WSq60Lwjc9Bq6XAYAmeLvZNm0IIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303749; c=relaxed/simple;
	bh=wH70zWV2qRQtDszFuov+55ovrVEDAsgUnnbN6OqXmcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmrjHAAyDJNn+IDerws+TWkkcuddlQDvY5E14XVK8a6bk6gUIA1eLPlsuI0OerNoJcpZ9t372YbGCh9eX4wflWIyDmRhg4Difj5Oll8Z1HsChTLFujI6iPhfO5C+8u6CD95Bcu6NTGld6qcd7/G8hVP0hmwlhDyBVW451xztxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TjUr9rZo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TjUr9rZo"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-841882f8f4bso3300039b3a.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Jun 2026 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780303748; x=1780908548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct8LTm9E0tar8OtNDyCoaad0P31p+YAvHyjb0MDrcWY=;
        b=TjUr9rZo6I+KBXS3KtHWqCYmwariRULVAXJZMVZl0n8MCMJKpAp50WFFtmkxG5mJQa
         QlaXzYSBq8tbYvVVAKb6/bys8wx7t0e38x6oBvqR/6QSjtz89KFbWPy/jNB+BV5UMoTS
         xuH4ydBkWGCdhAA0v4lI7Y8Op4DJ1d+GlTuA31oBfxhWljJhvPR/jTnnh0g4A4szsQDo
         xbZJhixtq1mnUls3L+M9ZzGga1tkX0rHlI72yFzACts5g5qPFszQRZaFNJsH1nG8qSZD
         wHkYm7tnHowZAP3dzEPRuwj59AWKKS1EP99o3NYG74vUsr6zlXIzlBFc8UeEEEo4K9Yb
         +A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303748; x=1780908548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ct8LTm9E0tar8OtNDyCoaad0P31p+YAvHyjb0MDrcWY=;
        b=dUQQL/7h6gingiZMfr1jGjkMJwVFkVt03kGkndhhVOEKz75ORbEqxsoX8N4e4Yrtgn
         U8k3zQd53JF1U5ECX8Yp/MFYDrYrttJPCuRHhkKyVC55jv5Aw8sNRbB8zzHQJr4aGJYO
         Pi7DIsOPwfVV/cVs1BokhLNwwOJVcmq65oi2uJ/LOIiKVZr1BKm3RWJdWYlt4WjoOLSF
         1Bsk+vdpOlEggbD3L0XphZVD0p/UnB0lyUYi9d694guTqahzX1Szujp7UvtGmazq3hH0
         Poo8aaV/VSD5d0JZNorYyfJkLTT68dMEBHvzgUn75qRSgn/v+cDKybRkevaZWBmj3E6N
         +ofA==
X-Forwarded-Encrypted: i=1; AFNElJ+1q92HivLNLzvT76LOZDihYPdbVQ7e/D7O52JddSrfyxbJiAf7SYBwE6Ya0qzkgSRMrH1xckG5gnzi@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBKN1b6NKsGZEOBAq4hEuc1KS/a7YamKFaIZeH2Hsnaq3Yzfq
	/q303CKhzCDmI3XTy2e++8SXGFFQBqLArASSiT3pFu9vC9ddP9k6DybcChBl2lsZbd4=
X-Gm-Gg: Acq92OFc+gsu0Vq2Zifs3yjK5LDlXMHREYja2/wRN0O63khvL2IsoX4dAM2OUxMi2VM
	GDPxegcGp4fC6OhSok8TYfvFP2BS9doF1/dPAsgkqwAc1HAToUceTyWMmFjhS1gUtGbnGPfiao3
	4TBa55jlsZqKCz9KMJzSiq5Kn2iEaAS5YrnjWeRPK116/VtFYnxeE6oD6eViPS6iDdrkP4Sc7GQ
	ucGzNtW0EFNE9qe2OSIbl3kGuU5qoYlT1XUef1hGwHROVY2KVjn9f1PfxzSjQbgxhBreQc7zUYt
	wgnQXw6FjjYqHj/3tfRcio3dph12+rkHYhvwfrpmvkUufEd/kwOXfzUd+IXCPAoKL3LhkX8pBmH
	LdcFQbxurEpK3SIm4F5Mph67m2+FQKxsD/MOVgicqRWmVqCIFcfZ/Ym72Wa7WwSATbMni2GGVH+
	aSE64vpTOR+Jy9fI2S440VZbjGZGDDhc6g2l9KcE7+pHKWJuyJg+Pc6g==
X-Received: by 2002:a05:6a00:3903:b0:842:2382:a0ea with SMTP id d2e1a72fcca58-8422535fc9bmr8854602b3a.14.1780303747688;
        Mon, 01 Jun 2026 01:49:07 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm6316230b3a.12.2026.06.01.01.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:49:07 -0700 (PDT)
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
Subject: [PATCH v3 2/5] arm64/mm: drop vmemmap_pmd helpers and use generic code
Date: Mon,  1 Jun 2026 16:48:41 +0800
Message-ID: <20260601084845.3792171-3-songmuchun@bytedance.com>
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

The generic implementations now suffice; remove the arm64 copies.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Will Deacon <will@kernel.org>
---
v2->v3:
- Collect Acked-by from Will Deacon
---
 arch/arm64/mm/mmu.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 24388e5c727d..ea10b0ebecd7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1776,20 +1776,6 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 }
 #endif
 
-void __meminit vmemmap_set_pmd(pmd_t *pmdp, void *p, int node,
-			       unsigned long addr, unsigned long next)
-{
-	pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
-}
-
-int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
-				unsigned long addr, unsigned long next)
-{
-	vmemmap_verify((pte_t *)pmdp, node, addr, next);
-
-	return pmd_leaf(READ_ONCE(*pmdp));
-}
-
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-- 
2.54.0

