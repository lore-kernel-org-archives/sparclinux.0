Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CF5C5F8
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792273; cv=none; b=GCmDOIXLoCS+WX3Zm84+FKs5Ljf8aoCI8mD1wRncltBgwnYnlPARrlYLzi6KXT8m/NNGx8xFOGcln5Hg9QwVqURnCR3YQZMObDGU9Xn/dVj/5E8gHMzWU1ZbfmB0F1XNzgIhGOOBvi2w+9xzjOC5JbVD9kR//48WvxhHbSCKX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792273; c=relaxed/simple;
	bh=OtdxslPn00ut3ZNOwlMQpC8bAo76CW3Q9+JhiTFcwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7HkmAqYny4uoykbzeiMZCWtIVeLtdS1nZ+3WBWtiMLY4Mw+EPfz0XRC7NAY7AhqBN9elPvHdYsSy6iEz7lWut8C4ysLBJ/k1sDMmaCJGLeu65p7me9+bqmmpRjgmTlEwOgozRf39twwooDGcUjA8X8LoNp++scKQF/vU7+4P7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdwOe3aI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdwOe3aI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
	b=VdwOe3aIvSGb3EjnErxECSIJ8yp8cVzdrS1vJ1eX6Ca4aVQ2ljRnzWT7ezAi+MQ1OEyJTs
	fo/PN0EzHIY2Y1ZqvjJBp7568xB4vEBTUB7pKUcvK2obLy2TbpkkQgWo+rPB89umVMOy5U
	UG6HVct4R7YankjwjN4LPGa7dGENVM0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-zJRVkpQVPlSntuZGP2FQDg-1; Mon, 18 Mar 2024 16:04:29 -0400
X-MC-Unique: zJRVkpQVPlSntuZGP2FQDg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e67a83e7efso943732a34.0
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792268; x=1711397068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
        b=kymhhxEOZP0NB2iH12hEsl2zc2n3/hFDiXaewtWOCBlrCzDA9/olwTJ4EYvdEDfFqV
         5fvYuc+iUN/yJuMsuMNZmcfxg/+VYLU1MT6KgamR35A/VBcv2aJvLw0g/K+B874IyELg
         rFMMErIKm20dHUiMj83LkqTKOQuMjwy7QFn2wBVmZTWiOwHeyZBoqjMPXkQtzR8zzf6X
         QJ55vRdNHb27ezMhivGjZC3lqxn3Otwdj8tX7L3Fo2N/r5nGdvvE31UqFkKAWo6rvWZe
         XRcuJDxdTAT3ETGOumu2xIwPZ0013tQ/jR8lV6VsnI7KKzyC8OtoufgvmZJgAugDjFeE
         CDdg==
X-Forwarded-Encrypted: i=1; AJvYcCUPwJMqrjjMCj7+Sk759nhHkTNq7riPAHviZ0Wt5hxjfpL4dlwb75q+4ff8nx05gqq6Ryj4/uOhvQf7NedKm2yORdmurlymfHdFag==
X-Gm-Message-State: AOJu0YyrfMuPC3mCeseqOfaQO0kRd7dGemGY9jpZy26mkam0DPVJaZnX
	2mUtBgfTbuL62mr8Y5beIpMAr9LAknQeBWgLVoaYVGBy4NNp71A9GIuRV1w1LoFZ4++ixiDfm2k
	3SfP0yhZ7BxlNtC4Gc4CE4U9huwSTe1LWfmWbGlvIsvuPPmDau3eo4L7d2Ls=
X-Received: by 2002:a05:6358:65a5:b0:17e:b905:ae1a with SMTP id x37-20020a05635865a500b0017eb905ae1amr174637rwh.0.1710792268104;
        Mon, 18 Mar 2024 13:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGISjMhnC6jpMGGK6QBF7/frbKYlLqkW40smiDqxegPdY+XDqO7mpvYlvBe3yHbKZyIwRsTRA==
X-Received: by 2002:a05:6358:65a5:b0:17e:b905:ae1a with SMTP id x37-20020a05635865a500b0017eb905ae1amr174607rwh.0.1710792267562;
        Mon, 18 Mar 2024 13:04:27 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:27 -0700 (PDT)
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
Subject: [PATCH v2 14/14] mm: Document pXd_leaf() API
Date: Mon, 18 Mar 2024 16:04:04 -0400
Message-ID: <20240318200404.448346-15-peterx@redhat.com>
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

