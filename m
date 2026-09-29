Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A643CE489
	for <sparclinux@vger.kernel.org>; Tue, 29 Sep 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673780; cv=pass; b=gWr8hn++tFGQMA/JKQ0DixGEE8H/aH3N/wkKPXA7wsmCathHo/cACzvPezMr8gm3mSifTMEsWqN7bSVYHRJcxQQv8kSZ9DR78tGmTL6Zi6OpucH6d4J83vC8ufnVmxrPG18aFAyBxR7+S9LR0DUHoGtokErXaFNLe+D/3bk4fqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673780; c=relaxed/simple;
	bh=OKr4fUIPbrOHWUmRo+UKdJkXsZji/RzT6pox/LwWRsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnaiMxgI3COyJNUpjs/TjdebNSfCmmo9y6dGCIDokyQutRLj2pYsa5vvpV1bI43VWIStfGTA7gZIo0GDj5G1XhMwmFDU5pjrdz9Xpc3VI20vmyYRLEuVtqOfKtv9cjTaGa0PmDSgd5jKDL500dd/5UfG5VPDnWh2PaSU2pTN/a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVZ0zeye; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVZ0zeye"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so568373666b.1
        for <sparclinux@vger.kernel.org>; Tue, 29 Sep 2026 02:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790673768; cv=none;
        d=google.com; s=arc-20260327;
        b=alXvuZBEUnIuLmgNH2EKHn8okFOoFiIkPbqaPXXYhvGHCsT1+lH6e0ohNk/elCJr5v
         gm5vWW5oF4AqyV2g/LGMzqb0q88Ol8zGYD5svfkSAqaGUvxEJyfT7vps9pfiu5Y6snhn
         htRjECcsj3SN5KgRCJOZQplNjTkB50WNGr05dYVmOasHT0Dsj1p6B4CTETwKTrGW8V8G
         H6QvEK1DDzAyfbS8x9qFl9Cgw5lz6iEJiPHfYUex3o+BMA1DY9ccUDvY41U+297P14qK
         zUoYsff+rSVKpWcggjdoHSpegHw+uBrwhmh/gv0+LaD/70TyGMUKdRz79kNY7JCZQ7jK
         J5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IN0tPSzGH98R2Pd3lnF+txldXvSCDJz1o/eX2B23T/w=;
        fh=hrxIpJZ4lNbOf/m5zKC++Sbf9zVFNdIeUOiGKjKf+rg=;
        b=iaBFwaygrQkU846WhEUf0L1vHYdHagvLo2BZCuyubETZUbsdDLwfx5bewjpfTPXAYW
         FnZtLY0+SOgb009Y8vyvI4G4/VqQun2u6mSpyMWCZh0vpf/vj8hlI81PoxqVnbX4F62l
         0TilyOyczgXPd0mM9rbxWtGal0IkgnIkN+fhMiStm/crzFE2tz/bPpU7DjOAkwSBqAmY
         0iFZIWjy1zEsobCxYs8q0m42wqAKlBq351Jof9vrpV/HDJQ0Voym3HFsswW66IdV6V9M
         Qtruro4P8uGytmsw7z9ecS+rHR+O4zaqiRoqYEgheYcs8S+B63r7YCPEiHRwB/mR6Mqy
         SetA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673768; x=1791278568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IN0tPSzGH98R2Pd3lnF+txldXvSCDJz1o/eX2B23T/w=;
        b=nVZ0zeyeWFLdn0WzLY7jUXm5sM5ARWKDh7fdyeZa0LKnTK7RmyO6Dv3dFe4cGjD6Bs
         vNBUhMb/wsH9vtRdZtNbfMPSrsR6UFPNx0Qte8TWtqhb2qFMTIiAYgUnquqOdZ8B9Aqg
         rWhWAnlVuLU7C9djzHN+nU/QnwnxsPu4wxGiv6HAdUbMT+ZVeAzKGFCpsLCodfXsRdWw
         X3e7iVViU2Sl0XDZb2AhhCT9Sp6ZkQ9kcn0tkp2BjRRLBscOYtcAwxSj5laUlbPd2dDI
         Kadep9+ngSeQjz9H3tjAeYUv7yA/CaI37T5BNwkDpXnp4gxME7K1Qfqqtq0GP2sBtk58
         nI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673768; x=1791278568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IN0tPSzGH98R2Pd3lnF+txldXvSCDJz1o/eX2B23T/w=;
        b=AeJO3stFcMH9waDBTX3UKPwSZE9sOpRae2TYEaEVsO4SQkPZc4H9DiaWGVp8W5VZdA
         XHGH92ONlXZUcwP3gbreSfi8q7rR9kmdgC8ZIgZpDPvK6LKzVljIhX3ULyr1aH+tKCS4
         F3KU4mHJxsUZ2Ql/Lg1so+P5kptOnBmrw+h6dUkyxTkbEtHSzEblRORNwfmDX6WXhcN4
         nrrdhssQDhh1SyXWyj1iBmFnCJfZnUN0CMramLVc7Uhrv46WXul+gSoJVZCcrNurMd+S
         OzATmSDlGUWfqxE+wOXoF0EsSpa597yXy2/2F5d3GfVoJDFnqMuQcU5KSNqDwkDW4lz0
         +7Lw==
X-Forwarded-Encrypted: i=1; AKwUvBza6g+URCa6S5ARqnh/cyZf/A0C7XeC+zhAA5UBSrrGV9VXGjibg+YFMwGORZhpuijs63mg3/hRfPax@vger.kernel.org
X-Gm-Message-State: AFuF++naQeRlEwL7EOD1Q0hueeaTF9FTOmY1VbICCyi6hmD1QOqIN1Vy
	ALtv5dHFjkpSYtil/uHYEXPl8hUj+/52dsIqtNUMgsmxSbYNWAxnrj24vx+kL4HUiVomkYGcsSO
	cobu+Sxyk9Ig32GQkcYAOVfcu3h/eeZk=
X-Gm-Gg: AYBFou0AIDPsXc5vyaE1BDveHGtSdBB4040391FmdmX4qeb+m/88LGSEwQWRPweWaq9
	hRbjyWt22TpQqB3i2xLSjl+hVmnKY53VsYs0gt9OgdRJmYOE4FGcRYEnfPGYZiD1+ER7Ozltuuw
	UtMEZ1B0PnfX9xM/RIRJBSBydK8BHyWiy+5h1HXLzrnNrtNmwKtQAj6JZULnG7uo9udjA1JjJT3
	kunznn+QvTo4IHBCznc7Lk47LRk6aRX08kL/bLZlR9Ds3iSIui5s3atwR9WlzkqknrAdHf9eGmS
	mYu1PoiCJmY5+Zpdts5Bwo7OunqEbqXPuxoIFgEUI5lp7K8E6QoRhCi8q/uYLcbfo4Wo4al9hF0
	vlYo3V10kkxg=
X-Received: by 2002:a17:907:e0c7:10b0:c2a:f439:f028 with SMTP id
 a640c23a62f3a-c2af439f86amr589341566b.24.1790673767797; Tue, 29 Sep 2026
 02:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924131106.1730494-1-dev.jain@arm.com> <20260924131106.1730494-3-dev.jain@arm.com>
In-Reply-To: <20260924131106.1730494-3-dev.jain@arm.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 29 Sep 2026 17:22:11 +0800
X-Gm-Features: AclHuK9DUtu6bTuANbbkm9jbY4Kl0z3X9Vvg3pkwBhg5_AJ3Q_VwlHfCh08tAEA
Message-ID: <CAMgjq7Ab0YwyPU28x+PohS=7ajPC4tguP62NDg748OwnLOx=-Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mm/swapfile: add batched version of folio_put_swap
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
> Add folio_put_swap_pages to handle a batch of consecutive pages. Note
> that folio_put_swap already can handle a subset of this: nr_pages =3D=3D =
1 and
> nr_pages =3D=3D folio_nr_pages(folio). Generalize this to any nr_pages.
>
> Currently we have a not-so-nice logic of passing in subpage =3D=3D NULL i=
f
> we mean to exercise the logic on the entire folio, and subpage !=3D NULL =
if
> we want to exercise the logic on only that subpage. Remove this
> indirection: the caller invokes folio_put_swap_pages() if it wants to
> operate on a range of pages in the folio (i.e nr_pages may be anything
> between 1 and folio_nr_pages()), and invokes folio_put_swap() if it
> wants to operate on the entire folio.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/memory.c   |  6 +++---
>  mm/rmap.c     |  4 ++--
>  mm/shmem.c    |  6 +++---
>  mm/swap.h     | 17 +++++++++++++++--
>  mm/swapfile.c | 21 ++++++++++-----------
>  5 files changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 338fce99e7119..a7e979bfc814b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5267,7 +5267,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (unlikely(folio !=3D swapcache)) {
>                 folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSI=
VE);
>                 folio_add_lru_vma(folio, vma);
> -               folio_put_swap(swapcache, NULL);
> +               folio_put_swap(swapcache);
>         } else if (!folio_test_anon(folio)) {
>                 /*
>                  * We currently only expect !anon folios that are fully
> @@ -5276,12 +5276,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 VM_WARN_ON_ONCE_FOLIO(folio_nr_pages(folio) !=3D nr_pages=
, folio);
>                 VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
>                 folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
> -               folio_put_swap(folio, NULL);
> +               folio_put_swap(folio);
>         } else {
>                 VM_WARN_ON_ONCE(nr_pages !=3D 1 && nr_pages !=3D folio_nr=
_pages(folio));
>                 folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, addr=
ess,
>                                          rmap_flags);
> -               folio_put_swap(folio, nr_pages =3D=3D 1 ? page : NULL);
> +               folio_put_swap_pages(folio, page, nr_pages);
>         }
>
>         VM_BUG_ON(!folio_test_anon(folio) ||
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a70dbc8d544e1..fa9fc8374fc26 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2159,13 +2159,13 @@ static bool ttu_anon_swapbacked_folio(struct vm_a=
rea_struct *vma,
>          * so we'll not check/care.
>          */
>         if (arch_unmap_one(mm, vma, address, pteval) < 0) {
> -               folio_put_swap(folio, page);
> +               folio_put_swap_pages(folio, page, 1);
>                 return false;
>         }
>
>         /* See folio_try_share_anon_rmap(): clear PTE first. */
>         if (anon_exclusive && folio_try_share_anon_rmap_pte(folio, page))=
 {
> -               folio_put_swap(folio, page);
> +               folio_put_swap_pages(folio, page, 1);
>                 return false;
>         }
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d5bd9506ce500..5f46061c6320c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1935,7 +1935,7 @@ int shmem_writeout(struct swap_io_ctx *ctx, struct =
folio *folio,
>                 /* Swap entry might be erased by racing shmem_free_swap()=
 */
>                 if (!error) {
>                         shmem_recalc_inode(inode, 0, -nr_pages);
> -                       folio_put_swap(folio, NULL);
> +                       folio_put_swap(folio);
>                 }
>
>                 /*
> @@ -2368,7 +2368,7 @@ static void shmem_set_folio_swapin_error(struct ino=
de *inode, pgoff_t index,
>
>         nr_pages =3D folio_nr_pages(folio);
>         folio_wait_writeback(folio);
> -       folio_put_swap(folio, NULL);
> +       folio_put_swap(folio);
>         swap_cache_del_folio(folio);
>         /*
>          * Don't treat swapin error folio as alloced. Otherwise inode->i_=
blocks
> @@ -2598,7 +2598,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         if (sgp =3D=3D SGP_WRITE)
>                 folio_mark_accessed(folio);
>
> -       folio_put_swap(folio, NULL);
> +       folio_put_swap(folio);
>         swap_cache_del_folio(folio);
>         folio_mark_dirty(folio);
>         put_swap_device(si);
> diff --git a/mm/swap.h b/mm/swap.h
> index 47290510de264..7ae915f594034 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -246,7 +246,8 @@ extern int swap_retry_table_alloc(swp_entry_t entry, =
gfp_t gfp);
>  int folio_alloc_swap(struct folio *folio);
>  int folio_dup_swap_pages(struct folio *folio, struct page *page,
>                 unsigned long nr_pages);
> -void folio_put_swap(struct folio *folio, struct page *page);
> +void folio_put_swap_pages(struct folio *folio, struct page *page,
> +               unsigned long nr_pages);
>
>  /* For internal use */
>  extern void __swap_cluster_free_entries(struct swap_info_struct *si,
> @@ -375,7 +376,8 @@ static inline int folio_dup_swap_pages(struct folio *=
folio, struct page *page,
>         return -EINVAL;
>  }
>
> -static inline void folio_put_swap(struct folio *folio, struct page *page=
)
> +static inline void folio_put_swap_pages(struct folio *folio, struct page=
 *page,
> +               unsigned long nr_pages)
>  {
>  }
>
> @@ -478,6 +480,17 @@ static inline int folio_dup_swap(struct folio *folio=
)
>                                     folio_nr_pages(folio));
>  }
>
> +/**
> + * folio_put_swap() - Decrease swap count of all swap entries of a folio=
.
> + * @folio: folio with swap entries bound.
> + *
> + * See folio_put_swap_pages() for more information.
> + */
> +static inline void folio_put_swap(struct folio *folio)
> +{
> +       folio_put_swap_pages(folio, folio_page(folio, 0), folio_nr_pages(=
folio));
> +}
> +
>  extern const struct swap_ops swap_bdev_ops;
>
>  int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 75167b8580cc0..8b47e7f1e1931 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1831,27 +1831,25 @@ int folio_dup_swap_pages(struct folio *folio, str=
uct page *page,
>  }
>
>  /**
> - * folio_put_swap() - Decrease swap count of swap entries of a folio.
> + * folio_put_swap_pages() - Decrease swap count of swap entries of a fol=
io.
>   * @folio: folio with swap entries bounded, must be in swap cache and lo=
cked.
> - * @page: if not NULL, only decrease the swap count of this page.
> + * @page: the first page in the folio to decrease the swap count for.
> + * @nr_pages: the number of pages in the folio to decrease the swap coun=
t for.
>   *
>   * This won't free the swap slots even if swap count drops to zero, they=
 are
>   * still pinned by the swap cache. User may call folio_free_swap to free=
 them.
>   * Context: Caller must ensure the folio is locked and in the swap cache=
.
>   */
> -void folio_put_swap(struct folio *folio, struct page *page)
> +void folio_put_swap_pages(struct folio *folio, struct page *page,
> +               unsigned long nr_pages)
>  {
> -       swp_entry_t entry =3D folio->swap;
> -       unsigned long nr_pages =3D folio_nr_pages(folio);
> +       swp_entry_t entry =3D folio_page_swap_entry(folio, page);
>         struct swap_info_struct *si =3D __swap_entry_to_info(entry);
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
>         swap_put_entries_cluster(si, swp_offset(entry), nr_pages, false);
>  }
> @@ -2535,7 +2533,8 @@ static int unuse_pte(struct vm_area_struct *vma, pm=
d_t *pmd,
>
>  setpte:
>         set_pte_at(vma->vm_mm, addr, pte, new_pte);
> -       folio_put_swap(swapcache, folio_file_page(swapcache, swp_offset(e=
ntry)));
> +       folio_put_swap_pages(swapcache,
> +                            folio_file_page(swapcache, swp_offset(entry)=
), 1);
>  out:
>         if (pte)
>                 pte_unmap_unlock(pte, ptl);
> --
> 2.43.0

Reviewed-by: Kairui Song <kasong@tencent.com>
