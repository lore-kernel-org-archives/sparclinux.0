Received: from mail-ed2-f13.google.com (mail-ed2-f13.google.com [74.125.228.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B43B6C0C
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550485; cv=pass; b=oUXOTngde8CpE9LDDWjNv8u5U7Y/ZNkw0abrgic1Gt1jAvmx/b836/M3ky1wwB6sLAZomHvgSVl2K868CzB9Ta1iVLCHbQRc5zAYwzwKsQSb6AozxIG21sKArMUuTn1N5Q8p8Gqv8HnwWGkhazhWtOGMF8i+M5LyqhuIMyNh9bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550485; c=relaxed/simple;
	bh=CTNDXQo5Ik8pEUNZkcnEchXw8zaYFKTIx91vzZ5s5LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2VSFgDz28hWKWm1x7GhGCuJeMMT3KgHA+GPUKCL8UpWSYQbSx8LE52rQNjncVJ5Y/v3y6RskBsH/pGGR2VcTRqB+HCTBd/eQR9/JszQ4RJiypUFION7c6tfRH8wgIy8gD3kfdx67Am8DW2kCM/+D4eA6PB1hpuVPhCVSJn/FBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF9Z6Iyf; arc=pass smtp.client-ip=74.125.228.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF9Z6Iyf"
Received: by mail-ed2-f13.google.com with SMTP id 4fb4d7f45d1cf-6ab0d9260baso1300487a12.0
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 16:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790550482; cv=none;
        d=google.com; s=arc-20260327;
        b=LA3hDKsEmzhwIKCALC5TLWmohELgP2yH004nACZq/m4F4jF3JxIwmJ1kr/gwfOx2JE
         NqIP22oZu9Nr5xQ9Lljz7ILn2KUV2Z8mwY+SgXEpRBx1ecayrUtx3oj9MlPgBEgF+YKa
         wBSjjgqVAsO6h4pZ+3f0AOvu1JTvQ88BONhRP0Whqb/O9/1aMmN+dXlQIZBIAGomWIgm
         8gbfgNjAUZYdqhQEB+gQE9Dfc5jb5pxF87Y81bcp7D2FVMm4rM7Ml4sQ2Xzlr9gVibMk
         zrOeLzfpGWXKLJxN3D4Twc5hUzf9E5d4zuu8CUofIIJV+vPeBKs/FzmSWFzs8+W9lK/3
         TQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JG/tCdTlMmUy1VQCk4CZdBjuAkjHwjba+Uca0dFauBE=;
        fh=x/67giKaN3aKu9ysUv2OKPJVkqLPx76eYVxSJtBmRc4=;
        b=kJpqg3m28Z82Q7vpfAM7Xd46+726EmEvzqeW8HCX0LE/NVltOwZz21d/pkr+Q18KVX
         D/o2jh8MUBtpoJe7v9Tt/DYx58VCAfz5a9ZUuAr3/NUJ29D/IHbgoInU6zI92TnPkD1k
         6KErJ/1CNXx/gclcIDV6EJ2R0fuxeGYQC/Jx34HzpkQIGsSt4u2IoKAP9WQ0Tr8nCISj
         xvnmwpw6xJ2rirE+HS1wNoMMEN2vOh5Y0Pn8kFgKikNxHdy+dQrHsaqqC5KOlEXUgX7d
         DyNICtIzcrELaeTXQ2pL++WVDAE122oW8giKfiaRkJf56ARVcwPIgyXHRs2oA7dunFUy
         Kx0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790550482; x=1791155282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JG/tCdTlMmUy1VQCk4CZdBjuAkjHwjba+Uca0dFauBE=;
        b=EF9Z6Iyfy2P/6Loz3rpDWJeRmPhCmWYfpFDgQlsKyJjetf7T9rR6YNb2VmsOWbMAhy
         xRGdj1qLEFC7pfzbSXPdSzK0mwYl3eU9R7UDNgDSX/6FVLoqtMhlPFLh8V2HHM7IWRig
         AssMM5DxalH+MY5/e7uZIl44Wj1bJYxtlVnQZttXSJvK8vYiUINXGQ0iKXp2XxPHb2zL
         ANMMkv7euaPBZtjWSCaZeHKVPUHM9oF4voyNYNpX+OBVbLwRnMPOw1GhYZBgCAxC2ZUM
         4+Gx9iR3pkekQmVn1bT86x+h1JTgQN+R3NRAYVJqlWDz8kstBQcA5+XfjOjuc11sZKSo
         YZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790550482; x=1791155282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JG/tCdTlMmUy1VQCk4CZdBjuAkjHwjba+Uca0dFauBE=;
        b=mtFjsn9sJjP7VABeRw9pzmNKfXWZtbn+rmU8mrW7SHZQgJQc+nrqR3kuz2E0u6YCrl
         VTSXHmmGyAEadrdIb/HdZTZrWnZXpcnEvzbM8spxxk4rqeaSSDZOPfN72VM59CzgXouW
         4RBA9/0tnD/Nn6NZPupHhL2d5NektUTmMEt4qIAS6le6q08SWC+7zeeDUlPKHVKS7M0k
         2TedTXyWoWd7a7NyM6z+Lf7I/3/WXT+gU/VR2p4OzCitXqk5KWVZyx27jOeh8b2kLeYS
         l/KgiDIG9LeB3oxoQmOILCEiXSRpp5gylhNJqkXODHdbKZI3EgxTUrssJpjGCSTi8aFC
         mS5w==
X-Forwarded-Encrypted: i=1; AKwUvBxnKc4v94kNfGGEsDdjHaV4UGkX2Osi9zsxU60xYsYOSvcO+kM7g12DL6UZEFer98CaxPigOHtbFIYf@vger.kernel.org
X-Gm-Message-State: AFq9FYImVMhv1oA1k/X9RmXADYPVPctANjaYH1Larh7srhh87fhtaeU6
	Fz2FNq4DKbxE86fPLArjqRnF9lP7afYAMfb5m2X6STY95agV6pGus7YgQLzuKqLF25qX4ViwI+v
	2MsiF78U1Oy913AgmX8eZMQ6WBqg4tOdp4Ljv
X-Gm-Gg: AYBFou2YsDZnxLTR4Qf2ZQHPSeW9i6bXuIdIOV7zlKjOm/ns/B+erJlu3qkQy7nFcKk
	Nbp5Y6x0QJoVsOh0LBYWnNTKvcedKjFIO4xa9cRoyKCIxeWD0RbYLubCdO5gTi3R+T/WUKTgfux
	XSmcSYC8J5bKBcoNGmaP6VNHjIn4l3l6SgzwFwzSVFmblJhcNdI4RLr8ICTrd7znDV//UMT5HK3
	0yXJ3N+YcKZOPJ7NHwjdiUcXzaa86/sH6rkN6TVVB4RuaKAYorL5wY1HYe65GLV+dKgHF1CjVr+
	gRPHijHPfIyFIn2mnlT2N+y4vIOc5A7qpfUk0Bn9bZoTjs85wmUHGrFEd7EPY7bTAmO7QBLLCHu
	2gH4987J4unigPu3xeXISTva5DUFb5tDctnmc/Xf5SQ==
X-Received: by 2002:a05:6402:208d:10b0:6aa:9fef:641c with SMTP id
 4fb4d7f45d1cf-6aac8f5b1d1mr7218826a12.28.1790550481746; Sun, 27 Sep 2026
 16:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005801.8338-1-kaloz@kernel.org>
In-Reply-To: <20260927005801.8338-1-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 28 Sep 2026 01:07:50 +0200
X-Gm-Features: AclHuK9wHFvF9AvbW3RHi3XsF87LZ25o8TZ7kIUlgFBipgElEQ_7njdLdEtPwZ0
Message-ID: <CA+=Fv5SEwB2b2On=2kEWq2hWMKVauDZ7wqa6+6xPD5nmBgGASw@mail.gmail.com>
Subject: Re: [PATCH] sparc32: don't clear the nocache pool through the PROM mappings
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:59=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> srmmu_nocache_init() runs before the switch to srmmu_swapper_pg_dir, so
> lowmem is still reached through the PROM mappings the head code inherits
> for KERNBASE, which end at 10MB on a SPARCstation 20. The pool, up to
> 5MB and allocated right above the kernel, was cleared there twice, by
> memblock_alloc() and by the memset(). Once the kernel image ends above
> 5MB the clear runs past the PROM's window, faults, and the boot CPU
> enters error mode.
>
> Every user of the pool clears what it allocates, so allocate the pool
> with memblock_alloc_raw(), after the bitmap so the bitmap lands below it.
>
> This has been broken since 2.4.0-test2pre2.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>


Very nice work, this makes a lot of sense.

For the record, an unpatched kernel
(carrying only the patch series needed to boot:)
https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.c=
om/T/#t

boots fine here: SS-20, PROM 2.25R, 512MB, 6MB kernel image, nocache
pool at its 1280-page cap. So the PROM window is not always small enough fo=
r
this to bite. Happy to dig into what this machine actually maps and report =
back.

Magnus


> ---
>
> Notes:
>     No Fixes: tag: this has been broken since 2.4.0-test2pre2, before the
>     git history.
>
>  arch/sparc/mm/srmmu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 9a74902ad181..16d5cde4f949 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -277,15 +277,24 @@ static void __init srmmu_nocache_init(void)
>
>         bitmap_bits =3D srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
>
> -       srmmu_nocache_pool =3D memblock_alloc_or_panic(srmmu_nocache_size=
,
> -                                           SRMMU_NOCACHE_ALIGN_MAX);
> -       memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
> -
>         srmmu_nocache_bitmap =3D
>                 memblock_alloc_or_panic(BITS_TO_LONGS(bitmap_bits) * size=
of(long),
>                                SMP_CACHE_BYTES);
>         bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bit=
s);
>
> +       /*
> +        * Until the switch to srmmu_swapper_pg_dir, lowmem is only reach=
able
> +        * through the PROM's mappings, which may end below the top of th=
e pool
> +        * (at 10MB on the SPARCstation 20). Allocate the pool after the =
bitmap
> +        * so the bitmap stays below it, and leave it uncleared: every us=
er of
> +        * the pool clears what it allocates.
> +        */
> +       srmmu_nocache_pool =3D memblock_alloc_raw(srmmu_nocache_size,
> +                                               SRMMU_NOCACHE_ALIGN_MAX);
> +       if (!srmmu_nocache_pool)
> +               panic("%s: Failed to allocate %lu bytes\n", __func__,
> +                     srmmu_nocache_size);
> +
>         srmmu_swapper_pg_dir =3D __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE=
, SRMMU_PGD_TABLE_SIZE);
>         memset(__nocache_fix(srmmu_swapper_pg_dir), 0, SRMMU_PGD_TABLE_SI=
ZE);
>         init_mm.pgd =3D srmmu_swapper_pg_dir;
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.47.3
>
>
