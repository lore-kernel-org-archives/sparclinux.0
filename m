Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB9DC7EE23
	for <sparclinux@archiver.kernel.org>; Thu,  8 Jun 2023 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjFHTPB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFHTOf (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 8 Jun 2023 15:14:35 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158E53ABF
        for <sparclinux@vger.kernel.org>; Thu,  8 Jun 2023 12:13:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b2bdca0884so32420a34.2
        for <sparclinux@vger.kernel.org>; Thu, 08 Jun 2023 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686251598; x=1688843598;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3hlbyYK7pDzwaZxcFIBlWQ9GVphTFdOhlIQXeLYhe0=;
        b=dJgo7fXPVEPfP5aOx2rlF6fhL0MOp6kKeclo0mcv4zTOiWrzHWntcp0lBZsfoj54Se
         XolJoU7BuSvwRUfmeldzR5qRMBOJZmJVG9boQPdpvF4oDnjII17h4IF7WTHJDAtPgKTK
         wCc48eCwjyNX1CCKOKbCJn6rCHbIrfq0gOAhHT/Cld5PzM9jgz6HhRaRcDPho1O+ftQz
         NYl5ZbGuf+ZDQqB6/nkOeRBoiE7Z3JRWHBfKCJGlqU4xYE9mQ0/j0JkL0Hi8bff5nmw2
         hyNF+dGcaX/VDgXb0gWmoFHLFIjjowl5ieph5brNA6Ro0AVROhwI1SIjSa8mT9DDlpOJ
         kD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251598; x=1688843598;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3hlbyYK7pDzwaZxcFIBlWQ9GVphTFdOhlIQXeLYhe0=;
        b=N66zdnYNvP+XZkmpmSqmuyg+c7YkRX3cKDOv2953k4xxXtW5n9wSJttXbiQNMvHmG7
         nxFI2lATyYJs/sWiBoycwFD3SAE9dSz4ec3lpfOq5tgBSBVYrCjT9XH3esaiAYheZWET
         W++fb80nUV3DM2vxnZmkNNXjIOLkBmvvsitR5GVVt0gUUk/ABI2f+Q1lwB9bAbA2GUBr
         ic8m5G71s4KICpmj/WKh7oMoyzLhmcBcpjB+o1D/IGld3H+C1Dw4sZY/2/GKm8WqL6Xl
         rUMs2D/oELtD8KiE42kDBw3RAb0bB5IgCBkFi9qF4dnd+w9JBRkKARsVJIQysWrhGXOq
         /1Mw==
X-Gm-Message-State: AC+VfDxq44qFPgnNCLzf7hu96py1hMOqe7yQZkZqiPQveMrXOnyK4/nZ
        HYpMIgegl3cgxqYCuDdsEQJciw==
X-Google-Smtp-Source: ACHHUZ7k4j5F178ZxkLqaj/gNdJycBqILZgmndfFTMZvJsxEKmjnaCgTvlswNo/GmMXGG825y1l48g==
X-Received: by 2002:a9d:7849:0:b0:6b2:a879:406a with SMTP id c9-20020a9d7849000000b006b2a879406amr5080795otm.18.1686251597829;
        Thu, 08 Jun 2023 12:13:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d188-20020a2568c5000000b00b9def138173sm449426ybc.1.2023.06.08.12.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:13:17 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:13:13 -0700 (PDT)
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
        Peter Zijlstra <peterz@infradead.org>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: [PATCH v2 03/23] arm64/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <5849464-7191-40c5-c55f-fba9c3802e5d@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
that: to keep balance in future, use the recently added pte_alloc_huge()
instead; with pte_offset_huge() a better name for pte_offset_kernel().

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

