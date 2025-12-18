Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589431353D
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055772; cv=none; b=aBA5ZkLnRC4Uvi3urAGj9ke8C1CwvcSU4uoJa0J7EK98tMuqAyAji2DzEdnyjjmSSGJlsCJfnbpi9sgFKnPprCRu5bWIiXCqyEwNTYXmQ7lEBirGjHj8fTYlzUG05xpYJ11uqJMk+UWdZeoaiJHf26srE739FgCedkBAeafEM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055772; c=relaxed/simple;
	bh=MY11Aj6Je8xCLlSecCA9metsKmBglYUSv1YI+81TBWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds7Mr97yY+l1xAHY3YZ/T2n8NIBMZT86KOyQIfM+fr/D5vu7/aFa9zCHqvkL8Bc6iuNaYyAakEVM9j82TXLofj/t/YZU4RrhwtU5Zb81MxjR/8U4tvUMy3VJ+nIU3bLqRt/Ipg2X/275wnBfUT26VjpWOR9H6NUyKExS0jZTfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEw73wuM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEw73wuM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d6f647e2so7833705ad.1
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766055770; x=1766660570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En+EeawiMP0LdiaonSFSpPBJQktT87DSvgUkdcBwHPI=;
        b=WEw73wuM26ezDkT/HmQqnq2hPJgngFdFNBQa5wcNgGYZZ6Jy46zU6SxFV5HNsdavQk
         jzE4hRaj6nH8mPWB2TBah5e7jlT973VM15VVcBoEqpjpF6aJtKwHgGZHqrons/CEy6H3
         kxtuWrS4VZJTp/DhTWZn3tF7S9yST6BCVoi6muhDNhdsDbH9QNL3GeCyr0snEiXBuW6z
         athnJ/OLXuZXQ+GVHgCD+Wo9Ir6OIQD04YMwGySrb0dQjNn89CNh2YtUcF/O3hNfBYcG
         UAg/j1mPcM2/5idSqa1jeFED23n5m6n9LCnmva2Q4oPdYILd07EXWW9uDuBsNFHGxb43
         8MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766055770; x=1766660570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=En+EeawiMP0LdiaonSFSpPBJQktT87DSvgUkdcBwHPI=;
        b=S5K6L9zbgbn9WLvegASZeyOFerQe+0PUEblHDdr97+CuHJPz8I/mRWEPWPj08/Ho0H
         c9RwZMJ5B0dKBoBCbzNGyp+HPjaCrIUzF87f+ehypYAbXB8slI85SgADmB7HVbsDMaL7
         qBMZkybx5FouIrVnDcqF/E3ViYyoN6Oqu9zGOxGR/LidynJ3UQ7upGBDXNgCJe1epBae
         w8YSHLJ9NhdAmpYu0oQlBcreyG2Bfs6OVecAXtKHAHc2hup01doNxEwtg8amOAPMVTpV
         dKnVwp1TUmcCR4AtVr4rLsvoeWxk8FEO0G7lWS5ROQ88Pj2BJfM0c04BpQ41c3HMVxpY
         NmDA==
X-Forwarded-Encrypted: i=1; AJvYcCUG+5VO5yKBAORv+j4uGpJZV1UFmMCghAGHrRUegCJqhs0XLDTfz9FdjWHHKkGOs7NGlWwX7DNT+2Jf@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPuZGWEm9IWErk0agH55QAI1IDwgVfqxiX8OV2zkjPwtzFKYJ
	NjxXkJv2gY6/XD8N19qzseexNioKBaP7V44KZf6I4598bMJERLxnbHVNP2tcT9k6mpIVzLwpfuF
	jddc1djuKrDi4/Luc4FVhYg7UHqJbXDo=
X-Gm-Gg: AY/fxX5Tgz+NV14eanNGPVdEFimYEXx6ayDhcgUE6SeyKKkzEZnRp/KCJfCba+svBsy
	yCq8zia7flBIuyA8MEymPaG9BOREWICFa1yAU1geVBk/UJ13Gld6KpUPUtr8WpVrZJWBl4Q9sjj
	NFSugQnLvslYppjuEeEfijIjb9LPGSTc5qFITl3OZpkQP+tzQ8OxQWpsV4+40G2IqA1pRKkg2VJ
	9OPO83b9POBEsPIrVXZKobycJ/usk5QQm+dhv/EcOgN8z2Rlihuz4kRvYCLNCQB2YL4+w==
X-Google-Smtp-Source: AGHT+IH1/DrYChO2Gun9o9bXvGbxXOFiFy9ttJqooM/uiUGdaYOlzL1RUFDLa7LiwEssz2HZQDik54yEGJN9oN42ooI=
X-Received: by 2002:a17:90b:3912:b0:33b:be31:8194 with SMTP id
 98e67ed59e1d1-34abd7bae4bmr17935657a91.34.1766055769647; Thu, 18 Dec 2025
 03:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217120858.18713-1-pilgrimtao@gmail.com> <d373f7b0-f822-4c31-990c-41a6cdc76db3@kernel.org>
In-Reply-To: <d373f7b0-f822-4c31-990c-41a6cdc76db3@kernel.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Thu, 18 Dec 2025 19:02:38 +0800
X-Gm-Features: AQt7F2p1oM-UBi3ufPsqgWlQ-JAwKfsIrRnsxPaSt1TZSRjeGmYZiIlx4BsjFqA
Message-ID: <CAAWJmAYJdEJyybVgD7erzZgvwufZ8gSmP_FCohmZLYozbhbb3g@mail.gmail.com>
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

On Thu, Dec 18, 2025 at 4:44=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 12/17/25 13:08, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > 1. Added the vmemmap_false_pmd function to accommodate architectures
> > that do not support basepages.
> > 2. In the SPARC architecture, reimplemented vmemmap_populate using
> > vmemmap_populate_hugepages.
> >
> > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > ---
> >   arch/sparc/mm/init_64.c | 56 ++++++++++++++++------------------------=
-
> >   include/linux/mm.h      |  1 +
> >   mm/sparse-vmemmap.c     |  7 +++++-
> >   3 files changed, 28 insertions(+), 36 deletions(-)
> >
> > diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> > index df9f7c444c39..a80cdfa6ba98 100644
> > --- a/arch/sparc/mm/init_64.c
> > +++ b/arch/sparc/mm/init_64.c
> > @@ -5,7 +5,7 @@
> >    *  Copyright (C) 1996-1999 David S. Miller (davem@caip.rutgers.edu)
> >    *  Copyright (C) 1997-1999 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
> >    */
> > -
> > +
> >   #include <linux/extable.h>
> >   #include <linux/kernel.h>
> >   #include <linux/sched.h>
> > @@ -2397,11 +2397,11 @@ void __init paging_init(void)
> >        * work.
> >        */
> >       init_mm.pgd +=3D ((shift) / (sizeof(pgd_t)));
> > -
> > +
> >       memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
> >
> >       inherit_prom_mappings();
> > -
> > +
> >       /* Ok, we can use our TLB miss and window trap handlers safely.  =
*/
> >       setup_tba();
> >
>
> Bunch of unrelated changes that should not go in here.

This indeed contains some unrelated code changes and removal of
extra whitespace. These could be split into a separate patch,
but the new patch might be somewhat redundant, lol. If you'd
like me to proceed this way, please reply confirming.

> > @@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
> >   EXPORT_SYMBOL(_PAGE_CACHE);
> >
> >   #ifdef CONFIG_SPARSEMEM_VMEMMAP
> > -int __meminit vmemmap_populate(unsigned long vstart, unsigned long ven=
d,
> > -                            int node, struct vmem_altmap *altmap)
> > +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> > +                            unsigned long addr, unsigned long next)
> >   {
> >       unsigned long pte_base;
> >
> > @@ -2595,39 +2595,25 @@ int __meminit vmemmap_populate(unsigned long vs=
tart, unsigned long vend,
> >
> >       pte_base |=3D _PAGE_PMD_HUGE;
> >
> > -     vstart =3D vstart & PMD_MASK;
> > -     vend =3D ALIGN(vend, PMD_SIZE);
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
> > -
> > -             pmd =3D pmd_offset(pud, vstart);
> > -             pte =3D pmd_val(*pmd);
> > -             if (!(pte & _PAGE_VALID)) {
> > -                     void *block =3D vmemmap_alloc_block(PMD_SIZE, nod=
e);
> > +     pmd_val(*pmd) =3D pte_base | __pa(p);
> > +}
> >
> > -                     if (!block)
> > -                             return -ENOMEM;
> > +bool __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
> > +{
> > +     return true;
> > +}
> >
> > -                     pmd_val(*pmd) =3D pte_base | __pa(block);
> > -             }
> > -     }
> > +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
> > +                             unsigned long addr, unsigned long next)
> > +{
> > +     vmemmap_verify((pte_t *)pmdp, node, addr, next);
> > +     return 1;
> > +}
> >
> > -     return 0;
> > +int __meminit vmemmap_populate(unsigned long vstart, unsigned long ven=
d,
> > +                            int node, struct vmem_altmap *altmap)
> > +{
> > +     return vmemmap_populate_hugepages(vstart, vend, node, altmap);
> >   }
> >   #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 15076261d0c2..5e005b0f947d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4248,6 +4248,7 @@ void *vmemmap_alloc_block_buf(unsigned long size,=
 int node,
> >   void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
> >   void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> >                    unsigned long addr, unsigned long next);
> > +bool vmemmap_false_pmd(pmd_t *pmd, int node);
> >   int vmemmap_check_pmd(pmd_t *pmd, int node,
> >                     unsigned long addr, unsigned long next);
> >   int vmemmap_populate_basepages(unsigned long start, unsigned long end=
,
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index 37522d6cb398..bd54b8c6f56e 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -407,6 +407,11 @@ void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, =
void *p, int node,
> >   {
> >   }
> >
> > +bool __weak __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
> > +{
> > +     return 0;
> > +}
> > +
>
> Reading that function I have absolutely no clue what this is supposed to
> do. :)
>
> Also, why are you passing pmd+node when sparc ignores them completely
> and statically returns "true" ?

The pmd+node is indeed unnecessary. My original intention was
to provide convenience for future architecture extensions, but
upon reflection, this appears to be a case of over-engineering.

> If you can tell me what the semantics of that function should be, maybe
> we can come up with a more descriptive name.

In the SPARC architecture, the original vmemmap_populate
function does not retry with vmemmap_populate_basepages
after vmemmap_alloc_block fails. I suspect SPARC doesn't
support basepages, which is why we need to modify
vmemmap_populate_hugepages to provide an interface that
skips basepages handling.

--=20
Yours,
Kaitao Cheng
