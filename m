Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F371F8755
	for <sparclinux@vger.kernel.org>; Sat, 29 Aug 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991702; cv=pass; b=UYBo7yjbPdaSoVT67ATOhHQ0yLun6t54+FtmrI23pUIUUMhtiX1aYqdn6cPPS1+HVsvpRANnxItbSbzKa77XJqqRO1pk//o9qFrL686O/N5HcHFgNx75kfKPhGJjbN4ijHWX7Gtt1LcBuH01/Al9sY8HMIe8W6j6Scn42kSrFYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991702; c=relaxed/simple;
	bh=Xmt2LcEI0vicxCfw80JA2tKyBEMb7Ir+ZWVj1/6whi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN1KZlBfaqU5xNDEnsfi9HriDJWNQ0/TgC09XzLRCP8G84y6geXm6rMYViQUCsNqbN8tZCNinYH5+U0sbHGp1I0gtI2ukcjCd8UxJAWBzf+XLl79DMHnonFGyFDdbWqTAkgFn9Mfho43PFXo+ajiBq87vqUod5/3xeAna5JsKIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUZB4w3C; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUZB4w3C"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2364027a12.0
        for <sparclinux@vger.kernel.org>; Sat, 29 Aug 2026 01:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787991699; cv=none;
        d=google.com; s=arc-20260327;
        b=m5NNJ+i0iSLpl5t5HeIF1FgicdLbWtGu2eEO7AfhAGIoh3h3nfev+QqwmGVMEuiZKp
         ACwfXLHSJ9OoI7tOdskt5R7rreTrzCejl9I+S6qA4UM5OLzxMDaMbFxXmfLwdMMOuVld
         CPI9z1DKmc7gznHiJh9gGe/lgBcVJhN6oI6ga0X1TuIG2SHoBhHGHyQcdaYOkoGHY2wZ
         VrHRh1djUx+POq4VUARD6r2VdE2eR6pXh28WBPz6AjYcnDROOokfYqsUtl+AXI0z8E/+
         OfnWMa8NUMx100XmVU8x2Ij+tU54i94Lx++mFFe5t0b7oUilSeRaek/FzdTErRidM7Q5
         aDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k1MZm2tWs3G68gpfTZLBsA7bA0jIxMZAYcuwV/qYMa8=;
        fh=xL3khHFPu8t9rYa5FOGRy4DapmWu2s6QCpUOa0aUhYE=;
        b=WqrokdDPNUSxPB8cLkUq/XqPQyQn10ewxww5PViE7zPSCu1IaIOGzL0Iz/j+naCwqz
         +SvdzqTsCBnBCynwND295mJciAmWNYx6E1c37x2UzO6Fyx/QZlGFi7yYzI8TVE/0HI8C
         X7DQbeVeuh9GnwFzYU9DK3JJkWSSRrrv/YjehjISoRVNGs812WnhEf9L2oh3Rxm3WE4B
         8cRjDpnH57cwXD7phbbsSzYgNJ2Pr7sGK4Js4s7satV1LH7AovpdKV2ddi9tBIpu2Uc1
         MeWqkpKHtGr6j3MFlFSzGZ1PFqWUD1ZI8UB9fWUOCuiLdd4kj4SJ4k7VwXZ/yhGLFK/P
         LMvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787991699; x=1788596499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k1MZm2tWs3G68gpfTZLBsA7bA0jIxMZAYcuwV/qYMa8=;
        b=EUZB4w3CYcGfbJU3K+vM0L4z5ks3yuu+si6bqvpzkOW7auF/CkhXiv/GKZlqBrqx9w
         srQamFqer8NfMwAfL/Zhyon5jkVe0LoijnoK2709SpVIio5u3O4ou3xEaCnRgAt8T1sz
         +5G4Ao/mF2Kf6jFdiBKNseSZ5a8MPTqK1JUvtvn2gc032AH/FWZRpLrNTN1MT65aRg0J
         z+9vduLJb1tZCPKkd6/70B4GmOoLl8mlaPjg2uy//AwtIsO1b00sN9bGZ5G0Vr7HA2Mh
         dHTdSImHEsENTCL6Aj1SVorkxH64N5/R+nAo7Q9MrBikHyfMKmFeUqq+RsFdb/rVEfUo
         JmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991699; x=1788596499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1MZm2tWs3G68gpfTZLBsA7bA0jIxMZAYcuwV/qYMa8=;
        b=ovYIuqUgdNANt4oO2b+1PQbMwpuHlbg4XCJYBHuoSNnrBUHfgca8iyKfsguapeBcte
         LCwFTCiy8u7WMy/D1U/3jqcWZnj6w84rQNEuzkemt8fw3+sU+J/51R4fK2twHAeCigdk
         4h1/0lKwxT5jUlouVCGGCkKhPzeL84Qos+V5STlsCp/gBVc3v/Fynp60QYUvbzJPOYfj
         rkGOqqkOstzn87WgfGL41/dnzygG2YRrcb5qboR+2pG2YUjinfQuG3LLlxsZt0I08epZ
         VKXDzGQGcOWkQpEyw0ResQUrAFJr1QU4IoRcrKt+w3tHkelXN5w8vgdHNusGtw4hYlJi
         ennw==
X-Gm-Message-State: AFuF++k9VxdBB7jDwXFZfLDDyT2fzA0OQn11ghYOJ+Oj87ZWCJ+WFFJR
	DSg4HrqGLR4z82B01S9QbSU0kruRycXIQ/M+vmn2D8wzvxnR7AoeprW1IWEZqC5auI7IMJWT9NT
	UlvuXvkbqXJO1ybnnZjBk1uxtDAd8Nys=
X-Gm-Gg: AYBFou1yKYsJjfmLEShZ7jKqS0IH6sVzPHnutI1tcsqMHFTowVHDS7TW3sGbB25fZwI
	ovjM66NaX6KvHMv5qyKk1xgj9QkTttBtLhZBh54P6khDSVacVjrTy9pkIQ2gi5s+IbYQngpZVva
	3Tm6Tgt8y4CoWryiGW50YXxeJq87LJ5382/SEQqoo3/p/1dg9kSu/291lOYROsKGO6/uSD2jtL9
	4B2Z9ytn05lZso9OzcNgdH0D5fLgxa8QlZlCO0iMGaMqokC9/fVXJNa3MPgvuAmxgSTUlCROWgd
	HFM7gXcBEdy/7TXfwjZ828wCQrtfgo8+YonQQ98a+wmNlxLyGs5Ik/MG2mA36m+XoDEcLKcBtpl
	hXyBR2dPgI/BslnmORSK5O2JcYejC/TQ=
X-Received: by 2002:a05:6402:a2cd:10b0:6a6:fe1:ab10 with SMTP id
 4fb4d7f45d1cf-6a60fe1ae0dmr6209217a12.6.1787991698907; Sat, 29 Aug 2026
 01:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827182757.6856-1-linmag7@gmail.com> <20260827182757.6856-5-linmag7@gmail.com>
 <20260829062623.GA44338@ravnborg.org>
In-Reply-To: <20260829062623.GA44338@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 29 Aug 2026 10:21:27 +0200
X-Gm-Features: AcwNN1Uqg3WNpv2SMeCAdSi_XoxXWJ1Qgmz64p5ll-3zF-vtkNvtYwWsshSym9U
Message-ID: <CA+=Fv5Qf1AmpVEfscnXPoVB9t1AHSwsPjFs65OzmEUMNER7ZrA@mail.gmail.com>
Subject: Re: [PATCH 4/5] sparc32: move early memory setup to setup_arch
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Sat, Aug 29, 2026 at 8:26=E2=80=AFAM Sam Ravnborg <sam@ravnborg.org> wro=
te:
>
> Hi Magnus
>
> On Thu, Aug 27, 2026 at 08:24:16PM +0200, Magnus Lindholm wrote:
> > Move the early memory configuration out of SRMMU paging setup and next =
to
> > the rest of setup_arch(). Derive the PFN limits from memblock, reserve =
the
> > kernel and initrd there, and retain mem=3D support with
> > memblock_enforce_memory_limit().
> >
> > When PAGE_OFFSET maps a relocated kernel, remove memory below phys_base
> > from memblock because it cannot be reached through the linear map. This
> > replaces the equivalent trimming of sp_banks.
> >
> Rebasing the relocate kernel patch on top of this would prevent the same
> code to be patched twice. But the end result would ofc be the same.
>

Doable, but as you say the end result would be the same. The relocate patch
is part of the phys_base series that's already posted and is a boot
prerequisite on my hardware, so pulling one patch out of it to re-land on
top of this while both are in flight felt like more churn than the tidier
history is worth.

> > -     for (i =3D 0; sp_banks[i].num_bytes !=3D 0; i++) {
> > -             unsigned long start =3D sp_banks[i].base_addr;
> > -             unsigned long end =3D start + sp_banks[i].num_bytes;
> > +     for_each_mem_range(i, &start, &end) {
> > +             unsigned long start_pfn =3D PFN_DOWN(start);
>
> Here for_each_mem_pfn_range() could be used.
>

Yes, that make sense

> > +     min_low_pfn =3D PFN_DOWN(memblock_start_of_DRAM());
> > +     pfn_base =3D phys_base >> PAGE_SHIFT;
> > +     max_pfn =3D PFN_DOWN(memblock_end_of_DRAM());
> > +     last_valid_pfn =3D max_pfn;
> last_valid_pfn can be replaced with max_low_pfn in all places.
> > +     max_low_pfn =3D max_pfn;
> Likewise, replace all uses of max_pfn with max_low_pfn.
>
> Code becomes easier to understand when the memblock defined variables
> are used.
>

I agree, I will fix this.


> > +     for_each_mem_range(i, &start, &end) {
> >               while (start < end) {
> >                       set_bit(start >> 20, sparc_valid_addr_bitmap);
> >                       start +=3D PAGE_SIZE;
> There are no users of sparc_valid_addr_bitmap, it would be better
> to drop the whole function in a preparation patch.
>
Well spotted, will do.


I'll get started on a v2 of this series and post it asap.

Regards

Magnus
