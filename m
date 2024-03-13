Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F25C611
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366455; cv=none; b=m+vw6gELXN8NP7BUHtzWcNDxnv/CtIVdyAucRit+11WV9NA8JSLEoV1k5h/O+1Zgif1viEpY7V5+FXQ+HVW2qqQk2TXjvsEkoJ5fFDUaUmfEoKbfCl2W1XyrQYYH54l8Iuh9SaUkPZlSO8bdPJ+nI8a7I+7w2tuuLGOnpgxKXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366455; c=relaxed/simple;
	bh=udgt5BojDZ8EVWkeL4uhl2LfvjHvU9M2T020easV1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8cI9zjZ7G9Lcolr8HGnntdneiC2bD5uC9v9CrBvAFCxCjUqS1I43JxAIidUFsZ+ED036Fm2nTRvnpklr7MOeWym+dGc92S1yb7qHUW4Zi5vlOLb57KHfNKcGt/bMSm53rS/wCvrrb+kUSVdw3cyyKVmDd1LLAXPoP6e5Y3jEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1m7E5Et; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1m7E5Et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXv9WADGZnpW9LG755UO1HRR+yBh/xYRmZG+iRDILn4=;
	b=N1m7E5EtoD45RmFLL1vaVjkpqyolkGFwfJo7NpA8diw6gJMRPPpWuSLArHe1r/2JcFPz7H
	McUh9aC6+ZCxTe2oru++pBkikRyuKCNTRmGG7lMq86TgKxVmml/QLBUcJoGYR/9167nn7c
	ecCecrp7oGvrLCyOCUrc5eTB/vgo64g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-rbQePjr7N7ykC6fvUkhgyA-1; Wed, 13 Mar 2024 17:47:31 -0400
X-MC-Unique: rbQePjr7N7ykC6fvUkhgyA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6818b8cb840so989196d6.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366450; x=1710971250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXv9WADGZnpW9LG755UO1HRR+yBh/xYRmZG+iRDILn4=;
        b=FOO20EWN31q6TX78knuH4Tq1JS/OFe6cSu3UrH2AVEQELU5gCiFU8PjUj5Z9TVTYRc
         Z9HOj6dPPkpfihcSu8/k+mGLBlijPpA6g3RyXYR+oKCjmku+EP/GdQKuDOc7NjaUUylD
         DcZ8UyepGiasoj9nOtSsdlp1od9YKz/SdFQ12F13l8IXq+SE2/kiqjemPA/Pve2tjpvO
         A7tPvHrGUwuIrf+ZE+8DCUKryUJQZoL3fbyLtHQcCGxSkRbHVsWh4nLdOt5fC5f0mAfj
         Ue3C6tiMD5OAQnZYXwp+S0tPHjiY4LUYQoIvolVSDJz/w3At8vp0ZQwSJOAYww/JdyA8
         WGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK3YXzZX0AB5J8/Z1Cmb6C3G/WIW0ogJsIwt/69ImrC6pnXkfnijWPuqPOwL/d3EAtc5ws5TTqRmW+9NPntIxlFXQilSACuz1fOg==
X-Gm-Message-State: AOJu0YyUOsHozyLvNORPDHd5utNXVKSWJlC7/AHGELkZPBf50MLFGCyd
	oiAOv9Pozdu28bRMrTDwQNFtPf3ppO6aGzwiICc2Q4ioszmV3eNA6bgcI5ap6QkUyy71NvzbozE
	DyE4iD/svBRp6YMVt6tiTyq8S6RGnghdBCVPVoBJEvhzT6mOOii1Z0i+bOSA=
X-Received: by 2002:a05:6214:ca1:b0:690:ca31:f070 with SMTP id s1-20020a0562140ca100b00690ca31f070mr2870213qvs.2.1710366450569;
        Wed, 13 Mar 2024 14:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7R1Abf8N+n3Ay4Ttv5JPf4Xs41/taFQJ/1rB/5tSFgWpT6oJW7WbEayo47shzOXV0M53hEQ==
X-Received: by 2002:a05:6214:ca1:b0:690:ca31:f070 with SMTP id s1-20020a0562140ca100b00690ca31f070mr2870205qvs.2.1710366450230;
        Wed, 13 Mar 2024 14:47:30 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:29 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 06/13] mm/arm: Use macros to define pmd/pud helpers
Date: Wed, 13 Mar 2024 17:47:12 -0400
Message-ID: <20240313214719.253873-7-peterx@redhat.com>
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

It's already confusing that ARM 2-level v.s. 3-level defines SECT bit
differently on pmd/puds.  Always use a macro which is much clearer.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Fabio Estevam <festevam@denx.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/include/asm/pgtable-2level.h       | 4 ++--
 arch/arm/include/asm/pgtable-3level-hwdef.h | 1 +
 arch/arm/include/asm/pgtable-3level.h       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index b0a262566eb9..4245c2e74720 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -213,8 +213,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_pfn(pmd)		(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
-#define pmd_leaf(pmd)		(pmd_val(pmd) & 2)
-#define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pmd_leaf(pmd)		(pmd_val(pmd) & PMD_TYPE_SECT)
+#define pmd_bad(pmd)		pmd_leaf(pmd)
 #define pmd_present(pmd)	(pmd_val(pmd))
 
 #define copy_pmd(pmdpd,pmdps)		\
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index 2f35b4eddaa8..e7b666cf0060 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -14,6 +14,7 @@
  * + Level 1/2 descriptor
  *   - common
  */
+#define PUD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
 #define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 3) << 0)
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 4b1d9eb3908a..e7aecbef75c9 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -112,7 +112,7 @@
 #ifndef __ASSEMBLY__
 
 #define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		(!(pud_val(pud) & 2))
+#define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
 #define pud_present(pud)	(pud_val(pud))
 #define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 						 PMD_TYPE_TABLE)
@@ -137,7 +137,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
-#define pmd_bad(pmd)		(!(pmd_val(pmd) & 2))
+#define pmd_bad(pmd)		(!(pmd_val(pmd) & PMD_TABLE_BIT))
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
-- 
2.44.0

