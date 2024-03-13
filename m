Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2159150
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366450; cv=none; b=pi98WRdrWo1Nb9WVmb/tqgGUYFSCSjwWO+fB3VjxNHfiRlSft40wfhM+iLxSDcL9pOJOe8HZiBoqHZpVLA1cpqjJFu/bEaqT+qJWFp96PdKrYT1fFDqslba9dLefTatF2nhoUWQy96Cq/mLNdol8KGnMe+pl5KgCgfvgIb2EFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366450; c=relaxed/simple;
	bh=XKAmzhpmXEAjAsa42PYgBQQ2HzrzYrw3Lh5/ehBy8nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgBkuJ8ogexyvA1I6VzvxwlLhTs22oJpES5jV25+AoHoJ1uX6msX3Z2Q+9o9Z95dGkjIjW3W4SrABbvrmWhhQCW3ZRJSL+fbD9Hy2KhknxwA9ViH1LXUdUPZYYapAEeLN2zr6lM0nZkR0x9JtAlRsSHtf2RpuQ365nZsRlyHuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UY4cbn0r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY4cbn0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
	b=UY4cbn0roYv30RDpTReEcyjCDf5I+4gS0nRH3HY7jnKWAaL0CV9Hs+THIQWDhWQWKFe7Ym
	M6YL6OZKVB5I2CxmTD2NuDo5UaWbaSCXUCzhPM53LI9pxr/BjRZsck+uwUlcl6Ubt3U95+
	AUh1Juq1BPN53tXeOTVEz+baEf1Jkh4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-PKQ78KtLM42F-wvr9o-ckg-1; Wed, 13 Mar 2024 17:47:26 -0400
X-MC-Unique: PKQ78KtLM42F-wvr9o-ckg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-690b5ad0e61so1037346d6.0
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366446; x=1710971246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
        b=wsE1yktiivEtf7Halo4dtaF0SdObT+IpuSHykHX2cvjzJtyS7TNlBEqa7uErQBnpeF
         XVtCRtYGnTqZjaLg21o8xKW4zlBzZp2BcNkjWupFif5dEjXZYNh1DNYckiM7K/6ShmFY
         DG2IdPKDOCdz3bjs7xxHqeySCBS0y3BXF76BHBE3bOmbGRY33HkKIwFD1//fFCQ3XN2U
         PXAaXRvZFyk+x0+VWgBY6Ys9kjG1Nph2IABrkwVqXqJM1bgw00ru1SYfEtXgNgo75vvd
         c0o56pX+wgjeH/Bo7FxbVVHTdfwR4LVKv7k51aX7+6TukEFGGfL/JFuZAU5MEpPRwrUO
         amHA==
X-Forwarded-Encrypted: i=1; AJvYcCUGx1AjBgZDM+v8NtNcEFq6reT3U0f+WHPjNv+/J5lxrig6eTLO+prR7hv3EADyuRT4Ox4WhFsQNqtZH/fYFAmkHuMn/p/ZZ0/aLQ==
X-Gm-Message-State: AOJu0Yy3IwNCyyGw62i55UaVYvIK81E2Hl/UwvMmY1+hWfcyH0Y0fIa2
	eDEuUYX1u+05m9hvzBoGap75mvbuLW7AUASvGEAjEJdPu7JkxHemvytksMTIMvMa8bZh+yC46Hj
	OxQqlGJ2Y6NOsrnyLKrINBGj5Gen1ygCwykvr1u3eYj8gty1sFLV5nPy9hzE=
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id j8-20020a0cf508000000b00690b02c2a5fmr13464374qvm.4.1710366446022;
        Wed, 13 Mar 2024 14:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXIxC5CVGnx+p2qd8ZmV2KZnCoGCjWGy3mEq+yzfnYrTYJ2FsP7C7aom0bl0ipU8C23yK/Aw==
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id j8-20020a0cf508000000b00690b02c2a5fmr13464349qvm.4.1710366445605;
        Wed, 13 Mar 2024 14:47:25 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:25 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 03/13] mm/gup: Check p4d presence before going on
Date: Wed, 13 Mar 2024 17:47:09 -0400
Message-ID: <20240313214719.253873-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Currently there should have no p4d swap entries so it may not matter much,
however this may help us to rule out swap entries in pXd_huge() API, which
will include p4d_huge().  The p4d_present() checks make it 100% clear that
we won't rely on p4d_huge() for swap entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 69a777f4fc5c..802987281b2f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -776,7 +776,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 
 	p4dp = p4d_offset(pgdp, address);
 	p4d = READ_ONCE(*p4dp);
-	if (p4d_none(p4d))
+	if (!p4d_present(p4d))
 		return no_page_table(vma, flags);
 	BUILD_BUG_ON(p4d_huge(p4d));
 	if (unlikely(p4d_bad(p4d)))
@@ -3069,7 +3069,7 @@ static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned lo
 		p4d_t p4d = READ_ONCE(*p4dp);
 
 		next = p4d_addr_end(addr, end);
-		if (p4d_none(p4d))
+		if (!p4d_present(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
-- 
2.44.0

