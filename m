Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025F5C5ED
	for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792272; cv=none; b=SanVOt5P4HDLBVbb36+cdyXFGzCXAu8CcrVUJp/TVed1523CltvMykoj/glnLxUVOi8vhBygjzOgLbBNWpbdl+Dhx2uIgJii58H6j7Q4ii+BmIanXG7Bk6eWMrkAi65rZLJfZGt6Jh9RAIQyGRVhyd6+4zkgdRwZ/9jQCIh7yI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792272; c=relaxed/simple;
	bh=ojVmr5RD35FTPLpAqjeK88wQPTEg2L/XUu1gv37ZNsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIUiupf/EDqAl/C6r+69nUT5PkQg9QMMModcfaue9xG0ilH4+euaiPOOYGcZEjrjQsErvdnDnN8hvmsh8juyTvOEf8pPuUuJqTIPZxfuwaeo51Aoj9wBVEZeBO2ZWdbst7YgbSfeuoGou8zIF+EH2HG5NEWzp86poEa5wEoswWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iycXk3YD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iycXk3YD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXDMCLhq+SpXi29RlzCNqEUhIAFpzfV1ImIXAFsvuS0=;
	b=iycXk3YD7CwKn5Hb2pUEesVXfEDiDMZGdH7RtGeVlx+joKgHFaHhi197XUsOD/RaVCsBPM
	RIp80YpkRGxYxXN7gANorGHiT5Pilf4UcOWzASjBj13hKRleS89KzfyauEPCQQJ0OVNpv0
	UPh4mls2wWoY+pBS+S4nLWRozJIEXfk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-5yqIg8MkOvWGTverED_zKQ-1; Mon, 18 Mar 2024 16:04:27 -0400
X-MC-Unique: 5yqIg8MkOvWGTverED_zKQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42f30752eb4so15657061cf.1
        for <sparclinux@vger.kernel.org>; Mon, 18 Mar 2024 13:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792266; x=1711397066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXDMCLhq+SpXi29RlzCNqEUhIAFpzfV1ImIXAFsvuS0=;
        b=wHiR3rp69OLc43CupGJnCkcEO2hxQY1+URFQmOHvDtfGIobXp7qPphW7s4u1/LPApq
         l5hmKtK6zATjxDn4mq0NSM3fLiZ4xogQwMH2yQU3LyuPYgjLQxE2X7nM2ncA2f5CaIDI
         x9qnhNV6+WsQFhUHWEH/wfHcTjr7yEGZjlLDWpTTBt8N7rnwDR0umARNyS5tPuwk1RnU
         h1/6hawT8nKZWtS01aSqk6dmcXy6BMkut8ZmVJG2CXkjZCcWtfB1OkIuwxmUS1JaaD2Q
         Z0f6V527x2Ec6LMI61YPSlw1ZQrkPZ/qqqADWENnHB+XorRSz8CFRITLG8bAzE7kRlFe
         DxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwVfQuwmqa1W0ggrhwBUgtHJMv8GCSPvnnnHsmYCctFFeoT19zsKVUT15NQ+ZQLEdZeI+XwWe2VsbyqbHfoDLp+HUzAtB34N/esQ==
X-Gm-Message-State: AOJu0YyMy/3pn4prPCdxoMQae+TgE31tiRx8wNqVY+Pu69qnMGPdMdGi
	FLk/POA2oL17wbvlyx4ZKIDv6PehONtsvQWHVbwDDm+4yKNe0mNz6UYpIX+5lzFv8gz+xhHh7hC
	LqiVPfusS7zqQdhIQg/js3u6vES8JB+dsZ/HznAZ9OTdTi/R4JAsxFc0ugeE=
X-Received: by 2002:ac8:5f91:0:b0:430:c2dc:a5ef with SMTP id j17-20020ac85f91000000b00430c2dca5efmr447847qta.2.1710792266521;
        Mon, 18 Mar 2024 13:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBYHTFmkqNiU+ToXou6wXh4FVDhWI9gJPxxfj+3GqwNDwAz7q/kbYXHDobvjaQIuNomZFyOQ==
X-Received: by 2002:ac8:5f91:0:b0:430:c2dc:a5ef with SMTP id j17-20020ac85f91000000b00430c2dca5efmr447812qta.2.1710792266091;
        Mon, 18 Mar 2024 13:04:26 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:25 -0700 (PDT)
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
	Mark Salter <msalter@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 13/14] mm/arm: Remove pmd_thp_or_huge()
Date: Mon, 18 Mar 2024 16:04:03 -0400
Message-ID: <20240318200404.448346-14-peterx@redhat.com>
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

ARM/ARM64 used to define pmd_thp_or_huge().  Now this macro is completely
redundant.  Remove it and use pmd_leaf().

Cc: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
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
 arch/arm/include/asm/pgtable-2level.h | 1 -
 arch/arm/include/asm/pgtable-3level.h | 1 -
 arch/arm/lib/uaccess_with_memcpy.c    | 4 ++--
 arch/arm64/include/asm/pgtable.h      | 2 --
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 4245c2e74720..6b5392e20f41 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -241,7 +241,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
  * define empty stubs for use by pin_page_for_write.
  */
 #define pmd_hugewillfault(pmd)	(0)
-#define pmd_thp_or_huge(pmd)	(0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 9e3c44f0aea2..fa5939eb9864 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -190,7 +190,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
-#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 2f6163f05e93..c0ac7796d775 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -56,10 +56,10 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 	 * to see that it's still huge and whether or not we will
 	 * need to fault on write.
 	 */
-	if (unlikely(pmd_thp_or_huge(*pmd))) {
+	if (unlikely(pmd_leaf(*pmd))) {
 		ptl = &current->mm->page_table_lock;
 		spin_lock(ptl);
-		if (unlikely(!pmd_thp_or_huge(*pmd)
+		if (unlikely(!pmd_leaf(*pmd)
 			|| pmd_hugewillfault(*pmd))) {
 			spin_unlock(ptl);
 			return 0;
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c4efa47fed5f..a580068a6564 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -512,8 +512,6 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 	return pmd;
 }
 
-#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
-
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
-- 
2.44.0

