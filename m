Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A1360ED1
	for <sparclinux@vger.kernel.org>; Mon,  1 Jun 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303743; cv=none; b=DcHou+vbUYA7z7gzJZNG4p3VCy1V7+pLZCGXi4QWhszG+mTUUGOv7D1njW2/YVNRijD1By83BFMP+VaGRGFjRewAk7xRMyTjaWu5oHby42cW8mfETZ15jOJe2UVTcUACMy/rj0WQkJSkD1D+TBbPNhc1ONZqgvRp0ZjikmVtomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303743; c=relaxed/simple;
	bh=QgZxJDmxK15glKgdwvuQXKx4II7jp/jciswRkVewa3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGWi5YYWZq3E72AJ0QatCkdUvqUW2N4wwwESSYjt9TIjZjm38yElknJTuS7dwrLhEpppclX/iYS471FbHk5L+/lqnAGbnbzIadod/1RDf1InIK3LBVarZtw6COrCFfsTTpoQQcqv3QUXoVJK2SUc3PZs3/LVsdiCYlA8HRKsLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RrwEJV3t; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RrwEJV3t"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84236f9b638so484955b3a.2
        for <sparclinux@vger.kernel.org>; Mon, 01 Jun 2026 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1780303741; x=1780908541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iZQN+oxehRhbRDFp2Djf7RG6EvHlnyDB08mWf0NvrQ=;
        b=RrwEJV3tctoHVfOdjruG43UZCeUczbChzvplAurXod4vB6cY/8nvQGPUotGkjzMfP5
         JuHKysyZAavyvruxpl4uM9fXthSeTeITN5gplmxJecHdJtwrNx6kwsYRtN2HKL0Ihuss
         u6wSt749kl4Rk87uRyK4gbPvXUyrfnBIfQf6P9i9RotkJkQ2lXuOur/iAwO6NQpITd0v
         YmC8+LMehaklomXReoePhb/RSPjnOCY52u/pfS0H/DYeIgW7qN90b+upBNzNlzZBJb53
         fXr3lLCXWWV/7W91TrSTMrJkplNxP7n6rF/8oJ0nvUEBRThwi53qvCJqIuz17YmsyEWE
         rRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303741; x=1780908541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8iZQN+oxehRhbRDFp2Djf7RG6EvHlnyDB08mWf0NvrQ=;
        b=Lkqq5onnAoFgMXfKIRpE4vdyHEayBtRvZL1L1b4aktSE7DlpFsFDIS0l3wkVP9HgIl
         emWM2VmimS/oEgseNyjHFNgzFv8JGSI1nrAcsE2u+6U6/CKh/AmWEDMBG3uVbzPukywG
         r0MZ7XYC7BeE7TMNAEMvLzCv4/QM4W1A1LlDj1MiiepwdqG9FfrXeDCXIUKdf+K8PRUa
         uB6dlDYyRPqg7ac3ApWtCE9k6QmeqcEc3pldpuyZmK1AYNp7NRMcmdxmMReAzdunN4zV
         m0mKx3Peqb72xeNEbTIhfflVe5MKWWsgF3vu3tCcn/FpqAHKwr0Mab8cdXcMa+fCVnf+
         TNeg==
X-Forwarded-Encrypted: i=1; AFNElJ/TZSpoj7VWvT83f0nn9myPwmkaut9Dj29liaqmUYTp4sj2bch+d3sM5qDQR9ofc9cHUnUtDMqIqqsv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5V4l1GZ0QSId9hIayePEcGXNXsPxPxfeCGnCa5XFg4elcYx00
	y5oQAcg6T/Cz2iCDXqXC8PSc4k05oPlUPvPokcXmIrnS3GdqsvdKvz1xXsctErZLX7M=
X-Gm-Gg: Acq92OH2U1FsQVbpxAMoIIRFiJ7NDS+IOvdhtu6PM+KVymHRu/YJJKOTgdWcmTQXkR9
	14bgMLTRXjmhKOKfC8mFoYzuQ2Kn9/5OWPEUT1IIz4I8W3iGQk9I856J2kcuK5mCTlWWB4knyzP
	6Lvzo1ks/B1MwpOfzPrqCsXFfY11RJyOv+QPNyGQo6nX51leLnAB+t9NXUrQ0AoNWdyWbZmWW8/
	/n/xn9HROefuwW8vKV5bLSBSxw5+rjtmZ577Wp03+RysdnX/164qvtBqQ9jEkFzGaJVNBPMmFoD
	9qBNbGCS1BzsqRONJVwp8UgiopKnY2lxxoTRU1bDGPA+NgNFZ0OR/532tYWQGubxXEA5fCP9zT5
	Bnv4A1cSEjxncydfw86GfUSFYQqPuMQukAMG9JHYr0O1jida4E7Fnd5bCIvrC7tJD6haL5B+Ij/
	t5RppMq27cnmPT/iZgdzOsF6f3RFocWLCqvOXyIRvYMzI7pDT78/wK9g==
X-Received: by 2002:aa7:9a86:0:b0:83c:928:6e5a with SMTP id d2e1a72fcca58-84225376b00mr9579300b3a.13.1780303741104;
        Mon, 01 Jun 2026 01:49:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm6316230b3a.12.2026.06.01.01.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:49:00 -0700 (PDT)
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
Subject: [PATCH v3 1/5] mm/sparse-vmemmap: provide generic vmemmap_set_pmd() and vmemmap_check_pmd()
Date: Mon,  1 Jun 2026 16:48:40 +0800
Message-ID: <20260601084845.3792171-2-songmuchun@bytedance.com>
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

The two weak functions are currently no-ops on every architecture,
forcing each platform that needs them to duplicate the same handful
of lines.  Provide a generic implementation:

- vmemmap_set_pmd() simply sets a huge PMD with PAGE_KERNEL protection.

- vmemmap_check_pmd() verifies that the PMD is present and leaf,
  then calls the existing vmemmap_verify() helper.

Architectures that need special handling can continue to override the
weak symbols; everyone else gets the standard version for free.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2->v3:
- Replace BUG_ON() with WARN_ON_ONCE() in vmemmap_set_pmd()
---
 mm/sparse-vmemmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 112ccf9c71ca..99e2be39671b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -386,12 +386,17 @@ int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
 void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 				      unsigned long addr, unsigned long next)
 {
+	WARN_ON_ONCE(!pmd_set_huge(pmd, virt_to_phys(p), PAGE_KERNEL));
 }
 
 int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 				       unsigned long addr, unsigned long next)
 {
-	return 0;
+	if (!pmd_leaf(pmdp_get(pmd)))
+		return 0;
+	vmemmap_verify((pte_t *)pmd, node, addr, next);
+
+	return 1;
 }
 
 int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
-- 
2.54.0

