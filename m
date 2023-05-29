Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CFBC7EE23
	for <sparclinux@archiver.kernel.org>; Mon, 29 May 2023 06:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjE2GSE (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 29 May 2023 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjE2GSB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 29 May 2023 02:18:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FE126
        for <sparclinux@vger.kernel.org>; Sun, 28 May 2023 23:17:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba86ec8047bso4305660276.3
        for <sparclinux@vger.kernel.org>; Sun, 28 May 2023 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341050; x=1687933050;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=PnX8u4a7nFzrI9AMI1PfJ2JIEBsc/6HUoh5hn/jeCJld2cHVyPh5B3mpoBHYP4HlDt
         huCzuvd10XbNys3q964U8F3Pwm5I1086lfw4K2KXsSdCwoHho0iYP2E/vuoTg9TJPXAw
         9Ao+OBlyjIf+ii9nemOKDnm34wjGWTWJPqiOtaDLYpgSbKG3NeKVJfh7S3pXb1pULdQN
         cjURL7J2sqlVPM4/ao36PpQzMPvierIr1dk2aTiiL2s04dhzXCN3987Ah17CrCgicXI7
         uLzuDFZr6ZrjJPk0lh0dr69aYCwSbUbiqg2JiJfrZxUW7xsSohaWtB46bIclcU6whmCj
         +nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341050; x=1687933050;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=koeeM0T/QlupZ7DwhBrbegexRJ+hpStM86RvVOzgHdYD4W2/c/YEwlnUBjA0lxkiDp
         +3rCwz8G0thGefpGhQ4c3cOp3FDKdfUYXaLGrwN4ydlVK9JitdA1vRIM/QK77n6sedCb
         A50oACE887sL/GVUBlQB79Rnm7pwNlH0vib3nR9hHQ8sO8hqOXEMCBjp8gPGigjD46Yu
         YRxGdmvUWMcGAWU9iA2fdOCF33BGM5GS6zB2lI2uzbtiNJutMqG9UgigMZcc9yXR4NkY
         v+YxKkBeFbhWqofU2wJPsWzLcnitOGbr9Rubxu0uMd0vJPA6nagqMjmMcMVjmmJUqJNP
         NTiA==
X-Gm-Message-State: AC+VfDxMOIJ1779e4uZeOSYNubTEyKuZjSAEydZVmqx7QIl6zOKMJaXK
        HrqHRGqDqpxyshfKLK1O1FfbCQ==
X-Google-Smtp-Source: ACHHUZ6g2ncsiViAbUymnL1kKwlhN1cywz3Q5/8UINRdk6/z7ELyukBfTa2iPWzHzMx63rqo3lZAZA==
X-Received: by 2002:a25:fc19:0:b0:ba1:e06b:bc57 with SMTP id v25-20020a25fc19000000b00ba1e06bbc57mr9201429ybd.64.1685341049679;
        Sun, 28 May 2023 23:17:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t62-20020a814641000000b0054f8b201c70sm3381110ywa.108.2023.05.28.23.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:17:29 -0700 (PDT)
Date:   Sun, 28 May 2023 23:17:25 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/12] arm: adjust_pte() use pte_offset_map_nolock()
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <94c2ebe1-6b23-1cee-4aae-22cb835776ff@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
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

