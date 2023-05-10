Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6454C7EE25
	for <sparclinux@archiver.kernel.org>; Wed, 10 May 2023 04:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEJEqG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 10 May 2023 00:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJEqE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 10 May 2023 00:46:04 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4225140F6
        for <sparclinux@vger.kernel.org>; Tue,  9 May 2023 21:46:02 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a5a830238so62370237b3.3
        for <sparclinux@vger.kernel.org>; Tue, 09 May 2023 21:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683693961; x=1686285961;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y3cIigX+Nl9tLTZ0FqCTIXHUTdUKJPmRsHmBn2kODQ=;
        b=X3r36dHHiJLgvp7jU0d4K3JzjfQ3mFZ409XlDfQRUNXPcZqJbsAuZzM3s3dqfqjzC7
         8KZfl7/K1d5O90p8GZrKYknrba26nw1LDXST+K7c2aBIUL4D4zJxqgAKfbG2qxu2Yo5u
         /0/dJOnRitUjxODeANtGQgBQxAoaXYK9cmTYbd/KEH4Bma0mqugbvo9G65UfkX3CZvm4
         /qVdLnQuXbtkydB1O0CAPyBH6Uxg3CoJyNGPZLXWNXdI0kdPUkxDZks6+sU3ASKIjHEF
         kaGykgOemp+4zkq4W/ysBBuFcBH4LTuAgjoNUoWbJlUwxz7uYcWBFSnWP85ZFQDgSIRR
         fYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683693961; x=1686285961;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y3cIigX+Nl9tLTZ0FqCTIXHUTdUKJPmRsHmBn2kODQ=;
        b=gECTNJcqZ4XTmIsOmd1V3zDdqd73YS4qKq1NYCDm5cihOkwSDXbivz6su3gFdYnGlS
         4idvxsChouTRTttVHphalOhgD96U6XJTCxto0v4mxYPad7Y2Nob7GZ36vFtzwSgpPD1W
         jsu92Sh5CIo17KgS2Enn72UCr6UNAOEya+eJ+tUndCOITD9FehkSducW/pKDJRleID/o
         BZF/vN/xJX1hpnwD5eM4KRoubG2Lm639/fEDhQtzG1lbvn0Nij0QJjXHJKq27yuOT6tN
         CuS9abz9ANoJFwwq7q5Nl1uP0yrP2pda5qDy8ysl6fS+4RdtIs5nj5YMhto/xoDEv0xk
         63Ew==
X-Gm-Message-State: AC+VfDwYGLpOC/s/ghgb6dPkzG2fLI0dvueK63yokxI6DJmN9k9EuJRR
        BrFRpekT7OPIEI13wd+XGDJZzQ==
X-Google-Smtp-Source: ACHHUZ7XGWNGIkPY+5hFXQ4Kt5/NxLbXPMIaWsRvM1j0AuAelIXLbwAPwZwsOjvzazAJBFrFLzpKOA==
X-Received: by 2002:a0d:e242:0:b0:52e:f109:ba7a with SMTP id l63-20020a0de242000000b0052ef109ba7amr17438159ywe.51.1683693961209;
        Tue, 09 May 2023 21:46:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s126-20020a815e84000000b0054c0c9e4043sm3833116ywb.95.2023.05.09.21.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:46:00 -0700 (PDT)
Date:   Tue, 9 May 2023 21:45:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/23] arm64/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <dda2885-929b-c278-14e-5f447e9eec52@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
that: to keep balance in future, use the recently added pte_alloc_huge()
instead; with pte_offset_huge() a better name for pte_offset_kernel().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm64/mm/hugetlbpage.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 95364e8bdc19..21716c940682 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -307,14 +307,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			return NULL;
 
 		WARN_ON(addr & (sz - 1));
-		/*
-		 * Note that if this code were ever ported to the
-		 * 32-bit arm platform then it will cause trouble in
-		 * the case where CONFIG_HIGHPTE is set, since there
-		 * will be no pte_unmap() to correspond with this
-		 * pte_alloc_map().
-		 */
-		ptep = pte_alloc_map(mm, pmdp, addr);
+		ptep = pte_alloc_huge(mm, pmdp, addr);
 	} else if (sz == PMD_SIZE) {
 		if (want_pmd_share(vma, addr) && pud_none(READ_ONCE(*pudp)))
 			ptep = huge_pmd_share(mm, vma, addr, pudp);
@@ -366,7 +359,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		return (pte_t *)pmdp;
 
 	if (sz == CONT_PTE_SIZE)
-		return pte_offset_kernel(pmdp, (addr & CONT_PTE_MASK));
+		return pte_offset_huge(pmdp, (addr & CONT_PTE_MASK));
 
 	return NULL;
 }
-- 
2.35.3

