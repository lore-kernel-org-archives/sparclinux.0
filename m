Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AD4F3EC0
	for <sparclinux@vger.kernel.org>; Thu,  8 Oct 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483806; cv=pass; b=uxMSYgAeh2XyVtiyOfHrGlVVoAFHIu/Ro+gQaE2uQmZMMIkAYeCXWEIDMSJJ7yRlQ/z6X3i2U0CUR5VpQQltXgi5ZlktEekNxJljs2xV2XuwrBi2vpgBpKPBYbenbCkV4TqvFdL2yr1mXfCdic1fYOfRP82mnQzFjuVqT3uVmns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483806; c=relaxed/simple;
	bh=Of40/D+2q7EuNroFiUgmRpSmrGdz3Ew/fHYx5vQm+dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/VOMNfA+vU5pSZUOzSfyZBqE7qAOXoy/Y31VGRtEfFqbgJRW16AkTfoscUmunD2py3fOROn3mpuggzggZ7JtrF+vhEwa76RrQNt6d6Thpu3sZITbFO+SDjR2GLLc+6t/HbWVDCpMq9y3LFZQkJZrij+CbtryeTAb3v/WLI+PG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzWY/B4K; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzWY/B4K"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a9bd4db6ccso7458943a12.0
        for <sparclinux@vger.kernel.org>; Thu, 08 Oct 2026 11:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791483802; cv=none;
        d=google.com; s=arc-20260327;
        b=HZpobfeTiyqxNFOJmChCTxWTK4R+REoWoVFIrOCWvz5i7E5J7iC6P+LKjwo7bW5Nbv
         RotTwmEmDbVHDqjgGpiXuvPGMaIFa+PiTRm4yZg91+xVKOC3y/i2P53iYj9VynYXyvs+
         847tuWU+092tGTYrKsWmCGExsAm3sT3Qs6xQMtCKhPrus7/drfdUArCapyRuMzscbbvj
         tRg0xgQzWBI6+vUJN4E5RusmJPNEvAMVcK0g15DJvK1PgCnEtnWM1igyCaDzvrxgadnL
         hh+6ogSp+qo8XDkiZBxmwNU5L2SoHg38TmW9aMb3HQjW7niwewsqsh084+qC8cUIC5dj
         Rzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qGB3yTtCVZXrcHj1e2uK63lVVVjDF5LreVlgkZI4Tg=;
        fh=dteoxZ+/4XMmELrlPlg/FlQC2vj68EXU/fxFn0SVx1o=;
        b=qsNl+1DvEqVV4hQb9JsIZLiJR1M7/6DcAK80+zQiQswTSKaE/H0GrYF4KKi1wXb9CD
         z3+Ky2qqKCjbc3iUqVBnMiHrEjCfqrtV+JsY4x3yn2ZI+9B0Tyq6aCVbrt4oY3yxYjDg
         3laG/6Tok5zJwSpGPuJcprGy5e7U7D18ZJhGxsUZrPvFgKFZarsPFUT1y5WNp0/bOfe/
         LYwOyXQVPGFyFE2RpR4LaPGx3iAM+nzQ4rdvwMxOXg0ZOF6yAEP8wlU72fuHH/ucX1bQ
         p7T1Nxbxi7DfDxBqJlGfFROuCP74ZcFwi2Dfg5xVT135xXFH2MugpqeEZOP+Exh08rGD
         LHSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791483802; x=1792088602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qGB3yTtCVZXrcHj1e2uK63lVVVjDF5LreVlgkZI4Tg=;
        b=TzWY/B4KvWsgzmObIAZmNHbTrlXsmAG6OR+fL7vmQBtxa3eXDUgmkt4RfyarQtszHJ
         UjWcfVm7WlufvVCxuvOCQgYjpHSeApakemW7RuVduFZRBvyFugP0p3+T08A4Pxk5PeO/
         Gzd5mc/bQxmxqsGT5GYo+Ggl1/ncJ7OqOT7phm+NCq6TkZjCsW2igzexmYNsEngLsMoN
         bhsfBD22/IS/MEz9AAAHKFU6McUVaZLyR11/IpDFV/edUSdBD979ca1Lcd/3Dei63ubJ
         4b1EbPaiZWc7SJEOUHm3CS16lqb+22/BX/kYv5n48BIrfhlznedte4iiBOvMve+91vmQ
         VuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483802; x=1792088602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qGB3yTtCVZXrcHj1e2uK63lVVVjDF5LreVlgkZI4Tg=;
        b=2paZUn14gOcifOXOWpY/s9L3RBOfhpvnjx5ERNsQFn9tqOc0kZ6MTjoxy8ALOJsFkG
         /qaw7Auogavc0CYD87iMfvVIFq6Cd4eruluXgwZRVMotggcZCtrP+CFb5oQBQN2RxVdS
         1I1JgDDUe9+syxcVfVC0qJnAzPCcqNxAQ5XCfjhBPJrYj3N4kzuMIPTE8uGZ+5TBZ5iS
         PJPq5ZJ+IA95ncJekRBV8FKlkDww6XpzJzkmcFAL3BP1+li/3pz3bmFMBNiLxFHuqvJu
         BZgXnJ7GftMCD1yFY1fuSlo/Z0+Rge/yeFco2Q5PCoSe5lXO622I2bOKz3rPMy7GDG8b
         yiqw==
X-Gm-Message-State: AFq9FYIo00+T9p3H5HyqJMd4rDOUcGvv4MglUDc3JlaBEfdm7XQC/oi9
	OVOLw0XJkWz/Ny5VGC1HcY2LG9K57i+s2xlBcKjCaurp55bVH+zNHFoyQ95mTu8yL41Lkn9riBu
	OR3Df866W4jjBDISUJ0W7JJFpCSK2aVc=
X-Gm-Gg: AYBFou25KoWkVY6XW5QpjiCa7/1tq0JDDZRtzLVrkOxLdr4//y/uUgnnoS6R5LSNbQ1
	emqJxewKJh1NOEHykn4R81TWR8avmZJRh6xZrwqb2sSF2pDnwb+eVmNs2dSWmYvr2cO9D4YGSxP
	0wNoUm0WdRPAAP2vVdHuM+6yFOhTe4pSpJXiX3VOTBxNAOKgRjeQ/m4LL+TEhTSvwvVjLlMYWsw
	qPa1Yd9TFGfa2evLG6dBv0Vmn2bOM8JpH4WfHCsCr+9zwWIzSQzRNbK908x2v1z5LBxcYnIHove
	9ool8HU9rD2LBP5ljztIIxOpdykgLzQxjYNDKMesGhuDxjEgbKeMzimKUCFyLY6qDTkzfiuOPBM
	sSl/2Ll5luOF6slNuoiwbMN4qJOfsotpUZwqSzAjGhA==
X-Received: by 2002:a05:6402:2348:b0:6ac:b3e7:2357 with SMTP id
 4fb4d7f45d1cf-6aff28fc46cmr6370997a12.21.1791483802293; Thu, 08 Oct 2026
 11:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002161515.932316-1-linmag7@gmail.com> <20261002161515.932316-7-linmag7@gmail.com>
 <20261008095802.79671bd1@kernel.org>
In-Reply-To: <20261008095802.79671bd1@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 8 Oct 2026 20:23:11 +0200
X-Gm-Features: AclHuK_YT4n7UtkmP7VNOeDIFq25O2F-pzFmRQ2myWVzNADzZnCn6eteznczwqQ
Message-ID: <CA+=Fv5RzceCozPFvpffbgoiV=V6t+mRxgk+UzF=TEBNO9aaeUg@mail.gmail.com>
Subject: Re: [PATCH 6/7] tg3: normalize inherited M3000 register byte order
To: Jakub Kicinski <kuba@kernel.org>
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Oct 8, 2026 at 6:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  2 Oct 2026 18:14:28 +0200 Magnus Lindholm wrote:
> > M3000 firmware can leave BCM5718 vendor registers byte-swapped while
> > standard PCI fields retain normal byte order. Match the Fujitsu 10cf:16=
5a
> > subsystem, IKKAKU model and swapped revision/product signature before
> > restoring host control; reject failed PCI accesses or register readback=
s.
>
> Is there any dependency on other patches in the series?
> if not please send this patch out separately
> --

There are no code dependencies on the other patches, so this can
go through the netdev tree independently. It applies to v7.3-rc1.
Booting the M3000 to test it requires platform support from
the rest of the series.

I'll send this patch separately as requested, dropping it from the full
series as I send out its v2.

Thanks,
Magnus
