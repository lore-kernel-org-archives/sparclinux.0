Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59359B55
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792259; cv=none; b=MVRMrfEojJ6IXlqgdkRakj4VvnrQ+ZFgCt3aImqSXemKVF3UhNKn90MLrdhG47szJW39PCONxD/M62f/php+SQf6Eu48QHoybkZMJHGG8zYfJsekx8C2hpyxApLJyUzL/HF7MBWFwmwtyPLa6Rh7sF62G+ZJcV2ncuz7fUY58Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792259; c=relaxed/simple;
	bh=udgt5BojDZ8EVWkeL4uhl2LfvjHvU9M2T020easV1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDv8TMdYvYoTPL+suO8kI9Vnf+Qiv/LPV8+BS1NpGutsBLymIjDaxYCOkivRba+Qn6f331y9nh7KH5b2Q2o1W7dv630oHZQE/Ir2JqoQqlwabEfQu9iMJLhS9qwSY3HcpdB7mRyqWgjL0zp+78Cq5tIX5a/Hymxwn4I3tUaU+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z077qJD5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z077qJD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXv9WADGZnpW9LG755UO1HRR+yBh/xYRmZG+iRDILn4=;
	b=Z077qJD5OWr5105K86hzv98RQ18ZKL716T5LPhoWcg6JI3RCtQ5uqlqBELD76njNNEcXXg
	3qHlahPBCJaX9dx8jmn8/i8rFDMB/TsV/d8g2Ct6S5GJ0HKi0rRu6XFwav/zlm9QE4bzkE
	RXCccDnsdBHqp4AZlwNUIzMxnKAI+e8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167--5tCQERUO_y4xpzjpI6MYg-1; Mon, 18 Mar 2024 16:04:16 -0400
X-MC-Unique: -5tCQERUO_y4xpzjpI6MYg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-430b4572a97so17523391cf.1
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792255; x=1711397055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXv9WADGZnpW9LG755UO1HRR+yBh/xYRmZG+iRDILn4=;
        b=EXI3chDiEZvxnL+OkzHcMG7V0p0zX+kLDcq25Ha0CurWd/jMYFyV4s/xMfgYAeGG2a
         DR8WgDAHpekCegoDAA5oMYDWpDXvAWpRSc8XMd9h0vYDVQFYCI6H1b61TcLhRUP1RAwZ
         WiILt4850Zd1so2noH4E71ayAkNVcbnKAqms34fJkNMW9K5uFFOq7BqBz3DcrkaKiK7W
         PiIIN5Xl75J/4N9gVoYm3gI/YvED/fNjOZmhl0UNJ/nZ+zTjXBZxxKloPk4R8uNq5Vd4
         cSjHbjcIMEl6cvNInBLruH0PTTNNKSwcaqkLCNxBVT+0YHrtZumWvkeCyDoN+CzI+Ecy
         b2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWTnILk2BU+V+NUQSfMVH6NE7WqtLjJzy0pyM1Z8kKofI1Q69TIjX0/qz7NQGWbHUyT7fOCiffaVeno2pHbvTtzjkbTENFpbBqy6Q==
X-Gm-Message-State: AOJu0YyU2+QH2fqMFYXuCumKVwJwHDm+LKtvWE9FrhZiYQ8kHdgKJd5M
	QhdF9cCtgtWKxxZtCJI29CKIC4Ye3nh4ttV6TiUmbjccVyIzsH7ha+tVLaSJsnEFy7BkUm1VD2+
	Jf73cDxhbyYzjyqgR057BcRRIDoib4k4Rnv6KcasMBGTmZDuCx9WIvUAopAE=
X-Received: by 2002:a05:6214:ab2:b0:695:c55d:fdf8 with SMTP id ew18-20020a0562140ab200b00695c55dfdf8mr6345888qvb.1.1710792255541;
        Mon, 18 Mar 2024 13:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM5if+BJ4z/wKMKgmRKGlctu1Y5Zn0gs2J/D1UPDtxcNZL4bpQ3QnCrk82omp9xwt5ITq/IA==
X-Received: by 2002:a05:6214:ab2:b0:695:c55d:fdf8 with SMTP id ew18-20020a0562140ab200b00695c55dfdf8mr6345849qvb.1.1710792254868;
        Mon, 18 Mar 2024 13:04:14 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:14 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 06/14] mm/arm: Use macros to define pmd/pud helpers
Date: Mon, 18 Mar 2024 16:03:56 -0400
Message-ID: <20240318200404.448346-7-peterx@redhat.com>
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

