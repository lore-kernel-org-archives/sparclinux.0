Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966559B45
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792259; cv=none; b=iKMManAnQMnAdyPUGuFqWnH6jAB2nyJ+UjR/mYrgM5cEM0A4mSH3L7uFgz7u2orxkw0EFuSIB2t2+x5l8iqedpp4ijWrDN7PfkBYfvK9QQAkLFH3pFESyqXOWueBQo0CuQoi4UMpzQNP5T+qLX4Ljs6KIhme49aKIhbl6B0w52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792259; c=relaxed/simple;
	bh=xsXv+igcIa2LD7vY6Lm1s+FcdmOPBabwjo2Ma8p3Wuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aswT2bTNJ+w4H11xCOekzGvKu2wcV+IF6Gr1g+FsijB08coKTxI1LADLWx6cbmZ8tKJN8WCFsJI201/+2ompB1iMw5RRKa5odfF0tR3Akf/3/jHemVI+t28scGy5zB1LUrBYV0ROh+u4XkQ7c1N1pDOcam5qsfnCAIpRYbPSpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0mfFgrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0mfFgrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtZJyICZEGrBJHpYWSu5beimQ7UmPGzVa4S5UCB/Dcs=;
	b=W0mfFgrAAF0QEJSOfcIdppmnlAqK4FRZymZyXAsNTET52OE0pLJiKs1I209fUq0NFGxzaA
	aGO1/XENKw0MK6Isp1yvRyUfJSq70rAEejAvVtdAuKUue/xi9vK9LGEdNj0432Nw7sguVS
	OaM/SKdCMV9JL0QZuWcbLHupBaeM8Nw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-RSElcEDjO_OWdLmANG6yQA-1; Mon, 18 Mar 2024 16:04:12 -0400
X-MC-Unique: RSElcEDjO_OWdLmANG6yQA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430b4572a97so17522921cf.1
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792252; x=1711397052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtZJyICZEGrBJHpYWSu5beimQ7UmPGzVa4S5UCB/Dcs=;
        b=IVzpSbvwOcHeFlg8J5tpENT8DJ0VJQ4nJlVFY/MlWdAASxLwIh+ssh2AREF809O3gB
         jYTDghO6aFdUffaRCp1GRb9g60Tgt6c7AKKYe3erbpWmW2aVoh/vIw1PN9M1KgJu1RuV
         me/HAcQ8b0890hd8G+49Dy8p4MfR9XXh+Yg7UpbXT16B/1Kzl7j5A3dBqKFI6U7okWIy
         ICYOH0IK8Bc+lqTT0BX9y/rr6LrYqoe67ca7qZYTOWchpeL12tlJD0xyrfuP6zeKPTIz
         +2hJp80CuP07v+BIsZXkkFt5TuRETl2796vHxZ7yj0lguMKi0yBAQZxmnWWz0u1v+Em2
         vtxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqYr+pqeqlKeXUBHKhw2rouYAxwVUM5PkvL+SsKODv7/msUCkeH3S1E10eiTlY4cWP9Xncu7s6Eh9n7zu6Rf5xdmzne+yl3u/hRw==
X-Gm-Message-State: AOJu0YzpB+U2BrxwQ8niQp/AdocNWin3uSoHvfj3gwCiFUlkh50DTMOq
	qRIFdDW1aqELI8jvxd7L24Y+G4Xt9x2uUcYAfmXfWGKLafoGO5V4kz83Axt+f4zQInpwAwEp80c
	bfQ1eIInWsiq0GKJsW7MBH7lcTnHE4dT6Pmuun58RtJPdnJq3Kl2hiaskwT8=
X-Received: by 2002:a05:622a:134e:b0:430:c82f:b9ab with SMTP id w14-20020a05622a134e00b00430c82fb9abmr6625397qtk.0.1710792252297;
        Mon, 18 Mar 2024 13:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFopBSFWwBK3v15ombZ7ZQDo2UFCgzW4nradhEvm8gSdWhrm9dq3oWG6x2VBEnxvd6M1ShIXA==
X-Received: by 2002:a05:622a:134e:b0:430:c82f:b9ab with SMTP id w14-20020a05622a134e00b00430c82fb9abmr6625362qtk.0.1710792251793;
        Mon, 18 Mar 2024 13:04:11 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:11 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	peterx@redhat.com,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 04/14] mm/x86: Change pXd_huge() behavior to exclude swap entries
Date: Mon, 18 Mar 2024 16:03:54 -0400
Message-ID: <20240318200404.448346-5-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318200404.448346-1-peterx@redhat.com>
References: <20240318200404.448346-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

This patch partly reverts below commits:

3a194f3f8ad0 ("mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present pud entry")
cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage")

Right now, pXd_huge() definition across kernel is unclear. We have two
groups that think differently on swap entries:

  - x86/sparc:     Allow pXd_huge() to accept swap entries
  - all the rest:  Doesn't allow pXd_huge() to accept swap entries

This is so confusing.  Since the sparc helpers seem to be added in 2016,
which is after x86's (2015), so sparc could have followed a trend.  x86
proposed such swap handling in 2015 to resolve hugetlb swap entries hit in
GUP, but now GUP guards swap entries with !pXd_present() in all layers so
we should be safe.

We should define this API properly, one way or another, rather than keep
them defined differently across archs.

Gut feeling tells me that pXd_huge() shouldn't include swap entries, and it
turns out that I am not the only one thinking so, the question was raised
when the current pmd_huge() for x86 was proposed by Ville Syrjälä:

https://lore.kernel.org/all/Y2WQ7I4LXh8iUIRd@intel.com/

  I might also be missing something obvious, but why is it even necessary
  to treat PRESENT==0+PSE==0 as a huge entry?

It is also questioned when Jason Gunthorpe reviewed the other patchset on
swap entry handlings:

https://lore.kernel.org/all/20240221125753.GQ13330@nvidia.com/

Revert its meaning back to original.  It shouldn't have any functional
change as we should be ready with guards on !pXd_present() explicitly
everywhere.

Note that I also dropped the "#if CONFIG_PGTABLE_LEVELS > 2", it was there
probably because it was breaking things when 3a194f3f8ad0 was proposed,
according to the report here:

https://lore.kernel.org/all/Y2LYXItKQyaJTv8j@intel.com/

Now we shouldn't need that.

Instead of reverting to _PAGE_PSE raw check, leverage pXd_leaf().

Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/hugetlbpage.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 5804bbae4f01..8362953a24ce 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -20,29 +20,19 @@
 #include <asm/elf.h>
 
 /*
- * pmd_huge() returns 1 if @pmd is hugetlb related entry, that is normal
- * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
- * Otherwise, returns 0.
+ * pmd_huge() returns 1 if @pmd is hugetlb related entry.
  */
 int pmd_huge(pmd_t pmd)
 {
-	return !pmd_none(pmd) &&
-		(pmd_val(pmd) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
+	return pmd_leaf(pmd);
 }
 
 /*
- * pud_huge() returns 1 if @pud is hugetlb related entry, that is normal
- * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
- * Otherwise, returns 0.
+ * pud_huge() returns 1 if @pud is hugetlb related entry.
  */
 int pud_huge(pud_t pud)
 {
-#if CONFIG_PGTABLE_LEVELS > 2
-	return !pud_none(pud) &&
-		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
-#else
-	return 0;
-#endif
+	return pud_leaf(pud);
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.44.0

