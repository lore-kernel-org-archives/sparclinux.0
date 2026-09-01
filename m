Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178921FBEA6
	for <sparclinux@vger.kernel.org>; Tue,  1 Sep 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270856; cv=pass; b=WsaOXgsSVZik/UvSPYUavgOtTx1aa8LD/WQTyoYl9KJczONlHtbExCFTQ190jz4fjBrF58wSuK2GLQRdKb5tblaNUebVgvhzyoQ2Y6/QcqirOfBEmKeqjzUPo68tiAhqZ//jUyMu1MGOwrcwwmM8A7aPQe4ZHyeFxKDISLjTzAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270856; c=relaxed/simple;
	bh=nklgLPfJRHctBtbtLaS9gMySV66Qnszrm+swoA1Ytd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlRNZsUsc6zsi1aCl/rIM4WmAruOsYqwhG25mc3ESNiX1dS9ceI8+D806b7MJRZwhI90WSUkcMddXA0ZKhviLkylsCIhRm1lXO2Cms4aSlcZpagvp/BW45QpxFmATjTjrV5KsEszH6JomemOyoVvh4OpXgRoe9RZVHp31E82ilo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUZmm32G; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUZmm32G"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso481632a12.1
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 06:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788270853; cv=none;
        d=google.com; s=arc-20260327;
        b=AZSs5B54Ty0ZRnSgY+ssBjagQBrYJgNLqhR42vH6/g1Frs6x7ByiASp8QQBV/HYsxw
         olN6Pv4Ek3WQqUoiJm2aZ7gPTvn0MMWVeFRVpZSMDsFyZSTGxLv8XXeKoZI4Ygsszrky
         YwP1G60IKX1OcKC5p0nYwrkyF+z/X4lt9WNSfLAK/bi0Pae/Xea3KTjHy7OImB8OTIXM
         Vz4Re22sAZKsCnvxYqA9p8kQ2JFk8veH0E5L5iv5ybbHPZ3YNNAta4xVoat3EkGeAdSU
         /LyWX1Pvi1HjuzWV4WRBpxvYkxXuDNmcq9gIkraI5C1wtNeovqceijERwUEcqK7Hv1ef
         Yg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ulo3g+NwIm1JGOdXuJA1Xyyl2IN9ayh+l8FSH/4IwHg=;
        fh=lIBdiMTals0VDbKkknJNa4hZrTGWR7Btvm26/3VRa0k=;
        b=lJpsWDm/8DY4ZfkHJ+Bw90lZ46HFwi6MO1R8n7pUBgIcPODoEubC0wGj7dyxq0vdPC
         b93i47WVlufmTRZd2wliPsTw2nYQjsrlMe64u2pB7ms6IxL9gLc+C7WvsmJhO0HyvHd5
         rTEU46O5alTLMr0WthxtXgXdshrp1a/Z+lpaUvjeWGi2OeOPgAkFdUTyOGIJBuS9VvBP
         ml+F6X2k5lrgoflHHKrHx3je9zBPWkMWDcyxZyQcBg4dGrxoEqAXPb+5uCoR/dMZzXO5
         1YV0hRAqycqm5DvkicVV3JPjey3dKvgmY+mI001rnqWP1hAPc8f/zb67Nsoyl1BBasfx
         uXNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270853; x=1788875653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ulo3g+NwIm1JGOdXuJA1Xyyl2IN9ayh+l8FSH/4IwHg=;
        b=dUZmm32GvIJmVibW6RTHMDt51Oh/sjjEhS9LbxUYupJsdFXQ6Axihm1XBvz20G+ATZ
         tsHh7QkGl0WZwR6un6DBWoo2IXP6/q0ay3i3OliUQekHlOyGXr/rnp5ysdHsqlc43I0P
         LZGzxds7MkGTdZiM4TRCrq6+UuMh4U6fHrhP7ZQJXWq+djy9PVdhGykBtTrFKH58bOyy
         xlC6O8PfQilk/eaiK1rYlmuFkj0MdSD0Pxdctw3UEjMctkDnEkiLNAEwb6V2SiVO+mWU
         jodTa5xvRQjnAU7bpWElPdjArES50UujDYEW54ug62MiADRhFifAqp5uycsZsEg0NLhi
         cgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270853; x=1788875653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ulo3g+NwIm1JGOdXuJA1Xyyl2IN9ayh+l8FSH/4IwHg=;
        b=ArFJnvCgngK9NVKpQ0FgE0W4P9iM/t495WZqZWSWrH+yABznnF+zxrk0gtbIpf6BV/
         VB2yg+2UqnCbuIfrJQgsj6ELGoOCnVp0xTtD/I15IqUs7KA6zuc2O3BaKaJHR9/c2oCt
         V1LI/bEz4HN2xlqXMJWaBGwlI5OIimep8UWiwFfRZzD6EAc8NpsAHKHzpom4SxpqYC0q
         E+9jWYkGW9JXibPHr20IdfA+VwgSyac3jyzPus8xzHHoNzOc2kwhc93nU8RvzMzCInar
         wcrhfZwybU9J6B+7O/B8f5eI9gEtliisNaL642uOvExhjxozuIkWSDyctGnInSJ+QzLK
         5w1A==
X-Gm-Message-State: AFuF++lDzJszyFk2Ncf3riBS2TC6EBPJOgnGzpVlwu9m8nQY7CxpCnpT
	T6h0Xk+X3/jYAmJ59XoVjVNcvnzdnexoc0Cnkx1CRHoHMjvaJgliNpLQwqapp3bYgjp0G5VQPAk
	OA9hbhXioctzkulySK3iHSNwDbN7jmbc8Hfro
X-Gm-Gg: AYBFou0wFcz5ZO59Vw/cvtm8P8Z2uYbwPJ/kWNBo8dW3rqNXGN+BhBrJsgrXqja72Fk
	KNsv4v0If6H6KvZdYWwLuBMLawuRuG9M+z493YC9vB7w11KUyansq/3y4TOfXAEjW3O78lKceWz
	APe/pFiz/aIwlAu1qsIleE5LLL+WTQwOgd48WxHefg4Vq128AEdgXMYAmNMFxHPEm3sZE2+Cx+9
	8KIYVV2R7qUHu0QVDKXSIndPRFssMtlXqqyKcCrS4s2btfrLcmkR7rJQQ6TrKXYjxrkYfJIIj1u
	LwFb0DqOyNbRm4sJNScP7NfdyO3O0k56NyxoFCiLwum5yXFXdVUk89nQnGxQ3dNlCk7hflMr8aw
	t/w==
X-Received: by 2002:a05:6402:2753:b0:6a1:c908:1701 with SMTP id
 4fb4d7f45d1cf-6a663b0cebfmr5071769a12.13.1788270853073; Tue, 01 Sep 2026
 06:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830120742.20950-1-linmag7@gmail.com> <20260830120742.20950-6-linmag7@gmail.com>
 <20260830181926.GB173328@ravnborg.org>
In-Reply-To: <20260830181926.GB173328@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 1 Sep 2026 15:54:01 +0200
X-Gm-Features: AcwNN1Ujzqq8uSBYZYR26NfQu3bI-0Yzhq3DaXzDvavXmWNc0ExNRc2BNZ1AaXk
Message-ID: <CA+=Fv5TV6YAeLriGHxQQ6Sv4PrMFYYDk=n2v92kpg8srb1tSHw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] sparc32: move early memory setup to setup_arch
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com, 
	linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,


Thanks for taking the time to review this, I've put together a v3 to addres=
s
your feedback, will post it after some more polishing.

On Sun, Aug 30, 2026 at 8:19=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wro=
te:

>
> We have several >> PAGE_SHIFT and << PAGE_SHIFT.
>
> It would be more readable to use the corresponding:
> PHYS_PFN() and PFN_PHYS().

I agree this makes sense.

>>  #define PFN(x)           ((x) >> PAGE_SHIFT)
>A cleanup for another day is replacing  PFN() with the standard PFN_DOWN()

I'll make a note of this, maybe we come back to it later than.


> > -extern unsigned long last_valid_pfn;
> > +extern unsigned long max_low_pfn;
> This is already declared in memblock.h:
>
> $ git grep max_low_pfn
> include/linux/memblock.h:extern unsigned long max_low_pfn;
>
>

This is the better solution, thanks


> > +     for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> > +                            NULL) {
> No need to break this up, we are not above 80 columns.
>

Yes, I'll fix this.

> > +     min_low_pfn =3D PFN_DOWN(memblock_start_of_DRAM());
> > +     pfn_base =3D phys_base >> PAGE_SHIFT;
> > +     max_low_pfn =3D PFN_DOWN(memblock_end_of_DRAM());
> > +     highend_pfn =3D max_low_pfn;
> highend_pfn is only used to set max_zone_pfn[ZONE_HIGHMEM].
> It would be simpler to just use max_low_pfn and get rid of
> highend_pfn.
>
>
> This part should also set max_pfn.
>

Well spotted, that makes sense.

> > -     if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
> > -             highstart_pfn =3D pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)=
;
> > -             max_low_pfn =3D calc_max_low_pfn();
> > -             high_pages =3D calc_highpages();
> > -             printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> > -                 high_pages >> (20 - PAGE_SHIFT));
> > -     }
> All the above are not needed as the kernel already print HIGHMEM, and
> this patch removes it - good.
> Maybe tell so in the commit message?

Yes. will fix this.

Magnus
