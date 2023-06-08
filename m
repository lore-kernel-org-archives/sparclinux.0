Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D2C7EE2E
	for <sparclinux@archiver.kernel.org>; Thu,  8 Jun 2023 19:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjFHTQt (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjFHTQs (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 8 Jun 2023 15:16:48 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0942D77
        for <sparclinux@vger.kernel.org>; Thu,  8 Jun 2023 12:16:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bacfb7acdb7so1065650276.0
        for <sparclinux@vger.kernel.org>; Thu, 08 Jun 2023 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686251670; x=1688843670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqbvyW6crf6toTfKG311uSxHzLZVjYgM3m9zpPIhyDA=;
        b=2n/XtD7AqYzwMObmNTcTXdhdmtrivr6xS0a6hxh2028Gq3sNV9XO29gB5O2y3L9l/t
         L2rqH6x4Pz17FgKoR1Y4rQPo+pjlVHFvq4Uxf6V5Z1hVLY+dk3dbsKixOg2g0+O6MH3o
         wHR7UhzFBUpyNSTJP8nVTqWIyYA0el7GHtc3GU+0DrUYPDVBZCtJf3wyrCUqLLZR09lv
         VqBAJ8/LNlL6ViTV2apFi54AS+jw7a1Zjo/eBl1kmHqeluHIV3N/nqy10dITHeklJsgD
         IGKWlS4umLi9ypWs+T7OEHIYU3YkWJ3FbGyXJ6NMN9TADYksX23kqJlAINxQPvIJDTtX
         gwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251670; x=1688843670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqbvyW6crf6toTfKG311uSxHzLZVjYgM3m9zpPIhyDA=;
        b=PQcNXQn+TU/T9WScSaj5ygLj8o6LkzYNEBH+EXoW0mOCVy5R4eC5McHx+0oHC0ZEQE
         a66Q4RKYvouz8AlTOyKXPbPRmpmIOVs1ix486pDK0StxcDMMJ7ix0G23p9fB4a5LC5go
         R9KrwBOBJZpf4Dmq92S0YSbj85vCa9sKlzwHSNMstcJHiqmW+p66FpIpxrm1guE5VlcK
         wduhtl61SKfO6BmYPG5Jm0or1X5nt3lBbdbC9QWgRBZaNokKh+D3TdaFSC8t/3yBMKzR
         oJSuzs2EPQ2n6STAa7V6RTYPGDJuH/wbN8Mo0bh3khDG6AI1tDYtrr4B406aKEOiEfkl
         57iw==
X-Gm-Message-State: AC+VfDwys9vnWGt43XNVUM9mTGOH/T06D4JcKesmh+SC4kLeUgppH8cC
        T7UQAEzzeSQ65tRkQuji0p3xsA==
X-Google-Smtp-Source: ACHHUZ7aUiIh5IKg+O5kgdrTnFDUinQat6T8kg6GewL/1W4sBHj9jDkDghROqTlVL3SjDvy6zEmR9Q==
X-Received: by 2002:a25:e302:0:b0:bb1:5a06:70ed with SMTP id z2-20020a25e302000000b00bb15a0670edmr543635ybd.19.1686251670430;
        Thu, 08 Jun 2023 12:14:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e10-20020a25874a000000b00b9e5b28dbd8sm429689ybn.17.2023.06.08.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:14:29 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:14:26 -0700 (PDT)
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
Subject: [PATCH v2 04/23] ia64/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <1c2c7837-bfea-9640-a74-985379fcc5a@google.com>
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
---
 arch/ia64/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index 78a02e026164..adc49f2d22e8 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -41,7 +41,7 @@ huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, taddr);
 		if (pmd)
-			pte = pte_alloc_map(mm, pmd, taddr);
+			pte = pte_alloc_huge(mm, pmd, taddr);
 	}
 	return pte;
 }
@@ -64,7 +64,7 @@ huge_pte_offset (struct mm_struct *mm, unsigned long addr, unsigned long sz)
 			if (pud_present(*pud)) {
 				pmd = pmd_offset(pud, taddr);
 				if (pmd_present(*pmd))
-					pte = pte_offset_map(pmd, taddr);
+					pte = pte_offset_huge(pmd, taddr);
 			}
 		}
 	}
-- 
2.35.3

