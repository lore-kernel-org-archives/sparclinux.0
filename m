Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7281E1C02
	for <sparclinux@vger.kernel.org>; Sun, 15 Feb 2026 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771160676; cv=pass; b=QS8KOJAu1j58Mfmv5bsLhhwFt2DkRd4DOQy8+pbNgNcxRuSJLZBZcnpuYdTsieJ+gCVHwgQCLKcUnuuTow81bMAKr+5lrNVysVUW9TSKeSyJRyKgC/l/9oXAWBj8V6BxnWZ8BdMaoPFycn4KxUckEHtU917MKuVA8t5GQRiWrBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771160676; c=relaxed/simple;
	bh=D/phwRJlhrZ/+lBrZdgg3inZXG+vBEzDOUTbnMCWzxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KImAzriuMcZ8yH0AGXpkdl4cK68PEGFL5pPbLvF18SqxwLBnQ5JfCcj5+wTWUDSi8sH9El15Y+2OJ/MrIasGcD8IRDAYxbILRrdTPBkS00FT31JssWkUYWht27aySCGPYoYXff1Yuz0WYIRavi4PG+5xOuFbiv0K5GF4MxMYj0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIBKhPod; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIBKhPod"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab3b0e49a8so10270675ad.0
        for <sparclinux@vger.kernel.org>; Sun, 15 Feb 2026 05:04:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771160674; cv=none;
        d=google.com; s=arc-20240605;
        b=kjYhhbfBfeDI0x9GvDMoCm3gcPHmpg3baQJASpLm6NHIwIvHyf2iydVaD6AsQRyaDU
         v5HAkJ1DHeNeBobmEV8/JzwCBK7nnIcYsBgdaAKDZj3q4wvfRDIdsDwEYdwq/u9ievSp
         H0OO7aQcpZfknIjLJm23IaycqnfHAQPpdG+F3hjuE8ZC8mTKZGND1Pl1N0tmNNN/SIko
         htfhcY3K7g3n5K0iau0YXMAPD1cdF8sx6SapY4K+FmlRJ7PdtGbrmRRwC8+qszQkUz/L
         lxNY/C56JYXW3UaZfb7ahRLQcBBwNrJsDcHqDhrtQMlkvkC7a6qdLvX3rIofnGZfc4nI
         HWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/kAfsVURHjtL1SjXKf5qAuSO+4oS4zBs7/TyPRXPRRQ=;
        fh=tveDD8DhWB8vL3DpoYxaeqTmM7Tc47NzSRioNARGq6s=;
        b=fOMLJ8O689p7/EIEomzS/R/RIa/qeXofjftSyqkpQ/sjP1GSimstxi5kVoDvL5J6JC
         KWr+gZVKTtiM5I/p0BSHcfIu8l6YgZX6+ay6Cb0K8FHTZ/siUf58mrnXRwDP6VszxRpI
         5Tt+Hp4j9R4xiCKLclkP5SmLaKg2Xp0O8IV1lQMIwode7UL3Oqqobtn8aeCcTC9T7hPm
         ugbS1VsezrrIbvu0coVDsMR/Dh4F52VnmoNm5cctykyThgoztLEnUCepLHHCy9atzSb3
         jMywGw7FNla5xIeYKHki6pL2Ds7PRT3dBqkqVLuby3hLaGmD2T/Spn61wrTkGPHOLDVr
         hCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771160674; x=1771765474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kAfsVURHjtL1SjXKf5qAuSO+4oS4zBs7/TyPRXPRRQ=;
        b=ZIBKhPodT4FVFPaG92wcYS6WkVuHh0gPIOPKZixUU3LnkAYmdwyfEMSGzBznmVNiAs
         qIZkpKtD6kSlzOcYEJDy8ovyE8dip6jRQo8YVUoyiJ6gtOMJDEXvbvL27aF17o7OC48L
         eYQVHbcnCC3wQERl+p9Slh6ePjH4uAU2s7LpZ8Hl0ppHvd9TzZJQg/n5LNMPNUgaPWUF
         d5ai40r2A3z29j9ou+IR6GhD2qmMcjkCBCU87IiOszODOwgDbNxvtM4gu8DVllL+EfVp
         wBd6/bor69pGqOZmWBIwNtl6IymtWL7L4fWjoOIL6dQxYLayJvhxluOUxOfhG2mXL8LP
         6O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771160674; x=1771765474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/kAfsVURHjtL1SjXKf5qAuSO+4oS4zBs7/TyPRXPRRQ=;
        b=a22+q4fOPAKEgw4W1RI1T4Qr6CS3tijDbwEDkVct8hWnrBYgLoRja7kdHBlexV6Lor
         sQL7ztIR5XJwy53i9w+kyqc0ovLrsn50+WNf5kZ4wEe/GX//Ub9Sfufl0qJaXLS+TBpP
         ZL0+KwiXlCLkWpFxPx1H795FzkF09D0pWkdGyo3dkTjOwZjJPwg84xzJZt0UJimm+M2c
         Hho3kBLK0eHE1BDx2re8nuGzMKbB2Yq0cEaIVLr6GlOsaHobdAhZV9RJvifzLZivxnnD
         +05+h/mPgI/V/udpxo/CW6IlbQx05F3sfAMVXIbJSa3NkLeQ/Ya/JLQ30rXqHMKwUDmj
         I9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXzzKUqz+6vE18L0+gvicMeFckMSNr51IPFitEJT+Z0+iQtM6guFu5obp2vwhYUyzrtWRC/z83Mylyv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0hFNuz1V/vl2gtAthomKkmN+w91NiMjVg1mpSKsEpEi3EVAM2
	Awg/ZC0EYKMaiBXkc9BUGQqt4dEm4BDupwzSPPMI/ECj17ZqzrfNuBU8g3cqTkxiCfJ1D7K+4tF
	8w86eAFwR4iGJPsTKnWj+cU0SeEbQbJVdT8EE
X-Gm-Gg: AZuq6aJhVwPbr1oZl/WeZAl9+BkC+CllJDh1DLIto7s+DPyAJmmmW3NcSqiDq8SpXaq
	4Lm90DcKzs7KbIns7+96LSTM0cgP7yHcRRmQEw8TzAq+4y2OqFygchXIldCTA4F3AVzEgtm8L9Z
	EMwO+xVduGVOV3JLL1heUiyS51qPA1bWfA5mSTi7csXBx6iPNk7s9qNhH0lFxRnqj7UKpHYEj5E
	26H7mNK8th5xoBJZhILS+OpbLlFTcs74SrJ8NpujGrSnZTLusH7Rp3HlbR8MgCpejqqjOJjQ4pt
	oIP65A==
X-Received: by 2002:a17:903:22c7:b0:2a4:8cd:c3cf with SMTP id
 d9443c01a7336-2ad17570671mr52720985ad.49.1771160673702; Sun, 15 Feb 2026
 05:04:33 -0800 (PST)
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
Date: Sun, 15 Feb 2026 21:04:22 +0800
X-Gm-Features: AaiRm515p7wM45fzFdzJOfFAX4z0PPQknnxh8KEacuRNrwbe5LM6_K1ydvVjsk4
Message-ID: <CAAWJmAZpk7dj1CgDMRtkUAf6C-uc6FQKX32+v3BgXN=3NQv1yQ@mail.gmail.com>
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

Hi Andreas Larsson,
Regarding my previous responses to the questions raised in this
email thread, I have not yet received your reply. I would like
to provide additional clarifications on these points here:

> Nit: use active language, "reimplement", not "reimplemented".

This issue has been fixed in version v6.
https://lore.kernel.org/all/20260201063532.44807-2-pilgrimtao@gmail.com/

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

In the implementation of vmemmap_populate_hugepages, the start
value remains unaligned when entering the for-loop for the first
time. However, there is no need to apply the "start & PMD_MASK"
operation in the vmemmap_*_populate series of functions. In
iterations after the first one, pmd_addr_end() will align the
start value; since start is already aligned, there is no longer
a need to align end.

In fact, in the original code, the presence of
"vstart =3D vstart & PMD_MASK" made "vend =3D ALIGN(vend, PMD_SIZE)"
redundant as well.

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

Since the vmemmap_*_populate functions all use vmemmap_alloc_block_zero
when allocating page tables, (pmd_none(pmdp_get(pmd))) can be used as a
replacement at this point.

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

This issue has been fixed in version v6.
https://lore.kernel.org/all/20260201063532.44807-2-pilgrimtao@gmail.com/

> 2) Trying sparse_buffer_alloc() before vmemmap_alloc_block(), which was
>    not done before.

The sparse_buffer_alloc function here is usable.
Both sparse_buffer_alloc() and vmemmap_alloc_block() essentially
call memmap_alloc(), the only difference is that sparse_buffer_alloc
performs the allocation in advance.

> Neither the commit message nor the cover letter touches upon this. Could
> you elaborate here?
>
> Given all the (at least seeming) functional changes could you share how
> you tested this change?
>
> Cheers,
> Andreas
>

Is there still a possibility for this patch to be merged into the
mainline? Should I continue modifying and iterating on it? Could
you help with testing it?

Regardless of your answer, I look forward to your reply.

--=20
Yours,
Chengkaitao
