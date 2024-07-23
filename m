Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AC142631
	for <sparclinux@vger.kernel.org>; Tue, 23 Jul 2024 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768659; cv=none; b=PPf6UU89JHbXY/1F8bpHogeaxByIjCGyXbLByn4cJnI3+a/tg7GsvnHSJYNhyfvDHcqSn8TiMCgsv7kfL61/JmpMr5/2ShwqOpkCGyB5oqr49TNqTprkUpW0oEVS5sEGUEfiObCw1LwCHTjGNKNB0R72J364hCILtiWTFm0nSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768659; c=relaxed/simple;
	bh=ByJ50gM2kVPVymv6FrYRFVV3V1JgaiK2qoeSbb51xT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYd+pXoBtwmyxDJ/zgD1P6OpPP+XGLqefyQ7N6R5+IXaOX7Ju0oIc0M8ilXjRb9qm6Z67Cyda7Vi7J3syGTVnnVjXdBEhdiHdJwtqM0HofzmEFODVIfkNEjTyemf8fQ8rLiOZ70uGiZynePTIVYKRW4UvOnfe++Xz3hlJIaV3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhf8XVeE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhf8XVeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721768656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgNOjwKnUy48py4Ld6sAQndZB5vwc59GpzRjxep5jN4=;
	b=hhf8XVeEeAOu7MuXJopUJd35Bsgof2iw0g6F3fE23CGXGU7dLFnhRyoJEl0h7pmDeRpwyh
	xRt98h6MZyn55DLEvzbzqTvIlnAdY1VmOpL8NdqNyaRji58nO/lGnAytryF3pXl3X98OUX
	Ykhfe4ZGrx4R+8METuHN8HmQJZs09Hg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-w70HkNCrMfS1DHwoqwvCJQ-1; Tue, 23 Jul 2024 17:04:15 -0400
X-MC-Unique: w70HkNCrMfS1DHwoqwvCJQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3daf080a14eso470310b6e.1
        for <sparclinux@vger.kernel.org>; Tue, 23 Jul 2024 14:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721768653; x=1722373453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgNOjwKnUy48py4Ld6sAQndZB5vwc59GpzRjxep5jN4=;
        b=iKg3MwqdGNPkM9ICejFoQ4DG57+FZ8h7en5+rx/fZ4yOJZyd9//ZG5jZ6VJ7nYoBth
         LPqOuUzYxS2tjFGfa++Y4ooV9uPZuNYmGYTheusU/LLkWuSLcOzM0hNX2bIWGun6p/oV
         0QMEXEyokFSYhYlYYQmsd3dtAk4SCZKCS12xkX+XR+AqWAp6j+jCygp21UbSGi+m5S/l
         lWvMxqiv1N4qHI7GJHMvZFvGSSSDERZA998sIoexpz+XdKnPplI5DTBQSpNDkjXFWlCA
         O2JG5TkPc1BdnnrTgj8XT5fPbgUb80ov4OtH/plfbPdr9ifrW3ozX71Wk4foX/gJKMOc
         uFaw==
X-Forwarded-Encrypted: i=1; AJvYcCXyxmEKoQR1eKZl62dtV055jN8sOrA+Z9BlDKWPgft7YmQwH9colOGuUQ5CP09D1MjbFjfnskY2hrFw@vger.kernel.org
X-Gm-Message-State: AOJu0YytCKHpb6BkZpRakvBafiXR0HYRAe3F8GT3vzSpaN/ibf8qr3yO
	QVAtT/zjHcJok7bzoUVUNQUjVkr4RFfHfUCWIrzw0OjGE0//cDu+1jvEtRIk1jVG8ULDHHdRKpV
	MHWxZdR3Ey7JXdU7xXy1SoVhm1Gji8vXFcmaJJuFvrI+3rtmKSow+DZufz0c=
X-Received: by 2002:a9d:6043:0:b0:703:78ff:1e1 with SMTP id 46e09a7af769-708fd973bc0mr6593340a34.0.1721768653030;
        Tue, 23 Jul 2024 14:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhxM1GaXKORyXEI48pMqHK/HKFQ8d349p1Ngql0yZkrT6ZS6/TU4RH6kRMVcENNPnDcnR0BQ==
X-Received: by 2002:a9d:6043:0:b0:703:78ff:1e1 with SMTP id 46e09a7af769-708fd973bc0mr6593320a34.0.1721768652631;
        Tue, 23 Jul 2024 14:04:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905a721sm515082185a.93.2024.07.23.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 14:04:11 -0700 (PDT)
Date: Tue, 23 Jul 2024 17:04:08 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
	Alistair Popple <apopple@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH RFC 0/6] mm: THP-agnostic refactor on huge mappings
Message-ID: <ZqAayNSDf_6cfziw@x1n>
References: <20240717220219.3743374-1-peterx@redhat.com>
 <cf36725d-c197-4c07-8998-d34711335fdb@redhat.com>
 <Zp57ZLk2IQoHOI7u@x1n>
 <cfe94481-233a-421c-b607-08517588de6c@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfe94481-233a-421c-b607-08517588de6c@redhat.com>

On Tue, Jul 23, 2024 at 10:18:37AM +0200, David Hildenbrand wrote:
> On 22.07.24 17:31, Peter Xu wrote:
> > On Mon, Jul 22, 2024 at 03:29:43PM +0200, David Hildenbrand wrote:
> > > On 18.07.24 00:02, Peter Xu wrote:
> > > > This is an RFC series, so not yet for merging.  Please don't be scared by
> > > > the code changes: most of them are code movements only.
> > > > 
> > > > This series is based on the dax mprotect fix series here (while that one is
> > > > based on mm-unstable):
> > > > 
> > > >     [PATCH v3 0/8] mm/mprotect: Fix dax puds
> > > >     https://lore.kernel.org/r/20240715192142.3241557-1-peterx@redhat.com
> > > > 
> > > > Overview
> > > > ========
> > > > 
> > > > This series doesn't provide any feature change.  The only goal of this
> > > > series is to start decoupling two ideas: "THP" and "huge mapping".  We
> > > > already started with having PGTABLE_HAS_HUGE_LEAVES config option, and this
> > > > one extends that idea into the code.
> > > > 
> > > > The issue is that we have so many functions that only compile with
> > > > CONFIG_THP=on, even though they're about huge mappings, and huge mapping is
> > > > a pretty common concept, which can apply to many things besides THPs
> > > > nowadays.  The major THP file is mm/huge_memory.c as of now.
> > > > 
> > > > The first example of such huge mapping users will be hugetlb.  We lived
> > > > until now with no problem simply because Linux almost duplicated all the
> > > > logics there in the "THP" files into hugetlb APIs.  If we want to get rid
> > > > of hugetlb specific APIs and paths, this _might_ be the first thing we want
> > > > to do, because we want to be able to e.g., zapping a hugetlb pmd entry even
> > > > if !CONFIG_THP.
> > > > 
> > > > Then consider other things like dax / pfnmaps.  Dax can depend on THP, then
> > > > it'll naturally be able to use pmd/pud helpers, that's okay.  However is it
> > > > a must?  Do we also want to have every new pmd/pud mappings in the future
> > > > to depend on THP (like PFNMAP)?  My answer is no, but I'm open to opinions.
> > > > 
> > > > If anyone agrees with me that "huge mapping" (aka, PMD/PUD mappings that
> > > > are larger than PAGE_SIZE) is a more generic concept than THP, then I think
> > > > at some point we need to move the generic code out of THP code into a
> > > > common code base.
> > > > 
> > > > This is what this series does as a start.
> > > 
> > > Hi Peter!
> > > 
> > >  From a quick glimpse, patch #1-#4 do make sense independent of patch #5.
> > > 
> > > I am not so sure about all of the code movement in patch #5. If large folios
> > > are the future, then likely huge_memory.c should simply be the home for all
> > > that logic.
> > > 
> > > Maybe the goal should better be to compile huge_memory.c not only for THP,
> > > but also for other use cases that require that logic, and fence off all THP
> > > specific stuff using #ifdef?
> > > 
> > > Not sure, though. But a lot of this code movements/churn might be avoidable.
> > 
> > I'm fine using ifdefs in the current fine, but IMHO it's a matter of
> > whether we want to keep huge_memory.c growing into even larger file, and
> > keep all large folio logics only in that file.  Currently it's ~4000 LOCs.
> 
> Depends on "how much" for sure. huge_memory.c is currently on place 12 of
> the biggest files in mm/. So there might not be immediate cause for action
> ... just yet :) [guess which file is on #2 :) ]

7821, hugetlb.c  
7602, vmscan.c          
7275, slub.c       
7072, page_alloc.c
6673, memory.c     
5402, memcontrol.c 
5239, shmem.c   
5155, vmalloc.c      
4419, filemap.c       
4060, mmap.c       
3882, huge_memory.c

IMHO a split is normally better than keeping everything in one file, but
yeah I'd confess THP file isn't that bad comparing to others..  And I'm
definitely surprised it's even out of top ten.

> 
> > 
> > Nornally I don't see this as much of a "code churn" category, because it
> > doesn't changes the code itself but only move things.  I personally also
> > prefer without code churns, but only in the case where there'll be tiny
> > little functional changes here and there without real benefit.
> > 
> > It's pretty unavoidable to me when one file grows too large and we'll need
> > to split, and in this case git doesn't have a good way to track such
> > movement..
> 
> Yes, that's what I mean.
> 
> I've been recently thinking if we should pursue a different direction:
> 
> Just as we recently relocated most follow_huge_* stuff into gup.c, likely we
> should rather look into moving copy_huge_pmd, change_huge_pmd, copy_huge_pmd
> ... into the files where they logically belong to.
> 
> In madvise.c, we've been doing that in some places already: For
> madvise_cold_or_pageout_pte_range() we inline the code, but not for
> madvise_free_huge_pmd().
> 
> pmd_trans_huge() would already compile to a NOP without
> CONFIG_TRANSPARENT_HUGEPAGE, but to make that code avoid most
> CONFIG_TRANSPARENT_HUGEPAGE, we'd need a couple more function stubs to make
> the compiler happy while still being able to compile that code out when not
> required.

Right, I had a patch does exactly that, where it's called pmd_is_leaf(),
for example, but taking CONFIG_* into account.

I remember I had some issue with that, e.g. I used to see pmd_trans_huge()
(when !THP) can optimize some path but pmd_is_leaf() didn't do the same job
even if all configs were off.  But that's another story and I didn't yet
dig deeper.  Could be something small but overlooked.

> 
> The idea would be that e.g., pmd_leaf() would return "false" at compile time
> if no active configuration (THP, HUGETLB, ...) would be active. So we could
> just use pmd_leaf() similar to pmd_trans_huge() in relevant code and have
> the compiler optimize it all out without putting it into separate files.
> 
> That means, large folios and PMD/PUD mappings will become "more common" and
> better integrated, without the need to jump between files.
> 
> Just some thought about an alternative that would make sense to me.

Yeah comments are always welcomed, thanks.

So I suppose maybe it would be easier for now that I make the pfnmap branch
depending on THP. It looks to me something like this may still take some
time to consolidate.  When it's light enough, maybe it can be a few initial
patches on top of a hugetlb series that can start to use this.  Maybe
that'll at least make the patches easier to review.

Thanks,

-- 
Peter Xu

