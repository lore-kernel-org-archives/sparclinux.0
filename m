Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639934E1CF
	for <sparclinux@vger.kernel.org>; Fri,  8 Mar 2024 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709880638; cv=none; b=QfdEViebZ7ebuVLi4WCodHp7eSSBRA9MAYRpkfs2Gj/6RO1IEZtiDFCnXM2LASBa5ZH+0mUIvIv0en7f2GsC0KNNBN+6xKeFf2UmLlAT3QYM8Yevi2EcuqVbltPR2GinRVmYpeqzFajtsMroRP5FJBWj2bfePaNxWPC6K4ZmrZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709880638; c=relaxed/simple;
	bh=icevmjjQzy7T8gdOkFpqgnXBgi/VX04oIsM5bIcpiN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b87rzTVhKunGTm6S5Qu+/WlfDKHqAxEBzV46KNx/8wFAPEJqAaDzmBQM8jhfgegMyw9pQ65CXxxLCtxp5l0P9Lcxj3CYuZkVn8kZyxvk3O8celfpczxDudjBlvMAA5TKKL4sAvhukhBJ2Am+urijzUzHvkhI/iztmUq1Put4SRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heDxVs4J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heDxVs4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709880635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epRg3dGewUcblPePlS+KzZdY/GgoToAmRabId8Bpp4I=;
	b=heDxVs4JuJWDoEnTziGBu+wOhirVIly0obbjgcHGDLl/w0Ujbc/n9faMMLhkFuGUgGitDi
	ckYwO4zwgUjdIoTTDaLCNHl/u6NC7d0ptkUi4Icx1EuVocmpWuCYsdZru5rTEqKhMRYDTD
	zZ9VNu4nQBrHTnuq+GvA3bD9uZOLatA=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-AJEqZs8uNXi6WvkSGrSKPA-1; Fri, 08 Mar 2024 01:50:31 -0500
X-MC-Unique: AJEqZs8uNXi6WvkSGrSKPA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-21e4604101bso607475fac.0
        for <sparclinux@vger.kernel.org>; Thu, 07 Mar 2024 22:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709880631; x=1710485431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epRg3dGewUcblPePlS+KzZdY/GgoToAmRabId8Bpp4I=;
        b=NhT0KEzZq6Bq1JuDPM2Bx0yBxnKZhiPckv7ZATLpEaF6VADr/xZXVpFFoT2ZOHTZ0J
         9xtHpPgbHBVQtrqzvr/fxSDHhExBg0VVVE/zGM+9sLBumqZPyL5lgEpLjwJ+kPwJYPMJ
         HxPM2JSZsDC5NVD2ZBUAxQkCxqP65cSUU2a3Td7vfRp6OcxwouCGzpatDvhR4aKfU6E3
         Q/0dgSMXuU+d9mGi3wpUYoeHpdwkdniaFcjoXQc0JiQzdc1LQvp5riyF9hh3cVv2NInD
         NsKHgjs4RpyD47hBrUetFD8HM/j8cRg2p10cguBdnXijzOYIxDOBjIsDuYSHqouywkXb
         AklQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZCsdNfztasxg4IvczeV40CU+Ypyow/sKcFxogS+jiwOb3hNpgrle0KmUILUqySS3x41LgRtAkOMHwcG8hnbrXS0VMZXrph9hOGA==
X-Gm-Message-State: AOJu0Ywgeb5Uv9uI4qOvufPMyQoHPrcjEKCq1vkyLjmYNeFD9DCpxwY2
	qVLG8R9BCDO1xU8bYLCmVyV8+LYbK3gAvY/O3qOc4J36am1h6JzzUpa5WZrXmtIEJoYUriA8ja4
	MwNROfpbtrmzHXXPmCeMZFUD1bMt/2ASTCEtUO96jV2zlCy+29irD/v/W+VA=
X-Received: by 2002:a05:6870:911f:b0:221:9798:22ce with SMTP id o31-20020a056870911f00b00221979822cemr1235678oae.5.1709880630972;
        Thu, 07 Mar 2024 22:50:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5WJ4Hs7BOa4+cQmkVKBMn/KDqWDXIuEQmCh9SbFC/cz4o3SLGxNN1BrH2AJEolH8ck0I8Eg==
X-Received: by 2002:a05:6870:911f:b0:221:9798:22ce with SMTP id o31-20020a056870911f00b00221979822cemr1235655oae.5.1709880630429;
        Thu, 07 Mar 2024 22:50:30 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r37-20020a632065000000b005dcc075d5edsm13621982pgm.60.2024.03.07.22.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 22:50:30 -0800 (PST)
Date: Fri, 8 Mar 2024 14:50:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH RFC 01/13] mm/hmm: Process pud swap entry without
 pud_huge()
Message-ID: <Zeq1LNValPosuWgw@x1n>
References: <20240306104147.193052-1-peterx@redhat.com>
 <20240306104147.193052-2-peterx@redhat.com>
 <20240307181233.GD9179@nvidia.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307181233.GD9179@nvidia.com>

On Thu, Mar 07, 2024 at 02:12:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2024 at 06:41:35PM +0800, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Swap pud entries do not always return true for pud_huge() for all archs.
> > x86 and sparc (so far) allow it, but all the rest do not accept a swap
> > entry to be reported as pud_huge().  So it's not safe to check swap entries
> > within pud_huge().  Check swap entries before pud_huge(), so it should be
> > always safe.
> > 
> > This is the only place in the kernel that (IMHO, wrongly) relies on
> > pud_huge() to return true on pud swap entries.  The plan is to cleanup
> > pXd_huge() to only report non-swap mappings for all archs.
> > 
> > Cc: Alistair Popple <apopple@nvidia.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hmm.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > @@ -424,7 +424,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> >  	walk->action = ACTION_CONTINUE;
> >  
> >  	pud = READ_ONCE(*pudp);
> > -	if (pud_none(pud)) {
> > +	if (pud_none(pud) || !pud_present(pud)) {
> 
> Isn't this a tautology? pud_none always implies !present() ?

Hmm yes I think so, afact, it should be "all=none+swap+present". I still
remember I missed that once previously, it's not always obvious when
preparing such patches. :( I'll simplify this and also on patch 3.

Thanks,

-- 
Peter Xu

