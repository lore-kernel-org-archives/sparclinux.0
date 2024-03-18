Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0C57892
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792255; cv=none; b=qWDODkLIz1xYsbjuF+vMQbMIKaFlcLcKHVmP6Z7xonTsU5OXQJ6DkNlumHDui7r6PeUwAqstnSYo1M3CWaL79M2p6GtUjn8buOUB3ldutwrZAlQ2Da0pIdlnJ7LYll1/MvO92CTcGC3YXAl6SfrpM9JDnIGTm4CIpfCKG6TXF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792255; c=relaxed/simple;
	bh=XKAmzhpmXEAjAsa42PYgBQQ2HzrzYrw3Lh5/ehBy8nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2FMpmC2HXgbFfWfIJxhYfxlgmvpUB4lXI605jZJz7wYlPn+tAPHAc0yUBnrgvDvAPZEB7ydKj6TThBVJUrug/unWthkOFYlO38SbrN39N2NR9M+C+Bv+mz3d7LiV+9lecaPnUwMGaVv0xrk3uDnSbDPNSHhnXDcispZdiQeK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6YS+vCA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6YS+vCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
	b=O6YS+vCAwaEx3DbX7jUjOyUpYA5qU8uq6C2t9jQ4hk/DF4zvQPx8x458zFfgxxYK7h2/c0
	UpQaWYxzcSi7nX5URdqZ/dZ2PI4D1IZfhUTbysr4qCkH5aPH9JrzepZs5F4gqjTpc2iTQc
	C8wF57vQnkyOvkPYqrAwKEWoUF5wuUA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-o6QrPGEROv-OEEQc8BJATg-1; Mon, 18 Mar 2024 16:04:11 -0400
X-MC-Unique: o6QrPGEROv-OEEQc8BJATg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-430b4572a97so17522651cf.1
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792251; x=1711397051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
        b=Z/UPCyNvXHLQE6zWWOLhbVAlukoW2OZKgc3ep8/o/Oap+WYXSA20eq7v77snuoFBF2
         pEOpeFnYFune/hThws18j6N68Iec/oKBAN4fgGnuhPV5N85dL6thLpWZjaORzkY8xPko
         bBbqtelmaagGDwHba1PYxt4wCeB0GJP3710zNw5XeFsn/2fPpfSyXrUqwwh9HCOv2TJl
         FIe8Bp1YMuVqwH6nyjVMZuT7HDlEAf80DCWYkd1UGrLqd6HYFP/3czRcrzS9fLQIZBzI
         ZGIl9/kFYADntDXp+KoM5msfeNczBNSdUF80hdUZE7oqJnCImMB1AS3FzSeN/GP8dT9D
         KwiA==
X-Forwarded-Encrypted: i=1; AJvYcCXrLAHAJSgGeUTpiCWIL8rWWQvnZQ7bZQO46VXS2J4bzm70VGQd2YLpIiXDV8XIfReNIxa89GuBLOsik7jUAq97EziiQQx6vEwolw==
X-Gm-Message-State: AOJu0Yw018aWSgK9UJR6JqWrKePVtysbGklYTvDiZzKQ0wJ3INVV3oMQ
	jGDAiXKcFDal1gCJqNS+bMqyPZyUTI577IL3EoCO/vlYnvav40gMFyerSTCe5j8RhG6e6twcFZM
	vFSq39TxJfTS1HNmt9V0njW1ZERAXnpAxY+bUBzCZSP7b1F/o5oy9X4rqZb0=
X-Received: by 2002:a05:622a:100b:b0:430:ace8:9801 with SMTP id d11-20020a05622a100b00b00430ace89801mr13041017qte.1.1710792250879;
        Mon, 18 Mar 2024 13:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lB75/Xyi/Yr3FGp4iv8P5rE4DSC0aUJAJLEw6DejnKFtl7A4ZV0qXSchssNp4WRDw4IDoQ==
X-Received: by 2002:a05:622a:100b:b0:430:ace8:9801 with SMTP id d11-20020a05622a100b00b00430ace89801mr13040968qte.1.1710792250407;
        Mon, 18 Mar 2024 13:04:10 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:09 -0700 (PDT)
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
Subject: [PATCH v2 03/14] mm/gup: Check p4d presence before going on
Date: Mon, 18 Mar 2024 16:03:53 -0400
Message-ID: <20240318200404.448346-4-peterx@redhat.com>
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

