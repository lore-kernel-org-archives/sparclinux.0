Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A79D282F21
	for <sparclinux@vger.kernel.org>; Fri, 25 Sep 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337842; cv=none; b=Q1oe0KKmgrmqCNItgp9j8XEoWHipZbZ3m1h5kceREX1r2Nz01h8bBVM9JGbZD5xelmIbDo9NSks7Gy5Efnhc34d6xtkkJZ4bNPn6Ux8CURzFs3Lvxni/DPgyc9p4R8j2ihWmFO54WjaqGYnP8ZHlcfnvN40sQZhZ2+BrXnA+9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337842; c=relaxed/simple;
	bh=oU4FDbUOk2vD4RyLzzlN2ENCAo3M6rqTVLqKImDLUnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3scKjJpanZ8lhYqeFS9pPzDy4w0EG1aRr89R/Z/l+M9OoXhlO+t6BqXnRxWHO9hufuOW0N5Dw4UIU2euz7Jpcvdez0br7nCHy/HkQBrBv1AOGawltLrmx6LIh6deSiuqpHq+kvLm2iTJacm7Rup2DOjE8oOmvXjvYLWNuExuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfORkqOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfORkqOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9351F0089A
	for <sparclinux@vger.kernel.org>; Fri, 25 Sep 2026 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790337839;
	bh=IuK/P9c6OAPq/+SKum+YEnA5wQo2vUmWCi3a8/VIFXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bfORkqOwm/jPH01KRlZxDLwAYlym2PajjAtqz0iI3rvaSi9SxCw5xh08DCT+jq1Pk
	 UqIOxrzR42d0Tnf3h/pfrv91Xhm9l9kIdz8PmTH1sLd8mL5Cqw8Sx3Go3Zr81NlWNO
	 tVJh+xRci46THm57MHhfTEF9d4uYYI+gKDpY9o2/qW4kxGPsEfCRg7lmqBiXB8mH4D
	 AgzvWQA/UTSADFicPeAnClJp69KNg44nVAr3dmAZZ0lDjZRLwGdpkL7NGMlKN7Kixw
	 CC8V2P4xBAYZTHyFHogVgvmmClYDRl/bYi+zF8i4qvzUHUD5E180BoAFX0eaFxohcR
	 EW4uCNSKEhz+A==
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d63f434fso13377491cf.2
        for <sparclinux@vger.kernel.org>; Fri, 25 Sep 2026 05:03:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy3mkp8nzOHfaP/qzgaveVOOWaFs/VEjuG6oavi8m1HqUpGE1xagbtPDk5zPLEllRza7mhANo7b46CC@vger.kernel.org
X-Gm-Message-State: AFuF++l9tPnoIHjtM7fdFHGzWPHIP4cRnDYD9ZnybUv2BA1udctFlsRg
	nQ0GivsF5n7VcCNBD+PHR1lIU/dZ/qe4Jkztg1725rHghhb0LDx5joSdWM832MogvueK/3Q0/5p
	zxdnsoTFLVioUeFEi5bD+euzN1DlDyAQ=
X-Received: by 2002:a05:620a:17ac:b0:93b:d79f:d948 with SMTP id
 af79cd13be357-93c43eb2a12mr376097585a.61.1790337839274; Fri, 25 Sep 2026
 05:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924131106.1730494-1-dev.jain@arm.com> <20260924131106.1730494-5-dev.jain@arm.com>
 <CAGsJ_4yDZypOxjwmAY_usM+v_OJahShz-_uRSAiUZUAzv14VRA@mail.gmail.com> <9c00b28a-8b76-48c9-9318-cf1f4abaf944@arm.com>
In-Reply-To: <9c00b28a-8b76-48c9-9318-cf1f4abaf944@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 25 Sep 2026 20:03:47 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wHO4RznDsNN5rqvAc3=zMxey672tT7A_NaLFuARjqGHA@mail.gmail.com>
X-Gm-Features: AclHuK_jh9CeCH_kPepZsAmtV7M4LNfu_ssdJYktuOmQA89haRao37oJcpOqxWU
Message-ID: <CAGsJ_4wHO4RznDsNN5rqvAc3=zMxey672tT7A_NaLFuARjqGHA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] mm/rmap: Add batched version of folio_try_share_anon_rmap_pte
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	hughd@google.com, chrisl@kernel.org, kasong@tencent.com, davem@davemloft.net, 
	andreas@gaisler.com, riel@surriel.com, liam@infradead.org, vbabka@kernel.org, 
	harry@kernel.org, jannh@google.com, lance.yang@linux.dev, 
	baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, youngjun.park@lge.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, pfalcato@suse.de, jgg@ziepe.ca, thuth@redhat.com, 
	sparclinux@vger.kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 7:09=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 25/09/26 11:00 am, Barry Song wrote:
> > On Thu, Sep 24, 2026 at 9:11=E2=80=AFPM Dev Jain <dev.jain@arm.com> wro=
te:
> >>
> >> To enable batched unmapping of anonymous folios, we need to handle the
> >> sharing of exclusive pages. Hence, a batched version of
> >> folio_try_share_anon_rmap_pte is required.
> >>
> >> Currently, the sole purpose of nr_pages in __folio_try_share_anon_rmap=
 is
> >> to do some rmap sanity checks. Now, clear the PageAnonExclusive bit on=
 a
> >> batch of nr_pages. Refactor the function such that the clearing of the=
 bit
> >> can be done at one place without duplication.
> >>
> >> Note that __folio_try_share_anon_rmap can receive nr_pages =3D=3D HPAG=
E_PMD_NR
> >> from the PMD path, but currently we only clear the bit on the head pag=
e.
> >> Retain this behaviour by setting nr_pages =3D 1 in case the caller is
> >> folio_try_share_anon_rmap_pmd.
> >>
> >> While at it, convert nr_pages to unsigned long to future-proof from
> >> overflow in case P4D-huge mappings etc get supported down the road.
> >> I haven't made such a change in each function receiving nr_pages in
> >> try_to_unmap_one - perhaps this can be done incrementally.
> >>
> >> Add two WARN's: check that the batch is entirely exclusive (for PMD
> >> callers, need to check only head page), and that there are only
> >> PTE/PMD paths converging into __folio_try_share_anon_rmap.
> >>
> >> Signed-off-by: Dev Jain <dev.jain@arm.com>
> >
> > The patch looks correct to me, but it seems a bit hard to follow
> > because of the `pinnable` handling.
> >
> >> ---
> >>  include/linux/rmap.h | 56 ++++++++++++++++++++++++++++++-------------=
-
> >>  1 file changed, 39 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> >> index 62ef511a6175a..91b5763ef466f 100644
> >> --- a/include/linux/rmap.h
> >> +++ b/include/linux/rmap.h
> >> @@ -723,17 +723,23 @@ static inline int folio_try_dup_anon_rmap_pmd(st=
ruct folio *folio,
> >>  }
> >>
> >>  static __always_inline int __folio_try_share_anon_rmap(struct folio *=
folio,
> >> -               struct page *page, int nr_pages, enum pgtable_level le=
vel)
> >> +               struct page *page, unsigned long nr_pages, enum pgtabl=
e_level level)
> >>  {
> >> +       /* device private folios cannot get pinned via GUP. */
> >> +       const bool pinnable =3D !folio_is_device_private(folio);
> >> +
> >
> > If we make a helper that does:
> >
> > for (;;) {
> >      ClearPageAnonExclusive(page);
> >      if (--nr_pages =3D=3D 0)
> >                break;
> >      page++;
> > }
> >
> > wouldn't that allow us to avoid this ugly `pinnable` variant?
> >
> > Then we can make a much smaller modification, which should
> > also be much easier to follow? No?
>
> David had suggested here:
>
> https://lore.kernel.org/all/95b8224d-3ed4-4fe3-9954-d5ba0aa373f8@kernel.o=
rg/
>
> The argument was that the helper would have no context of the pages we ar=
e
> operating on. Although you are correct that this makes the function harde=
r
> to follow.
>
> Maybe, revert to the original function, and have this helper
> folio_clear_pages_anon_exclusive, which will take the folio and do
> the page_anon_exclusive_batch =3D nr_pages sanity check, and add
> kerneldoc to it which says pages should be within folio?
>
> The kerneldoc can be saved by calling __folio_rmap_sanity_checks in
> folio_clear_pages_anon_exclusive - that will cause duplication, but
> then it's all a VM_WARN_ON function so maybe we don't care?
>

Never mind. If you and David have already discussed this, then it is
all good to go with your current code. Everyone has a different
coding style and taste :-)

For the patch, feel free to add:

Reviewed-by: Barry Song <baohua@kernel.org>
