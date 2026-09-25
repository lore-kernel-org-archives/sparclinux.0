Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFED54788
	for <sparclinux@vger.kernel.org>; Fri, 25 Sep 2026 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316927; cv=none; b=l1JUxiU0bSggkvSExXMTkQvj/jDczVvZe48Ef+ePPdvxNk/q89YYccaPQ+7VnCH1M5zw8Ah706DrtJEx9QwoaamOTdUFXgro4pKVX5KZyTZa72LK3t/HHv0ZZU0Ts14LDU8NqlSMMsXqODfhCHySSQfk10nOHRkVGpofNmR/S+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316927; c=relaxed/simple;
	bh=gqdZ3I0twQbpv5s/8nZZ6kvyVQoMjiJpq/gJD58f47I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuR3CiCYQ3Z1BAUeqsjtJ3ButRA+hLy7Ef1vOhasEXEmZTDWziTL33/HtBYgpQtPZiSFS/CSm4Ep2U1yHIGx17OaLIoHVhH9yMPmh3EMcAnF4UQSMdTe93YHR+UdLYYSGTVy2mW8yD97pWsUNEJBWQGLj7Y0DsEN6AVApMrGEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGG/6nEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGG/6nEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EAD1F00900
	for <sparclinux@vger.kernel.org>; Fri, 25 Sep 2026 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790316926;
	bh=L5szWJ3MtFuMGqlN3CGWg6+ZdC7LPkFsOBEbQomKAD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NGG/6nEsgOlLQXHfxrimzB/y/1XtYoia78hFJZ4MADrggrfL4R91Vky9V4OivC6pY
	 1asnho3iBIyikWzTU++ueE9xkNSQM5h7SOb6HEF76v+Gi6DPRgRXu7ZYkkPXMPtFSe
	 pt/zwDPYFcNGqj4064aUMSO3JON7Q+V4DgCX4B95Ea1oATElGhDR5XzwsF9TYEh5+A
	 da01CpPO5FxCi0+PQK2WIAUWpoUxt+dipTNi6PiHhyKOha6cuwQarkoj9aHKe/elUj
	 EE+kp8YyReFs87TChHFPZeWKh8go27FEGTkHQsl8PRiFoGzaCtw7Y666nl9pQK52kc
	 O8318EgYT3rlQ==
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfd70b08cso65840285a.2
        for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 23:15:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1RJyCNwtmT2cKsflwXVcqeSk5eb+GFuYP96nWwe/XJz5roN1JVM+hxpuSJ2itNMeNfvM/WQ9E5fWM@vger.kernel.org
X-Gm-Message-State: AFuF++l7y7Yz3Z0N+xpc39SNSZLRm/dGmr+p63L08QE8IOEfFp4FuKvf
	27Ur/uYJrMDQbzCy5sLSBUdSdMrWxCyl8IKx31DcNcbybYNC+pWqRd4QTxtmefK/+YkKwPmTcw6
	csYgkZlQnpRwu3ou+eeUnu681agO8110=
X-Received: by 2002:a05:620a:7102:b0:939:13bf:e861 with SMTP id
 af79cd13be357-93c474960a6mr173095285a.40.1790316925092; Thu, 24 Sep 2026
 23:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924131106.1730494-1-dev.jain@arm.com> <20260924131106.1730494-9-dev.jain@arm.com>
In-Reply-To: <20260924131106.1730494-9-dev.jain@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 25 Sep 2026 14:15:13 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xhGwxQCH4sG4=dyomRkN_PGHeW7e0uz1MsQHFW-Gs6VA@mail.gmail.com>
X-Gm-Features: AclHuK9jjlMe0ex91FLllPwWgrryVptw5UUfz3oUZuMUNZHj3oHU6V_c2FmEk5M
Message-ID: <CAGsJ_4xhGwxQCH4sG4=dyomRkN_PGHeW7e0uz1MsQHFW-Gs6VA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] mm/rmap: batch unmap anonymous swap-backed large folios
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

On Thu, Sep 24, 2026 at 9:12=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> Enable batch clearing of PTEs and batch swap setting of PTEs for anon
> swap-backed folio unmapping.
>
> Processing all PTEs of a large folio in one go helps us batch across
> atomics (add_mm_counter() etc), barriers in __folio_try_share_anon_rmap()=
,
> and repeated calls to page_vma_mapped_walk(). In general, batching helps
> execute similar code together, making the path more memory and CPU
> friendly.
>
> On arm64-contpte, batching also helps avoid redundant ptep_get() calls
> and TLB flushes while breaking the contpte mapping.
>
> The handling of anon-exclusivity is very similar to commit cac1db8c3aad
> ("mm: optimize mprotect() by PTE batching"). Since
> folio_unmap_pte_batch() does not look at the bits of the underlying page,
> process sub-batches of PTEs pointing to pages with the same exclusivity
> state, and batch set only those PTEs to swap PTEs in one go.
>
> Disable batching for sparc (because of arch_unmap_one), we will batch thi=
s
> later.
>
> Rmap accounting and reference accounting must happen when anon folio unma=
p
> succeeds. If a large folio is only partially batched or a later sub-batch
> fails, account only the pages that were actually unmapped. Put that
> accounting in __ttu_anon_swapbacked_folio() itself instead of using goto
> jumps at the try_to_unmap_one() callsite.
>
> Similarly, do the finish_folio_unmap_batch() in ttu_anon_folio() itself f=
or the
> non-swapbacked lazyfree case.
>
> If the batch length is less than the number of pages in the folio, skip
> over this batch. page_vma_mapped_walk() handles this: check_pte() returns
> true only if any of [pvmw->pfn, pvmw->pfn + nr_pages) is mapped by the
> PTE. Swap PTEs have no underlying PFN, so check_pte() returns false until
> the walk reaches the next present PTE to unmap.
>
> Remove the finish_unmap label since no goto callers are left now.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/rmap.c | 109 +++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 80 insertions(+), 29 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index fa9fc8374fc26..cdda9efd80bc3 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1966,12 +1966,13 @@ static inline unsigned int folio_unmap_pte_batch(=
struct folio *folio,
>         end_addr =3D pmd_addr_end(addr, vma->vm_end);
>         max_nr =3D (end_addr - addr) >> PAGE_SHIFT;
>
> -       /* We only support lazyfree or file folios batching for now ... *=
/
> -       if (folio_test_anon(folio) && folio_test_swapbacked(folio))
> +       if (pte_unused(pte))
>                 return 1;
>
> -       if (pte_unused(pte))
> +#ifdef __HAVE_ARCH_UNMAP_ONE
> +       if (folio_test_anon(folio) && folio_test_swapbacked(folio))
>                 return 1;
> +#endif
>
>         /*
>          * If unmap fails, we need to restore the ptes. To avoid accident=
ally
> @@ -2141,16 +2142,25 @@ static pte_t swp_pte_prepare(swp_entry_t entry, p=
te_t old_pte,
>         return swp_pte;
>  }
>
> -static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
> +static void finish_folio_unmap_batch(struct vm_area_struct *vma,
> +               struct folio *folio, struct page *page, unsigned long nr_=
pages)
> +{
> +       folio_remove_rmap_ptes(folio, page, nr_pages, vma);
> +       if (vma->vm_flags & VM_LOCKED)
> +               mlock_drain_local();
> +       folio_put_refs(folio, nr_pages);
> +}
> +
> +static bool __ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
>                 struct folio *folio, struct page *page, unsigned long add=
ress,
> -               pte_t *ptep, pte_t pteval)
> +               pte_t *ptep, pte_t pteval, unsigned long nr_pages,
> +               bool anon_exclusive)
>  {
> -       const bool anon_exclusive =3D folio_test_anon(folio) &&
> -                                   PageAnonExclusive(page);
>         swp_entry_t entry =3D folio_page_swap_entry(folio, page);
>         struct mm_struct *mm =3D vma->vm_mm;
> +       pte_t swp_pte;
>
> -       if (folio_dup_swap_pages(folio, page, 1) < 0)
> +       if (folio_dup_swap_pages(folio, page, nr_pages) < 0)
>                 return false;
>
>         /*
> @@ -2159,21 +2169,57 @@ static bool ttu_anon_swapbacked_folio(struct vm_a=
rea_struct *vma,
>          * so we'll not check/care.
>          */
>         if (arch_unmap_one(mm, vma, address, pteval) < 0) {
> -               folio_put_swap_pages(folio, page, 1);
> +               VM_WARN_ON(nr_pages !=3D 1);
> +               folio_put_swap_pages(folio, page, nr_pages);
>                 return false;
>         }
>
>         /* See folio_try_share_anon_rmap(): clear PTE first. */
> -       if (anon_exclusive && folio_try_share_anon_rmap_pte(folio, page))=
 {
> -               folio_put_swap_pages(folio, page, 1);
> +       if (anon_exclusive &&
> +           folio_try_share_anon_rmap_ptes(folio, page, nr_pages)) {
> +               folio_put_swap_pages(folio, page, nr_pages);
>                 return false;
>         }
>
>         mm_prepare_for_swap_entries(mm);
> -       dec_mm_counter(mm, MM_ANONPAGES);
> -       inc_mm_counter(mm, MM_SWAPENTS);
> -       set_pte_at(mm, address, ptep,
> -                  swp_pte_prepare(entry, pteval, anon_exclusive));
> +       add_mm_counter(mm, MM_ANONPAGES, -nr_pages);
> +       add_mm_counter(mm, MM_SWAPENTS, nr_pages);
> +       swp_pte =3D swp_pte_prepare(entry, pteval, anon_exclusive);
> +       set_softleaf_ptes(mm, address, ptep, swp_pte, nr_pages);
> +       finish_folio_unmap_batch(vma, folio, page, nr_pages);
> +       return true;
> +}
> +
> +static bool ttu_anon_swapbacked_folio(struct vm_area_struct *vma,
> +               struct folio *folio, struct page *first_page,
> +               unsigned long address, pte_t *ptep, pte_t pteval,
> +               unsigned long nr_pages)
> +{
> +       unsigned long batch_idx =3D 0;
> +
> +       while (nr_pages) {
> +               bool anon_exclusive =3D PageAnonExclusive(first_page + ba=
tch_idx);
> +               unsigned long len =3D page_anon_exclusive_batch(batch_idx=
,
> +                               nr_pages, first_page, anon_exclusive);
> +
> +               if (!__ttu_anon_swapbacked_folio(vma, folio,
> +                               first_page + batch_idx, address, ptep, pt=
eval,
> +                               len, anon_exclusive)) {
> +                       /* Restore the remaining PTEs that were cleared. =
*/
> +                       set_ptes(vma->vm_mm, address, ptep, pteval, nr_pa=
ges);
> +                       return false;
> +               }
> +
> +               nr_pages -=3D len;
> +               if (!nr_pages)
> +                       break;
> +
> +               pteval =3D pte_advance_pfn(pteval, len);
> +               address +=3D len * PAGE_SIZE;
> +               batch_idx +=3D len;
> +               ptep +=3D len;
> +       }
> +
>         return true;
>  }
>
> @@ -2186,15 +2232,22 @@ static bool ttu_anon_folio(struct vm_area_struct =
*vma, struct folio *folio,
>          * See handle_pte_fault() ...
>          */
>         if (WARN_ON_ONCE(folio_test_swapbacked(folio) !=3D
> -                        folio_test_swapcache(folio)))
> +                        folio_test_swapcache(folio))) {
> +               set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
>                 return false;
> +       }
>
> -       if (!folio_test_swapbacked(folio))
> -               return ttu_anon_lazyfree_folio(vma, folio, nr_pages);
> +       if (!folio_test_swapbacked(folio)) {
> +               if (!ttu_anon_lazyfree_folio(vma, folio, nr_pages)) {
> +                       set_ptes(vma->vm_mm, address, ptep, pteval, nr_pa=
ges);
> +                       return false;
> +               }
> +               finish_folio_unmap_batch(vma, folio, page, nr_pages);
> +               return true;
> +       }

Hi Dev,

if we look at the whole `ttu_anon_folio()` code:

static bool ttu_anon_folio(struct vm_area_struct *vma, struct folio *folio,
                struct page *page, unsigned long address, pte_t *ptep,
                pte_t pteval, unsigned long nr_pages)
{
        /*
         * Store the swap location in the pte.
         * See handle_pte_fault() ...
         */
        if (WARN_ON_ONCE(folio_test_swapbacked(folio) !=3D
                         folio_test_swapcache(folio))) {
                set_ptes(vma->vm_mm, address, ptep, pteval, nr_pages);
                return false;
        }

        if (!folio_test_swapbacked(folio)) {
                if (!ttu_anon_lazyfree_folio(vma, folio, nr_pages)) {
                        set_ptes(vma->vm_mm, address, ptep, pteval, nr_page=
s);
                        return false;
                }
                finish_folio_unmap_batch(vma, folio, page, nr_pages);
                return true;
        }

        return ttu_anon_swapbacked_folio(vma, folio, page, address, ptep,
                                         pteval, nr_pages);
}

The comment "Store the swap location in the pte" is really out of
place. Since we are already here, can we move it to the right place?

>
> -       /* nr_pages > 1 not supported yet */
>         return ttu_anon_swapbacked_folio(vma, folio, page, address, ptep,
> -                                        pteval);
> +                                        pteval, nr_pages);
>  }
>
>  /*
> @@ -2374,13 +2427,14 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
>                          */
>                         dec_mm_counter(mm, mm_counter(folio));
>                 } else if (folio_test_anon(folio)) {
> +                       /* finish_folio_unmap_batch handled internally */


let me paste the final code here:

                } else if (folio_test_anon(folio)) {
                        /* finish_folio_unmap_batch handled internally */
                        if (!ttu_anon_folio(vma, folio, page, address,
                                            pvmw.pte, pteval, nr_pages))
                                goto walk_abort;

                        if (nr_pages =3D=3D folio_nr_pages(folio))
                                goto walk_done;
                        continue;
                } else {
                        ...
                }

                finish_folio_unmap_batch(vma, folio, page, nr_pages);

                /*
                 * If we are sure that we batched the entire folio and clea=
red
                 * all PTEs, we can just optimize and stop right here.
                 */
                if (nr_pages =3D=3D folio_nr_pages(folio))
                        goto walk_done;
                continue;

I am really struggling to read the code here. For anon folios, we
handle `finish_folio_unmap_batch()` internally, while for other folios
we still do it outside. This feels a bit inconsistent.

Also, we are duplicating the code below twice:

                if (nr_pages =3D=3D folio_nr_pages(folio))
                        goto walk_done;

Can't we just do `finish_folio_unmap_batch()` like the other cases?

That would also avoid the duplication.

Best Regards
Barry
