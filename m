Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E43EB64D8
	for <sparclinux@archiver.kernel.org>; Tue, 20 Jun 2023 07:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFTHpF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFTHoP (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 20 Jun 2023 03:44:15 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B741731
        for <sparclinux@vger.kernel.org>; Tue, 20 Jun 2023 00:43:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-570114e1feaso51316997b3.3
        for <sparclinux@vger.kernel.org>; Tue, 20 Jun 2023 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687247035; x=1689839035;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=qhwhngGUpgrcZDlnvH+b7VWG9WLTHUEVswW9xK/3YCFZXun6Sku2aj+qmeuJtlpDm9
         NL1p7tRRaSaVuFlEgJZSd1u9Osk9e4zYWPVYSmjFqeH51Two+LdeRyVK6tn3qt9RQ2/C
         FXROYrneK++r2OPYxjNpEmp15a3hsycB8EeXDTwBWnGuwYFgeqd19dhMRsM+70lw7kZD
         UxM84oMlRLUMCqnzuOHx9Iap0algo8Gh2vtX9lFjHG25G0LFiMapQLFR33NHeN7LFjU7
         xqRJD57e/d0/xxEOFNXoz5t1uVw5lEYV2V7WrZMTJMmAFZ9r11+4uO5ZNp31jPHEHE3P
         8GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247035; x=1689839035;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=WbhkwaVP1xJ9hU2pHBPp0UcoE4y+2Qm/jnEbTl6TwzFfiRndXTCKXM+x//ig8rCKRr
         zsxwdQwq9k7pXTM/w1okppGENN2EpiM3Un7LB3o0rrCAI6iKHUfDc9ErDbIDMFzieeHI
         vsxBQ35nweEnF8MV5tzwH8TaqGQ28zxVDk0mAyUrWkwtfqNp5AeFuRRZUJu6DX0hRJ0g
         29b7vQ50AOxL9vMBkA0auqNIKgw3bsPcNSt2hoOD3+fblCZSEq8/rL1125VznznfHNwV
         y5TmjTELjhM/sWL3TptsuBMhniAGEbGPzlqF4m8wZY9Rh3tGMA2TFafuUKHA87Wp2fSz
         /TqQ==
X-Gm-Message-State: AC+VfDxBXNNB06LBc8Pivs54sewaZ88Bwz63rj4CSGus2bx1GHw4cRcp
        e2hdYX540CgGRwfLkvOPI3duBQ==
X-Google-Smtp-Source: ACHHUZ7JD/5gT47oLcluDex4538IBoUvSmCiuwTDk3dXuw6uEp5PSF1HYd+jz7L8cEHWLsd+Ww/fjQ==
X-Received: by 2002:a0d:cf82:0:b0:56d:2b1e:3d88 with SMTP id r124-20020a0dcf82000000b0056d2b1e3d88mr11408597ywd.24.1687247035289;
        Tue, 20 Jun 2023 00:43:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y188-20020a8188c5000000b00545a08184f8sm365085ywf.136.2023.06.20.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:43:54 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:43:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 03/12] arm: adjust_pte() use pte_offset_map_nolock()
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <c959c62f-b186-cb41-55ab-59da79ece688@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
in adjust_pte(): because it gives the not-locked ptl for precisely that
pte, which the caller can then safely lock; whereas pte_lockptr() is not
so tightly coupled, because it dereferences the pmd pointer again.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm/mm/fault-armv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index ca5302b0b7ee..7cb125497976 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -117,11 +117,10 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map(pmd, address);
+	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
 	if (!pte)
 		return 0;
 
-	ptl = pte_lockptr(vma->vm_mm, pmd);
 	do_pte_lock(ptl);
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
-- 
2.35.3

