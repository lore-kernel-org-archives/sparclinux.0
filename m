Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9836728D
	for <sparclinux@vger.kernel.org>; Mon,  1 Jun 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303769; cv=none; b=tJV4X/lu/RsO8KJoOEd+TZgpCjPM6CKjXmQqsfIa07JmNzpXaKf4NN9cySEVEOY7ONrq0KII2h65BaSOmisoxPUm5nE8vSO2COz1IW7cYfTTC2uT2maxNoLlzZiIpcbr6AhQAaGOKC3Dfjo81D5h4ikhUh2y4qGVm4fu6YKRlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303769; c=relaxed/simple;
	bh=pwblFY2nzACXWSoP5Rom+zjueIYD5KdpIL15G4qchH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBlXJ85O8Sh2zQVb0MeuU8BBJlBPEXD7kfIv5XZjDoNK+cD6el0R+rdhInDM4nedrB/C6+P4tizG6q0bVvhGlNUO4tSAOdOiwzY7X9jIi+DLklXjJV2rbIFdTA3XBpVJRLZY7M8OTeexGMd8toUU/rap10Rqbip4lLXIAkhTNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cCts3ZzU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cCts3ZzU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423efad617so429293b3a.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Jun 2026 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780303767; x=1780908567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs9Ftk//Eli+AipH1EmAF2SPdnVVPcjuiC9Ml1N6W44=;
        b=cCts3ZzUFfvoOPmNSdBMMpmmBUy5S1A/7iBtN8B2fxZCbM5Dw/3kr5OkomaVdfNYJ3
         NTvtVpE9vXqg+SwcuSs8/0N0bD6yCulksQbEKCWjc5M9sZFgr+TLE2/aQB17PA/nPgN3
         uRvedjvvF4MKCuK3OmJWGuYJlb4tXBlUW2ymCiPTRntwuuBtWjhcey7G4UmGzb9zcycr
         7xldd70fm9cCcLiScmRPjpGhsrhbe8dEkJ7RlgkozlSWPcQlx1Kd8tZz1B0EWNnrvizW
         8sTPl5LIKzaiF/yP4ZDOo3nL0A0ilgj7yq9JuGg5LjvMd4CYm5bJQSGuRmrZdwsQnKsA
         71Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303767; x=1780908567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zs9Ftk//Eli+AipH1EmAF2SPdnVVPcjuiC9Ml1N6W44=;
        b=TrPjROByLFon9yROvQ7Gk0voYaAqmeEF827f4VhpoyW6X/TxlO9iCeilAc8YLrMLht
         HPFJiYEdDEWKxkJRONDc8ALVP2PXgWcPhXh3ReaCh0Tey2FLOujmyXX1Jny5cEwiiG1E
         6HAqhlAMc6Ki7CvzSGnTd8ncCmsQdir1GY01lz64Z76iZxnOPQe+Dhm5/GWU6R7MkCxL
         hGhvcgogtH6TxSofR0CpT3aLbefmIidh4Jc9badzU6sHzGI1wofwC6apNyNW5SJoUahZ
         Gi9XAqdLGVPO1Bl7H2N66FO5F9aMou51o7nJvhvMxGDUAnzojnDQJJ9ieA/nPgoOpPKD
         lP0w==
X-Forwarded-Encrypted: i=1; AFNElJ+aMZAnFxBnbimi0GOTGlRox7opHlyIJuynaEnLb3VR1+ecOsw8gudtuKCb7zuzPF7wuBZm68b/KESZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/j3crjinDhoYMe2m8qM2pARwUPn+MuQHK1lN4vZxngXcKkGL4
	vvj4tCJlSaBAiAIY4vDxyG0RVJLV4r80IblHXYZBFfk0hv4+gCfcvFXadpZm3W+wS08=
X-Gm-Gg: Acq92OGxioNJd6s/HMCjeI2kbYU/BwefhKqAmxe8xltsRmi0uGEOaAGpXI4sx6LXlV4
	a1dWilNNJYtaT2mPDlyAJufwFoZe2ywdEiWvM7LHGLz/ptZAa4ncYRnzKJKqv7fTzhM8tS2rfln
	wmOInCAjSkIUAJTzHnsUm8eyXiofyOKLBAqd/5oEJr13a7MgZ88OMiGrxwuPWTgKVgGxZSyS3AQ
	0M0GQP8dC1CEcsQX9wRCN+5ujtFKwaocJz34ot+sstaBa0d68oT+C27vds51V6dIOfQ8+Ie7DnU
	iXe/g17i2hshzzz6t3SjOaotcDcGQ+GEXv4JlGvk5fkbdc7+j/+TgHBgdZRmA2b6jZWXm/oSyds
	/SO+bZw+V69rxcSEvey1UzXYCYRkPde4wMI+KNK6Vuc6/OYyKKOYsmdGGVXUrTWDrwpskU+PvVG
	Ftt73RDH4oj3slCyJe30+dLl1wzhHPfsf1oS4ea2YTZBTVBk8EqfL+6Q==
X-Received: by 2002:a05:6a00:4c8b:b0:842:43d1:4b41 with SMTP id d2e1a72fcca58-84243d15007mr4884011b3a.47.1780303767463;
        Mon, 01 Jun 2026 01:49:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm6316230b3a.12.2026.06.01.01.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:49:26 -0700 (PDT)
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
Subject: [PATCH v3 5/5] sparc/mm: drop vmemmap_check_pmd helper and use generic code
Date: Mon,  1 Jun 2026 16:48:44 +0800
Message-ID: <20260601084845.3792171-6-songmuchun@bytedance.com>
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

The generic implementations now suffice; remove the sparc copies.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/sparc/mm/init_64.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3b679b1d1d72..103db4683b16 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2559,17 +2559,6 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
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
2.54.0

