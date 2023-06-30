Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D4EB64DC
	for <sparclinux@archiver.kernel.org>; Fri, 30 Jun 2023 06:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjF3GAs (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 02:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjF3GA3 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Jun 2023 02:00:29 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601373A8B
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:00:20 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-57715484180so15898557b3.0
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688104819; x=1690696819;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0nTG/kHTQnVMhxohP5MHsuqRdzFEHicjq/sQ6iCKf4=;
        b=Ov/WA9FIpcLbO5CWiZUETBfpY3/i28SEAzmOAtKKfVPcjC2oiPdl88c3NEOwzb8cD+
         6WzK7yaRwizLNaiSK+XsCbeueaZWtb1w0nxmwBno9xEic/fO7Z4szDyPbW8HYyXhAvZ7
         YV3jFnWqdMrYUC5skCnnCQvrYAyK6TUTJpnLrxix2anE3XJz7ZmlaiODH4pHDYJGT4Q6
         giQoUvXCxUzI+Kk2H80FyTpsBZKpuQSjgZKIWyFp5elg9xREP/alCVI73Tg8EO5xvOTl
         AJIs6DUayxlLux2wbVvwTJNJxrms7uSk68djZvXan8LY41dV6vRsyGpCGRqDLR35B8w7
         0tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688104819; x=1690696819;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0nTG/kHTQnVMhxohP5MHsuqRdzFEHicjq/sQ6iCKf4=;
        b=e5Gys2wZE6POHhGxJ9lfwMtIL5dyfSEHBoCmSvlIxeWXreVUODHac1AOe7TvY5WRKW
         u/kGYb/BPwHlbZJA52PeAK20+4DFd5KqQs7BbZUzvSF+rA9b4jaPypFV5xUFkTgbKQCP
         cYZKRaW7H70pOUJLiRjSMgoRBl4Medb9PKY/h4Cs7DwpUPMOhNW5GANGzeJTbRZ2UNly
         i/1k98LsUkc3m374pmwTX8RRat4kTQtq8fDBdkvqVYbRKB9MGc8r6giThc/M4yswIkP8
         PnFjcgbA00HvMJJqP/6yKCNH5s7s2l/lkfJxVuJ9yXUbVNRiwYPhyi4Yq9QZnhNenvj0
         /TKg==
X-Gm-Message-State: ABy/qLbnckgR6H9rGt4gOCMXRIemlBIrT9ZzlcPW8X76xiJKpHs0fbWs
        SfKMdTw9ZzKAojq5YP3BciqFtA==
X-Google-Smtp-Source: APBJJlHFE9Bxkgb6xQI8G8hQpu1DsdB6JNYk+x45ihxlo4iT7BDx6YBh1zc44ElJh614CQjrX+ONmg==
X-Received: by 2002:a81:5302:0:b0:56d:31a1:bd9b with SMTP id h2-20020a815302000000b0056d31a1bd9bmr1566007ywb.41.1688104819415;
        Thu, 29 Jun 2023 23:00:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n197-20020a0dcbce000000b0056d3d7a59cesm3278770ywd.12.2023.06.29.23.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 23:00:19 -0700 (PDT)
Date:   Thu, 29 Jun 2023 23:00:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Jason Gunthorpe <jgg@ziepe.ca>, Hugh Dickins <hughd@google.com>,
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
        Zack Rusin <zackr@vmware.com>,
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
In-Reply-To: <20230629175645.7654d0a8@thinkpad-T15>
Message-ID: <edaa96f-80c1-1252-acbb-71c4f045b035@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230628211624.531cdc58@thinkpad-T15> <cd7c2851-1440-7220-6c53-16b343b1474@google.com> <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca>
 <20230629175645.7654d0a8@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, 29 Jun 2023, Gerald Schaefer wrote:
> On Thu, 29 Jun 2023 12:22:24 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Wed, Jun 28, 2023 at 10:08:08PM -0700, Hugh Dickins wrote:
> > > On Wed, 28 Jun 2023, Gerald Schaefer wrote:  
> > > > 
> > > > As discussed in the other thread, we would rather go with less complexity,
> > > > possibly switching to an approach w/o the list and fragment re-use in the
> > > > future. For now, as a first step in that direction, we can try with not
> > > > adding fragments back only for pte_free_defer(). Here is an adjusted
> > > > version of your patch, copying most of your pte_free_defer() logic and
> > > > also description, tested with LTP and all three of your patch series applied:  
> > > 
> > > Thanks, Gerald: I don't mind abandoning my 13/12 SLAB_TYPESAFE_BY_RCU
> > > patch (posted with fewer Cc's to the s390 list last week), and switching
> > > to your simpler who-cares-if-we-sometimes-don't-make-maximal-use-of-page
> > > patch.
> > > 
> > > But I didn't get deep enough into it today to confirm it - and disappointed
> > > that you've found it necessary to play with pt_frag_refcount in addition to
> > > _refcount and HH bits.  No real problem with that, but my instinct says it
> > > should be simpler.  
> 
> Yes, I also found it a bit awkward, but it seemed "good and simple enough",
> to have something to go forward with, while my instinct was in line with yours.
> 
> > 
> > Is there any reason it should be any different at all from what PPC is
> > doing?
> > 
> > I still think the right thing to do here is make the PPC code common
> > (with Hugh's proposed RCU modification) and just use it in both
> > arches....
> 
> With the current approach, we would not add back fragments _only_ for
> the new pte_free_defer() path, while keeping our cleverness for the other
> paths. Not having a good overview of the negative impact wrt potential
> memory waste, I would rather take small steps, if possible.
> 
> If we later switch to never adding back fragments, of course we should
> try to be in line with PPC implementation.

I find myself half-agreeing with everyone.

I agree with Gerald that s390 should keep close to what it is already
doing (except for adding pte_free_defer()): that changing its strategy
and implementation to be much more like powerpc, is a job for some other
occasion (and would depend on gathering data about how well each does).

But I agree with Jason that the powerpc solution we ended up with cut
out a lot of unnecessary complication: it shifts the RCU delay from
when pte_free_defer() is called, to when the shared page comes to be
freed; which may be a lot later, and might not be welcome in a common
path, but is quite okay for the uncommon pte_free_defer().

And I agree with Alexander that pte_free_lower() and pte_free_upper()
are better names than pte_free_now0() and pte_free_now1(): I was going
to make that change, except all those functions disappear if we follow
Jason's advice and switch the call_rcu() to when freeing the page.

(Lower and upper seem unambiguous to me: Gerald, does your confusion
come just from the way they are shown the wrong way round in the PP AA
diagram?  I corrected that in my patch, but you reverted it in yours.)

I've grown to dislike the (ab)use of pt_frag_refcount even more, to the
extent that I've not even tried to verify it; but I think I do get the
point now, that we need further info than just PPHHAA to know whether
the page is on the list or not.  But I think that if we move where the
call_rcu() is done, then the page can stay on or off the list by same
rules as before (but need to check HH bits along with PP when deciding
whether to allocate, and whether to list_add_tail() when freeing).

So, starting from Gerald's but cutting it down, I was working on the
patch which follows those ideas.  But have run out of puff for tonight,
and would just waste all our time (again) if I sent anything out now.

Hugh
