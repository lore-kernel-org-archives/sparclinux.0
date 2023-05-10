Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166C2C77B7C
	for <sparclinux@archiver.kernel.org>; Wed, 10 May 2023 04:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjEJEzb (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 10 May 2023 00:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjEJEz1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 10 May 2023 00:55:27 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCC1116
        for <sparclinux@vger.kernel.org>; Tue,  9 May 2023 21:55:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a20a56a01so120908337b3.3
        for <sparclinux@vger.kernel.org>; Tue, 09 May 2023 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694524; x=1686286524;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=alKFmwAdxdkIViw1WjkjX/OCKeQtR2IpGs2zcY6rd0M=;
        b=x62YCY0VbtXBlAlTlrXst8L8I4Klp5jHuIkAXWeopDmvUXAbp7vfKzA00bYNToXaoh
         jicsfIaPz1O7U+TdGvn8r6E/DcCNuMjdSP+L+rcocZxL69l/kttcZnaGKZv3QHFP73NA
         pwziDs2dpT8TywS3eBGCmWf5OZTvKDvRn5iqAcCmFi7ZDxOpEnJaXZsg4chuls0Conw6
         1BHyDKqM9ymKdiyVbkRMd5EkORJUOPu5k/Dt9X7/wDI/4JSqAZEDqusgNEXsSQSkAunQ
         L5ABejKB++Tm9XQd6rM3WeiGICDJg3QSoGYLUowekQIKv98a1U+1e3RQQ2gzWsEHyeuU
         f9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694524; x=1686286524;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alKFmwAdxdkIViw1WjkjX/OCKeQtR2IpGs2zcY6rd0M=;
        b=IgyMQrwaYb04efKbXPnCWfqy+DcFL1uhDtRSY+zGtUrYxdMy5GSSf/Oi+DdGW41yVO
         K0ipHZUc2tsiV67pNtRc1ZHnMZIxjfEJQyEBEC/s5ZoW28md9bjFZk0S1YDkQDhl2qHe
         poPr/xBX5zDw9jdr+c1J5HdrdnThBZf4oje7+PDxQtZCSZUxzs8TSbQWjN0KWV1RXpXE
         bqtXzPb9ssahDeJd+luqO9OkVoZHSth/1SvKlYEIZM76VVWWj5aHNvOm5lK1+f7UY3Ty
         cTz2ZQHXIqCmRfkBJSasOmC7eO4JmQIMmoHkY4gcsel9O7rN9F8C2mai8HOdxd8HzjaM
         0dPA==
X-Gm-Message-State: AC+VfDye7wkq6J0lNcZfFmiswK/YcGZFYt4pxgWgJRE9U9Ifk/mv0eV2
        UOuPFWX8Ze472bUgb7+EbMFsBg==
X-Google-Smtp-Source: ACHHUZ64xP5yCWBSXd1pkCU9S6oVULY9BGDq0OyW51W97Dv6Ixjw6iQVWcUZjR+Rvr+uTi8eh8kq2A==
X-Received: by 2002:a0d:f545:0:b0:55a:ab98:a2ef with SMTP id e66-20020a0df545000000b0055aab98a2efmr17944134ywf.40.1683694524456;
        Tue, 09 May 2023 21:55:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c1-20020a81df01000000b0055a29ec6504sm3793706ywn.81.2023.05.09.21.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:55:24 -0700 (PDT)
Date:   Tue, 9 May 2023 21:55:20 -0700 (PDT)
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
Subject: [PATCH 10/23] parisc/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <8552705d-e0c1-a3a6-c26b-b887d4f61288@google.com>
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
 arch/parisc/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d1d3990b83f6..a8a1a7c1e16e 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -66,7 +66,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, addr);
 		if (pmd)
-			pte = pte_alloc_map(mm, pmd, addr);
+			pte = pte_alloc_huge(mm, pmd, addr);
 	}
 	return pte;
 }
@@ -90,7 +90,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 			if (!pud_none(*pud)) {
 				pmd = pmd_offset(pud, addr);
 				if (!pmd_none(*pmd))
-					pte = pte_offset_map(pmd, addr);
+					pte = pte_offset_huge(pmd, addr);
 			}
 		}
 	}
-- 
2.35.3

