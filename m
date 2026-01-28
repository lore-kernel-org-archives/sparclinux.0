Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E043215F5C
	for <sparclinux@vger.kernel.org>; Wed, 28 Jan 2026 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570759; cv=pass; b=hXhf1zriTl7jYEzdecmVs64ieO8TyKL95lba+ZRwIpi3BKOPfxQ894Wurfd4IisXBTAGNxn+RLzH35UUCw7e1/xjNkrIdKdW6OHfIgEb3uqWZP1x+E1KphQ48EICOaZAlzsUaRHSHSgMoTJBUIHGbXxgDoTA4OnpWe6oVs6frCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570759; c=relaxed/simple;
	bh=cwCVkzPTCpDjD+rbXT/hgUVDRHxSnAYdGksCW9r6RFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaC8V/fU8OJeEbK2Ho5h4XCotvmn10WK7onGO8hB5ItH6osef4QLZ8kKJw+hJ4pAVUaeatKSKMU1pSGrlelWQDy0AB/Oaysm70JW7w4bGviKgmrwJ68hQ5ROYAlE7hAA+9JhRDf2RqNf296GTgdG3tiNl74hb++MA+m8v4hRfD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuNeXlLw; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuNeXlLw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so5158591a91.1
        for <sparclinux@vger.kernel.org>; Tue, 27 Jan 2026 19:25:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769570757; cv=none;
        d=google.com; s=arc-20240605;
        b=FqKeQuDCHe+oQ1VMhL6/8qyy+DLnV8dj5ieaiZr/UTu3d5o2DPY7beW97dU3SaaeGc
         2AGJa4mYKUhwLgEAwt0itc+oVgwaknacYcvEV3h0g2VpSxHa5tCLeIBue4xuvnJKZnnI
         hskx1SwliP7AY9bT5w/jxpLecLejZNkQFbYJ5zjcFLd1wBr6jDmqQs613uZQCvBdyAbG
         pPbC3L1kspn9ywXc9qPep6+XZkMxacPRDkWIvXgCzDo2lXTqKVkSSm2iKXmhkV0tM6BC
         dLk0dMYAp0PsSrd+fFb3zOunRXWDnqZLo2C52EHvGgb2vNQwZiezzfy+g4ULL9ngopXW
         ng3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aoGoz2eY2Z5cScS79bGBONPFBBMwxV4aMlRLmXnwIds=;
        fh=iTJMaw97UDCZJvGhTbDCgCPaj8Hs97TMqBcaLtVSmIw=;
        b=RMthfdTLKKsbjuuOpGUa6i9Qa/bkz5GudXK4N07Y9IPrNO+4BiU6rI3j17tFXv6RMp
         bLwUlmWq9mVT6ohtQTUt+z+/xHenL6dSyHs8XBq8382h8RGa0mKRWhqrIZsoU9yOgy1G
         oBPr8OTfolKMj6dh3qf+2JtytJfO/f2jbEAr8vday/I31buk83wQkGyTtm+vl+p5EfNb
         AynIjitJLSS33rfSlDH2UMHlX9JRK8/4h/H4S0AZSnHG0gua/B/ko6K66sx3Ycb/1YU+
         4oey0u91A9qpHdX0p1eXeItNw/ixD+IwQ7/V8rP1ho97HKZYUURvzH+pNgwrFofF3d2k
         f8pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769570757; x=1770175557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoGoz2eY2Z5cScS79bGBONPFBBMwxV4aMlRLmXnwIds=;
        b=kuNeXlLwRX2vH4QCtr8ddhDW98q6yzuJPalsuEokKhusAA7rNhMRS/efBmIUSj6ENx
         E0Ql/dv6qQ1z41SQc7Q5XLyLW4vbPNFjdq4o/GAIMplPPmfkYlJfdyivaSfWssLklzKj
         HPlaAQFlj+BHdeztxnWBdhY8srafYoCTlwAYcdkO2ha+p5Ug6regaVUQA80Wpt/Gr0Ht
         LOGHRPNyCpb95DZ2PswSOHvyJNseHCqDQyH0pCWrLpon24YJNgTtUBkC2phMNBCBg3j1
         LjkKYxLigpl3RL9UIxTvnH6zoJJzdcqvo8Fr/MNkssT6Qn1Z0gRvrTxf/i49KRAABFUh
         i9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769570757; x=1770175557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aoGoz2eY2Z5cScS79bGBONPFBBMwxV4aMlRLmXnwIds=;
        b=OmRzkxj95jbTrc++/GZ2DmlUbzr7ycufFQwKwBZgLOFo6NuBgj7U7VpAQdzbbBK7FY
         qtBIBkCyMimxL/OdzQodrrMDQRH61hXE+aObo1s+A4LCrFUATt2v5U5n132w59jfZMkv
         Fg9vfeuHYDFmRnDsU793EbFXmQ+kXWtCggNLKGN4bAVgZo2TPrBml+X+5C36XgI5pMNI
         jsf8FWkLZ+9YzHDK0GO+dpEQ5LGWTJuoKCYDPx+TZj/P+q3XRFDanC3KPduCQQwRfvR+
         PikXAy67G0o4QkfhelRWLgB4Mr71HKfrEo0+YDzuHFAm3m/NHaDXuw0F5KGyHnuYNE1J
         qHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMXzuwejZV9XfbB5crQngomnDJlW5/6u/IZlDjwqqEbzR+Zv7oikirqOtrhPOTgA8+x3V8H71esFbt@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1ZoHkOlFCemVDMwj0rawhiu9Twhog7dsWBWIqLTpdeCou63d
	qlS9ORyNYqqc1hXeAvbYqkMkREoFTd10wtfaZU1h/nlgZuFUz2YxkTf0hlJ4DMJEyJ5RDkVflRw
	Y/P1vyHUdhuSxwWygcP0GBq4FhURM950=
X-Gm-Gg: AZuq6aIi0/89V4jL676i6KTtesPr+mb5XseWtkLGzJIVHQE5xFZuu4FlnuBe2rpvb3X
	atphQ8AAxEgjWEo+AKIzXemHdVIDDynVv1wLS/zfCXrqyhAfpNWn50PlwVLU6PB5h8eJsQWbzK7
	KntVXeICb42vcFIUrfC3tFQ+B/yAQtXozhop9eSzDfWuAK8HndLvoVwzGXBz8dfvjEYyvoRBywj
	v3XpCqP8+5cHHl80gsBU1baPRUJjXKuLNe2cOLLSYVmAGWNtWsxFROh6WoFPVOwEZUTwA==
X-Received: by 2002:a17:90a:e990:b0:353:883:aff6 with SMTP id
 98e67ed59e1d1-353fed846f5mr2705765a91.20.1769570757348; Tue, 27 Jan 2026
 19:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111074453.66728-1-pilgrimtao@gmail.com> <20260111074453.66728-2-pilgrimtao@gmail.com>
 <aaf30e1e-be55-4212-b096-69f71bafd406@gaisler.com>
In-Reply-To: <aaf30e1e-be55-4212-b096-69f71bafd406@gaisler.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Wed, 28 Jan 2026 11:25:46 +0800
X-Gm-Features: AZwV_QhgQy9ZJdV5p3jCCt7MradNH2YcIqn0iOIIzYeURQTKXe5ygQBurmDKREs
Message-ID: <CAAWJmAYmMtdE7nSJ8BWSnt2DObipqGi_KdXdMJrHfwc0ANBSPQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
To: Andreas Larsson <andreas@gaisler.com>
Cc: davem@davemloft.net, akpm@linux-foundation.org, david@kernel.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, kevin.brodsky@arm.com, 
	dave.hansen@linux.intel.com, ziy@nvidia.com, chengkaitao@kylinos.cn, 
	willy@infradead.org, zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 10:50=E2=80=AFPM Andreas Larsson <andreas@gaisler.c=
om> wrote:
>
> On 2026-01-11 08:44, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > 1. In the SPARC architecture, reimplemented vmemmap_populate using
> > vmemmap_populate_hugepages.
> > 2. Allow the SPARC arch to fallback to vmemmap_populate_basepages(),
> > when vmemmap_alloc_block returns NULL.
>
> This patch seems to potentially make more functional changes than what
> the descriptions gives impression of.
>
> Given the amount of changes this seems to introduce, more on that below,
> I'd like to see more description on the changes and why they can be done
> than this.
>
> Nit: use active language, "reimplement", not "reimplemented".
>
>
> > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/sparc/mm/init_64.c | 47 ++++++++++++++---------------------------
> >  1 file changed, 16 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> > index df9f7c444c39..858eaa6615ea 100644
> > --- a/arch/sparc/mm/init_64.c
> > +++ b/arch/sparc/mm/init_64.c
> > @@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
> >  EXPORT_SYMBOL(_PAGE_CACHE);
> >
> >  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> > -int __meminit vmemmap_populate(unsigned long vstart, unsigned long ven=
d,
> > -                            int node, struct vmem_altmap *altmap)
> > +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> > +                            unsigned long addr, unsigned long next)
> >  {
> >       unsigned long pte_base;
> >
> > @@ -2595,39 +2595,24 @@ int __meminit vmemmap_populate(unsigned long vs=
tart, unsigned long vend,
> >
> >       pte_base |=3D _PAGE_PMD_HUGE;
> >
> > -     vstart =3D vstart & PMD_MASK;
> > -     vend =3D ALIGN(vend, PMD_SIZE);
>
> It seems that this patch removes alignment of both start and end. Is
> this a functional change in practice or are these always aligned for
> some other reason?
>
Whether vstart and vend are aligned with PMD_SIZE doesn't seem to
affect the behavior pattern or output of vmemmap_populate_hugepages.
The vmemmap_populate_hugepages function performs necessary alignment
processing internally, such as pmd_addr_end and pmd/pte_index?

> > -     for (; vstart < vend; vstart +=3D PMD_SIZE) {
> > -             pgd_t *pgd =3D vmemmap_pgd_populate(vstart, node);
> > -             unsigned long pte;
> > -             p4d_t *p4d;
> > -             pud_t *pud;
> > -             pmd_t *pmd;
> > -
> > -             if (!pgd)
> > -                     return -ENOMEM;
> > -
> > -             p4d =3D vmemmap_p4d_populate(pgd, vstart, node);
> > -             if (!p4d)
> > -                     return -ENOMEM;
> > -
> > -             pud =3D vmemmap_pud_populate(p4d, vstart, node);
> > -             if (!pud)
> > -                     return -ENOMEM;
> > +     pmd_val(*pmd) =3D pte_base | __pa(p);
> > +}
> >
> > -             pmd =3D pmd_offset(pud, vstart);
> > -             pte =3D pmd_val(*pmd);
> > -             if (!(pte & _PAGE_VALID)) {
>
> It is not the same thing, but is this equivalent to if
> (pmd_none(pmdp_get(pmd))) at this point?
>
For PMD entries, there shouldn't be cases where pmd_none and
_PAGE_VALID exhibit inconsistent behavior. I've observed that
pmd_none is widely used in the SPARC architecture.

> > -                     void *block =3D vmemmap_alloc_block(PMD_SIZE, nod=
e);
> > +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
> > +                             unsigned long addr, unsigned long next)
> > +{
> > +     int large =3D pmd_leaf(*pmdp);
> >
> > -                     if (!block)
> > -                             return -ENOMEM;
> > +     if (large)
> > +             vmemmap_verify((pte_t *)pmdp, node, addr, next);
> >
> > -                     pmd_val(*pmd) =3D pte_base | __pa(block);
> > -             }
> > -     }
> > +     return large;
> > +}
> >
> > -     return 0;
> > +int __meminit vmemmap_populate(unsigned long vstart, unsigned long ven=
d,
> > +                            int node, struct vmem_altmap *altmap)
> > +{
> > +     return vmemmap_populate_hugepages(vstart, vend, node, altmap);
> >  }
> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >
>
>
> This change introduces using vmemmap_alloc_block_buf() instead of
> vmemmap_alloc_block() seems to introduce two new behaviours that was not
> in use for sparc64 before:
>
> 1) Using altmap_alloc_block_buf() for a non-null altmap, that was not
>    used before. Also the fallback to vmemmap_populate_basepages() passes
>    on altmap.

If altmap validation isn't required, I can retain the original code
logic by setting altmap to NULL.

> 2) Trying sparse_buffer_alloc() before vmemmap_alloc_block(), which was
>    not done before.

In SPARC, sparse_init() is called to initialize the sparsemap_buf.
If the SPARC architecture doesn't support using sparse_buffer_alloc,
we can remove the sparse_init() call path.

> Neither the commit message nor the cover letter touches upon this. Could
> you elaborate here?
>
> Given all the (at least seeming) functional changes could you share how
> you tested this change?

My original intention was to help architectures adopt more generic
kernel APIs to reduce maintenance costs. However, due to my lack of
physical SPARC devices, I couldn't perform comprehensive testing,
I've only verified compilation correctness based on code analysis.
I sincerely apologize for this limitation. If you have access to
physical SPARC hardware, could you kindly help with testing?

--=20
Cheers,
Chengkaitao
