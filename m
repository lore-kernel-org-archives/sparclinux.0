Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD905B5A1
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792265; cv=none; b=p+qJBqrFLmKwsaW60wjH8+26I9vDueQvlxnRkzYI0FUlZ5EyBEJpLLiSSKioFx1bMqxhvocwGQh8LErS3lTrSS1KlTIU9GU19C/6gjK/6o2beVjt+/E1utB/kG39uLxyILSSs9ksepTbnlMme8WwQtc586RcRG8EiafraYkieIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792265; c=relaxed/simple;
	bh=iQQgqfXsWxx8LbxXDlwC+eVTcKSnHUToAbw1far1TeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNgR34e/yHU630eVaB0OYU7hV0IhdKF1YGPh8cb266WCt/OgX23ArH4PU8kiuKyK1ENmnLUvebSAGaw3olpAWSUN2gLHx6GJxSJYAg/J5pgMuI/L13Yjm+2xsTibPqhEtEJanJEuLVooHUP0AIfZrAFSYWS13wUyEcPk00XSUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpv8PxWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpv8PxWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
	b=Jpv8PxWJQZKZ1IYVe15VrpiUDORHnFCxDPRbj7iLMce03wnLpBVVBsu4860HTjYgz+y1As
	VLJn46csO+VBKepkhO+s+lyspsmnnW3he32J7W4QrPKQlu54YJxqcLKUlDqf63rsMcRyfZ
	AvYt6wdzv9RNSU8xGUeUdjkvAPWjr3M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-mzKQNnKqPmqQHwWSxkTwwg-1; Mon, 18 Mar 2024 16:04:22 -0400
X-MC-Unique: mzKQNnKqPmqQHwWSxkTwwg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430c76df729so6673141cf.0
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792261; x=1711397061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
        b=FSOeuJptJo9Ks8ofh6dtzqj2k6nXqhHzkxWiXGoZYv5EUYcjA3zSEhtNKRSGu6gvld
         H6gjNTnPxkaNESiGIAk94Kk0s92bQx5wj73kYpp4lnM6uGSlMsA86CRrPlCrwWAoaKPr
         KOnaM9JKzaKBumx/ZNg+ohIwlcdyF6oJA/tML6OjIaRYeFu0qKmKCC1Z4nEEglekAAe3
         P+mYUEG/R0LN7+UPuDP61XeT6KWm94mYTLewgIKzX1YAx32ZADzQJSHYchxhuwXDcqYK
         OicvT8Fal2GvtF+cg6yeVwKgHE75WMrKXoT4vKJjNjCO0rJ9AJ1j4U4lz0SAHZz10oVY
         P53g==
X-Forwarded-Encrypted: i=1; AJvYcCWO0WXJiTyIBQqeuNwfLqHlfTIo6pf13swgao70jGDf4hj6z9ddPZBPHdDYPsoIfkBTmxf5B+OL/9PqQkoTXvGj7wuZAsQlQPnp5A==
X-Gm-Message-State: AOJu0Yyfloj5W6Ina8m6tZJwJqb4YosTb1+maW8Xf9KuFxsiTX51GnhD
	KSH0wBx3ISiu/7jz40VfG+Ta8THqxfGwy3tIT694P3F1o9GKYbIT5MNW+/cUoxzLS/Zsnp0su7y
	uJ/JWLH/FsfaIeeFbTaTShKlq4WiHru3i/KeTekEvIbwhyoCeKZGvx0sVP3U=
X-Received: by 2002:a05:622a:15c8:b0:430:ae0a:c08f with SMTP id d8-20020a05622a15c800b00430ae0ac08fmr12238067qty.6.1710792261458;
        Mon, 18 Mar 2024 13:04:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQhMJRmPtSMLbLztL+aVkPHyOJfqD1JG0yGIJ+aGiheaz6nxeexYpcIdXvqwuavYhzTjiHrw==
X-Received: by 2002:a05:622a:15c8:b0:430:ae0a:c08f with SMTP id d8-20020a05622a15c800b00430ae0ac08fmr12238049qty.6.1710792261015;
        Mon, 18 Mar 2024 13:04:21 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:20 -0700 (PDT)
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
	peterx@redhat.com
Subject: [PATCH v2 10/14] mm/gup: Merge pXd huge mapping checks
Date: Mon, 18 Mar 2024 16:04:00 -0400
Message-ID: <20240318200404.448346-11-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318200404.448346-1-peterx@redhat.com>
References: <20240318200404.448346-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Huge mapping checks in GUP are slightly redundant and can be simplified.

pXd_huge() now is the same as pXd_leaf().  pmd_trans_huge() and
pXd_devmap() should both imply pXd_leaf(). Time to merge them into one.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 802987281b2f..e2415e9789bc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3005,8 +3005,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+		if (unlikely(pmd_leaf(pmd))) {
 			/* See gup_pte_range() */
 			if (pmd_protnone(pmd))
 				return 0;
@@ -3043,7 +3042,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
-		if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
+		if (unlikely(pud_leaf(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
 					  pages, nr))
 				return 0;
@@ -3096,7 +3095,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			return;
-		if (unlikely(pgd_huge(pgd))) {
+		if (unlikely(pgd_leaf(pgd))) {
 			if (!gup_huge_pgd(pgd, pgdp, addr, next, flags,
 					  pages, nr))
 				return;
-- 
2.44.0

