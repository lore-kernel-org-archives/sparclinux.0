Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB329A9C8
	for <sparclinux@vger.kernel.org>; Sat,  4 Apr 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775305280; cv=none; b=HPQNQ45SKXUfTGlLJ3JJ2veq0P1NjYhPYSan/9B2HrhoKHTLw/rklC0y2VgpEBZEyRaPSsRJt9lSb9BOmwrjHA77zeN1GpvzZ9Ev6pPD51NQhlijTD/mUqI/2FDfQMnzoSYeF38yn5bhaLLYNC4RbftAlsEejWITkMibo+7w3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775305280; c=relaxed/simple;
	bh=reEz+myQ6H+KBDbMQirfBVvSjeJsGQrNL/qo1D1VFUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmdXS0cCI+Pc8doYYoA8gfGayIjiMMJJICZc2K12nNd4/0gHDy9GE416d0VS/0rkAplfN5/S58fkKDoVWiaO6QcZ9WugB6E/J6FaXkPvNgdsQoBK275VpuPCyx8Ui8Y0SSOLWg+DcNrXR2dp6mxAGd1rUl0clKgwoYlbJWY76mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LBhcPAvn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LBhcPAvn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824c9da9928so1734998b3a.3
        for <sparclinux@vger.kernel.org>; Sat, 04 Apr 2026 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1775305278; x=1775910078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmD+wUZmRVhtkrDT5Nt1vWAFME2ljMO3CvkEWHIVAgE=;
        b=LBhcPAvnw0FjtQ6ubMw5Lun8Ih6wN9cUM2D+259XGoRBExYw4eUrPjP9tTneMdUkKE
         /1mXXawETKXrfKeWx19IYdcKOxw0FUQqPDw5Fe8MWPDpZA1tmca7d2669zkPPrG1RBze
         gttCrWUhVpfHfgePkC1SGq6nxkHzKiQkL/hjoJjZ4+ovSdHGgIkijhmnmBMSU80QCodF
         JbiY93wLe5vmPDf1gGpVxFuMdJNf2hR1E+Us7fayz7g1kIFX3ZWaZL2WqUvP7iW+VBYD
         kAi6ahw+KeHdBnps4iEQvmhig0cC3IJSKAxqwcXhUGVR3XWxVzmi5EDgMkO5HjFO0sFn
         6gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775305278; x=1775910078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmD+wUZmRVhtkrDT5Nt1vWAFME2ljMO3CvkEWHIVAgE=;
        b=c6+cfiSZyysPYpD4jS7az5e6qD1gqD2B/B60TE1P4g+MeVXmiGg/gL2WjNwbVY+BPT
         xwObcpZl08JXUY7+DSd19FayTn1BB2Gtj0g4bZTLT/k5WjH0jUFjekK5tmBXcTh0myNG
         uLNGN+WGo+mX6YMUlKCEuQBFEvsuuu0ATNt44eCXNziUPSS2XJE9caEkJMUfEq8I7vYQ
         UB/OBTE1Z0LqdWrz/1krJQscMewwZHQqDoC+0Yx3oDHe7ksDFA03Ne2MXynKuU5exp7X
         T6EznrTxk5E+dqoOXE+bawpLyInGpvxO1SRBiCgINPb4UuyRbPJoaxV+6NpoRhHvxwrg
         v5ug==
X-Forwarded-Encrypted: i=1; AJvYcCWuSWmrUV7BUgQJl79PbN0xa6NB6jDlZ/PsFQ2XRHm3JOy83UlBSO1FDkK1DL2KYePRv/dnxCNm/fi6@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrOglKF0MYuhWq/sBPPd4wg6p6AYpQkKN8aRZDlzU8RSfKGRO
	y+tD6YUAH37cqn/8Tm1cKr4637N2t8SBgrUprrAzLbfnbxaSOEmBQ/cMkihBrL4wrsM=
X-Gm-Gg: AeBDieugE4EC5RHF4g8kkSOo6gpbnb/3Y9H33W7D4nDBe+Rrv4uZ+yv1oTENQlsrce1
	/ryXYOdU+wEqLXbG2AgaUzdCsvc+ff/NAxaxSQt56x2tVFMpjsL02uAM632R82DwIKaxisc893+
	6r1KYD6j+TDqUfCR/u+uv7+Q06KJEh+aZSlCUm4tNxo9kXh4i904LMXTEfW63L9eREbiu42xqxG
	GHffYRjcZ157j9dzQwxU9Lc4lMZfrYuLamcFohKImxK+m3cGHc0gPfjenz3aSAoeJh/OZy9bB9Y
	TX+vKLByv9UTPaueQ/9TG/4QEYB/YPjxtc4jTizar4anxzjWXAnJdCKq4yuvvZSF1iLigB6xneh
	xtKW+miNGnq8Og1mzrskeswJ0/MaggEGpl9/tjNDzv0GMFfhreyDrwiYhHkcCBm1amMsrY7rGH8
	KjWwggBmUQWmwdW7EcAYu6Q4EfkDJI8TGHOdCbpiz7tDmYHw+KcuBTtA==
X-Received: by 2002:a05:6a00:ab87:b0:82c:24a9:d5f1 with SMTP id d2e1a72fcca58-82d0db3f376mr5931662b3a.30.1775305277918;
        Sat, 04 Apr 2026 05:21:17 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cfebe5b23sm8327063b3a.59.2026.04.04.05.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:21:17 -0700 (PDT)
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
Cc: linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>,
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
	Petr Tesarik <ptesarik@suse.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Austin Kim <austin.kim@lge.com>,
	Chengkaitao <chengkaitao@kylinos.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 0/5] mm/sparse-vmemmap: provide generic vmemmap_set_pmd() and vmemmap_check_pmd()
Date: Sat,  4 Apr 2026 20:20:53 +0800
Message-Id: <20260404122105.3989557-1-songmuchun@bytedance.com>
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

v1 -> v2:
- Fixed a tooling issue in v1 where duplicate/conflicting patches
  were incorrectly sent to the mailing list. No code changes compared
  to the intended v1.


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

