Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908454725
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366462; cv=none; b=Ecr+rR8YpuS87oj9iXS3lc3P9au3/dvEKXYAaH3Jp+s36rYg5CQQvYWJkE6ilTlP+eJjLjcgWg4nsKLlN7r6Y3nsihEVvD5H2RxI1IdD5bu4MBLv3ifKGIc9U08h2HgizVYUF1bE1khFFiT7IZT3IibYARoLBUzV/UYWorBnsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366462; c=relaxed/simple;
	bh=RZT7eZ9qXAWIGdyOh/YTc5ekI4YFmly+9JiblJdJ5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4wsxpCunB7yjJ2PXZI1kFoJwNWLmTOJyBLO1Ens4iSsFQszX+NuamiXD/JpipSaf9s6LiQ1vcY5PPBbD+SxzhKRclUW6dtGPAKxulhzl2uxU1TaJ7kLdXUtq0KzfIOOFQV1+rwQ1yydXKp8iFTqyrhEXyfQQR+Z4daD3hktZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqWOTs1c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqWOTs1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3/QtZ/X4uy5vGDlYUaKemCeea0qTqCUbzq3qEDmZ7g=;
	b=KqWOTs1cgvMyp8D4WfJo5JT0Rzte5AxEkHwK87aq145U9UDQYdPm52pW0CvKMm41KPmbnd
	yqHuwogNH+KYNVj8bO6MOX7gVfVo++NpPmv4Ha198kfADbp/0h8o/Lgxaj9Eil4e+NtOff
	RW2coLE8V5wf9bV4etx1jxXtYSZ1ZDQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-4PqxyTKGMyiRToOvJ4tJ7g-1; Wed, 13 Mar 2024 17:47:35 -0400
X-MC-Unique: 4PqxyTKGMyiRToOvJ4tJ7g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6912513fc7bso1699646d6.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366455; x=1710971255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3/QtZ/X4uy5vGDlYUaKemCeea0qTqCUbzq3qEDmZ7g=;
        b=RDtoObfg1cmAAbpDKS/DdY7ZYCO7VUFShBxxuvZSkSiR31IXCS8w40LQ2aILHAmCyY
         E9zY84qGT49/wvZ5X8lbEfFYoIBAxH87DfLYzRswO++QDE/9ee+jP6WsrCPfydM3nFC7
         eVj+Vs/7HuO4UzGdzbNNjwgXF97u6FiA5p970dFa6Rb/5r2DBgbDqwqrfhPqGN+rK7Gv
         B1vTu8VYmsb+MrDFfyENI74qe9p45fizXcK/1hhMAdI3mg4gx/G3YqDqnG4mXNMrClSl
         /M8w+kxrLtiIH8USYgCTUFeTj5rWYkqn7MJbVs0o/bDE37l1683Ah5RbM++1Hiw7+1VR
         3xww==
X-Forwarded-Encrypted: i=1; AJvYcCXCqJP5WhLPQVPVF7Y4CfhHsf/u7dpD3bOgqrRk42jsnykzV3+bTZQwkBtdODom+eZAqDRALvxHDB9DHO4sDKUlIGtCsN5EXfxplA==
X-Gm-Message-State: AOJu0YwV2EdkvwYxMbkgfuf/KpvPliKRijyg38jpThO7uJFNDB9yFNtE
	zmJs2R+87AMh995TqzJ9QPk+sskAvUbEZ/UNnQQ1+AOqFNc9BbgMzJN0W19js5T5XmKU2o3Wlm4
	YA+pqU5FtSJH5kZLOJRPdafJyvYpMJPQGWZweCtyGkusV58OIYjVVkzrbwrc=
X-Received: by 2002:a05:6214:2c:b0:690:c12f:9750 with SMTP id b12-20020a056214002c00b00690c12f9750mr2845127qvr.4.1710366455045;
        Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/h1WlE9AZBGc/IXZwL3Hjjpc9ZAcuTEVAooWtSlvbi8OV5VzFu9Jid1QvxHh3VTvOYBscJA==
X-Received: by 2002:a05:6214:2c:b0:690:c12f:9750 with SMTP id b12-20020a056214002c00b00690c12f9750mr2845108qvr.4.1710366454748;
        Wed, 13 Mar 2024 14:47:34 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:34 -0700 (PDT)
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Date: Wed, 13 Mar 2024 17:47:15 -0400
Message-ID: <20240313214719.253873-10-peterx@redhat.com>
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

PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
constantly returns 0 for hash MMUs.  As Michael Ellerman pointed out [1],
it is safe to check _PAGE_PTE on hash MMUs, as the bit will never be set so
it will keep returning false.

As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to create
such huge mappings for 4K hash MMUs.  Meanwhile, the major powerpc hugetlb
pgtable walker __find_linux_pte() already used pXd_leaf() to check hugetlb
mappings.

The goal should be that we will have one API pXd_leaf() to detect all kinds
of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.

This helps to simplify a follow up patch to drop pXd_huge() treewide.

NOTE: *_leaf() definition need to be moved before the inclusion of
asm/book3s/64/pgtable-4k.h, which defines pXd_huge() with it.

[1] https://lore.kernel.org/r/87v85zo6w7.fsf@mail.lhotse

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .../include/asm/book3s/64/pgtable-4k.h        | 14 ++--------
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 27 +++++++++----------
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
index 48f21820afe2..92545981bb49 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -8,22 +8,12 @@
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int pmd_huge(pmd_t pmd)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pmd_leaf(pmd);
 }
 
 static inline int pud_huge(pud_t pud)
 {
-	/*
-	 * leaf pte for huge page
-	 */
-	if (radix_enabled())
-		return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-	return 0;
+	return pud_leaf(pud);
 }
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index df66dce8306f..fd7180fded75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -262,6 +262,18 @@ extern unsigned long __kernel_io_end;
 
 extern struct page *vmemmap;
 extern unsigned long pci_io_base;
+
+#define pmd_leaf pmd_leaf
+static inline bool pmd_leaf(pmd_t pmd)
+{
+	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
+}
+
+#define pud_leaf pud_leaf
+static inline bool pud_leaf(pud_t pud)
+{
+	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
+}
 #endif /* __ASSEMBLY__ */
 
 #include <asm/book3s/64/hash.h>
@@ -1436,20 +1448,5 @@ static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_va
 	return false;
 }
 
-/*
- * Like pmd_huge(), but works regardless of config options
- */
-#define pmd_leaf pmd_leaf
-static inline bool pmd_leaf(pmd_t pmd)
-{
-	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
-}
-
-#define pud_leaf pud_leaf
-static inline bool pud_leaf(pud_t pud)
-{
-	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
-}
-
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
-- 
2.44.0

