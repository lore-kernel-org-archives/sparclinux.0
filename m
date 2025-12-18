Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDA2EC0AD
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059750; cv=none; b=olBUxRT6if8ey1T/QXgFD9+UGV/mCXxt3dX8P5mpw3r7XH6K1T0OPflkBAhSPWdIum+1StO4F8CBWyKDcW24siZ0VrPVL3qfbO+Gq7hUHGbOpduy0Sofd6TtZ2sowS/Q4rTDUBJS9A+//L1CLpWa/maOIeYiGRJS78k97En44P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059750; c=relaxed/simple;
	bh=5QbkLs3eAmHI0q4F/Bjkvs+Od+TUF25IUuSwDO2KNI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMBtZd2GojaXeMgFmjzClbXRIRVFCocAaRIzl9ZVwywO1+wEjXmVvOzu5vEvGb3nMIcgUXcvR+8KcO+1uVyQ0ScY1O+l2BJh4EikVua5WcWDcoviPusn1GvbFHE9X5MKnNDtc9bh9cIb7/RgP7hfjmcQu6t2+Ukg2lgeFOs9kWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBN0Ds0v; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBN0Ds0v"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bfb84c2fe5eso216379a12.1
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 04:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766059748; x=1766664548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHE1DktcfgTgvIuicioIyZLgtx7X0c5eJ01RjbYGdSI=;
        b=UBN0Ds0v37OXHo7RzApeujOsU5+8TkTi7/Nfo2RDENxVqeuTk4a0FhFxkI2Xc10lAN
         iZfKeY1sq2uNyo/zXeohkq7jUOcLZElIo3+Cy98x3XtYNDbj14+IuUj9CiriNDx36c0X
         9auu4c/ww2RxvCU0KkBOd7lQKBPEUABSGLYCh0uXbc2k0SoxWUOhFD7lg17iIxhB0ECM
         znJsxCrDXCEAg/T/97FFBWkih3vyL3/ZRn6COpls17aYeH2z1UTkLPZheOAjbKnMCA+o
         5+HMTSvDM4K8SUmTHrCuliWUUHZKW65XiJYsDSjEKIOq3bOhMNFdtPzt5aHbXNc6FWZG
         8Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766059748; x=1766664548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHE1DktcfgTgvIuicioIyZLgtx7X0c5eJ01RjbYGdSI=;
        b=gVnYqLy4hY0LANCzpgJgop9bmmdm25I0Qls3Esn1j+KZzAdUbtqBUUaZujiSzSWWCJ
         +7/cpOyywjNcZ90bFU7g+Sr6JUbnQnchT3gw7nd11nd1H5cDbSmcq/qNb/tcf4aCXB5W
         W+QfYEeAR9UY060ceTr6UP8a8/E+ZUESbDYLdp8uhdw3evRKV0hAc+bZyn3MEydEKpnx
         TjdK8CanXRu6aRQCYgjRLoZQtky9t/P3WewQfV6lKcEDFlEgAGYcPbP3Tcwbo05We/hp
         MXyMqx0Zcu7/cIZHieQBYeC8Ecw6iRlsQuRjj43ooDvHOZhdVWStVBFBFD7vHwRh8P01
         YoRw==
X-Forwarded-Encrypted: i=1; AJvYcCVk3FP8cc5LUOwlscIuQrSlPonBkF82d6Rq3cd3Dq2IJN4x/g6UEf4ube9hdgMvkYA0n1yulyv9koun@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mW3FbSn/cJOwjb+D0WvTiH5dKRBkv45rT98LCbK1GzSdZkol
	1k7im5lbjwsbha8Fd30Zb3iWpGFWGNmTgEmCDfBDzqlujgGULnvao7acD8KDuQcxLhJYLBvm0cQ
	yFKB7/3chtSstTF4tpqkWY+noOzpXJ4M=
X-Gm-Gg: AY/fxX559mVFgI69ZBB3PitLpHyTph0OYYTfZ4n23mDA2J/Lo0WCptec/XgT3ClPH+i
	a/YhB1hOrrj1C2frngCBWRKpFtnbwl/anVjPM36zuzOFL+5Ovn+mwvFV5HwbTppUvnqgXcI8Dwi
	2wS754YUxx9+dd8DolPqIMn55ieHauXEYb6cZrsIYzMxOQivFpAk+OrR7XFBotNUfSb7BLXpe/q
	a/Xl9+EG5ImTfv5CRtlUBDxAboRLq0gnt3sDvJLUdm6ZtUvZx17ggyYBupt79KS1cg4XQ==
X-Google-Smtp-Source: AGHT+IFTTfUO30yzA2Dx4USbhYHMj0svTb/BVY1U9NRWjNhoq9m1ZU+yXheFUq02TDUzG8NzUgZV9kxNT8DNGyPr9UQ=
X-Received: by 2002:a17:90b:17cf:b0:34b:75f4:96d3 with SMTP id
 98e67ed59e1d1-34e71d80c4bmr2064722a91.5.1766059747972; Thu, 18 Dec 2025
 04:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217120858.18713-1-pilgrimtao@gmail.com> <d373f7b0-f822-4c31-990c-41a6cdc76db3@kernel.org>
 <CAAWJmAYJdEJyybVgD7erzZgvwufZ8gSmP_FCohmZLYozbhbb3g@mail.gmail.com> <d2aa6eb6-cf67-4b89-a9d4-306c720fad55@kernel.org>
In-Reply-To: <d2aa6eb6-cf67-4b89-a9d4-306c720fad55@kernel.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Thu, 18 Dec 2025 20:08:56 +0800
X-Gm-Features: AQt7F2pkmTsUiJV8lIIJaZ0vsj6lH6G4x65cGL3iKhJH2kP5ETESDd5-2fe-D1M
Message-ID: <CAAWJmAYfaic8Nj+_Zj0W9LToRBkA+77zqDTPf9iguf7B36L6qQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, kevin.brodsky@arm.com, 
	dave.hansen@linux.intel.com, ziy@nvidia.com, chengkaitao@kylinos.cn, 
	willy@infradead.org, zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 7:49=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 12/18/25 12:02, Tao pilgrim wrote:
> > On Thu, Dec 18, 2025 at 4:44=E2=80=AFPM David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
> >>
> >> On 12/17/25 13:08, chengkaitao wrote:
> >>> From: Chengkaitao <chengkaitao@kylinos.cn>
>
> ^ this is the author
>
> And you reply from a completely different address with a completely
> different name.
>
> To whom am I talking here? The patch author?

Yes, I'm the author. Due to company security policies, I have to
use two different email addresses, which I have no choice...

> [...]
>
> >> Bunch of unrelated changes that should not go in here.
> >
> > This indeed contains some unrelated code changes and removal of
> > extra whitespace. These could be split into a separate patch,
> > but the new patch might be somewhat redundant, lol. If you'd
> > like me to proceed this way, please reply confirming.
>
> We usually don't do random other stuff as part of one patch. It's a
> different story if you touch the surrounding code, but that doesn't look
> like that here?
>
> >
> >>> @@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
> >>>    EXPORT_SYMBOL(_PAGE_CACHE);
> >>>
> >>>    #ifdef CONFIG_SPARSEMEM_VMEMMAP
> >>> -int __meminit vmemmap_populate(unsigned long vstart, unsigned long v=
end,
> >>> -                            int node, struct vmem_altmap *altmap)
> >>> +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> >>> +                            unsigned long addr, unsigned long next)
> >>>    {
> >>>        unsigned long pte_base;
> >>>
> >>> @@ -2595,39 +2595,25 @@ int __meminit vmemmap_populate(unsigned long =
vstart, unsigned long vend,
> >>>
> >>>        pte_base |=3D _PAGE_PMD_HUGE;
> >>>
> >>> -     vstart =3D vstart & PMD_MASK;
> >>> -     vend =3D ALIGN(vend, PMD_SIZE);
> >>> -     for (; vstart < vend; vstart +=3D PMD_SIZE) {
> >>> -             pgd_t *pgd =3D vmemmap_pgd_populate(vstart, node);
> >>> -             unsigned long pte;
> >>> -             p4d_t *p4d;
> >>> -             pud_t *pud;
> >>> -             pmd_t *pmd;
> >>> -
> >>> -             if (!pgd)
> >>> -                     return -ENOMEM;
> >>> -
> >>> -             p4d =3D vmemmap_p4d_populate(pgd, vstart, node);
> >>> -             if (!p4d)
> >>> -                     return -ENOMEM;
> >>> -
> >>> -             pud =3D vmemmap_pud_populate(p4d, vstart, node);
> >>> -             if (!pud)
> >>> -                     return -ENOMEM;
> >>> -
> >>> -             pmd =3D pmd_offset(pud, vstart);
> >>> -             pte =3D pmd_val(*pmd);
> >>> -             if (!(pte & _PAGE_VALID)) {
> >>> -                     void *block =3D vmemmap_alloc_block(PMD_SIZE, n=
ode);
> >>> +     pmd_val(*pmd) =3D pte_base | __pa(p);
> >>> +}
> >>>
> >>> -                     if (!block)
> >>> -                             return -ENOMEM;
> >>> +bool __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
> >>> +{
> >>> +     return true;
> >>> +}
> >>>
> >>> -                     pmd_val(*pmd) =3D pte_base | __pa(block);
> >>> -             }
> >>> -     }
> >>> +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
> >>> +                             unsigned long addr, unsigned long next)
> >>> +{
> >>> +     vmemmap_verify((pte_t *)pmdp, node, addr, next);
> >>> +     return 1;
> >>> +}
> >>>
> >>> -     return 0;
> >>> +int __meminit vmemmap_populate(unsigned long vstart, unsigned long v=
end,
> >>> +                            int node, struct vmem_altmap *altmap)
> >>> +{
> >>> +     return vmemmap_populate_hugepages(vstart, vend, node, altmap);
> >>>    }
> >>>    #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >>>
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 15076261d0c2..5e005b0f947d 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -4248,6 +4248,7 @@ void *vmemmap_alloc_block_buf(unsigned long siz=
e, int node,
> >>>    void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
> >>>    void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> >>>                     unsigned long addr, unsigned long next);
> >>> +bool vmemmap_false_pmd(pmd_t *pmd, int node);
> >>>    int vmemmap_check_pmd(pmd_t *pmd, int node,
> >>>                      unsigned long addr, unsigned long next);
> >>>    int vmemmap_populate_basepages(unsigned long start, unsigned long =
end,
> >>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >>> index 37522d6cb398..bd54b8c6f56e 100644
> >>> --- a/mm/sparse-vmemmap.c
> >>> +++ b/mm/sparse-vmemmap.c
> >>> @@ -407,6 +407,11 @@ void __weak __meminit vmemmap_set_pmd(pmd_t *pmd=
, void *p, int node,
> >>>    {
> >>>    }
> >>>
> >>> +bool __weak __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>> +
> >>
> >> Reading that function I have absolutely no clue what this is supposed =
to
> >> do. :)
> >>
> >> Also, why are you passing pmd+node when sparc ignores them completely
> >> and statically returns "true" ?
> >
> > The pmd+node is indeed unnecessary. My original intention was
> > to provide convenience for future architecture extensions, but
> > upon reflection, this appears to be a case of over-engineering.
>
> Jup.
>
> >
> >> If you can tell me what the semantics of that function should be, mayb=
e
> >> we can come up with a more descriptive name.
> >
> > In the SPARC architecture, the original vmemmap_populate
> > function does not retry with vmemmap_populate_basepages
> > after vmemmap_alloc_block fails. I suspect SPARC doesn't
> > support basepages, which is why we need to modify
> > vmemmap_populate_hugepages to provide an interface that
> > skips basepages handling.
>
> So, something like vmemmap_pte_fallback_allowed() ?

LGTM=EF=BC=81

--=20
Yours,
Kaitao Cheng
