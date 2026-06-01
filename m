Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C793C2E
	for <sparclinux@vger.kernel.org>; Mon,  1 Jun 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303737; cv=none; b=NdKRhdUgSqETstUNbq5hxMsYU444Ltw+L/Y3Mo1ePVQv9inq8tWKk/dBQx+yLaylLuTH1QhtBCCtxmJwXBEDp3qbmZxH3Evw/71ADUnFTv+QUbWDJL/qVq3yzcC9xBi1lDW31d/gQG2A2w/ROSHGvVMwfgb+8ahqf+qCX1vUgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303737; c=relaxed/simple;
	bh=NvoQjpNT2HpM83YM+zIhjI24n2QTBJI+D98AX5XJkNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8+paI6zEiqmKILeCfHNP3aeipyTB6r4wpp/qtq4d1//as3X7pfoJ71qj6yP+GaISkg2FoV07ubF2UIoZ1mL2wklgn9joArHO2LqromYkaZUC1tn6JCY/9sYCFIhwrWqZwqPgdzxAMw8XTrZl16kSgO5mbVBTPv46/fhEcDwYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MdZXE+jj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MdZXE+jj"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842307472d4so286355b3a.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Jun 2026 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780303735; x=1780908535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1haIEjJUB66z54EoqIjtLZBJBg9TY7RS+jT0B9dn0/g=;
        b=MdZXE+jj7XjutOjo1y2EOo4S2wIXLjDpovPZ2B6KoCj4AWQVFCy1ezj8nyHZqGwm4b
         ReEGCpYSfikiTQ+SC5WJpLO79TQGWFS6j72IbmRcDoENjCguYJ2BzenwPV0NjVIiJ2C+
         WuCxc4x3n74fWNZ+sdgR8zq55oTXoPWJ58Pyot4XSnLAplxYBCVme1Xe6GSB12M//U3y
         svT1n4QOvkzhjie/PT+0i3sJWUqrcdDivXNVErSoJuBkT5qXR5f6ZJ2KVJ5/zIrwEeGD
         fP575nohZpI/LJ3K0Y/pVrjyZz5Lxaxz4JlriEeNgRw438tpLWtyf/wwRrrJKgMrsSJ4
         Hk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303735; x=1780908535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1haIEjJUB66z54EoqIjtLZBJBg9TY7RS+jT0B9dn0/g=;
        b=LWkbUDpSpgzA3TCkfGHTYplBa3xVyS0Mbz2U5woyxa9t3aKuYuCdseGXuOzyvCFhtY
         xI9y7HGOvovV4Yh3rh97ulz/cuF18qfMdgRL/GMBbs16YPE0564tK2rdTVLOJTfNzPmJ
         Fu8PWXvNf9CWtgV8FlCfU80eWVd+3M0Rjl+c/GKTHcen14NzBmDOTTry/jOTjF79Ui1y
         9rz4e+FzCbcFEItUow2eXq27s2KLQ8e1f/7ZVioGy7g3octVdZH7kCCGZOt78s8ZnIuv
         N+ab/oglEI1hAOQx1UtNcSAYSor7v1Dgz5n6FtStdlnIprYgGjos0fKlmvlhRDr3FpFC
         ao7g==
X-Forwarded-Encrypted: i=1; AFNElJ+mFf82D3rD9lX/pAz9ivySXtKnQJW8RrVlJdNCT36Sb4AchAbkhr+D0ugHrxVN1VpIfVkO51YejQDE@vger.kernel.org
X-Gm-Message-State: AOJu0YxWe5sL2Fa2VfMeEYrxYYKLZGIzgglagtbi06eI+UPJhchihP+4
	C73LU4uv9I51SPnIS9HfIE6xnC5eREPGI+hDriJ49yG2ZAA+HYvzZqFvvU9BSG8qBi8=
X-Gm-Gg: Acq92OF01SICTzeB3vhXxRxG8DiHUBprSoZYQunQ/R8bcCGTS2opkthTk4nYNg3VVty
	odFHcCnwjaHnOkwHLHa1SYMqHwhPn2eiM8Aoi3S6aqFL7KAwG/z08fvYhfO326c+Vj67N4NPPfs
	b3xqSeYjfBRgqoab2e7339wDm/oztdozUNaBlo+ex9cMCpN15Fo5VuyadotOgNAWtQRj4xmWbGg
	ucduXMJtbBFr7vKXV9+x8XatIFEpQpIZKL/BU1FNdZlY/zi1sHjTOWUTG/nwno5Y9Q7ap+ImSt5
	+3+W1AA50LPPCSowq6ZHL4X6+onUd05ItZ3WWXtULyHNWc6KWadKwb6ttBg3gU2vrVzulpgRHvM
	MhqgvQeDDJt+7M2RsG7sHCMf3bAJtIw644lapI0gVlk4EpRkSMCwGAWyJbSx9ywpttaMgfUQS4O
	wIbPvMs6Z2fLtR8ozaqeK6w2DJUuKsgW/F/4/83xBJ6R7iCD4FBkiMhg==
X-Received: by 2002:a05:6a00:1822:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-8422575fc22mr8798151b3a.50.1780303734571;
        Mon, 01 Jun 2026 01:48:54 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm6316230b3a.12.2026.06.01.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:48:53 -0700 (PDT)
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
Subject: [PATCH v3 0/5] mm/sparse-vmemmap: Provide generic vmemmap_set_pmd() and vmemmap_check_pmd()
Date: Mon,  1 Jun 2026 16:48:39 +0800
Message-ID: <20260601084845.3792171-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The weak vmemmap_set_pmd() and vmemmap_check_pmd() hooks are
currently no-ops in the generic code, which leaves architectures that
need PMD-level handling to open-code the same logic locally.

This series provides generic implementations for both helpers in
mm/sparse-vmemmap.c. vmemmap_set_pmd() installs a huge PMD with
PAGE_KERNEL protection, and vmemmap_check_pmd() verifies a present
leaf PMD before reusing the existing vmemmap_verify() helper.

With those generic helpers in place, patches 2-5 remove the now
redundant arch-specific implementations from arm64, riscv, loongarch,
and sparc.

v2 -> v3:
- Replace BUG_ON() with WARN_ON_ONCE() in patch 1
- Add Will Deacon's Acked-by to patch 2

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


base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
-- 
2.54.0

