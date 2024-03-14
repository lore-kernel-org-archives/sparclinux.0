Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A05A4CB
	for <sparclinux@vger.kernel.org>; Thu, 14 Mar 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421171; cv=none; b=QLLB4dBrdN9ZXt5EIFaum4/aAS32JYPKJ6NdIztKMjn9HE99H+ImV2pkDjMe+OdATb/c1Un93PH03O6gCe7b1ppSJyBsP/62hWeG0/75sCTwkUFpOg1beU+hczVqhVo+uWcdzvIFwNfH18iQgnB/JOHD4lEBRuuBaHlW1SipY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421171; c=relaxed/simple;
	bh=yVKWvtTcilhjLoZ+TCPRFpuKTw3Iw+UQUwWQlErhy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNLfNHGLZBidBzAUhtf6XYF60Z2BVBN6087Pe2Gfs1nr+AhKpcE1aR1zAywtv7PiJLT9ppKpoVJSryvvHw4Rpm5TVHMJKBkIhWNbxtelbB0lYhZXtDn/DU8GXVsndD/C09aqnjknqnZ4o/asrB/3VBZ5B7G+6Co3Kr3rfp+pSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSaR2vE1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSaR2vE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710421169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKCzOVXDDLeWui+9xMnOflGFcsiyeRgIZTuCOA+l7OQ=;
	b=dSaR2vE1rU3Gnl/T8xSffNMNi88szzSueQV13TvvBalN/AdPVq9Ov+nn0E+ZfCm+fTYunp
	bxNc5qaajufWsHRWiO+rh22T9fOeqLcvGfBpEW8R5/b94nQ7+5aO/74SxU0top+MzSVwNT
	7tF0nuLDRatjXqBQaWAjIuNkwVeHNO0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-cMySHFWYNK61XZOhfYr0ig-1; Thu, 14 Mar 2024 08:59:27 -0400
X-MC-Unique: cMySHFWYNK61XZOhfYr0ig-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4d424421d4aso121577e0c.0
        for <sparclinux@vger.kernel.org>; Thu, 14 Mar 2024 05:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421167; x=1711025967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKCzOVXDDLeWui+9xMnOflGFcsiyeRgIZTuCOA+l7OQ=;
        b=ib2iC+5DidKLSXvoX+9gG/QgVk+n5OBR2TsxTalCHF3ZIKKBQipx939s0y4jN6nwyF
         PP1GP3YqmPK8/oiqFIUGvgVsuXfSTA/7dfkm1DY7WRtDW5qH8o1fpqCGKsnRfAe831Fy
         53B50UlDp8cf+8sfTcrhcD0Ibej+mDLDsYZxsX9wUxVf1BMcwz9z+A784GAPoAx6KSBU
         XlWhHE/uNTse/jCoG0sZdA9VhjfyS42Gxr+FLDSFX+Af617zM9NnQbyjy3KKMrF9dda5
         QLEzhK5lt2zwgSIK8L2QTWZW1t8XmDKzyy+9gJw8h8C3p1A6iVWkfVw0tpZ6QnqyTlRB
         M9xw==
X-Forwarded-Encrypted: i=1; AJvYcCWIzwfTg1uh9k8vZ2tB9OBHDKQBpE2Ns6LcG/Qd2DCvldjUvV1Q0srVpqqVOytnIXoCP+SgYXOrysBW2QBjbEA5aq46nRopI7LoOg==
X-Gm-Message-State: AOJu0YzVpHOD4uM1a61MULkMH+qKqmL1Wmx5M5SQRvhtZkFD2+ROiAN0
	qLjFc0U47ucZVdP5DyBoa43S0wgvaX44kg7ft7KQWrRzOLHyyrOCr++Gt1w9TvovEpIoudyb/+f
	G+KEjaabPY2yaEtLPKi21HaVcB7cCQHCWkcKYMhlTOb4C6UAXwGezOdbk748=
X-Received: by 2002:a67:f405:0:b0:476:7cf:5495 with SMTP id p5-20020a67f405000000b0047607cf5495mr1410171vsn.3.1710421167228;
        Thu, 14 Mar 2024 05:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpB2lM/GBtztEZpRh5zxenkJs3cKW/cbCqzpceWYQibEUdWkJxv7eCQPooUilH8iyb4M7ppQ==
X-Received: by 2002:a67:f405:0:b0:476:7cf:5495 with SMTP id p5-20020a67f405000000b0047607cf5495mr1410155vsn.3.1710421166816;
        Thu, 14 Mar 2024 05:59:26 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id q14-20020a05621419ee00b00690edd77658sm413155qvc.75.2024.03.14.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:59:26 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:59:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 11/13] mm/treewide: Replace pXd_huge() with pXd_leaf()
Message-ID: <ZfL0qh0re5BpYGba@x1n>
References: <20240313214719.253873-1-peterx@redhat.com>
 <20240313214719.253873-12-peterx@redhat.com>
 <0f929f80-92fd-4824-a7d6-839f1aef4c8a@csgroup.eu>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f929f80-92fd-4824-a7d6-839f1aef4c8a@csgroup.eu>

On Thu, Mar 14, 2024 at 08:50:20AM +0000, Christophe Leroy wrote:
> 
> 
> Le 13/03/2024 à 22:47, peterx@redhat.com a écrit :
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Now after we're sure all pXd_huge() definitions are the same as pXd_leaf(),
> > reuse it.  Luckily, pXd_huge() isn't widely used.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   arch/arm/include/asm/pgtable-3level.h | 2 +-
> >   arch/arm64/include/asm/pgtable.h      | 2 +-
> >   arch/arm64/mm/hugetlbpage.c           | 4 ++--
> >   arch/loongarch/mm/hugetlbpage.c       | 2 +-
> >   arch/mips/mm/tlb-r4k.c                | 2 +-
> >   arch/powerpc/mm/pgtable_64.c          | 6 +++---
> >   arch/x86/mm/pgtable.c                 | 4 ++--
> >   mm/gup.c                              | 4 ++--
> >   mm/hmm.c                              | 2 +-
> >   mm/memory.c                           | 2 +-
> >   10 files changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > index e7aecbef75c9..9e3c44f0aea2 100644
> > --- a/arch/arm/include/asm/pgtable-3level.h
> > +++ b/arch/arm/include/asm/pgtable-3level.h
> > @@ -190,7 +190,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
> >   #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
> >   
> >   #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
> > -#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
> > +#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
> 
> Previous patch said pmd_trans_huge() implies pmd_leaf().

Ah here I remember I kept this arm definition there because I think we
should add a patch to drop pmd_thp_or_huge() completely.  If you won't mind
I can add one more patch instead of doing it here.  Then I keep this patch
purely as a replacement patch without further changes on arch-cleanups.

> 
> Or is that only for GUP ?

I think it should apply to all.

> 
> >   
> >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >   #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
> 
> 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index c95b9ec5d95f..93aebd9cc130 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -429,7 +429,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> >   		return hmm_vma_walk_hole(start, end, -1, walk);
> >   	}
> >   
> > -	if (pud_huge(pud) && pud_devmap(pud)) {
> > +	if (pud_leaf(pud) && pud_devmap(pud)) {
> 
> Didn't previous patch say devmap implies leaf ? Or is it only for GUP ?

This is an extra safety check that I didn't remove.  Devmap used separate
bits even though I'm not clear on why.  It should still imply a leaf though.

Thanks,

> 
> >   		unsigned long i, npages, pfn;
> >   		unsigned int required_fault;
> >   		unsigned long *hmm_pfns;
> 
> 

-- 
Peter Xu

