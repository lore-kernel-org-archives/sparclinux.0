Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4E3ACA4C
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799648; cv=pass; b=nWWvXbM6BrmI5hnzzsW1HaWoga8b6j8zZEsrQ/RwiDDp0WQgj2KjWBJjOGJ6bFFOjjzDISB3vgpI3CTkCcFnD+08vD2tiwWTbH/3StpIbcRv+hqhdklcDPsq0H6dPok0SaRbH9/LVGG3vvc8iFGyG3HD2P5VYNE/DPSb+sfshKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799648; c=relaxed/simple;
	bh=IuzwAnw1rUh62l+FmVmzDScNQgvfcu8ImYzQ4ZCCZ48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9qVfFLjDaT5/b2F4p8nQFdrxqXX2e87a3H3IBrBEOIFAFCMqrmdZgybT2uryhqNvhp7u5MSryaAsbaO4tMa16VynxQQnsf6yUojQmJnZNTsK5S7Sd1XlcK9YCD//IZveso9gaOa5UNh4q651J4pQwwzd1SfHqfJmFRylBSd/mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCDaeE30; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCDaeE30"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c360ab7a6f9so29968666b.3
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 03:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791799640; cv=none;
        d=google.com; s=arc-20260327;
        b=cT1l5eNPYnvAMR7QNeJwau4tW/seHyGccZ9QTECOZBaNAibCc0FxZcL9nvtypOenNt
         6ib0Sd8wTKsJAZPCZnWmkiyN5Gyl6UP3wPtESxWhSKHFd9FXUg6x+OwH0gYHzXBK8NwY
         R9ZIw71TZq410NocXOiPTHE7HPRL+5b372Z3GR75arObjblDA5w99MvPuUaeXF1dtDpg
         F+WKNzYLMCaAs6vF9xoz896DwlsnjuhV4j2lenWrNwJ4fBKHJeCxlYGzeb+MnbUuaPiH
         /4DWKqcli201Q4D7hJh9BtCJOnU184EpR8hYXNQBgLehNLo4eGQE6uR67M4JCsZybMTA
         if2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IuzwAnw1rUh62l+FmVmzDScNQgvfcu8ImYzQ4ZCCZ48=;
        fh=E2Ygc0dXGZn/my4KcNTlIV87X46B6hS5wfK8VzHiLAs=;
        b=MWyPsnLcWMczWc3l3pSPoIPIaN/sJfUYdVHatitFMd6saqqfKC0cKIdxg/D8JpiCCm
         yhno4mbXTDTMp+5OOZ9QPgt1F+iE/oDGIkLn1B18GtVQbKsbjwBtDBLvfsGpIOmC/8Xo
         2iSPS7N9FPUFI7cC/jgZ8jNPDRmGwmylPbEfJdDBmGN2q1snptwFhuL4hVyngAgWjnSX
         1i6lQxkpSC2dc2/7lhGFZ36O4hmqwDdmPnF1viXf4DRBjMb7erbTFlzHlbJ/Sl/yo0tW
         xRZYVNQ90qLhOuYG8zRmMpmBhYUl30r8ko0n+sUyrl2wx5cbvKTMdyyo9PBS0cT/GgYB
         GIEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799640; x=1792404440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IuzwAnw1rUh62l+FmVmzDScNQgvfcu8ImYzQ4ZCCZ48=;
        b=kCDaeE30LnlwUU4V575RsBvUGBQLpO16MEoed1QgUkNcHO2H7YrgkRRN4avRWM04Hg
         R6VcYwNkaIiMDdcQK4F1rQNMkW+/36wSOkm7ZVezvQ9FSS/UGdZQ8nXtpWg91Z9QoZ0W
         4iNXrOdrwIken1VXvGG0hWoKXW83gl7MZBBFyRIxwCfbq2u4On4j2uRE/R9SPIHOp3SN
         Nf2SRu8vibWOrpFfquAG8qVgn+UEmM+7zHytKeDKTTvpG63pIbbKFdzj/92nLOmsgJfG
         CM6FDzmS+G78SUXCR1RzNdS7094DV7SiwGN3A5HAxVWc1h9MURe12KpdqznJO3Ex/xkF
         3LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799640; x=1792404440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IuzwAnw1rUh62l+FmVmzDScNQgvfcu8ImYzQ4ZCCZ48=;
        b=sFWF+4HvtDEMTPw8cHta97OTx+VufuqqyATgCMYtThM3b1FV/Mb9SHFwQqVNOAWQe9
         23eOPNDz+xRGtaU9SytpbtxH3Fyw8D8o08MqIvsKEWc0E53viYLgc8xdyOyH2fTlzbsP
         e403+xJT/sEOVU+aiqMUGG8M+q/tt0N1d0+fUEzyUJXKy/3T5Qy+ZVCVH19SvVTYD/P6
         YFN9aciLHi2svK0e6KSuv1NnF71irW3/jG/XgPhNECpLSCE8iSFCuBR0wB1MOnmft9CG
         tbysJmdIZQdbov84StXUgJCjcOAMgyfJFi86ni/TqNZUEVNBFSAiY8rw/sYeHHKDSz7v
         ZU8A==
X-Forwarded-Encrypted: i=1; AKwUvBwZebBZAhRrxUh9hP3Kdy21q1mXjwr/5+RxpPXi/eJqk44joAHjEO/cftF1YJtCmPZhfa7omxpdVQel@vger.kernel.org
X-Gm-Message-State: AFq9FYJrREMEHLwMssPpVyJXDOeG7r6OdwZ0YAmTb0gc7JM4SKslmMl4
	zJHWit6bvD79Bf3q61KzEJLeOD54mGxFtXzGAWC2eoQ4bF65Z5AIGAhUaqmm21HNbGHdPWoaFvs
	zy1RIIAwQN1IvQ83oRqwQBxHR8H673UYSfY7lLEk=
X-Gm-Gg: AYBFou2XVpgf5Zluqz4XpEdWj7CcEt/oBlQHmENUuE64aY8wVtLqnZz2zBwe+51OgoM
	48+CZe5RTnRiRAZ7t8x1/v2mddEb85cKa3QtUBi+Gld8yDMHW+axSWwDj7CvVg+v/zcgTIGFjs7
	gtk2DqGw5XlOFX3J5FxSqP3lX7Ny7Tp/41qTwFzVDcCyqtYh73kvseUVTxSx1gKD1bVkroPsO6S
	HZn3iO1C5034YT8eBIALdetEFUAGdtE4QTI8AYNVHDdRl6DTUhEREeMOPgtjNrCgHDTApfcVvBU
	vod25zm4RmAEHXys8NWW/Xy6OjliB2NAgwlgp7CXheoiqyjdwVwwyr/ygIcj7GEfefB5HG6Epu7
	xcplfPowgM0ZuGQ7aMx2pJyX0ynyChkiEC9B/Iilg6g==
X-Received: by 2002:a17:907:7ba3:b0:c29:f5d5:5aa1 with SMTP id
 a640c23a62f3a-c31aa097acdmr942387766b.43.1791799640254; Mon, 12 Oct 2026
 03:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no> <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no> <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
 <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
 <b85e047233f5b38cdbfbd7af852ce30055680b47.camel@itx.no> <c4fd9e838043b2b552ea9c33dfaf716a5e9d5b6a.camel@physik.fu-berlin.de>
 <6a37e24972e63cf3c6212644e7c3f18a8a9c06da.camel@itx.no> <CA+=Fv5TZYv53K=c9QFhwCSXJMVyCi5Kv6WjPKUcrPxEpU2BKUg@mail.gmail.com>
In-Reply-To: <CA+=Fv5TZYv53K=c9QFhwCSXJMVyCi5Kv6WjPKUcrPxEpU2BKUg@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 12 Oct 2026 12:07:08 +0200
X-Gm-Features: AclHuK_gp_8Oh17Rt6f79P2JKRz4Gzvy_i50NSJQ_BMTdv9qhTu_wH4lRoaaIKc
Message-ID: <CA+=Fv5Rx5_bbotG4hoZA4W=vZxEc+6Mqh0-Lus62gB1kqg3nPQ@mail.gmail.com>
Subject: Re: Mount crashes with SIGILL on v240 on for-next
To: Stian Halseth <stian@itx.no>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux <sparclinux@vger.kernel.org>, 
	Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again,

On Sun, Oct 11, 2026 at 9:28=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com>=
 wrote:
>
> The latest kernel has all of these enabled and boots successfully.
>
> So the failure appears to depend on some other part of Adrian's full
> configuration, or an interaction between several options. I will
> continue narrowing the config differences.
>

I got a bit further, created a bug report here:

https://github.com/sparclinux/issues/issues/113

Regards
Magnus
