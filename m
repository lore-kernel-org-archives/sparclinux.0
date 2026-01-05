Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBF30B512
	for <sparclinux@vger.kernel.org>; Mon,  5 Jan 2026 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639909; cv=none; b=ecqnahDXImsQ6fzftWz+7uIp9dBaBfxXkFIYjccRzPKiAdL1SNlFi8VM/40j8GLZeCcT3pro0if8GSNWGccfoM2DJSDTPh67OFxrC+6/mpxdQlNepvlz3serRMQmyXiGpKarPmw+MHz2fWVPxqecY4BWVE/+74pnjr8gVwmKMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639909; c=relaxed/simple;
	bh=Gx9eSAVj6IjIV1MJpCWyW5YSmZ2/sdTWOEru/YL3xKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGZgb7Niw/1vFh4P7FukWAKIx8DkMSkJHHWaEra5YuHuvngQ1IhCXWeTGFl5xU0nnysY65PAfClY6zxoeMHRWkJyGVotPB+O7upXQZNz59Md7cc39/PqN3pVyvJOQX01SWezKJfmmZHtZ98sgZsPuDCyj56larpFia/KAlNk/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdUNqBQK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdUNqBQK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775895d69cso1431065e9.0
        for <sparclinux@vger.kernel.org>; Mon, 05 Jan 2026 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767639906; x=1768244706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+T85xG7RFn5rLmFPcEnHN9rx8p/ELEmXn/p/BMRsk4=;
        b=YdUNqBQKJEX+77z3OK0BMbFIGnG9FUSz9ocwbsaeRS85fTTMLByCu9om2Zej/u8jav
         GG7+0mmoe+rzbzTA2+11anpt7HA6faMgzIC7c6/9XFiUUbPYkn/4p+xo6gSHhsTPtS7Z
         43pK1XO9KGjyTAnoo1yjBTam0lrkaqWx46nDH7Yvk0STRr7T3418xPAuPqUu6d9E6YMi
         /7h9c/Ya1oYwTmC/xL9Vmr9eGQH+ip5eDfi9O2u110ReCvCUdsuC2q6elLgOoImVt1eh
         YZtvtC6SJaKZwpSVl7/zLeydpNYwsJIpxu7qimGMOcTYXdrNhY+vJw2lFW20tfcxC5PA
         KQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639906; x=1768244706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+T85xG7RFn5rLmFPcEnHN9rx8p/ELEmXn/p/BMRsk4=;
        b=fNQbC8YRTbQBxDUiGuthFa30yMyN45KdxApVMj7WFJjV6ive6lASOGOph0QrCBQntt
         QCLkRNr4InV+oel+s/BDBt/bnNajeoNgFiMsGQp3ZW5svuJMhu5VO4Fh06Skz+O2MaR7
         K7p2+jEKeKG9NUaaT8gYiSfs5jccrgyslgkFjny74n4+LfajpHRIKTFhzDAkbBdcdVMa
         ehDYo/1ATk+aztrGagsKEHZ4S8ZWgoDG2qFELqy8BK9NKmrC79uL3xOPkY8wCM/2Qa+W
         FCAVz4X6v7bXR1tzqfsdr1/eoSsVCfgNA3ypYEdCTzFC2F1Z1REmw2ukQNzjosEaHExA
         vLWA==
X-Forwarded-Encrypted: i=1; AJvYcCVExnj4rKKJta9mm0zBIEuhKSK1oT6uENXa5eulpnsl+39lW1G0gqql/HOWdB9n2PyntKvbAiEIUvlk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiu+9ldGX2GL2MC92DdMCKLkkAyNxtyCOWd0ZPEvvz5fiT/Y1c
	WwvSRYXxKRQ2WT7m31+Rbrgmo5lXxDSZ6kEW9Dcvt5EamA3laR6Zay+v
X-Gm-Gg: AY/fxX4C+XfLDzvdSrx30BfMkbntc48T5LMdsdkholXWbohuwOboSXi4Pb7Cm8vQnxK
	PP3QhjZGZLynX3q4IA1duAkj34VJOBlBVub2pQdqKdcEH0XuI/gfLbQAehC0Y2mxQUURw5BWoVm
	8UQ1IEOsOO3DtaGn+mkh1GmbjcesKnV2ziaVSHGncC59mwtkhpchppYmny7OzXUp45eM9CLyETr
	RLcywsOJLPkvIP9So+sAEOOqSFuJsVc0/jVnkKx+Z8pp8VRPMIelMgqezgCcwJ8EFTdUUG2vB7m
	+XXP3aNNvFYkQ7lSUpEbW0A9meK4NQjRJYqhtSnXRvT5cJQaBlqNFzDN03U/886+lbA5k/+JIfu
	eoIvx4fayvbps/xkMI2abCQwMNyM3VHWhqmbTP3HUHYC5WSWZG7Ow1RgEN9sgdbyUfukrhqkxgU
	LKkUzK7Yk04NoDUHudtqnx2lvi3zwBO9BoDk1aIsvi8CNnGXC+/mNTjRL/vTNe7yo=
X-Google-Smtp-Source: AGHT+IGlHrTGN9QhI9D4GcPAN0WpXBCiJkY6o1Su8HuTrk460ua/0mSfGa1CiVo2PPimvYizFp7ESg==
X-Received: by 2002:a05:600c:4f93:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47d7f0929c2mr4085365e9.18.1767639905594;
        Mon, 05 Jan 2026 11:05:05 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm2991115e9.7.2026.01.05.11.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:05:05 -0800 (PST)
Date: Mon, 5 Jan 2026 19:05:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: ebiggers@kernel.org, Jason@zx2c4.com, ardb@kernel.org,
 dengler@linux.ibm.com, freude@linux.ibm.com, herbert@gondor.apana.org.au,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 19/36] Bluetooth: SMP: Use new AES library API
Message-ID: <20260105190503.53cc31dd@pumpkin>
In-Reply-To: <859377de-cb72-4e87-8ee5-97f8c58a5720@citrix.com>
References: <20260105051311.1607207-20-ebiggers@kernel.org>
	<859377de-cb72-4e87-8ee5-97f8c58a5720@citrix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Jan 2026 15:40:22 +0000
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> >  	/* Most significant octet of plaintextData corresponds to data[0] */
> >  	swap_buf(r, data, 16);
> > =20
> > - aes_encrypt(&ctx, data, data); + aes_encrypt_new(&aes, data, data); =
=20
>=20
> One thing you might want to consider, which reduces the churn in the seri=
es.
>=20
> You can use _Generic() to do type-based dispatch on the first pointer.=C2=
=A0
> Something like this:
>=20
> void aes_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
> void aes_encrypt_new(aes_encrypt_arg key, u8 out[at_least AES_BLOCK_SIZE],
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
const u8 in[at_least AES_BLOCK_SIZE]);
>=20
> #define aes_encrypt(ctx, out, in)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0 _Generic(ctx,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
const struct crypto_aes_ctx *: aes_encrypt(ctx, out, in),=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
aes_encrypt_arg: aes_encrypt_new(ctx, out, in))
>=20
>=20
> i.e. it keeps the _new()-ism in a single header, without needing to
> change the drivers a second time.

You'll need to cast the 'ctx' argument in both calls.
All the code in an _Generic() must compile cleanly in all the cases.
(Totally annoying....)

	David

>=20
> ~Andrew
>=20

