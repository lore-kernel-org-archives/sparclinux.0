Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B64F054F
	for <sparclinux@vger.kernel.org>; Tue, 29 Sep 2026 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673689; cv=pass; b=u4rfH+ZiyWetCNra6UB9gR5X5wl7SMykaddmTo7wan+f4SWto0IDWCRApbf/MpoM24g5l65+q/x5QyEI3SmgNB9e7Do4khI+XMKhNMCdxCiHPeZV5DfNo+6rzOItBR6Rpg2c31TYx++qJ7HduPczw1itzDemdsq1WapMk9nTuCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673689; c=relaxed/simple;
	bh=KffUdrW4MIDYYjKmdfFtDkcgVtt4B2IrR74wnM1cZv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLq3PNsiyAhUc1xneIEZtNpNhQd8mL/z4mmSIEpO9WfZUZSfi4/TFfcDeD4nHiPPBZB8cHqd3aZo7xbUpEfAx8f4qBkIQjnKpGGOzK6JOvCekQ0YzcOeoStXYcO5yw+hjtHlnf3TReKppjRPYH/DaHVmpyJrNnUeIGM6Pbp/7do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc/rbEYJ; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc/rbEYJ"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2c570a3030so354574166b.0
        for <sparclinux@vger.kernel.org>; Tue, 29 Sep 2026 02:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790673677; cv=none;
        d=google.com; s=arc-20260327;
        b=lFOvvU8yYnIJaUcaP1J95dmzM79AMM11Iwe9BjY6c3OsCbsYQ20MQi6waNu4i8l2ma
         N+Umx/O9tCAloZTdbHFzDgl3qhHJbOigSOXywmsUgunM866IRIrfJirnQ1em65+1Q9wu
         D9B+TZAPn/pbx63k/M49J7eSVHQzc0CPZYJmmTVjpKrtlxIvGG58viw+J196zxTTZvj7
         N9fFoSH/YyhHLt8OSFOUjuuRE7hCnH11T+2tldFrEgKLgpTJO6ec0e+q35uwfDkeK3Et
         wB5NybmPljOy1n+CEpZ7N6EO69k5SQovf7vciayxgNxigDSNDtT1Ty8vK+bSibIkPs4H
         aYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GhqndOhozIw40kNwzku+lND3i27hg00jPoEVizKt1rI=;
        fh=G728Sub6DdXiNvY7vWc6AUrYRuVZkELdrtVCJ7ZM9l8=;
        b=EndP2k2B/pmYCSmkSrJdAjVs4KZS3EGjqN+iojgBg0D7Zm8vlHre3IdWUz3Yv3OuNh
         eP7u1lfxQOw/LiCYIxLMHwny6RwfFyy43qS7YOREcjt2z9iGfo9K4LQt+v8h/pG/847X
         RRziNdl9ZBf3HVk4pkhzt8usRLq88UBphwheh02elDNeB/naR0sDS+rJQqOi2lGjLlOL
         eBJGsY8xKvhmW/2mpawG2fIwZrOkqppBJtGOnLisNRpA+5DnSSroEhhWK74Tr/ltieSA
         cM9LVcZyFm1RE+nXzE/BkJpVUXJrgLbMrujWgMDEOM80DFvIYIl6czGwTza4Rf7gB64G
         jDMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673677; x=1791278477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GhqndOhozIw40kNwzku+lND3i27hg00jPoEVizKt1rI=;
        b=Vc/rbEYJqggb9tipRL+iGmi/EIB3v1070TxrtvWbfv2EZFiaogLFhx/ZjB1SSTABt/
         YyrD5hrzKGHnqbJflBqFJIqE0KSpGoTfHBvUk1oeV+a2855trkS1X2Ltgs8RQazbclPP
         SYGiBWSWsEy8deoSdpnp+d20h0NebvDKmGlWaRomxnviV9LW9eVawEq9+Bl8OOgtA14p
         GpohE2A8au1UNWqmbxbE6Jw4JBBbU+JNxDh/XhbHjzD0Y5vhbdXcCQiC9/8Xt2PA/Jn7
         c2c8xAi7bp1MlWjXVBDfL4w1WU66ZrB3NYz1LGyobzLgLCGhtaAO35N3EbKbx/ZiFiji
         4Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673677; x=1791278477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GhqndOhozIw40kNwzku+lND3i27hg00jPoEVizKt1rI=;
        b=ZzsLYGSj7P76FrvVQjovprAnVYfswD982CkR7q/Fraxg9nVnUC6+MaTd3rBtn3FlUH
         e/CLixXN6kSCLAh8uo+jfX+YfE8wAFqfFgUTSamhyZ4NboIy9XzrDd9JTagl9o2hwe9g
         7tFIawQ2CLEZWekcswvC4Uc+1Uk9taqtJCqxJXgESbshMXJKojPEIs3VLEEXZNf25mlz
         z7WV1Re/9OBYglZKK5CA4VSkWbh3mryNwsovL6WLBcNry+M2FAYNmnxN7lHC5TYbPnpH
         itP1b/ZjEP9UM23XQoc9KnEVMSsF5IDeVynZ/nXu4oa4slxfFPz8kyFEeRW3KNQuA/9N
         WuXg==
X-Forwarded-Encrypted: i=1; AKwUvBzxKkXS2mfh7qQg8Srjnw/YSrjq28MvYBKH2wlhKJcazS2P+/JA2seNXuYVu+UHSNgTerdqOF7PZRjH@vger.kernel.org
X-Gm-Message-State: AFuF++m+uJM0JaGCqQdnukGK9aEdSciCnjJ9C9oTnY5/KgbZaq2J6Kfk
	iwK+y9IdXqHVhV1x+m46nfp19gHiJm5TkQgw8N4jn4hV42B9zeny3PEro6hA+z5NwBXaLNjQ0g8
	YPHxSfYE+ZWCBR+S2lJZ6cazPnl6BScE=
X-Gm-Gg: AYBFou1vDAAwiSlMdE/Sgq0IWsXRbbN7CSCfx2nB6qSjRfWMrCllwokjmXRhsfWNtV8
	46Q4AueanUnjVe/ZY4X1Wain32RlyaPkzcPxcZG6U4IW5EaKBkYm6RRsShsLN2BvklWh742bpiX
	PoXFbjo3/pjVctq40KdUWPW/A86aYHQykYjK9KEFvXc5HBIdmuBWDkqKng2hdBxXE8oXmg53Hh3
	nO/Cl/PaQuIS+3BpFhf8cntgg20faKCuzshC1Vl95iMcA4GCPybjhswgCRy2x3ITXwVHvWH9JmA
	vHk8udMWgbqN2MwIxyFD3xVjjm2uornOkY/OvcIAugLivYjUUfIOzLvU988CWUc326l+f1JEyih
	H6A4KQGdPDVc=
X-Received: by 2002:a17:907:c80d:b0:c2b:f3d5:2090 with SMTP id
 a640c23a62f3a-c2bf3d52cd4mr701192866b.27.1790673677038; Tue, 29 Sep 2026
 02:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924131106.1730494-1-dev.jain@arm.com> <20260924131106.1730494-2-dev.jain@arm.com>
In-Reply-To: <20260924131106.1730494-2-dev.jain@arm.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 29 Sep 2026 17:20:40 +0800
X-Gm-Features: AclHuK9lxCbTSA0mjXTjQjkfbiHSsXqGwiLHzR329M81OQsBZnsP4Ya5LuEJfD8
Message-ID: <CAMgjq7CWom3pwZa5j=gmtb57Y+1+QfAkmkLVcgKnJVsZi+Fi3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm/swapfile: add batched version of folio_dup_swap
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	hughd@google.com, chrisl@kernel.org, davem@davemloft.net, andreas@gaisler.com, 
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, 
	jannh@google.com, lance.yang@linux.dev, baolin.wang@linux.alibaba.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, 
	baohua@kernel.org, youngjun.park@lge.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, pfalcato@suse.de, jgg@ziepe.ca, thuth@redhat.com, 
	sparclinux@vger.kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 9:15=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> Add folio_dup_swap_pages to handle a batch of consecutive pages. Note
> that folio_dup_swap already can handle a subset of this: nr_pages =3D=3D =
1 and
> nr_pages =3D=3D folio_nr_pages(folio). Generalize this to any nr_pages.
>
> Currently we have a not-so-nice logic of passing in subpage =3D=3D NULL i=
f
> we mean to exercise the logic on the entire folio, and subpage !=3D NULL =
if
> we want to exercise the logic on only that subpage. Remove this
> indirection: the caller invokes folio_dup_swap_pages() if it wants to
> operate on a range of pages in the folio (i.e nr_pages may be anything
> between 1 and folio_nr_pages()), and invokes folio_dup_swap() if it
> wants to operate on the entire folio.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/rmap.c     |  2 +-
>  mm/shmem.c    |  2 +-
>  mm/swap.h     | 18 ++++++++++++++++--
>  mm/swapfile.c | 18 ++++++++----------
>  4 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6661bc11ce658..a70dbc8d544e1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2150,7 +2150,7 @@ static bool ttu_anon_swapbacked_folio(struct vm_are=
a_struct *vma,
>         swp_entry_t entry =3D folio_page_swap_entry(folio, page);
>         struct mm_struct *mm =3D vma->vm_mm;
>
> -       if (folio_dup_swap(folio, page) < 0)
> +       if (folio_dup_swap_pages(folio, page, 1) < 0)
>                 return false;
>
>         /*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b572c60f2af85..d5bd9506ce500 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1914,7 +1914,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct =
folio *folio,
>                         spin_unlock(&shmem_swaplist_lock);
>                 }
>
> -               folio_dup_swap(folio, NULL);
> +               folio_dup_swap(folio);
>                 shmem_delete_from_page_cache(folio, swp_to_radix_entry(fo=
lio->swap));
>
>                 BUG_ON(folio_mapped(folio));
> diff --git a/mm/swap.h b/mm/swap.h
> index b3b54c28929a1..47290510de264 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -244,7 +244,8 @@ extern int swap_retry_table_alloc(swp_entry_t entry, =
gfp_t gfp);
>   * folio_put_swap(): does the opposite thing of folio_dup_swap().
>   */
>  int folio_alloc_swap(struct folio *folio);
> -int folio_dup_swap(struct folio *folio, struct page *page);
> +int folio_dup_swap_pages(struct folio *folio, struct page *page,
> +               unsigned long nr_pages);
>  void folio_put_swap(struct folio *folio, struct page *page);
>
>  /* For internal use */
> @@ -368,7 +369,8 @@ static inline int folio_alloc_swap(struct folio *foli=
o)
>         return -EINVAL;
>  }
>
> -static inline int folio_dup_swap(struct folio *folio, struct page *page)
> +static inline int folio_dup_swap_pages(struct folio *folio, struct page =
*page,
> +               unsigned long nr_pages)
>  {
>         return -EINVAL;
>  }
> @@ -464,6 +466,18 @@ static inline void __swap_cache_replace_folio(struct=
 swap_cluster_info *ci,
>  }
>  #endif /* CONFIG_SWAP */
>
> +/**
> + * folio_dup_swap() - Increase swap count of all swap entries of a folio=
.
> + * @folio: folio with swap entries bound.
> + *
> + * See folio_dup_swap_pages() for more information.
> + */
> +static inline int folio_dup_swap(struct folio *folio)
> +{
> +       return folio_dup_swap_pages(folio, folio_page(folio, 0),
> +                                   folio_nr_pages(folio));
> +}
> +
>  extern const struct swap_ops swap_bdev_ops;
>
>  int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c1c5fbb3c909d..75167b8580cc0 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1799,9 +1799,10 @@ int folio_alloc_swap(struct folio *folio)
>  }
>
>  /**
> - * folio_dup_swap() - Increase swap count of swap entries of a folio.
> + * folio_dup_swap_pages() - Increase swap count of swap entries of a fol=
io.
>   * @folio: folio with swap entries bounded.
> - * @page: if not NULL, only increase the swap count of this page.
> + * @page: the first page in the folio to increase the swap count for.
> + * @nr_pages: the number of pages in the folio to increase the swap coun=
t for.
>   *
>   * Typically called when the folio is unmapped and have its swap entry t=
o
>   * take its place: Swap entries allocated to a folio has count =3D=3D 0 =
and pinned
> @@ -1815,18 +1816,15 @@ int folio_alloc_swap(struct folio *folio)
>   * swap_put_entries_direct on its swap entry before this helper returns,=
 or
>   * the swap count may underflow.
>   */
> -int folio_dup_swap(struct folio *folio, struct page *page)
> +int folio_dup_swap_pages(struct folio *folio, struct page *page,
> +               unsigned long nr_pages)
>  {
> -       swp_entry_t entry =3D folio->swap;
> -       unsigned long nr_pages =3D folio_nr_pages(folio);
> +       swp_entry_t entry =3D folio_page_swap_entry(folio, page);
> +       unsigned long idx =3D folio_page_idx(folio, page);
>
>         VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>         VM_WARN_ON_FOLIO(!folio_test_swapcache(folio), folio);
> -
> -       if (page) {
> -               entry =3D folio_page_swap_entry(folio, page);
> -               nr_pages =3D 1;
> -       }
> +       VM_WARN_ON_FOLIO(idx + nr_pages > folio_nr_pages(folio), folio);
>
>         return swap_dup_entries_cluster(swap_entry_to_info(entry),
>                                         swp_offset(entry), nr_pages);
> --
> 2.43.0

Looks good to me.

Reviewed-by: Kairui Song <kasong@tencent.com>
