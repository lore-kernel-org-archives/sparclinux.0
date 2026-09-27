Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A53BB69F
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790547967; cv=pass; b=pF6S4G5+D5FWfG/VQJTBS1dpF/bZKMkQL87lsZRd/aTnH944sa5e9TU1xnox780nptscu5jmZf6zEwiOmkdqprxZLdjJObg6Cu2vgJtbce2sMi2utz4KQ94B1tAQ7gk6bCNHhWOdanyAoOvPj2le80rMnbab6hrmR2T9wHnVJBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790547967; c=relaxed/simple;
	bh=2bDuw0+wNhe+WPzHFiOFAlgXEGE/uaBtJ+Rl0pqmcRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smuZ/0TP+Gzv5YguRqA5y8UmBV+86Hws2cF1ip+vVx5rE1DnUXevEOuMWiajYO/rOF4BtTrZjxTWMHe5zECgCqNfRwoua2B/5z8ucBt7fw5YC0sXtcsPiuJ0hM/Dngk2DOkU8XspS314uNkJWkhkcBXab8G3GrCzX53RBtmDgPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpbiqDdg; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpbiqDdg"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf5e6878fso2821027a12.3
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 15:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790547962; cv=none;
        d=google.com; s=arc-20260327;
        b=KAAAT//tbJNpNb2QRCFB+QwhhWIF+bnBb5AYgq5zkHWTpznW8+j4rQnHCtf2XIsQF7
         IZ6KI3CGbK2TnzZDgIOUEITcVDyZQoa/K/CkEMa757+KhSMv/PRq+rsCiR5M37mbzXfT
         1nlkt5NEGg+Qiu9dd8B+JBqcvJ9aYLq1ObFDMO6pCQOUy14aJfjy+gio6ZDSUpirYMeg
         XUcnD4uyqCvnCj2exmoS3KXjWMDzHjobRrpa3MdS4QWIHCLePrYY9m/MX7Nn1kogTtYz
         Ng7y9e3LrW3pqpa4rW0D+flyS153JTb+LUhCynCDJ3xadZZck/5eAWRxceVW8DvSx4iL
         okjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pk8+IqqFQoG7APvd2FjLP1mLXbt1I0a4Mq3J0BV0leo=;
        fh=VWVTg7jzUr0TeiSp9oLvySBVtMVLQiKpTfQbgsvu2WA=;
        b=fTm9b27uDQQM4Vai1PGpM8ZA2FaEAEjdb8gr2DUDluGeQvam8/mbXnvkQ51RXVOxzv
         ckgjtI/gR1IxFlaATMslXDX0G5aGoQAI9s6j+GK2kps4g9+sAxk04thpRa4LJ72ul0sU
         zzNbgWfdLAmDIKUzPdt362+t6kZH2bKD3NSHpQlrpUSiFJ1AXk0/LCwy/ch7Lozv7ql7
         LzocLZgVqQ6e9sqo8B3ux81cRQwHVUmhnv4nHGSp0M/NB61u0NQ0cm5BPKLGqTAqGyps
         Q7DIMZOsy6iWEe7ZS6jPDAYC8apacdfKDA2ZvPWwj0J8todBA8F8oTw/3mFMOf8DUaqc
         xo/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790547962; x=1791152762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pk8+IqqFQoG7APvd2FjLP1mLXbt1I0a4Mq3J0BV0leo=;
        b=XpbiqDdgge3Ei/vqcpw5QfsZ0yN01p06YscfKlPKJf/w+SDHzQiEV0Oo5NJFLH1SUS
         8EBE1fviPRlH2b5p4tSARO6xzSYEG4BUttz6bRO0ktsp+Nsv/Pujcg9AzkxyhLw3RuA3
         Rj/jADTHyPXwqB0GWrOYR/o+TSutxNl+altuGQAiw2zhGJuaaWRSN9Ty/0ARk1gfERuq
         tr1TtbYLLlb1ePavTgcCGqMcc8AINBDpODk9uy/4PSCDQ9AQWOZcg7kEQDG9Xti6+fwJ
         xyvBebKgyjpAyGH2IySB7rtIz3pdX0FjVp0LXCDSxpeuP+FN7sH7opQRMj9ZtH0xLjGy
         9IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790547962; x=1791152762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pk8+IqqFQoG7APvd2FjLP1mLXbt1I0a4Mq3J0BV0leo=;
        b=KCJ8L2XVu0M7a1iJHTWCoGWxuWWFGin4yS58fa3gd1JSL37LriQ6feSiWPs6ey3zgt
         AuVUAlO2eSkxCh2gRyLt1UYJpIC+DD/hOvvoDrtEa9EEJ1C2n2G/1pb8gOM42I4h1Yi/
         Q/rsKK8PoRG5t5dPDTPdyEC+Ryh+hGf4/mMJBpqdb/tXFYYGcy2rT603nisVAOgvdhwj
         LktCrjiMpYfEX1SNcAhLeTPAeaVV6BWbo+BvWcud5XZKLpSqFYekw8jwg++PYbyJEu5g
         E0ybUeks0udDP+VsEx/xAjSgo9wpWC8PODO8Sb8WYZOPe855dgJ+5MtAWWoI3fYtFAPm
         JtCw==
X-Forwarded-Encrypted: i=1; AKwUvBw253sa9JGUn0vrhNWyjdPmhqSF2os15mkfDJahLjCIrmFg/qfHs1tnhKvlq2erQcOZte1KP7uVBoid@vger.kernel.org
X-Gm-Message-State: AFq9FYItbbyPrinKjWFSDde2DfbkVEIFnMUUkCpsPMFDwMpLA8uZOZdq
	rkWmwmb+xOEQOXRw0HsGx95O3JfqFMO/h99hGRcx81nwhFg4klfjI4YAqhcr7ZmeYnFSv7+lstS
	fvXarGW8+MqjL5nGnhHpuLVjJcjVbMdwheZYk
X-Gm-Gg: AYBFou1AnsU1h4GNxTK6Mc55BsKg2dWn+2Irif5Jr51xusTUhI+bZZAu/EMb9CESQYH
	6BebaE5ILYQTF2AOcEALKxFgZz5IsD4Y928ku5sdiQj9m4zdbXF49jzHhh5x3qo7jgb/sIJSdv5
	n2VrjbtG7eZoeWzeyGz6hozzWGQazfwSwGmCd90gKb8KD18sG/iRINqCKgFsKdxQy23DYFqUIMA
	Tzuk7v9KYOBmz8JXI36bBr6hj83yeCd954qMeEUTZViEX3JSXOLuZ8jkoPAXfrnSBGd/bODUq2/
	KDF0hguaQcdWsaVEO4ru6aKHZFIStrmiz47qvtJhVFb8FTKg94KOatJAKbq0naBiEX81w30FOEv
	gs3XufkQNkCjQzEPo2ztu9D4cFDZois/OWOLmzXoV8g==
X-Received: by 2002:a05:6402:1e93:b0:6a6:37a3:2b0f with SMTP id
 4fb4d7f45d1cf-6aac8ecf40cmr8482648a12.8.1790547962401; Sun, 27 Sep 2026
 15:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816075141.3489194-1-linmag7@gmail.com> <20260816075141.3489194-3-linmag7@gmail.com>
 <4038ae1d-40ae-44bd-b914-ffb064a695dc@gaisler.com>
In-Reply-To: <4038ae1d-40ae-44bd-b914-ffb064a695dc@gaisler.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 28 Sep 2026 00:25:50 +0200
X-Gm-Features: AclHuK9rwxVH6zb2rI_EoaqpgJcB1MHehPkETJupcMmTEB8wPmy-zByMAqhb4ro
Message-ID: <CA+=Fv5TPJpqBmAdbvXX_xXXgUSNut8eTCtDpDNTEeLHK+F629g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sparc32: derive phys_base from the PAGE_OFFSET mapping
To: Andreas Larsson <andreas@gaisler.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Fri, Sep 25, 2026 at 5:46=E2=80=AFPM Andreas Larsson <andreas@gaisler.co=
m> wrote:
>
> On 2026-08-16 09:50, Magnus Lindholm wrote:
> > setup_arch() computes phys_base as the base of the lowest sp_banks[]
> > entry, that is, where RAM starts, and assumes the kernel image was load=
ed
> > there. That holds for the traditional boot path, where SILO places the
> > image at physical 0x4000 and PAGE_OFFSET is mapped to physical 0.
> >
> > It stops holding once the image no longer fits there. SILO loads a kern=
el
> > between physical 0x4000 and its own text at 0x280000, a window of 26050=
56
> > bytes; a current sparc32 kernel is roughly twice that. The loader must
> > then place the image elsewhere in physical memory and map PAGE_OFFSET t=
o
> > it, at which point phys_base describes where RAM begins rather than wha=
t
> > PAGE_OFFSET maps to, and the two disagree.
> >
> > phys_base is the offset __pa() and __va() are defined in terms of, so o=
nce
> > it is wrong every early translation is wrong by the difference, includi=
ng
> > the physical addresses written into page table descriptors. The
> > tablewalker then follows pointers into pages that hold nothing while th=
e
> > same tables read back correctly through the nocache view. The failure
> > surfaces as a hang right after the context table pointer is installed a=
nd
> > the TLB flushed, with nothing on the console to explain it, since the P=
ROM
> > mappings the early console depends on have become just as unreachable.
> >
> > Ask the MMU what PAGE_OFFSET actually translates to and adopt that.
> > __get_phys() already implements this probe for sun4m and sun4d and retu=
rns
> > zero elsewhere, so no new low level MMU access is introduced and machin=
es
> > without an SRMMU are unaffected.
> >
> > Memory below the kernel cannot be reached through the linear map, which
> > runs upward from PAGE_OFFSET, so drop the banks that fall below it rath=
er
> > than leave entries that __va() would translate to below PAGE_OFFSET.
> >
> > With this a 6MB kernel loaded at physical 0x03000000 boots on sun4m: th=
e
> > context table lands at its true physical address,
> > srmmu_inherit_prom_mappings() preserves the PROM console mappings, and
> > srmmu.c needs no change at all, since map_kernel() already handles a
> > non-zero phys_base via do_large_mapping().
> >
> > The cost is the RAM below the load address the loader chose. SILO's
> > memory_find() picks 48MB on machines with 64MB or more.
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> > ---
> >  arch/sparc/kernel/setup_32.c | 40 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.=
c
> > index 1b0db16cd37b..34e8f7c87685 100644
> > --- a/arch/sparc/kernel/setup_32.c
> > +++ b/arch/sparc/kernel/setup_32.c
> > @@ -254,6 +254,30 @@ static __init void leon_patch(void)
> >
> >  struct tt_entry *sparc_ttable;
> >
> > +/* Drop RAM below the kernel; the linear map runs upward from phys_bas=
e
> > + * and cannot reach it.
> > + */
> > +static void __init trim_sp_banks_below(unsigned long base)
> > +{
> > +     int i, j =3D 0;
> > +
> > +     for (i =3D 0; sp_banks[i].num_bytes !=3D 0; i++) {
> > +             unsigned long start =3D sp_banks[i].base_addr;
> > +             unsigned long end =3D start + sp_banks[i].num_bytes;
> > +
> > +             if (end <=3D base)
> > +                     continue;               /* wholly below - drop it=
 */
> > +             if (start < base)
> > +                     start =3D base;           /* straddles - trim the=
 front */
> > +
> > +             sp_banks[j].base_addr =3D start;
> > +             sp_banks[j].num_bytes =3D end - start;
> > +             j++;
> > +     }
> > +     sp_banks[j].base_addr =3D 0;
> > +     sp_banks[j].num_bytes =3D 0;
> > +}
> > +
> >  /* Called from head_32.S - before we have setup anything
> >   * in the kernel. Be very careful with what you do here.
> >   */
> > @@ -332,6 +356,22 @@ void __init setup_arch(char **cmdline_p)
> >               if (highest_paddr < top)
> >                       highest_paddr =3D top;
> >       }
> > +
> > +     /* phys_base must describe what PAGE_OFFSET maps to, not where RA=
M starts. */
> > +     {
> > +             unsigned long real_base =3D __get_phys(PAGE_OFFSET);
> > +
> > +             prom_printf("phys_base: RAM starts 0x%lx, kernel is at 0x=
%lx\n",
> > +                         phys_base, real_base);
>
>
> This must not print bogus information on LEON systems.
>
> It is a pity that leon_swprobe() is not ready for use at this point or
> it could have been used in __get_phys(). It could be changed in the
> future to not do the strict checks that now depends on variables
> initialized later with, the here calculated, phys_base as input. For
> now, please refrain from printing the above on systems not supported
> by __get_phys(), or move it or parts of it back under the if below.
>
> Nit: I think it should be "...RAM starts at 0x%lx..."
>
> Apart from that, this patch, as well as the rest of the series looks
> good!
>


Hi Andreas,

Thanks for the review and feedback! A v3 is on the way restricting the
probe and diagnostic to sun4m and sun4d, so it won't print a bogus kernel
address on LEON. I'll also fix the wording to "RAM starts at".

Thanks,
Magnus
