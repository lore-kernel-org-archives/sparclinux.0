Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E112045AD
	for <sparclinux@vger.kernel.org>; Mon,  1 Jun 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303756; cv=none; b=DBLc3YIe65ijcEyX76H59ShRa/0DukzV5lCehLjIOvTl3HxC4DRUcMMjqZI4t74b8B/4KlTntFluNvB371YJ9nlNUwayr9tMuOW1mJ9ecUZw7nOVRYuNgXFrWl6X4C6KlpWyLBOyiHn8DZRdXGxGDJhOByGzbWLUyvVSbaDDTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303756; c=relaxed/simple;
	bh=90ZcI8WdDuxzGpB8f60twhO+4k8/kpTvbg92FgL7hmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCh96KhT6+nZTowK6TO683emi7Krl7ui9eBR0snlcKdh43S3UxnUStPZsKsWkgSj1wYdJEtt5qkTRlrLJvFuess/Pq1/43HOKbuX4akSq1jyh8SD6f2TB2/ahYEEaJkBzaGhcy5eFLAE75rvmxwFTxDkabncXS/LrQhWBNRcs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qb1lrRqa; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qb1lrRqa"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36da8439078so798975a91.2
        for <sparclinux@vger.kernel.org>; Mon, 01 Jun 2026 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780303754; x=1780908554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8b/yYnv8ZH41kctmwMZLOttDvAzW7LNe3UEG0HH1sI=;
        b=Qb1lrRqa+2fzGaIKqVmjJ+FGBiJkdsFHIU69RDa9OoBnw+nLel9u2xjZt0a5rnuFFc
         +G1DX+OghOZEF0b+Xj3N0gKwB3Lhk7EDk6fYa6D14QR0SuliQ1A9oC6d6yVEGMkLSYLc
         oM7GLyDclUtW+JIhqX6+Fh4nuHx7Ovdyn8Q9hj2mC8YeM+5GxdYlo5k/EA5nn/aydjA4
         rCJQ/LImh+ZMwmu/mzMg1MIKox6aDT/Yhqn5K2QFayghd5b2YYyyMrXFQtDhO2OeDIb7
         gBnq5sKQLnQMtBKQMelG15DeQlNBlndegHA2UV+Eft5F+z1LaRUT14Ec5/Rfoo+eQEy8
         K3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303754; x=1780908554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q8b/yYnv8ZH41kctmwMZLOttDvAzW7LNe3UEG0HH1sI=;
        b=bNj6iAtqdZhsxh62ikbf15FhAH4F/OZ7tZ9EaVxXGCcejnBPq4xtc8p8B4gRKuErB8
         ha83h33IZA6Oz6NtiWz8w4oxUrG9yID9qaRgtvbKTjeHMoK7gzVMa09wf/Io74uWe6Mm
         GuH7aqRw3zuuKPGrXf/jlTAuwnLWINgP5DbD3PZhYbyHVRQU0bclBUd5VUkifZMbVQOb
         6VOPKzgQPsEZzPYLu3NBZTMQtU9bp3M5voHdp+P5haNd8QM0kfgEOlqLSvvNDGWrpt6P
         aiaUsMC5GWw25qaUJppC5ooaDosUX1dPVHoHtjL41EmB2yPT+yAnDfw+ziW06h2zNk4h
         Zwyw==
X-Forwarded-Encrypted: i=1; AFNElJ/uOAE/jmE8RiIt0ytAj3E5gVh9+qrDSWswKwerCnZufe+WQGw9PIaksc1qgIS0JpWJFrg6kpGCgP/f@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJKgBuZHdxBASO129wbND0K+oZFKEXUYWK9MHSZuQWp8BeR4j
	Tr4mh5WdxQtvmu0xytbeZc6nItP9ZrfvzzcRjAouoEl9zunR12QhdBk70izc85jX9pQ=
X-Gm-Gg: Acq92OGz48+YTyPT0byZ2vh19fSGRMsOA8PqO3dmqnVXnH5GajLmx1eVuO6zoFI15CU
	1IPzwZNaC/WVusnWsxigkyWHdLuFf6CDJ6f3BCoAdpVup2f4Y8gZmGkbfljsN4pBgZ6wK7FSmr4
	8rQMcAfn+KII/KEb+ImhUd6llUsn3XNusYO3CpvVXRPRDdEMBniE5zcb6Ov8QOPoDrgbH6IZp7L
	R0RlogL7IscpLjMlZBCUKnGn0C9YApKJYzTN2Q2ZuxVelZp98bzhJuH6cThQOrN43RYKt7EZN+l
	+3VaclEAiDPMQ8ydQT6F+uzO74jXAKiNtOuRhHTsVw3vFKiK+63SRx69XjL7FyELEiG7CbU9KGs
	N/DixZuLp1Abr1Pgj7sPZGK37njyOLyTXO8qaRK+0CcH949XyhecctODzwBcPokvJMwQx7o/iXj
	TERzaIXy0U1T1RZovdZP72D4TX19g7+2Uh/8zQo/qvXiEF8PQdqQfyag==
X-Received: by 2002:a05:6a21:8ccb:b0:38b:eadd:449a with SMTP id adf61e73a8af0-3b428242975mr12005378637.38.1780303754272;
        Mon, 01 Jun 2026 01:49:14 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm6316230b3a.12.2026.06.01.01.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:49:13 -0700 (PDT)
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
Subject: [PATCH v3 3/5] riscv/mm: drop vmemmap_pmd helpers and use generic code
Date: Mon,  1 Jun 2026 16:48:42 +0800
Message-ID: <20260601084845.3792171-4-songmuchun@bytedance.com>
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

The generic implementations now suffice; remove the riscv copies.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/riscv/mm/init.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 885f1db4e9bf..5f680eb83e86 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1359,19 +1359,6 @@ void __init misc_mem_init(void)
 }
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
-			       unsigned long addr, unsigned long next)
-{
-	pmd_set_huge(pmd, virt_to_phys(p), PAGE_KERNEL);
-}
-
-int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
-				unsigned long addr, unsigned long next)
-{
-	vmemmap_verify((pte_t *)pmdp, node, addr, next);
-	return 1;
-}
-
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 			       struct vmem_altmap *altmap)
 {
-- 
2.54.0

