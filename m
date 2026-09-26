Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7513345EB4
	for <sparclinux@vger.kernel.org>; Sat, 26 Sep 2026 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421530; cv=pass; b=SXd58/xWwcu2ItEOtTDnDRgTxL2z5cbWfBfHBcDOgjLf+zl7407mqD3vJeHbHF+2HbvjgQoTZydt9GacSfj97MIqZmsusvVB7KDvqjAeEt44qWVxMVmAQwfHb59xvRaPV9p5EU75AZrBMjDOHGq7YBAGaOnHn5KYFDob31t7FMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421530; c=relaxed/simple;
	bh=V9J59zY6UoJzXVGxu5czEpfvrqLPKJSto6ACG50o4Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhgEhhdVy37gH9sbRLpF+k39RyE7xPyR1YLex3UlQsXpfyTTHmvYvhmaw/0NeZ35Xq43/cJe9x5kBhqlr0mehgkIeua8pVh9Hqp4ueONW6AzFBjLqjbR4VwO7JR57tmBdqfGvDvIi9tJ0YCHrhaAs1FMp0Si7u3f4qBcnzKMExw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBymB0SX; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBymB0SX"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso2897572a12.1
        for <sparclinux@vger.kernel.org>; Sat, 26 Sep 2026 04:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790421526; cv=none;
        d=google.com; s=arc-20260327;
        b=sFI9sxR8xF7OMGlgtTTZH0A5c4AvmIyvvAaTiNALjmqrFaVEbkGBUVqyXLC36eVRh7
         t++9T8QSjOuKju41nYS8owSKWD1YSoyZ0peEebGpxpZUMc+h71RSDhDc+1/n3yJMYfGI
         18wcBAu05dxAKQhUMkrWaIx4XxECrM/0BHjE/LMRspWsTX0Zp9yM6wx7DWclUcsGjqrV
         m1NxYJ1XNw5EQKA1NpfRqPbULc4e2+5jreci3fryTR5MIPTsSjJCiW5Zh++ji6Z8pUJ6
         p+8qnhYdum5DpGw0ZrfjQiN1TPVbr5kxqyLTvbQWrkyfqu/OAEzjCL3NP3ispMeOzumE
         VQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yf93UqGc+Z7oTZ0AQX2J9TASiALew47VbMsIzLX9+8Y=;
        fh=Fmc8FGJNWgP1XBbZqlKvaMu3jhQ+Uka1AD6cHP9CFTk=;
        b=q2E90noKv0sLn4bqBTa1MP50QoXaucHC0/maN2tWc8kyQBf3yS/fAXLUAVoGpSxmqC
         e00TKhKSs5dWXoMbtkSvP6t8VJ3cSTHmGi1AkY4cbIcwITFsjGCe3uc+rODkso4EL22S
         W3tAce1eGC4RnUZ87SJsqFxaFQIG89XqR6mpeGWt61+N/gORLOREDVFf3+OUvPbk9L8A
         pgpwVGCyxoNO/M0qfWdIiDkYYIOQWkYWxQlYoyIOc8EHFLFiF3pFCkWlPHbyTN/yxmbP
         3RlFu8rM6YMRv60K9MRGN1XCW5eeFj69TLrwpa9xcQnb18RnmFOMYWD6Is29Zavsmv+Y
         QbuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790421526; x=1791026326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yf93UqGc+Z7oTZ0AQX2J9TASiALew47VbMsIzLX9+8Y=;
        b=QBymB0SX18Pnt750OsM4cBH1cdtUDlOBNWAkZHGAkDvKkRY8cdqqZ0sfI9LvnpPWj9
         n9OTvI2RL8mOG5TabpUQFv0AgpqDszrSssDtC62HMlDrh2pEmvWVRhKQw0FvdYJTa7Rc
         KVzRlK8rDVocR9w7Ac52uCEuIp3FZZQf4cafhEtjePBj71wLQCDw10g9kUUSVUlRKjU6
         S390jfuftJS0e2jkv03yrpLeq7zySoRoAG4XcBeL0Bq9T55Da66dd1+Ja46bvGkLGJLD
         tdsN3ohc0JDaa4Mp3Gi3VPr/RlprCKpW8xSiC8cmauOYVYCgrhv7v4nJ7vQeZ+fJtnd2
         cdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790421526; x=1791026326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yf93UqGc+Z7oTZ0AQX2J9TASiALew47VbMsIzLX9+8Y=;
        b=YNBQKA8me7hVg7yHILL1lEeUSmXLx1yMtK/Qj/WIyzaBr9SawHW+I387W4gBJ8pa2F
         X7qd7fEGAgv1vAP40sgFM+WGhwY8fncLrMaQw3aPf86kLXaCcrbKw/i9uI5YXI4NdyJG
         ce6JuxV0NYpicIYzmxsuHRLeyqr5//7dc9/I25XESCvJo4L8gQ5WJ04x6kTAZB73BvZ6
         S5EfL1e349EYYCKHq1Bce6VrmyYju2BOFMgh4eKtvSgTbfJFHCHJy4C+NKoYVEX+wJhY
         /VgYFRItzd1EGbTpg3ZHZZ2yJMjbbmH6b/hOZ7n4aHRFOIubYMFTtgRR1U32y+rbX24z
         SRPw==
X-Gm-Message-State: AFuF++kVZ6RmD32qj9tzEWFyoIDWtloqMSxkRqwv7MqSY7imJuIprIm5
	abOHu9Sg4aW4E2kjgpzNEGqz4Qq7qIg7MEiR0Lv5o3VDMNyAy5cCw/Dv6/KfTpn/8Q2Hlyewl6f
	4zzuH/xscS2hlj+043ylMlesqxQnKnpY=
X-Gm-Gg: AYBFou3N+E89JipPzUvi6UGe4MLbRQsD5bArQok/k+kLc7oyzc7s2fzcfeG9OF0FTKz
	PY2qi4e0kTXSEDTkMhNv4mFmgiMZSldRIpD5rpre5UYYCDadrPbjMaVQ8Ou28ng+Cx4NHW+yvgU
	rYnjb+uqSTCtgCY0DJQnwpGRGeXOuYsyAIjUHr1HcZOCmEel2ku+1C+uYco4HTp7Qd37GCz4eIr
	8dtQYounUCTrE8acTjWQ8tBKzYncQhGTiMjQjHm60KVVkyJ7gEBK7KBmmm4gCfZxRVtlXMpfRhu
	vrCtBAhsS+HhLJ7nr762IMA22LKrSdY+3CkQA3yrmasaOwOiiE8I8+GJMkUI4Xc+657wNvOayZf
	+AWXzYtANWQpe/i5b2ROiiGJPyxWFVNe9lnud8tvEQQ==
X-Received: by 2002:a05:6402:325c:b0:6aa:9284:9a99 with SMTP id
 4fb4d7f45d1cf-6aac8ecf1aemr6053081a12.6.1790421525923; Sat, 26 Sep 2026
 04:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901214611.60560-1-linmag7@gmail.com> <20260901214611.60560-6-linmag7@gmail.com>
 <01904ae2-ed8e-487e-80f7-540b4d06b55d@gaisler.com>
In-Reply-To: <01904ae2-ed8e-487e-80f7-540b4d06b55d@gaisler.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 26 Sep 2026 13:18:33 +0200
X-Gm-Features: AclHuK-XYz2qy1Wovd3QSCowHFPmplQY1B4zQKfyKFGz00jXXtaVE3Ks_uynXTY
Message-ID: <CA+=Fv5QqrL95oj49xfiZAOROPMh40mNFpZemRs2KQwwHzP18ZA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] sparc32: move early memory setup to setup_arch
To: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, 
	linux-kernel@vger.kernel.org, sam@ravnborg.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Fri, Sep 25, 2026 at 5:58=E2=80=AFPM Andreas Larsson <andreas@gaisler.co=
m> wrote:
>
> On 2026-09-01 23:45, Magnus Lindholm wrote:
> > Move the early memory configuration out of SRMMU paging setup and next =
to
> > the rest of setup_arch(). Derive the PFN limits from memblock, reserve =
the
> > kernel and initrd there, and retain mem=3D support with
> > memblock_enforce_memory_limit().
> >
> > Use for_each_mem_pfn_range() to find the lowmem boundary and replace
> > last_valid_pfn with the standard max_low_pfn variable. Set the standard
> > max_pfn variable to the end of physical memory and use it as the highme=
m
> > zone limit. This tightens LEON's _pfn_valid() upper bound from all RAM =
to
> > the lowmem limit, with no functional change because LEON does not use
> > highmem.
>
> It is not at all true that LEON systems do not use highmem. Rather, they
> can make heavy use of highmen. Continued further down.
>
>

Oh, yeah you're right, I'll remove the incorrect statement that LEON does
not use highmem.

> > The removed bootmem code also printed a private HIGHMEM summary. Generi=
c
> > memory initialization already reports the highmem zone, so do not retai=
n
> > the duplicate message.
> >
> > When PAGE_OFFSET maps a relocated kernel, remove memory below phys_base
> > from memblock because it cannot be reached through the linear map. This
> > replaces the equivalent trimming of sp_banks.
> >
> > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> > ---
> >  arch/sparc/include/asm/highmem.h    |   3 -
> >  arch/sparc/include/asm/leon.h       |   2 +-
> >  arch/sparc/include/asm/pgtable_32.h |   3 +-
> >  arch/sparc/include/asm/pgtsrmmu.h   |   1 -
> >  arch/sparc/kernel/setup_32.c        | 112 ++++++++++++-----------
> >  arch/sparc/mm/init_32.c             | 132 +---------------------------
> >  arch/sparc/mm/leon_mm.c             |   1 +
> >  arch/sparc/mm/srmmu.c               |   8 +-
> >  8 files changed, 67 insertions(+), 195 deletions(-)
> >
> > diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/=
highmem.h
> > index c7b2e208328b..b1b915ac604d 100644
> > --- a/arch/sparc/include/asm/highmem.h
> > +++ b/arch/sparc/include/asm/highmem.h
> > @@ -26,9 +26,6 @@
> >  #include <asm/vaddrs.h>
> >  #include <asm/pgtsrmmu.h>
> >
> > -/* declarations for highmem.c */
> > -extern unsigned long highstart_pfn, highend_pfn;
> > -
> >  #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
> >  extern pte_t *pkmap_page_table;
> >
> > diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leo=
n.h
> > index 053a24b67aed..815131c77ed7 100644
> > --- a/arch/sparc/include/asm/leon.h
> > +++ b/arch/sparc/include/asm/leon.h
> > @@ -251,7 +251,7 @@ extern int leon_ipi_irq;
> >
> >  /* macros used in leon_mm.c */
> >  #define PFN(x)           ((x) >> PAGE_SHIFT)
> > -#define _pfn_valid(pfn)       ((pfn < last_valid_pfn) && (pfn >=3D PFN=
(phys_base)))
> > +#define _pfn_valid(pfn)       ((pfn < max_low_pfn) && (pfn >=3D PFN(ph=
ys_base)))
>
> What is the reason for doing this change? When leon_swprobe() is called
> max_pfn has already been set up. Is there a reason for not using that?
>
>
> However, in the scope of the calls to leon_swprobe(), no parts of the
> inherited MMU table's PTDs/PTEs are outside of lowmem. If there indeed
> is some technical reason for needing to do this change I suggest that
> you, in a separate patch before this one:
>
> - Remove PFN() and replace the callers in leon_mm.c with the standard
>   PFN_DOWN() instead, as also Sam lifted as "future work", and
>
> - Move the _pfn_valid define to leon_mm.c, make it only check for lowmem
>   pfns and rename it to _pfn_lowmem() or something like that.
>

Thanks, you are right: last_valid_pfn previously held the value of max_pfn,=
 so
changing the upper bound to max_low_pfn was incorrect and could reject vali=
d
LEON highmem PFNs.

> >  #define _SRMMU_PTE_PMASK_LEON 0xffffffff
> >
> >  /*
> > diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/a=
sm/pgtable_32.h
> > index f89b1250661d..91a6032cf6a2 100644
> > --- a/arch/sparc/include/asm/pgtable_32.h
> > +++ b/arch/sparc/include/asm/pgtable_32.h
> > @@ -37,8 +37,7 @@ struct vm_area_struct;
> >  struct page;
> >
> >  void load_mmu(void);
> > -unsigned long calc_highpages(void);
> > -unsigned long __init bootmem_init(unsigned long *pages_avail);
> > +void __init find_ramdisk(unsigned long end_of_phys_memory);
> >
> >  #define pte_ERROR(e)   __builtin_trap()
> >  #define pmd_ERROR(e)   __builtin_trap()
> > diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm=
/pgtsrmmu.h
> > index a265822a475e..a2a6c8564c3e 100644
> > --- a/arch/sparc/include/asm/pgtsrmmu.h
> > +++ b/arch/sparc/include/asm/pgtsrmmu.h
> > @@ -98,7 +98,6 @@
> >        restore %g0, %g0, %g0;
> >
> >  #ifndef __ASSEMBLER__
> > -extern unsigned long last_valid_pfn;
> >
> >  /* This makes sense. Honest it does - Anton */
> >  /* XXX Yes but it's ugly as sin.  FIXME. -KMW */
> > diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.=
c
> > index 795714959da6..6ad85538964d 100644
> > --- a/arch/sparc/kernel/setup_32.c
> > +++ b/arch/sparc/kernel/setup_32.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/kdev_t.h>
> >  #include <linux/major.h>
> > +#include <linux/memblock.h>
> >  #include <linux/string.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > @@ -254,28 +255,71 @@ static __init void leon_patch(void)
> >
> >  struct tt_entry *sparc_ttable;
> >
> > -/* Drop RAM below the kernel; the linear map runs upward from phys_bas=
e
> > - * and cannot reach it.
> > - */
> > -static void __init trim_sp_banks_below(unsigned long base)
> > +unsigned long phys_base;
> > +EXPORT_SYMBOL(phys_base);
> > +
> > +unsigned long pfn_base;
> > +EXPORT_SYMBOL(pfn_base);
> > +
> > +static unsigned long __init calc_max_low_pfn(void)
> >  {
> > -     int i, j =3D 0;
> > +     unsigned long limit =3D pfn_base + PHYS_PFN(SRMMU_MAXMEM);
> > +     unsigned long start_pfn, end_pfn;
> > +     unsigned long last_pfn =3D 0;
> > +     int i;
> > +
> > +     for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NUL=
L) {
> > +             if (start_pfn >=3D limit) {
> > +                     if (last_pfn < limit)
> > +                             limit =3D last_pfn;
> > +                     break;
> > +             }
> >
> > -     for (i =3D 0; sp_banks[i].num_bytes !=3D 0; i++) {
> > -             unsigned long start =3D sp_banks[i].base_addr;
> > -             unsigned long end =3D start + sp_banks[i].num_bytes;
> > +             last_pfn =3D end_pfn;
> > +     }
> >
> > -             if (end <=3D base)
> > -                     continue;               /* wholly below - drop it=
 */
> > -             if (start < base)
> > -                     start =3D base;           /* straddles - trim the=
 front */
> > +     return limit;
> > +}
> >
> > -             sp_banks[j].base_addr =3D start;
> > -             sp_banks[j].num_bytes =3D end - start;
> > -             j++;
> > +static void __init setup_memory(void)
> > +{
> > +     unsigned long ram_base =3D memblock_start_of_DRAM();
> > +     unsigned long real_base =3D __get_phys(PAGE_OFFSET);
> > +     unsigned long size;
> > +
> > +     memblock_set_bottom_up(true);
> > +     memblock_allow_resize();
> > +
> > +     phys_base =3D ram_base;
> > +     if (real_base && real_base !=3D phys_base) {
> > +             prom_printf("phys_base: RAM starts 0x%x but kernel is at =
0x%x\n",
> > +                         (unsigned int)phys_base, (unsigned int)real_b=
ase);
> > +             phys_base =3D real_base;
> > +             memblock_remove(0, phys_base);
> > +             prom_printf("phys_base: adopted 0x%x, RAM below it droppe=
d\n",
> > +                         (unsigned int)phys_base);
> >       }
> > -     sp_banks[j].base_addr =3D 0;
> > -     sp_banks[j].num_bytes =3D 0;
> > +
> > +     if (cmdline_memory_size)
> > +             memblock_enforce_memory_limit(cmdline_memory_size);
> > +
> > +     min_low_pfn =3D PFN_DOWN(memblock_start_of_DRAM());
> > +     pfn_base =3D PHYS_PFN(phys_base);
> > +     max_pfn =3D PFN_DOWN(memblock_end_of_DRAM());
> > +     max_low_pfn =3D max_pfn;
> > +
> > +     if (max_low_pfn > pfn_base + PHYS_PFN(SRMMU_MAXMEM))
> > +             max_low_pfn =3D calc_max_low_pfn();
> > +
> > +     find_ramdisk(memblock_end_of_DRAM());
> > +
> > +     /* Reserve the kernel text/data/bss. */
> > +     size =3D __pa(PAGE_ALIGN((unsigned long)&_end)) - phys_base;
> > +     memblock_reserve(phys_base, size);
> > +     memblock_add(phys_base, size);
> > +
> > +     /* Only allow low memory to be allocated by memblock. */
> > +     memblock_set_current_limit(PFN_PHYS(max_low_pfn));
> >  }
> >
> >  /* Called from head_32.S - before we have setup anything
> > @@ -306,9 +350,6 @@ void __init sparc32_start_kernel(struct linux_romve=
c *rp)
> >
> >  void __init setup_arch(char **cmdline_p)
> >  {
> > -     int i;
> > -     unsigned long highest_paddr;
> > -
> >       sparc_ttable =3D &trapbase[0];
> >
> >       /* Initialize PROM console and command line. */
> > @@ -343,36 +384,7 @@ void __init setup_arch(char **cmdline_p)
> >
> >       idprom_init();
> >       load_mmu();
> > -
> > -     phys_base =3D 0xffffffffUL;
> > -     highest_paddr =3D 0UL;
> > -     for (i =3D 0; sp_banks[i].num_bytes !=3D 0; i++) {
> > -             unsigned long top;
> > -
> > -             if (sp_banks[i].base_addr < phys_base)
> > -                     phys_base =3D sp_banks[i].base_addr;
> > -             top =3D sp_banks[i].base_addr +
> > -                     sp_banks[i].num_bytes;
> > -             if (highest_paddr < top)
> > -                     highest_paddr =3D top;
> > -     }
> > -
> > -     /* phys_base must describe what PAGE_OFFSET maps to, not where RA=
M starts. */
> > -     {
> > -             unsigned long real_base =3D __get_phys(PAGE_OFFSET);
> > -
> > -             if (real_base && real_base !=3D phys_base) {
> > -                     prom_printf("phys_base: RAM starts 0x%x but kerne=
l is at 0x%x\n",
> > -                                 (unsigned int)phys_base,
> > -                                 (unsigned int)real_base);
> > -                     phys_base =3D real_base;
> > -                     trim_sp_banks_below(phys_base);
> > -                     prom_printf("phys_base: adopted 0x%x, RAM below i=
t dropped\n",
> > -                                 (unsigned int)phys_base);
> > -             }
> > -     }
> > -
> > -     pfn_base =3D phys_base >> PAGE_SHIFT;
> > +     setup_memory();
> >
> >       if (!root_flags)
> >               root_mountflags &=3D ~MS_RDONLY;
> > diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> > index 6880d9cb30a5..ac4462f1cf76 100644
> > --- a/arch/sparc/mm/init_32.c
> > +++ b/arch/sparc/mm/init_32.c
> > @@ -35,66 +35,13 @@
> >
> >  #include "mm_32.h"
> >
> > -unsigned long phys_base;
> > -EXPORT_SYMBOL(phys_base);
> > -
> > -unsigned long pfn_base;
> > -EXPORT_SYMBOL(pfn_base);
> > -
> >  struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
> >
> >  /* Initial ramdisk setup */
> >  extern unsigned int sparc_ramdisk_image;
> >  extern unsigned int sparc_ramdisk_size;
> >
> > -unsigned long highstart_pfn, highend_pfn;
> > -
> > -unsigned long last_valid_pfn;
> > -
> > -unsigned long calc_highpages(void)
> > -{
> > -     int i;
> > -     int nr =3D 0;
> > -
> > -     for (i =3D 0; sp_banks[i].num_bytes !=3D 0; i++) {
> > -             unsigned long start_pfn =3D sp_banks[i].base_addr >> PAGE=
_SHIFT;
> > -             unsigned long end_pfn =3D (sp_banks[i].base_addr + sp_ban=
ks[i].num_bytes) >> PAGE_SHIFT;
> > -
> > -             if (end_pfn <=3D max_low_pfn)
> > -                     continue;
> > -
> > -             if (start_pfn < max_low_pfn)
> > -                     start_pfn =3D max_low_pfn;
> > -
> > -             nr +=3D end_pfn - start_pfn;
> > -     }
> > -
> > -     return nr;
> > -}
> > -
> > -static unsigned long calc_max_low_pfn(void)
> > -{
> > -     int i;
> > -     unsigned long tmp =3D pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
> > -     unsigned long curr_pfn, last_pfn;
> > -
> > -     last_pfn =3D (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> P=
AGE_SHIFT;
> > -     for (i =3D 1; sp_banks[i].num_bytes !=3D 0; i++) {
> > -             curr_pfn =3D sp_banks[i].base_addr >> PAGE_SHIFT;
> > -
> > -             if (curr_pfn >=3D tmp) {
> > -                     if (last_pfn < tmp)
> > -                             tmp =3D last_pfn;
> > -                     break;
> > -             }
> > -
> > -             last_pfn =3D (sp_banks[i].base_addr + sp_banks[i].num_byt=
es) >> PAGE_SHIFT;
> > -     }
> > -
> > -     return tmp;
> > -}
> > -
> > -static void __init find_ramdisk(unsigned long end_of_phys_memory)
> > +void __init find_ramdisk(unsigned long end_of_phys_memory)
> >  {
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >       unsigned long size;
> > @@ -124,83 +71,6 @@ static void __init find_ramdisk(unsigned long end_o=
f_phys_memory)
> >  #endif
> >  }
> >
> > -unsigned long __init bootmem_init(unsigned long *pages_avail)
> > -{
> > -     unsigned long start_pfn, bytes_avail, size;
> > -     unsigned long end_of_phys_memory =3D 0;
> > -     unsigned long high_pages =3D 0;
> > -     int i;
> > -
> > -     memblock_set_bottom_up(true);
> > -     memblock_allow_resize();
> > -
> > -     bytes_avail =3D 0UL;
> > -     for (i =3D 0; sp_banks[i].num_bytes !=3D 0; i++) {
> > -             end_of_phys_memory =3D sp_banks[i].base_addr +
> > -                     sp_banks[i].num_bytes;
> > -             bytes_avail +=3D sp_banks[i].num_bytes;
> > -             if (cmdline_memory_size) {
> > -                     if (bytes_avail > cmdline_memory_size) {
> > -                             unsigned long slack =3D bytes_avail - cmd=
line_memory_size;
> > -
> > -                             bytes_avail -=3D slack;
> > -                             end_of_phys_memory -=3D slack;
> > -
> > -                             sp_banks[i].num_bytes -=3D slack;
> > -                             if (sp_banks[i].num_bytes =3D=3D 0) {
> > -                                     sp_banks[i].base_addr =3D 0xdeadb=
eef;
> > -                             } else {
> > -                                     memblock_add(sp_banks[i].base_add=
r,
> > -                                                  sp_banks[i].num_byte=
s);
> > -                                     sp_banks[i+1].num_bytes =3D 0;
> > -                                     sp_banks[i+1].base_addr =3D 0xdea=
dbeef;
> > -                             }
> > -                             break;
> > -                     }
> > -             }
> > -             memblock_add(sp_banks[i].base_addr, sp_banks[i].num_bytes=
);
> > -     }
> > -
> > -     if (cmdline_memory_size)
> > -             memblock_enforce_memory_limit(cmdline_memory_size);
> > -
> > -     /* Start with page aligned address of last symbol in kernel
> > -      * image.
> > -      */
> > -     start_pfn  =3D (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_e=
nd));
> > -
> > -     /* Now shift down to get the real physical page frame number. */
> > -     start_pfn >>=3D PAGE_SHIFT;
> > -
> > -     max_pfn =3D end_of_phys_memory >> PAGE_SHIFT;
> > -
> > -     max_low_pfn =3D max_pfn;
> > -     highstart_pfn =3D highend_pfn =3D max_pfn;
> > -
> > -     if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
> > -             highstart_pfn =3D pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)=
;
> > -             max_low_pfn =3D calc_max_low_pfn();
> > -             high_pages =3D calc_highpages();
> > -             printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> > -                 high_pages >> (20 - PAGE_SHIFT));
> > -     }
> > -
> > -     find_ramdisk(end_of_phys_memory);
> > -
> > -     /* Reserve the kernel text/data/bss. */
> > -     size =3D (start_pfn << PAGE_SHIFT) - phys_base;
> > -     memblock_reserve(phys_base, size);
> > -     memblock_add(phys_base, size);
> > -
> > -     size =3D memblock_phys_mem_size() - memblock_reserved_size();
> > -     *pages_avail =3D (size >> PAGE_SHIFT) - high_pages;
> > -
> > -     /* Only allow low memory to be allocated via memblock allocation =
*/
> > -     memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
> > -
> > -     return max_pfn;
> > -}
> > -
> >  /*
> >   * paging_init() sets up the page tables: We call the MMU specific
> >   * init routine based upon the Sun model type on the Sparc.
> > diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
> > index 1dc9b3d70eda..a43c5ffbbbe5 100644
> > --- a/arch/sparc/mm/leon_mm.c
> > +++ b/arch/sparc/mm/leon_mm.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/kernel.h>
> > +#include <linux/memblock.h>
> >  #include <linux/mm.h>
> >  #include <asm/asi.h>
> >  #include <asm/leon.h>
> > diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> > index f094f6c105a2..e333d3eac451 100644
> > --- a/arch/sparc/mm/srmmu.c
> > +++ b/arch/sparc/mm/srmmu.c
> > @@ -59,8 +59,6 @@ int vac_line_size;
> >
> >  extern struct resource sparc_iomap;
> >
> > -extern unsigned long last_valid_pfn;
> > -
> >  static pgd_t *srmmu_swapper_pg_dir;
> >
> >  const struct sparc32_cachetlb_ops *sparc32_cachetlb_ops;
> > @@ -871,7 +869,7 @@ void __init arch_zone_limits_init(unsigned long *ma=
x_zone_pfns)
> >  {
> >       max_zone_pfns[ZONE_DMA] =3D max_low_pfn;
> >       max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;
> > -     max_zone_pfns[ZONE_HIGHMEM] =3D highend_pfn;
> > +     max_zone_pfns[ZONE_HIGHMEM] =3D max_pfn;
> >  }
> >
> >  void __init srmmu_paging_init(void)
> > @@ -884,7 +882,6 @@ void __init srmmu_paging_init(void)
> >       pud_t *pud;
> >       pmd_t *pmd;
> >       pte_t *pte;
> > -     unsigned long pages_avail;
> >
> >       init_mm.context =3D (unsigned long) NO_CONTEXT;
> >       sparc_iomap.start =3D SUN4M_IOBASE_VADDR; /* 16MB of IOSPACE on a=
ll sun4m's. */
> > @@ -910,9 +907,6 @@ void __init srmmu_paging_init(void)
> >               prom_halt();
> >       }
> >
> > -     pages_avail =3D 0;
> > -     last_valid_pfn =3D bootmem_init(&pages_avail);
> > -
> >       srmmu_nocache_calcsize();
> >       srmmu_nocache_init();
> >       srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM - PAG=
E_SIZE));
>
> Thanks,
> Andreas
>

Thanks Andreas for taking the time to go over this patch,
I'll put out a v4 based on your feedback, asap.

Magnus
