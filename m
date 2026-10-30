Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349493;
	b=QgO3aiyDb0eFs33Q7FIWkbITTvrshdJFMBIMLPyIGt5eQc9nCgP4Tlhu/P+lQJpna+jY
	 czCfgiRc7IR8wvmf/citU8cwPHDL+VTORZ+nFTrkTVHaCR8wQEQNTP58hR8EW2XWFSKE5
	 Y5b5lwYm+qIkV/8e9sigvGn1Bi734jueOxKG7Xubxrt0Gxb/j5mblKOvoaiit34B/uxV7
	 UowZNQ74uOgkRlsGvQu5RXRY1vcIHKDD+42AyBgkUO48rENn0B0lqzBUvHG+ap/sCuPaL
	 mxlBoImOsOCw8JVvLPbT0iDJtwEqWCWQBo5ga3KYon+syyVWrU09FhbvR9n6PffmQuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
	b=czwwXRXXi1zQwEkNYiBVjxH8pt8MllvTSx1t+YeWmsNRZt0FD4mFcyMtnBx9uP9sBPAi
	 I0mpgXS2cCyVMJzN/QcxKFBh2PZK8SYfJTUElFue/ArI1uwYtYCibixe1IpY1e1tXGm+D
	 5cyh7alrkhNB8oUs3/FpOAO36BzVDc2LgJWOVogqt0HtSWTVEDfYTQrVv2tYhG5cO7maP
	 TKkAHVEqu1coDUhjljVM2HRTSF3Egwo4nBjauB/+Bc66zbxB/gUWl5LMD8R3cVJ5kTqup
	 0y9RpC2yzjatw7Y7qYcki/G78L8ZdnIB03693WqmcH5J1kgAWNY/HUB+dGo9ZvRsgbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=B3qLNBas;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B0606A320
	for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 692B0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=B3qLNBas
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso234997a12.1
        for <sparclinux@vger.kernel.org>; Fri, 30 Oct 2026 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349492; x=1793954292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=B3qLNBasitzf6QWVfYdSO4M4fb+3mJygu2Kl+gY3YU+aYRkjSfNxVvnwbTc3Y1MYmh
         SrNHFFRP6u2kzxV2WkRKPt9zbzjRMIwFCENvXZJEr5iJb2yyq4eNLacHh1Wob+gtM9uy
         SbRswPI2mty1hHvr+50TA7YXj8o6GoxMu+ZpgFZFbUjoHzq+uqnCw8jAimDCDM3LcXJi
         zTMWX2laLn/Zw3UlsiR7ZX2lydLN59p4udq8E+ZMZmtUOFVcJaSBpcM2upIYp1RJaq4O
         Y46Pn/FkGHCTZtrkCXyufob1K6unSqc3aA8EgpD1o5WUG1FxNrtm8KYgAx+zgnbrluK7
         2mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349492; x=1793954292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=cpkjGSP2QT91KcA3T4Utvyez7xz68IRmxC70rwz8QBVt0AoZYvdJMoxTOW1zNNLq5o
         lhRFz+/iPHQ1oaa4NrWL0Ku0qYhD8lZJPRuqsRkJCK0EbPXj6e0HiHI0VbTgWQpAuonV
         YUUeCSyiuy/f8zNuzhkwig3/m2KufogxAQ5/4jiSxrbvm6UFMwBbDwfnkEN4RIX39dSU
         20yRh+/plCwQbTlqPCotTwH0HEufzhckm7uJ9zsYhPKKw8RatYhdoqzyyZYQFn77qVz9
         1uohPDgBBgpDndl8cVn9aZZP+RkOIVivMMl0Gsf5nZ51RfIrRKdDJQnG05j86uSTN9r3
         vumw==
X-Forwarded-Encrypted: i=1; AKwUvBwyXLIlVpPQ/CSiIBVfGqsPCokPwpoCxDeUV3WHWjUa929Fz3m1tO6EPezDyO89RYZ+xXNkuiJv5Jzz@vger.kernel.org
X-Gm-Message-State: AFq9FYKunPUmpVtgRHXXclEiGKOmwtdYIb3uwSuzwsjTrwZ6zT3ZIKUG
	MLJusqLLLsU9lrGWGCQuGMnHX367Uk9lzQaLOJZjkVnl6AhkZYqONg8DSUu/i7cKmDs=
X-Gm-Gg: AYBFou0aA6d2qUDxN9T9jygMjRlVfxhCtT2XrpCfrKJ3ZBjEx2SO8Ti8HY2fcW4jR4o
	pRJq38wHXu/dtTUjOoAWfzBCsmUa1RelOoPVS3M9iVNO2pmQCyrxBJp97ZBH3DiCHAeL8fRC739
	8QBsRfZj8gR5xsezqucTu5zJ1mpZQmTBMVMcoisO+8AaTVeedi+auY+9iDmh+n0dr1Hf8pUm1L0
	sLjJ0f8goeGkUeEq6PmhWwl6cDDd5Ja1PgO9BYnUTXPGCQQJtRvSRHQM94BDXRzV1Rye8cgcfQT
	dwiKWnP/h14mAicwSJOX9Xc322lUfJZUA4L2/Or9lZh8oSm8RA6BfDyAHcD0hVpX8fIt3JXP7GE
	16pTov3xRxMiy4Lc3dlJPsInptpx08PJ+XDngyXGaTeK9hTqrEMKKeq2DXsmFEY/RmqngAzVval
	76kY4VECPT1djarIIWGLJsbsEqbwGGscJPkI9CltvXHUOORmYrxkvuyPmqsSs2Pn82Qxrpc5L2i
	AruzFVUWClKtDjPVSDzricfTWnOfNK5YxROKHl39AroPQ1Q0tRWZ9/qT4IrO7VLkz+O87Vgl6I/
	YmKJnyOQp8C0OOynPuGrmXgghjfFRQhRBCVRPfj1+jmDexdvAM8=
X-Received: by 2002:a17:90b:5147:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ae897c7c28mr1424866a91.14.1793349491405;
        Fri, 30 Oct 2026 01:38:11 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:10 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Date: Fri, 30 Oct 2026 16:37:58 +0800
Message-ID: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up cleanup to the page-table teardown fixes [1].

pagetable_free() now invokes pagetable_dtor() for constructed page tables.
This makes pagetable_dtor_free() redundant and leaves explicit destructor
calls immediately before pagetable_free() duplicating lifecycle handling.

Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
then remove the remaining redundant pagetable_dtor() calls. This keeps the
destructor decision in the common free path. No functional change is
intended.

[1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com

Muchun Song (2):
  mm: remove pagetable_dtor_free()
  mm: remove redundant pagetable_dtor() calls

 arch/m68k/include/asm/mcf_pgalloc.h    |  5 ++---
 arch/m68k/mm/motorola.c                |  2 +-
 arch/powerpc/mm/book3s64/mmu_context.c |  1 -
 arch/powerpc/mm/book3s64/pgtable.c     |  1 -
 arch/powerpc/mm/pgtable-frag.c         |  2 --
 arch/s390/include/asm/pgalloc.h        |  4 ----
 arch/s390/mm/pgalloc.c                 |  4 ++--
 arch/sh/mm/pgtable.c                   |  2 +-
 arch/sparc/mm/init_64.c                |  1 -
 arch/x86/mm/pat/set_memory.c           | 10 +---------
 arch/x86/mm/pgtable.c                  |  5 ++---
 include/asm-generic/pgalloc.h          | 12 ++++++------
 include/asm-generic/tlb.h              |  2 +-
 include/linux/mm.h                     |  6 ------
 14 files changed, 16 insertions(+), 41 deletions(-)


base-commit: 9c449f885765cf8d80b2c60b1971e774bba51a3f
-- 
2.54.0

