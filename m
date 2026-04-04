Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C8175A6A
	for <sparclinux@vger.kernel.org>; Sat,  4 Apr 2026 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775287057; cv=none; b=eb8ClmEArb9WEjtP/jmIM7s+4u0x7vYMSRjw4xiyYcyyxp2kk2Pu+vTzqBV8W11s0IS3VI21tNs1lrVM5d/nxDZJkcDcgUA8Y6OhsGuImxXNB0GgY57wQDwA4JmMc4U37jrSmedSQfsDpJPJ42bm11gyIuyC2ciVHjv8egpK7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775287057; c=relaxed/simple;
	bh=gRo1lRle8QYwvb7+ytargpCfHq76BR2Kzkumqys+pZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNXsMTl5dSNfm/FSFOv3bENo2liLvgp1Aq2aH+wyG6l0JLUNruuNfKGrfqSvexKSE2gW110jV2F2nxNVAVdWJH3fFClZdFvYvvd8KOUjhwZn6Dp4dyvLQO/1C3rASqto7aaeue/WJ8zpHMIAQuOwcnmxka9uUVyYoLdNJJfLlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bb8eb65R; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bb8eb65R"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so791500a12.1
        for <sparclinux@vger.kernel.org>; Sat, 04 Apr 2026 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775287054; x=1775891854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxHSxQTiSROLSCEz/HR/Hur/9my7UlNa+rqcrvgfgaw=;
        b=bb8eb65R8GYl2y1uDO+Z8I4TFHFADQ5ENe2V76qEcWnrQhBLnmkGkSEmuAKAvvOXMN
         TZ3EADMxvoOVF6nidq4ZF+xlxa1E9IyHuvpVp142e/V4cToDE07lYsKntfhlT5xc3a6Q
         wtJN18Z/2eiLjPCPuiqStsdEf0sP+wXxglyh0UdTmvfkQiq7abhziZiY14tNlG9+QfNP
         8l959J3lgEu+ICtS8pQMS5yjZtl0YWYFl8qsvnpAyDKlEA8qax3UeFo6D0caPJF2wDRU
         A2LBYalBoYXGsm2KXbddUba5Nu7umRu6Re2ksHWaHS9vrcJ5TkdtpHxwe4Vj25PGlvH9
         ODng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775287054; x=1775891854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxHSxQTiSROLSCEz/HR/Hur/9my7UlNa+rqcrvgfgaw=;
        b=TPhoBH70+Vgs80iLGpMCM1bsuQD7qRWLi0lr91nKYy17VSnIThfVbP0DZDudIVUC4u
         js5ggcVUQB1+QtFuZxtnvdakGp3DfR9D5TtxQGHFMXnfNCYJvZJYFb3olAjWNvaY1cLN
         YYv/bzjWod30wB3t60YQ6gcduRaUx2lFdvKvbaNcfHq05zBKcSRgmogQSiipnKJXe3Qo
         YuIHvbvjLAAmRXjjkT/lnz8nGS+x7vzjJIbAwvoodXUnvVq7mFU9a/CHGs6xpRhIhQDe
         +vAfiqgRU+lNPeYxvebihp6Wk6scjRDnTUOka6CakE9o5jQb6bgBP8azdHzRe7WcD1fp
         vJ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHFwnwipV5teybCtC+rWW3aGqpqq6XmrZgpPVBpunjM2DkKvDBGqN1gnnH5YF/wk7jc1w0khEs2PTQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wdVPvvEJQ5WMd3LXLI9euc810gQo+gKSOPURD87vccsTKjLI
	P3E/t7miu9tbotheIrNqffqjkHwx0pDEZ9j9SGhYKWRVYnk9VIBA+onxYg/Ho1VOHWM=
X-Gm-Gg: AeBDieu0k/8InEHasM6RtdBKaAwjFnZQKuktMIGhy+MdxZ+r0FUrxqfAOm6Yw22c6xf
	FRRaeWhtiyL3kGY2YDoBUj/m+a7+wtpYwxWYgN8i4rSE9SpJc8dmpGMr3yROrpxJm7hEl8ekyeR
	E1Wsd5p2USgrgHI4Ckfh6lFZf235RmM7hWZ0JPHMHVJi3kOQUYO7/62LnGA/Jy7k5l4co1UI68l
	HJdaabhjFWGm/ilNChVBh+O60aksX9IL7vAAJa8SYbeXzwcx0x/3nEQ20B8NIcQaQDVSGzh5jEQ
	8p6NiLAQrLQLXXuJByUkdt3ayIF+I+cyhVtSLfhlO9agnZJ8VrlPNZjGO2DV0OHDqpUppSpD3G5
	CXk06PHtgj2XpEw7MEPM+0PTr3voekAkQgD/ZBVIZPVRKZy+C2aykD19v/TJhmHXkw7L1+k7pw6
	pzgyEqzn2q++XKl7r1LN0A6hHNzCvV6FUQHXV4YGSdDWeP+jmHW4ZqIg==
X-Received: by 2002:a17:903:2808:b0:2b2:539b:d29a with SMTP id d9443c01a7336-2b28178ad30mr37104585ad.23.1775287054199;
        Sat, 04 Apr 2026 00:17:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979525sm94675115ad.45.2026.04.04.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 00:17:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Petr Tesarik <ptesarik@suse.com>,
	Austin Kim <austin.kim@lge.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	Chengkaitao <chengkaitao@kylinos.cn>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] mm/sparse-vmemmap: provide generic vmemmap_set_pmd() and vmemmap_check_pmd()
Date: Sat,  4 Apr 2026 15:17:04 +0800
Message-Id: <20260404071720.3577290-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two weak functions vmemmap_set_pmd() and vmemmap_check_pmd() are
currently no-ops on every architecture, forcing each platform that needs
them to duplicate the same handful of lines. Provide a generic implementation:

- vmemmap_set_pmd() simply sets a huge PMD with PAGE_KERNEL protection.

- vmemmap_check_pmd() verifies that the PMD is present and leaf,
  then calls the existing vmemmap_verify() helper.

Architectures that need special handling can continue to override the
weak symbols; everyone else gets the standard version for free.

This series drops the custom implementations in arm64, riscv, loongarch,
and sparc, replacing them with the generic implementation introduced
in the first patch.

Muchun Song (5):
  mm/sparse-vmemmap: provide generic vmemmap_set_pmd() and
    vmemmap_check_pmd()
  arm64/mm: drop vmemmap_pmd helpers and use generic code
  riscv/mm: drop vmemmap_pmd helpers and use generic code
  loongarch/mm: drop vmemmap_check_pmd helper and use generic code
  sparc/mm: drop vmemmap_check_pmd helper and use generic code

 arch/arm64/mm/mmu.c      | 14 --------------
 arch/loongarch/mm/init.c | 11 -----------
 arch/riscv/mm/init.c     | 13 -------------
 arch/sparc/mm/init_64.c  | 11 -----------
 mm/sparse-vmemmap.c      |  7 ++++++-
 5 files changed, 6 insertions(+), 50 deletions(-)

-- 
2.20.1

