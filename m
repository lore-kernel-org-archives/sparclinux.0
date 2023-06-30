Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADEEB64D7
	for <sparclinux@archiver.kernel.org>; Fri, 30 Jun 2023 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjF3PbK (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjF3Paz (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Jun 2023 11:30:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4D49C7
        for <sparclinux@vger.kernel.org>; Fri, 30 Jun 2023 08:29:09 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bfee679b7efso1935919276.0
        for <sparclinux@vger.kernel.org>; Fri, 30 Jun 2023 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688138947; x=1690730947;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjAYnVeboGLbIm0tKT9e16Vsq7Oo9WWm/R7Yf2CYkqU=;
        b=OrFdTzSQQkVcKVrUqqdFxWYPfui4NZ+US05WE6v2rnqFm6OACvYRXXvuvVVn9/WgtH
         IO25JQBx/7LBuF94N8uGWuA7lOqK/g2aZp1o+jdYwvLq2sHeGN6e7HBrH9hoQ4jtcPqs
         90eQkQW0JM+WPNUbFUyKu7cCa3Sn5U5Jf2hFgFgK4apj0UpwkpB4OeYiFgRXknc7EB6e
         QGvEjMl6zgdHa4GtApbCh6wEU0EpLaffyB3TGQ3swbjHsGW/3I5351vpgsD4dqv93K97
         b7yuMuqA/UWI4+PDCNp0ztgzGA9UcYiCsSREvoSv8SCHEvA6U71YyFDKLcORLE5cGOxV
         8bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138947; x=1690730947;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjAYnVeboGLbIm0tKT9e16Vsq7Oo9WWm/R7Yf2CYkqU=;
        b=iiSMsAKbmUhvUf4zw+dUsCW0F6S7W9TjaiEFPwFiuEATuiijiZzCC4bo6dp0sn2Po1
         BDMldD0llH5e9Nre/TqgzCgr7BZhT3zMzFzrvdo+MdJY9jd3bxZb+Moc/pwhw4WzbI1/
         uhAWeINx1dgCmiR6Nl9nY6OnUc+QEmqDYSUMQPYhebaxEt1gBkMAZTgK8XlI4HhyDh4l
         ca9hSQthcTUKvYDVkWE0Xt5a38FQq45id0YXZ2coYUHRwXp5mUoHRPSNQ7bR26Jzurxz
         1psLAmUB2MzTtKkAWt1jL1jJcKycF/VVK6dRF9ZED+5eqHwRb8+z155X+FtI5g0M2wSg
         6rnQ==
X-Gm-Message-State: ABy/qLYGI3bp4kGhMPZSUJBTl7u1pQV3je7hc5X5504pr3N3r1fXMviH
        kH3naq/OzzqpCTGww1tMh+s9zg==
X-Google-Smtp-Source: APBJJlF5EFV8fGkahr4C63tlYCJc9C/Ov9as/Fr8WIXMxA7p0Zq+iobFwmSBQKWq4vNdROS9uHFFYw==
X-Received: by 2002:a25:d303:0:b0:ba8:9512:fbc9 with SMTP id e3-20020a25d303000000b00ba89512fbc9mr2919284ybf.11.1688138946703;
        Fri, 30 Jun 2023 08:29:06 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 144-20020a250496000000b00c3da591adbcsm635911ybe.31.2023.06.30.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:29:06 -0700 (PDT)
Date:   Fri, 30 Jun 2023 08:28:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <20230630153852.31163592@p-imbrenda>
Message-ID: <062b19-4cf1-261-a9bf-9cefd32382fc@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230630153852.31163592@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, 30 Jun 2023, Claudio Imbrenda wrote:
> On Tue, 20 Jun 2023 00:51:19 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> 
> [...]
> 
> > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > +{
> > +	unsigned int bit, mask;
> > +	struct page *page;
> > +
> > +	page = virt_to_page(pgtable);
> > +	if (mm_alloc_pgste(mm)) {
> > +		call_rcu(&page->rcu_head, pte_free_pgste);
> 
> so is this now going to be used to free page tables
> instead of page_table_free_rcu?

No.

All pte_free_defer() is being used for (in this series; and any future
use beyond this series will have to undertake its own evaluations) is
for the case of removing an empty page table, which used to map a group
of PTE mappings of a file, in order to make way for one PMD mapping of
the huge page which those scattered pages have now been gathered into.

You're worried by that mm_alloc_pgste() block: it's something I didn't
have at all in my first draft, then I thought that perhaps the pgste
case might be able to come this way, so it seemed stupid to leave out
the handling for it.

I hope that you're implying that should be dead code here?  Perhaps,
that the pgste case corresponds to the case in s390 where THPs are
absolutely forbidden?  That would be good news for us.

Gerald, in his version of this block, added a comment asking:
	/*
	 * TODO: Do we need gmap_unlink(mm, pgtable, addr), like in
	 * page_table_free_rcu()?
	 * If yes -> need addr parameter here, like in pte_free_tlb().
	 */
Do you have the answer to that?  Neither of us could work it out.

> 
> or will it be used instead of page_table_free?

Not always; but yes, this case of removing a page table used
page_table_free() before; but now, with the lighter locking, needs
to keep the page table valid until the RCU grace period expires.

> 
> this is actually quite important for KVM on s390

None of us are wanting to break KVM on s390: your guidance appreciated!

Thanks,
Hugh
