Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0E5A7A9
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792264; cv=none; b=RifiMInRSuybtksDQQ9ta3nFxgdFXIZHOz4Y+ML9gj8RbmtNmr7+id2mDg399t/hm8wna1GysyE3/9yfhd3RsEYQSx06O+3vlk8uQd5N8yKKvhQIMl07Z+hqXVaNYsSniWdxxACq+SsCRBe3a0t4YVY3XZC8QE6FQQyHZp6a07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792264; c=relaxed/simple;
	bh=weqlLlG83TBsWRguH056K5yDTM9gfMC/nowGeaZU39M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhXeNOUJCydDFpDsl0wirZy12rkur4tN7EZtgsUUBk4nModuR6tQvXthjQ5bYy3BKaKFCmYzhaZag1JxpGePwvxmZLPNYB2vbTaHuvGUYxniQlY4ARzB0M8SrcQ5yi8Q4vzlgenflz23LZApcEDrpQINXBKCpV28Nv4yKI7fHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwuUFmR/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwuUFmR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vy04FBLzPG5Zls0F5g74nprsAX71rsrg1jdch17dleE=;
	b=OwuUFmR/M7jrwdD08cWPPhNzSH+p3JUHNkxpchMwqd5jWQbkx+HcKR02B0KLBCzOBLRV0X
	dhRJ9Z/ZPn0dVX3Vgz7Ln0nx+65Fq7yWU+SUl2u7gWpi506tu5C/zj7rKH35ftaTwvUheE
	XDiebKYpfto+4GkspdKN7ymPvROGKYE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-9wn7dkwZMtOViBNwK4nCTQ-1; Mon, 18 Mar 2024 16:04:20 -0400
X-MC-Unique: 9wn7dkwZMtOViBNwK4nCTQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-430b9ee6bfbso6674561cf.0
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792260; x=1711397060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy04FBLzPG5Zls0F5g74nprsAX71rsrg1jdch17dleE=;
        b=Me5lJ40o4V6IScTlioE0qPsbP9+s5dXfmHCPPqu7fzKJc/QXsOPNEUxySoIvpdk7Sm
         aeDoS/mzHg88uQPCtuJzBznQaQ3YHnEmaEhxGmsQ1/jKa3pQSNvj2zlIPlhDN5q0dTjO
         xC1ls2p/0stb+6KmM4MITNHMx2/vIRUJm5/d6BG9MsK7I/jdZkpr5uuyYwJKykyMmIp3
         c3hvdw0gsNsIsm8d2XgDmKRnel+GCD5OwdN+F8MosQiLEbIAGG1H04dV23sFXEvPpN4e
         Z/tCTv3LgOQRPEdFZaFK9jd+yp2Q2jSbrEuIocLNbA0IXxDTPIbb8RpiwBxmLQtCdMlL
         4M6g==
X-Forwarded-Encrypted: i=1; AJvYcCXjDZOiZzey0DkRopQ4eHm5l8fq2PhQ+xOIE4Xfgm+iOnqb6x7ZjsWk1Vag7llv+u7IUSMJyw1AxtrRS3hMOb+qhhWCwN/5QajPqg==
X-Gm-Message-State: AOJu0YyHBeY7M7/kyA4ZX57oTNbfVOqBfDALxZdJ9JgFH4pkePLk8FcZ
	62nAwolkmr+6QJUqr7VJg0n2cH2W7AF8aBbAsGAlysHmAwX4sMaaW0ko6tHXYoa9e1ZGmeVIapR
	ey53Zq8D+qF3S68ERYgx8jVqxj47Pv74gbF2Fgldz+Eo34ai+dK37m0on4zw=
X-Received: by 2002:ac8:4c86:0:b0:430:c314:d150 with SMTP id j6-20020ac84c86000000b00430c314d150mr275831qtv.6.1710792259889;
        Mon, 18 Mar 2024 13:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpXWUncergFjfMSFDTE8/2jUGQ81NOYysiHRDsucc9G0cV8OOvdubCssw9QQ67SSZupi5Ulw==
X-Received: by 2002:ac8:4c86:0:b0:430:c314:d150 with SMTP id j6-20020ac84c86000000b00430c314d150mr275803qtv.6.1710792259416;
        Mon, 18 Mar 2024 13:04:19 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:19 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: [PATCH v2 09/14] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Date: Mon, 18 Mar 2024 16:03:59 -0400
Message-ID: <20240318200404.448346-10-peterx@redhat.com>
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

PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
constantly returns 0 for hash MMUs.  As Michael Ellerman pointed out [1],
it is safe to check _PAGE_PTE on hash MMUs, as the bit will never be set so
it will keep returning false.

As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to create
such huge mappings for 4K hash MMUs.  Meanwhile, the major powerpc hugetlb
pgtable walker __find_linux_pte() already used pXd_leaf() to check leaf
hugetlb mappings.

The goal should be that we will have one API pXd_leaf() to detect all kinds
of huge mappings (hugepd is still special in this case, though).  AFAICT we
need to use the pXd_leaf() impl (rather than pXd_huge()'s) to make sure
ie. THPs on hash MMU will also return true.

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

