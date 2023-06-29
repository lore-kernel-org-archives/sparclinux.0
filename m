Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8792C001DB
	for <sparclinux@archiver.kernel.org>; Thu, 29 Jun 2023 05:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjF2FIX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjF2FIW (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 29 Jun 2023 01:08:22 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB92705
        for <sparclinux@vger.kernel.org>; Wed, 28 Jun 2023 22:08:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so273166276.1
        for <sparclinux@vger.kernel.org>; Wed, 28 Jun 2023 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688015300; x=1690607300;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFm7aP76Kl3qxn7n2tNVkuwpkcso4qVmefkLtKFqRbs=;
        b=SH61IoWshgo0/pKjl3ljDej2EI0+DSaPIoPH0EnGJIbXtfIIjKOXzIBV7zaurn/u2O
         NzEik2ic/sSNSVVbeZ/UgymQtK7K6oY5QRG/wzVH8poLJ32013nMh89etey0qcHiO54m
         9VJ8ecSgnyFVz892TYk34hIsLIVdE3C863sWe4PpKLL17z0rdk//QH8zHLezplf5zecn
         CMt8pQ6lO/N91/4KfIatcw4X88/dCSpVTpYW/IpvL+vwGOTzzDciFmwrt9muCsAvhi7d
         WOqlfS0Kym0VC+rHJLQVRUIX2a29Zo7bJvGsOEaU1uowBUKaMzsYZ9yHhLs0KJAe7PQ3
         Eu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688015300; x=1690607300;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFm7aP76Kl3qxn7n2tNVkuwpkcso4qVmefkLtKFqRbs=;
        b=dYm3cRmIcjUZjmEDQzA951iQ+I6plSOyIM9GNY0tgzD/bIUmTzrbuXVIihyfujjAXG
         fM4phc6ys7o/ZqgrPxfGTkARjBWnMT4lcVtFrhbt7+acDRWcPQI6Ta3pNtus1OcA3J2j
         GJVufTb8kUfqYWCcu2wyl5gaHGJz5I5yL+t2lyPQhQ78546YBpgDEvhc6G24YkeOOpSB
         ts5j7LEbwopjHpgR3OkU+cKXJ/cjzqSejMRaYAkwrsuceAmt+grIqmW0FYYFZQ72+HW3
         QK2hgX6MDBjJODdLtbvQn90Rq1/pOhK+rN1e2mxIPdaIvvr1cCCZfqJLexAqxnOn15+Z
         nbMA==
X-Gm-Message-State: AC+VfDxpGUQAFd9csQwgVImIN6Wit6qmHMBRWvaPMDkTKgafqQb74dc2
        WhzD+Mw4hL2ffVPHazq8dSebxQ==
X-Google-Smtp-Source: ACHHUZ7dmal1wUP2kBcbn8Y+5hPCsOTidCkpFmDgLcwfB+9Ewvv4+lKBVPvM/Ea71yfLSwxu543Ddg==
X-Received: by 2002:a25:bc86:0:b0:c25:3076:ffdc with SMTP id e6-20020a25bc86000000b00c253076ffdcmr9008572ybk.1.1688015299744;
        Wed, 28 Jun 2023 22:08:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 66-20020a251545000000b00bcc0f2e4f05sm2365847ybv.59.2023.06.28.22.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 22:08:19 -0700 (PDT)
Date:   Wed, 28 Jun 2023 22:08:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <20230628211624.531cdc58@thinkpad-T15>
Message-ID: <cd7c2851-1440-7220-6c53-16b343b1474@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230628211624.531cdc58@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, 28 Jun 2023, Gerald Schaefer wrote:
> 
> As discussed in the other thread, we would rather go with less complexity,
> possibly switching to an approach w/o the list and fragment re-use in the
> future. For now, as a first step in that direction, we can try with not
> adding fragments back only for pte_free_defer(). Here is an adjusted
> version of your patch, copying most of your pte_free_defer() logic and
> also description, tested with LTP and all three of your patch series applied:

Thanks, Gerald: I don't mind abandoning my 13/12 SLAB_TYPESAFE_BY_RCU
patch (posted with fewer Cc's to the s390 list last week), and switching
to your simpler who-cares-if-we-sometimes-don't-make-maximal-use-of-page
patch.

But I didn't get deep enough into it today to confirm it - and disappointed
that you've found it necessary to play with pt_frag_refcount in addition to
_refcount and HH bits.  No real problem with that, but my instinct says it
should be simpler.

Tomorrow...
Hugh
