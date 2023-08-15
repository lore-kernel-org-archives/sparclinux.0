Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD25C001B0
	for <sparclinux@archiver.kernel.org>; Tue, 15 Aug 2023 15:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjHOPme (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 15 Aug 2023 11:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbjHOPl7 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 15 Aug 2023 11:41:59 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C5E72
        for <sparclinux@vger.kernel.org>; Tue, 15 Aug 2023 08:41:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c531d9a4aso16834697b3.1
        for <sparclinux@vger.kernel.org>; Tue, 15 Aug 2023 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692114118; x=1692718918;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7TsLh4UpmerFxSf2LHp//sOCj39QtIaP8NhFu7Ity0=;
        b=v/t1rSu7IOqD7zsEvHxRPZ8PsCIFzAnrAyhA1GeAnqzR3gqcLYYTCisHr6LsT22vfP
         4laXof+eVPcmpLgSaUurUglySIUk5wTKrOXJIVrfFuzCfybCzb0/0AVfQMVJ0iJIRG4H
         0geKl/MMV99hPY+b1UkztXinVcOvwL2sVflQuURKZUXygILqXy0hylwT5O5AGgmvPpyb
         srYr1if/5tuZjeqAnbfWF3gwfEMlVFJI+jpZVbFzcg3JYBWEdRGg/oIVxBn0/AdWjomv
         dLXCkhljXHfLN7Qp8CgGrb1wPb2fkkHuSPRQ+VOFXR8Uhg34HjYmVoNDAYs3GRvk+rOp
         M2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114118; x=1692718918;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7TsLh4UpmerFxSf2LHp//sOCj39QtIaP8NhFu7Ity0=;
        b=GSeeUJ5KVH17I+pRQkQQauHRLqmJEkLY3rIvSMrIeQmHmJELe2gQfHBoo7O5FBFXOt
         i5SZ35YDK3SFJO7gP/3fuPK2hlD+AOaPu72k8pGyuEdU2ubImM+2hXqPBPtie3HdIrgA
         U1v2m9tby31v1KfeUmEhZJVLWymeWK2jGiXVRXrQeJdCPcMtthmgwsNjj3/IHTxDH9q4
         1UehSANbjA/sD31NMgrFF4Q683M3DB0pv1e2Fs6jMTsyw0HEf6UggtXxCfVoJDGHduNk
         rti677vaBn1Z29yQ5qajbjWsx4ayGOPHbBO/FBCRz6fme+NJmggJJnjNxMnSYf329JtE
         u+ZA==
X-Gm-Message-State: AOJu0YyGFci70v0SF/R50Rvy/ILxtqcVpSrjslH1ZzzyhWDtS/YMl/WM
        BUx2JKcF0EDA3K7+OJjxJ/Bq7g==
X-Google-Smtp-Source: AGHT+IFym1gqMNFckrS6y/rCULvNhW2b/lORvGgm0DCRSg/pwTXV+un25GqW0LvhUjQm8jbcdgknTw==
X-Received: by 2002:a0d:cc92:0:b0:589:a4c7:ee40 with SMTP id o140-20020a0dcc92000000b00589a4c7ee40mr2727997ywd.2.1692114117698;
        Tue, 15 Aug 2023 08:41:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x206-20020a814ad7000000b005707fb5110bsm3475226ywa.58.2023.08.15.08.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:41:57 -0700 (PDT)
Date:   Tue, 15 Aug 2023 08:41:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Hildenbrand <david@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [BUG] Re: [PATCH v3 10/13] mm/khugepaged: collapse_pte_mapped_thp()
 with mmap_read_lock()
In-Reply-To: <76e6b2ad-4e1e-2ad3-95df-00b4d33ec9d2@redhat.com>
Message-ID: <35d52c74-9ba9-211e-a4f-ade6ed318e76@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com> <CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com> <cacd4a19-386d-8bea-400-e99778dbc3b@google.com>
 <76e6b2ad-4e1e-2ad3-95df-00b4d33ec9d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, 15 Aug 2023, David Hildenbrand wrote:
> On 15.08.23 08:34, Hugh Dickins wrote:
> > On Mon, 14 Aug 2023, Jann Horn wrote:
> >>
> >>          /* step 4: remove page table */
> >> +       if (strcmp(current->comm, "DELAYME") == 0) {
> >> +               pr_warn("%s: BEGIN DELAY INJECTION\n", __func__);
> >> +               mdelay(5000);
> >> +               pr_warn("%s: END DELAY INJECTION\n", __func__);
> >> +       }
> >>
> >>          /* Huge page lock is still held, so page table must remain empty
> >>          */
> >>          pml = pmd_lock(mm, pmd);
> >>
> >>
> >> And then run the attached reproducer against mm/mm-everything. You
> >> should get this in dmesg:
> >>
> >> [  206.578096] BUG: Bad rss-counter state mm:000000000942ebea
> >> type:MM_ANONPAGES val:1
> > 
> > Thanks a lot, Jann. I haven't thought about it at all yet; and just
> > tried to reproduce, but haven't yet got the "BUG: Bad rss-counter":
> > just see "Invalid argument" on the UFFDIO_COPY ioctl.
> > Will investigate tomorrow.
> 
> Maybe you're missing a fixup:
> 
> https://lkml.kernel.org/r/20230810192128.1855570-1-axelrasmussen@google.com
> 
> When the src address is not page aligned, UFFDIO_COPY in mm-unstable would
> erroneously fail.

You got it, many thanks David: I had assumed that my next-20230808 tree
would be up-to-date enough, but it wasn't.  Reproduced now.

Hugh 
