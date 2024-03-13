Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E55D732
	for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366457; cv=none; b=Hu4vY0J2QBnuOZqDzUqH6CavB6eN2J00ZIa0Zx/6AiLKwcaGSdxEKDbeTNOQjLI7PG3ZB3djylKleLw+cBlBQFpv9dJTCkEOBJBjkvTbr6hCEOMuOyNCMC6H7uCf26BJbpOzlvq2Nvo6/FoZQbrp8VM1bXFvTYeb0F+rgXMfmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366457; c=relaxed/simple;
	bh=5RHxSgtdvJKVCp5Pr7PrdSJPxWg3TC/UA6xoLVOm0PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF2PuJSW3ALBLEOjaTno9npWPwFnKKnz1rMz759Yx+/+qMJCP9j5Yr1CMDjZqxjbZQW4+QLwDOLyvwOarOiNfHOwdeVAb+zWs/d2z78/QQNhH7tmf5U5G/ctKhGARTmFIbXjkLPTpjGn5fu69R1vvPKyMhJRYyN0Nzi9gSOrm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJhpHYXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJhpHYXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4C+lWpN1qDfU+nymiqOVXkY7IqPiijqTb8F5rFjpmTU=;
	b=ZJhpHYXKVjrATAR8XHea/x7zYtAkLc2gejiIqLzppBqOFVON1ZgRUuNaSvpf8iKklzLiRY
	pQpZH4pHu1dLfvfvolCeKVdZjPGRNglmsxs6+gh+dQczRQMabTBTrmXPrEi2l9XSuvZnIP
	51btbbN7ZUPOH7oMA+3d03nloMd319g=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-CWsnkFddPMi2HQXGQLtwrQ-1; Wed, 13 Mar 2024 17:47:32 -0400
X-MC-Unique: CWsnkFddPMi2HQXGQLtwrQ-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7da965e700fso36736241.1
        for <sparclinux@vger.kernel.org>; Wed, 13 Mar 2024 14:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366452; x=1710971252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C+lWpN1qDfU+nymiqOVXkY7IqPiijqTb8F5rFjpmTU=;
        b=sggDAO1kMGIjCaruWdGNJZoN/TJDbMoqk+bDfOslUxcYgCshKKRnOaNg95qZEohdYV
         1cdNSvlbnKGGy4f4FKp1N1JJLfxy7f1FSEyDI10vIoX+liLH+wWogTypHeFsBeiiesjH
         75B52cFwrwtLW82R7yKSpQ4MTMYh1UxWlLsQXjhOZsIK37DrbuEadkqJF9+ADbjofZ2V
         dIUv8FJ+xqmKdG4HxajjENraey5tNBZuUf9dz1r/VG5RsWnGNFsgdX6AEEDqnPh2hkNB
         6HyVFUNBJnVdkPhyX4ovIcpMDvnsceRYJXc9R5V7lotMlJh8Cz42xZUCpF29YKv+CdTC
         UjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9C1p4WWpLrP4dQhWwuHyGnJfKgUmoBrDnjLWChwqaCPsTJXT+uRrfBO22LOkzw89bJTUd5UAhF8c6cPlCpBF4QZkidGY7Ck6gIg==
X-Gm-Message-State: AOJu0Yz7J8QmOLo2FZZzC1TRG9ZWi07OLTj+Md1XXz3UQSC/oTvBbMy9
	BPe2kcNueVZmOBoFnV6EfGZPVU0OL4Vm0HZRmEq5MMNAYKFR1Y2nXFEEqVejULPHuPmhj/JCpRg
	0bzt1VzWZz2tiJrRGDnL+a/w4bLeDKX2CGbnoKqBo6HQXdu+FnGtKtrLY5Sc=
X-Received: by 2002:a05:6102:22c3:b0:474:974a:9262 with SMTP id a3-20020a05610222c300b00474974a9262mr178624vsh.2.1710366452190;
        Wed, 13 Mar 2024 14:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHbMJFgovzI2kAdigpD7SPTonoPokqIJ0+3R0neH2rsizaH6LOW92IcmRgIzS4nmmpWup5Ig==
X-Received: by 2002:a05:6102:22c3:b0:474:974a:9262 with SMTP id a3-20020a05610222c300b00474974a9262mr178595vsh.2.1710366451805;
        Wed, 13 Mar 2024 14:47:31 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:31 -0700 (PDT)
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
Subject: [PATCH 07/13] mm/arm: Redefine pmd_huge() with pmd_leaf()
Date: Wed, 13 Mar 2024 17:47:13 -0400
Message-ID: <20240313214719.253873-8-peterx@redhat.com>
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

Most of the archs already define these two APIs the same way.  ARM is more
complicated in two aspects:

  - For pXd_huge() it's always checking against !PXD_TABLE_BIT, while for
    pXd_leaf() it's always checking against PXD_TYPE_SECT.

  - SECT/TABLE bits are defined differently on 2-level v.s. 3-level ARM
    pgtables, which makes the whole thing even harder to follow.

Luckily, the second complexity should be hidden by the pmd_leaf()
implementation against 2-level v.s. 3-level headers.  Invoke pmd_leaf()
directly for pmd_huge(), to remove the first part of complexity.  This
prepares to drop pXd_huge() API globally.

When at it, drop the obsolete comments - it's outdated.

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
 arch/arm/mm/hugetlbpage.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index dd7a0277c5c0..c2fa643f6bb5 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -18,11 +18,6 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-/*
- * On ARM, huge pages are backed by pmd's rather than pte's, so we do a lot
- * of type casting from pmd_t * to pte_t *.
- */
-
 int pud_huge(pud_t pud)
 {
 	return 0;
@@ -30,5 +25,5 @@ int pud_huge(pud_t pud)
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_leaf(pmd);
 }
-- 
2.44.0

