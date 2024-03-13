Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817157324
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366449; cv=none; b=reXVZd+cSlnV/k7tQ0QuEH/9gvFMGUAQf4csPqQ5jJ94Hp0BL+/q+bakLRZupFTzdOGSQDRem3Yq8t7N0z38poF6/u6BlDwvaxnZZKBk5JoDLAVU3lY7q2G7/Tqi35N2w4Hjj6/hhydEBdIm0BtALHH1jADxra9i5V4CYmKdrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366449; c=relaxed/simple;
	bh=PJKzqnHG6HtyEXo/aXT9kPop7Tc4xiPLd1rW13UePCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzT6Pf2svwh94moCu/Wr+zBWdGcqKXQQdKiDS3vUNROIEB1piKb9m4pH4HIUZcDpv/KeSqDJSn6vS0Gl9ApX7m5HxIEIA7sTDYwsg3xGyeq8hbnwIj4olanxLXJYOWjZGbibFqB6UEVJGZVKEfw/k6EAivYYOa3HXO4P/lAx5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuWK7MIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuWK7MIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D9LYre9es5Pr/ZmF0ksBqg/v+REJVkPqwZxeVyu2sc=;
	b=PuWK7MIBXf4+FuojOVhCcZzf7yzEgNJeu2GCPF83ym29z8M56Y6klqHxX0b1u80K00UTnp
	C8I8MnQYMMFSIBqFASVZxZLmZVIXlqjh+HYierlbLlroPnhEBOyN1SpzoXuW8nZ6xZLJs/
	VipUxUKmSYGNfsMjiLKiNW21yiuZggk=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-L9mqp6ENNVWLXBftdbSdyg-1; Wed, 13 Mar 2024 17:47:25 -0400
X-MC-Unique: L9mqp6ENNVWLXBftdbSdyg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-22206c445fcso134269fac.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366444; x=1710971244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D9LYre9es5Pr/ZmF0ksBqg/v+REJVkPqwZxeVyu2sc=;
        b=lg0Y4ZuuJ7L57F4mV1sGXmGVdQVmj2ww7k4HmAdPks3J9PfYvxPXvtwj1pkEPOW+1w
         OhlcOvP3+Xi43D/11QQPmURVp5io/L8HvTfsIu6iCqqshTRmftuxH1Ym6rVA7JF7PL06
         SIjEH3PHMaSTQrA0Or9aFQmYsafSGPOs1VqWjt/BXURZRJjhrCZWjkHotDN+6E2OVNHU
         yUVb0Qe4Nov7UpLBUvprQzku2CYo2O/z7fufcStT5uePJJQ2VVzPquiTBJP863tZV6aM
         5fULmcmXDVM7n2rryfQcUdJSeMg/4qvYPYcFVWlzTiaH3ebRhtwbSmphO9gza7i7rbAs
         F+zw==
X-Forwarded-Encrypted: i=1; AJvYcCWt2p/49ckx5PYjFjfuxpam7P5Pdzyl8N/1U2GvwZfFCz0e48vgvl5URL0CswuBXHUCVzV6vRX3XZSXteLn1QmjPjEB1GuJjdV1AQ==
X-Gm-Message-State: AOJu0YwNhMt+eWP3gUkdit0TJG7jNqizqlJTkHQHvnTbcHQH9W3jqYD3
	VoTlFY9FxgTivPwOHLdzEOBHVot2CEjHb5zzcPChUDa+m/VQeJ7Ej11pXaO4rWQRLovcFKYU+sP
	KuKLs/5Kz0NORqhv7dt5IIK3nNioK3zeLmrifghDNqzcyrLqwI8ABRxsS+Wc=
X-Received: by 2002:a05:6870:548b:b0:221:8fd1:21d9 with SMTP id f11-20020a056870548b00b002218fd121d9mr65923oan.1.1710366444689;
        Wed, 13 Mar 2024 14:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsHUgdlv9jd2gJ8jFSi5EgQlUb7Ps0TGhERhhMFfAJj348C9AzYnG5IHJKnziXpPDsCb1mgQ==
X-Received: by 2002:a05:6870:548b:b0:221:8fd1:21d9 with SMTP id f11-20020a056870548b00b002218fd121d9mr65901oan.1.1710366444348;
        Wed, 13 Mar 2024 14:47:24 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:23 -0700 (PDT)
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
Subject: [PATCH 02/13] mm/gup: Cache p4d in follow_p4d_mask()
Date: Wed, 13 Mar 2024 17:47:08 -0400
Message-ID: <20240313214719.253873-3-peterx@redhat.com>
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

Add a variable to cache p4d in follow_p4d_mask().  It's a good practise to
make sure all the following checks will have a consistent view of the entry.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d..69a777f4fc5c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -772,16 +772,17 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 				    unsigned int flags,
 				    struct follow_page_context *ctx)
 {
-	p4d_t *p4d;
+	p4d_t *p4dp, p4d;
 
-	p4d = p4d_offset(pgdp, address);
-	if (p4d_none(*p4d))
+	p4dp = p4d_offset(pgdp, address);
+	p4d = READ_ONCE(*p4dp);
+	if (p4d_none(p4d))
 		return no_page_table(vma, flags);
-	BUILD_BUG_ON(p4d_huge(*p4d));
-	if (unlikely(p4d_bad(*p4d)))
+	BUILD_BUG_ON(p4d_huge(p4d));
+	if (unlikely(p4d_bad(p4d)))
 		return no_page_table(vma, flags);
 
-	return follow_pud_mask(vma, address, p4d, flags, ctx);
+	return follow_pud_mask(vma, address, p4dp, flags, ctx);
 }
 
 /**
-- 
2.44.0

