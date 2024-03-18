Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE95733F
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792254; cv=none; b=sf4xYQng1D3A26AHuGJu7qCkb65+lWOFWXUrYRnVpKgpHCfk3Zx2HkEZJMGKftbDkuquO2eqEKSIVZ7eO0dXZ1QtQvwwA1U3MRmYRNR6K1Jj9zWCZEuHPmnmf0aFKdDySr1fSesb29O0A0BMSHCnOayasz7JME9UlfNlT4fB344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792254; c=relaxed/simple;
	bh=PJKzqnHG6HtyEXo/aXT9kPop7Tc4xiPLd1rW13UePCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nihxGPiTfCYpGcvpVWrJ4uCrBn40A/taisYIe80KTVPw0wq7R/K7Esztt8/FBS6swacjuuVguGTEusk7vH3fUcHYKguZMuWCfm7Asqv9usnj20vWc6R0VSkBMSwNoVTLIUO4NCR/E9dcQi7c2/woHM+IG51Nb46H1uEa7OlBRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTdU6A1x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTdU6A1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D9LYre9es5Pr/ZmF0ksBqg/v+REJVkPqwZxeVyu2sc=;
	b=ZTdU6A1xpPBWgRCglnn/06arPQ7nDjg6hUkl3yWMAWF3sP0PD0h9cvJlXaiyTC3RONAm0A
	wc/gl6RFhHdYi8rFPKxltgR8EDhBs5opVnNvSgciJ8+P5fbxDo4ukSeUYkVAsICenwfhJU
	+vLD5FbvGgNqto9GPiy5jtojn6qMMiI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-bAhf1VNgMtKX6C7a8fZ20Q-1; Mon, 18 Mar 2024 16:04:10 -0400
X-MC-Unique: bAhf1VNgMtKX6C7a8fZ20Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430b4572a97so17522481cf.1
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792249; x=1711397049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D9LYre9es5Pr/ZmF0ksBqg/v+REJVkPqwZxeVyu2sc=;
        b=hN/fjdTjnuL1LqwnSYLlYlZJYwiKqBn9pyD9Ro++8gBucBwGucHM5GZN7b4vBFddsA
         X1n60uQc9BIeujDDcGR30aQJ/KTGOOkfQYQooN1uToZn9oPvojevkDc62IRJvkxy1QEr
         hnwFpttfkj3DJa6EN4t9AGuehrhtXCFvIiTCyrVskNLRUYT0L2fiPE8eu2mh2C8Y+TIw
         J6pR58XMuJfkDgGU+mkRpzo6kUOqFeQczySpPM/r6YeTThSkQ6KkdDC6VDQnI2h6z21A
         clvELc8ps1CWDl316jf6LeoJBx9UdYhW1uHdffMieDA/n4qkTzO9Hx5jsiwUQGTy3/T6
         W4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUbc43hybW9+iF1JNKWhwdt6xRCD9/foMlnSm7iMShepcU/FL4125Mty3RVS6ZLsXnkJqeElqWiI0dFTdmCpK/0O0mz7Bp+9Ru51A==
X-Gm-Message-State: AOJu0Yx1qySdl+3hjOv+WcC3w65hLysIXXtxFi2BczfjTf7LTWcIuHtl
	Qbl9ObNOau77rzQbsDXDHa+SgTFEn5go75s3TXW0znI4Kmde1L0ATCg+Yl6NOxqIwPZjBbtvliL
	m2e2dn5sBYX1g4JnKG3Dn6IzkDPO1Gm3ui5+R+VjlYmAjefA2Eb9Z9IjEaS8=
X-Received: by 2002:ac8:5809:0:b0:430:9ec1:77f9 with SMTP id g9-20020ac85809000000b004309ec177f9mr12704571qtg.3.1710792249343;
        Mon, 18 Mar 2024 13:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbpoPvKLD658FrZMZUfa21VFbJZXAX/nOy5o3FQUuNePIa1lkPrmXkrLKWAEePy+S7Jq7UDQ==
X-Received: by 2002:ac8:5809:0:b0:430:9ec1:77f9 with SMTP id g9-20020ac85809000000b004309ec177f9mr12704524qtg.3.1710792248947;
        Mon, 18 Mar 2024 13:04:08 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:08 -0700 (PDT)
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
Subject: [PATCH v2 02/14] mm/gup: Cache p4d in follow_p4d_mask()
Date: Mon, 18 Mar 2024 16:03:52 -0400
Message-ID: <20240318200404.448346-3-peterx@redhat.com>
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

