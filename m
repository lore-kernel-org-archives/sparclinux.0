Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793149551E
	for <sparclinux@vger.kernel.org>; Tue, 14 Jul 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042184; cv=none; b=eofi8A4Cnmg8thKamZ3pl/J/SGa0S3NNtBVjL6hwbbQpuAwAl0+w6unxWNoph4Yiy2KTT2U3ASSbZXl03o29+yuVk/00aH0M06/4+f2KB8eEh1zMZrxfDHOsUWbd2gxDxKe8BpAQALlerZZQf1zFIviHg6EWGeaTf+156iO2JnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042184; c=relaxed/simple;
	bh=b+EJlyZCjRd+zn9R4Sh1X4jRP+azN9ASK6QXE0fMCOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKCVQhWkCc962xZdAqDXWnrT9h4lVeduQAgDOH07mRlkpjE7AcwPCrAg29PPdHTeCrMRIXjAPTHgl90DUJ3LSeuOtDi5tNVXk404Jvo6Vw1AJvnpASP9D6pEUbJoUN5E30DzhtK+6lo6dcJMlYTFe8J2YCcqKfl3vKo1nuYKqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPPAUCP4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPPAUCP4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1061354a91.2
        for <sparclinux@vger.kernel.org>; Tue, 14 Jul 2026 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784042182; x=1784646982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fwuFYnIFntaeyFiFTCtuOmdD45sxN5bbxj7Gff2yTa4=;
        b=KPPAUCP4LIdjO5XJ0zjy2zAJBq10fBFDDwlJY9GTpiAxYnLIYddoRSL3J3DqiV2P6y
         +ku+Y5iejEVZh74yQXu/qXHGwYG5tW7DUPanHDeomUKhLvdQ9xVYaRVbrSddbLJOI0ad
         Qa3CN2PzZmtaETC8zO5yZkKtPICmsqoVsAjJTpPBDiVw91s3T/y1PMupM2jzbtWqABLc
         vuMkMEHNPjyjGBPp96D51ljj1HiXb5xNpmWEkTe5pRWRrWkxeNs3m/dCydtAoDLnHP6C
         yMrnw4pGDOFin2LSg/EILdO6tpkQIxtwxT8Aq/YMZplq4BBxszdXGzHEbNOqUuiMfQt6
         xyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042182; x=1784646982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwuFYnIFntaeyFiFTCtuOmdD45sxN5bbxj7Gff2yTa4=;
        b=JFhvUBbhaxICu0prwTrQQuLBMo5t8Q9G8BAepnTNFxUyoDna6oY1qF2aojKZ+uXDvj
         hAGNT5tHKf1gjRDCx6F/KRpft4ax3A2Y3E2oLdFwO7H2DzEd6oHmQK88LPIAe1pyGppH
         vtB84ikvEJRR6GCM1j1Bvc4TPlrrvCkXChSPpiKBY1WwXFwpnj2nlufhrKrX53VqfKJA
         hSNtA5FSKTk/iCD6mQG/JR7hUtWFgWa4mgfA2fU5xVERezbRGgSUGRnAuHDWMm8fmifH
         Swox7GU1uURZu5FvKS0ZPBuR0TdSun60AcfZuc7bAn3ig+v+6z34NOZ1OFRR0IolwrBG
         74Vw==
X-Forwarded-Encrypted: i=1; AHgh+RpPbvY2LV57HSLE9J66JMnCSBmeJGKaal6NgxebA9KTzvVO6kWWW3Y5lic9DOm7NM9QuGRXSiKWT1v0@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEtdxm+s67GZIwjVTESAKmsvr8trmu3Q8nbJsINHupG3wuOmn
	DtkX0RIhzqtPDLB2mOKKQd49WATq0kqS+J9os61INkY1+JUi7zj7UcSS
X-Gm-Gg: AfdE7cmWr2pYwfKYECknJmorvgJ4slBrtj4hDf5PoU4VO6VSw+fogj4G+gqzedmTYjt
	atfFW+KKccHtYyDcMlaJ5Vzef/8rC3dzn3EkzEiFsZAJ9aXxs6Mx+zQlqKKJRxPDackwDnR75KP
	6l4Cq0GOoclXhehtOxxuDnC6q2/LCqSRyc8OIFxw6I28pns7Kt/YMGabzfgwT3GWqJlwIRxH+R2
	COX9UO2DHINy7zpPk5JVpU2uQyPFfeg6Y5sXPxlHde+6Ms+JhQPXzG1v1Rr5RD7k6qB47cb+kTE
	JKuZQpEYDbn0p7SVKCTdAzj7vrvNZOLz1XGQGCiuO/b+9me+5g/OR3FVxotC8FRXAlVeyHCOWDk
	eaqGP1vucgy0rFXVf+w+Sl9c4m9lewsQ5TKzmmMElqrfjQVZgiAJw2hu463UPV3J4cOgBMBGo7o
	7h8wQGON+MVI+YASD/rHgZUcP9Ocns5ZO9B+bI7vEK1jfx
X-Received: by 2002:a17:90b:2e8f:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-38dc7b3f8ccmr13234040a91.24.1784042181685;
        Tue, 14 Jul 2026 08:16:21 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm49794403eec.7.2026.07.14.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:16:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:16:16 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ning Sun <ning.sun@intel.com>, x86@kernel.org,
	tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
Message-ID: <alZSwAM4pwmMOeaD@fedora>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>

On Tue, Jul 14, 2026 at 03:04:03PM +0100, Kevin Brodsky wrote:
> As a step towards removing pagetable ctor/dtor calls for kernel
> mm's, move the page type updates from the ctor/dtor to
> pagetable_{alloc,free}.

Thanks for doing this patchset.

We should switch over from __folio_set_pgtable() to __SetPagePgtable()
in this patch. Ptdescs and folios should be treated as distinctly
independent of each other.

Eventually, we want to replace the memcg accounting as well, but
there's no existing API for that right now. Lets leave that as is for
now; this patchset is big enough already ;)

> __pagetable_ctor() is now empty so remove it;
> pagetable_{pud,p4d,pgd}_ctor() will be removed at a later stage.
> 
> The ctor is normally called after pagetable_alloc() (and dtor before
> pagetable_free()) so this patch should have no functional effect in
> most cases. Where calls to ctor/dtor are currently missing (e.g.
> x86's split_large_page()), this patch will ensure the page type is
> set correctly.
> 
> This patch is based on Matthew's earlier implementation linked
> below, with the difference that when freeing the page type is
> cleared in __pagetable_free(), meaning that the update is delayed
> until the pages are actually freed in the
> CONFIG_ASYNC_KERNEL_PGTABLE_FREE case. This shouldn't matter in
> practice.
> 
> Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Link: https://lore.kernel.org/r/20251113140448.1814860-4-willy@infradead.org
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  include/linux/mm.h | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 361a0d7b74c5..94f0fb1c662a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3684,6 +3684,7 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>  	if (!page)
>  		return NULL;
>  
> +	__folio_set_pgtable(page_folio(page));
>  	lruvec_stat_add_folio(page_folio(page), NR_PAGETABLE);
>  
>  	return page_ptdesc(page);
> @@ -3694,6 +3695,7 @@ static inline void __pagetable_free(struct ptdesc *pt)
>  {
>  	struct page *page = ptdesc_page(pt);
>  
> +	__folio_clear_pgtable(page_folio(page));
>  	lruvec_stat_sub_folio(page_folio(page), NR_PAGETABLE);
>  
>  	__free_pages(page, compound_order(page));
> @@ -3799,19 +3801,9 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>  
> -static inline void __pagetable_ctor(struct ptdesc *ptdesc)
> -{
> -	struct folio *folio = ptdesc_folio(ptdesc);
> -
> -	__folio_set_pgtable(folio);
> -}
> -
>  static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  {
> -	struct folio *folio = ptdesc_folio(ptdesc);
> -
>  	ptlock_free(ptdesc);
> -	__folio_clear_pgtable(folio);
>  }
>  
>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> @@ -3825,7 +3817,6 @@ static inline bool pagetable_pte_ctor(struct mm_struct *mm,
>  {
>  	if (!mm_is_kernel(mm) && !ptlock_init(ptdesc))
>  		return false;
> -	__pagetable_ctor(ptdesc);
>  	return true;
>  }
>  
> @@ -3917,7 +3908,6 @@ static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
>  	if (!mm_is_kernel(mm) && !pmd_ptlock_init(ptdesc))
>  		return false;
>  	ptdesc_pmd_pts_init(ptdesc);
> -	__pagetable_ctor(ptdesc);
>  	return true;
>  }
>  
> @@ -3942,17 +3932,14 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>  
>  static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  extern void __init pagecache_init(void);
> 
> -- 
> 2.51.2
> 
