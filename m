Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3781B5D464
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366466; cv=none; b=BlZPWlgb8i0N01zjMeM7WGAmMCLv9xxnyWahmZk1xRl19BRZf5nyhdPkAjwDSij+XqeJegUfFoFrmn0MtHvGqs4XB4pQ99Y6yu34eM00GDzTI2GEWO96na6u9Dd4Bq01wr7xMuLrOaOiZdJj1viLYN3ejq2qigwmLitzQj9DkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366466; c=relaxed/simple;
	bh=iQQgqfXsWxx8LbxXDlwC+eVTcKSnHUToAbw1far1TeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl+ImK6D07GxvZt8r/wTGqmUtPPMjd/s3NkjArqy/cu9WAGEGRS+9BzCRYF1QmQGq8gvpIw3keVzAHhAB9DQYRo8u+pZyoX7B7nXMAGCFEYDpY/zGTAgnIm8bDhrirYKTJGDykrLD+0PtM9ruPi/KPOsKXAtxTMzVP2rbwDeBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcSzGPTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcSzGPTw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
	b=QcSzGPTwArZrbnn4lTjiy0r++lcitKJa39yC+BwkChjhhvy03/hr44Ua5PNB0UCEC4FSf6
	HjPUvC71PYbzpT5+u7AxrjfkXiTE78gq1172nEU8XENf7fXkGzA3mbA0pDODw236MjGT+V
	RKcMlIJQhd6u8mPUu89SO2KFaRR0fSM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Tqg61XEVN-SNkXZcDAVPpA-1; Wed, 13 Mar 2024 17:47:37 -0400
X-MC-Unique: Tqg61XEVN-SNkXZcDAVPpA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69120b349c9so1131876d6.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366456; x=1710971256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
        b=e9m9hUWevJMGim5zjvMlduri1Zlek6iSQYrxsX0OhPRXBVDuivb1mOv9NYCuaY9EAV
         IsweeSwhP3+PZMiWzNRveCPULABfNLMBwvoLuWgg9PghLS4TxDvwEdomO7qKNfyjA5oe
         olTAUifIFMFJF+1/Wr7h8y28aHOV7k6ZPn1Eqsy2Vx7mJsYAS7068Nvp1+ai/lvSQHZl
         +hGv1gbzA+R8UHhmhPDnDY9JciodxxLJifLvE31XJ7BfveI1/BvS+6lZYxwxFC6HnOB3
         eekshm/DF7Ln9F/0caKv8es1IZVOFwyfrTAqWfxnPqB0OODVlzQ5p5BTKj5yItaNwOXq
         v8JA==
X-Forwarded-Encrypted: i=1; AJvYcCXbk6HWePZfDY/QpH20eFTYZOKhzmYG8bC13xxOZO/UqhpF3FCzQ1/zsCkbJhJdyIWcrVZ9TBEYCAl3CXWy3eL4oSqhodZasJ6CVA==
X-Gm-Message-State: AOJu0YxgCjC9w/+Mf1Q3pNs7pNgO3lHSnNb4vSIt/TSOtxDOAKg/dl0w
	G9xLZ7gDfjfimOQ9c8am/YwstqePVU5zXa4TZCGlr3Q1YPZqhdgnhBBcJCGdilGq3J8WDkzvn4t
	qerQ558BQxC2VYCL/E/ndKjcnVAk8RzD+gQ3Nl5CFLH7qvkPzIhT2x+gCQBg=
X-Received: by 2002:ad4:4c41:0:b0:690:c64d:c2 with SMTP id cs1-20020ad44c41000000b00690c64d00c2mr5759457qvb.2.1710366456318;
        Wed, 13 Mar 2024 14:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+HGFdkYe0dzh0k+TaZTCqm6znW50jTd/iFDz8bJGRu/cwrU7vGL7Qd6Yn9XWGaKvseEdKzw==
X-Received: by 2002:ad4:4c41:0:b0:690:c64d:c2 with SMTP id cs1-20020ad44c41000000b00690c64d00c2mr5759436qvb.2.1710366455985;
        Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
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
Subject: [PATCH 10/13] mm/gup: Merge pXd huge mapping checks
Date: Wed, 13 Mar 2024 17:47:16 -0400
Message-ID: <20240313214719.253873-11-peterx@redhat.com>
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

