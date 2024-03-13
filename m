Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB65EE78
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366467; cv=none; b=nL+wXCKjr52wKxt4r3WaOPEZFmyWsHeEPNF7KQs6TXARfykZu77GEubibflmsaBM1v4QLG5lQQQN36d2oX+ZnYfE38bLKsQ7lk+8DPoWYlm0YgG+SS5y/8gX/Ja4NaSeTft0Qua1uRhtXISIl8iT2TNBgWNKAALg0EhoVvGJy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366467; c=relaxed/simple;
	bh=OtdxslPn00ut3ZNOwlMQpC8bAo76CW3Q9+JhiTFcwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpYd9cQxKsVf4hSmUcRLs6ovE9tS+f17Y9QrKRUmmwfEnmZOr9lagIs2CXVGEMgJyds8NP2cpIUG3bCkAJo6n2Qb0+TRgc5Ru+vWpQKzLHemB9eraPMmYqw1YnWM8Ye/5haxDDzNZbf/iu7kjrfKH+eDHLpKchryIO/JUw+Cp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtBNisYf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtBNisYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
	b=QtBNisYf7XfwYzICx0puyDSv7NCHTQ0Vr0rYjB5gnSkJnBK3UUrk1uxJT25RIZHtO/bfoJ
	QX5RuHcdVe3zSPZUoEsgIxuO4z52n3apo6g26vmTr79sgNYJhpMATW/tAqt6LRlrQjH95/
	rIi7DsrSSvR1wPm24zeojaQC/4iu3NQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-nkyZhZhYPkK4geRtN9ne7Q-1; Wed, 13 Mar 2024 17:47:41 -0400
X-MC-Unique: nkyZhZhYPkK4geRtN9ne7Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-690ab2b0de1so1163206d6.0
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366461; x=1710971261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
        b=sQV8KvdtqF2HRz8o8dLSG1s23E2yBdDPojFZ7IlxQDF2qeKtUNsQSy5aiJvlPzlVk2
         bVSNfJVk9/PT+uq+5XIpo+8vsgFxGb4g/AVcT3m5HM4n5PmySAwXPA6RQnZDa6YabK/S
         NsmcOF1B59r8+X5Ui+iFNLbCZZ2QoO94eActCCsQnKNntZgIC9IKup9VbY2eUGUoAsL5
         xpnB06VfOLAI2FVL93OKXmbhpQXG9IhhxbtiveoOO09tBSnlY5atDVAHOmUH4kvvBy1g
         u4fiM/SCrdYyaWRsYJ7bLz7sRWG6fJX8PAeTwAxEZ8UNIlSo0l1npTfKWTWEAemBPw9+
         7uWg==
X-Forwarded-Encrypted: i=1; AJvYcCVFwNgjSEjS5NKytjvBj+8wHezNqzmqx8hPZp4XkXItF5px1/9JuhmTo/2ZULJ1cwQoqe02DdL1jYCmhThvqlVAu1RlzIPsxhXOFA==
X-Gm-Message-State: AOJu0YxkJvyFCiANR+LMqTY47xpbQMlC6qhNjmuj0Ppba7nNQ4IsmGjq
	yAxT7P5DLT+mmNkEuoK0c9A6rWoahRqaCSr0PmqRp12/LQafKPfYTWbK+w7VSGDwRmayMyhWJKt
	R/pVejOpZLAwiNUC+zdbaXMjkI5sX45YdYvi8GuACy8cj+JqaiYhRZz/GDMo=
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id x3-20020a0ceb83000000b0068fe77970f2mr5934048qvo.3.1710366461088;
        Wed, 13 Mar 2024 14:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzQ7u+SJJkcqXmUXcq37q3NbZvmeXcFSg9ZX/No2VaFoCndSeWwMBLZUu/Dqoea36C4ilydg==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id x3-20020a0ceb83000000b0068fe77970f2mr5934040qvo.3.1710366460771;
        Wed, 13 Mar 2024 14:47:40 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:39 -0700 (PDT)
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
Subject: [PATCH 13/13] mm: Document pXd_leaf() API
Date: Wed, 13 Mar 2024 17:47:19 -0400
Message-ID: <20240313214719.253873-14-peterx@redhat.com>
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

There's one small section already, but since we're going to remove
pXd_huge(), that comment may start to obsolete.

Rewrite that section with more information, hopefully with that the API is
crystal clear on what it implies.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pgtable.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..6b0d222a7fad 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1770,11 +1770,25 @@ typedef unsigned int pgtbl_mod_mask;
 #endif
 
 /*
- * p?d_leaf() - true if this entry is a final mapping to a physical address.
- * This differs from p?d_huge() by the fact that they are always available (if
- * the architecture supports large pages at the appropriate level) even
- * if CONFIG_HUGETLB_PAGE is not defined.
- * Only meaningful when called on a valid entry.
+ * pXd_leaf() is the API to check whether a pgtable entry is a huge page
+ * mapping.  It should work globally across all archs, without any
+ * dependency on CONFIG_* options.  For architectures that do not support
+ * huge mappings on specific levels, below fallbacks will be used.
+ *
+ * A leaf pgtable entry should always imply the following:
+ *
+ * - It is a "present" entry.  IOW, before using this API, please check it
+ *   with pXd_present() first. NOTE: it may not always mean the "present
+ *   bit" is set.  For example, PROT_NONE entries are always "present".
+ *
+ * - It should _never_ be a swap entry of any type.  Above "present" check
+ *   should have guarded this, but let's be crystal clear on this.
+ *
+ * - It should contain a huge PFN, which points to a huge page larger than
+ *   PAGE_SIZE of the platform.  The PFN format isn't important here.
+ *
+ * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
+ *   pXd_devmap(), or hugetlb mappings).
  */
 #ifndef pgd_leaf
 #define pgd_leaf(x)	false
-- 
2.44.0

