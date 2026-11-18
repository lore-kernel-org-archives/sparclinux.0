Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000555;
	b=fp0lVpww7cFSyuEr8sB2erYw/xnRsTQ2jWUyFIzs+tDDQEh90Wr347gAcCRTVc0JjNE7
	 XsgVm4gTlvv6kfN/5WAInzZKWpKVFYwmRAF6mD/HApdZ1hwULZgR3KxezENso5aM+snhK
	 MEjNHsE2ElIFcU6hkurwxwiR6Dj5v0TfDaJcdEKfM14G0/OvDzk3Xw54Q0b0Mi1eRfjQb
	 CVi4xtt0EhEmcy/PZQaeMu6sxVhM0PVoj/fC5FCQJuTCwaNG7xFNEDfMhNdzntcugd+yv
	 UdpfjYpe+zxEiabx43rcpgzvesPvkA/jBgnIG10jEGZEDkcJHCrv1Bv8xcqgAeOrmpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000555;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=Y4hHKOCSU2CmbP8FEKSLsQJzoNedloCjuCXqEcxU9FM=;
	b=YuI2jN+bXpS/pVX1UDvVJdu0wfDcfbynS44uOETyHWta8LpmOGAbWkA406eK/YHsGJL0
	 gYAml1GF70gAr6C0OQw/vRsr+cDpSAebTsI2rS64Kkhksg3XKNfdGkctPzQ4qykGwawZp
	 SOJBiNtITj0c41SgZSGD962qWwb26N7T5Q91mwJgIvB1iQJ2JF6OLEaMuHBNtZf7EYGfJ
	 ci5z7fAHkHmfQhfSmyzbfh0SFgXOUfjGCcP9bX4V5x3NfqG0Eci/e4HN3v70BGO/kigEL
	 Ae3w8aTB2tmLDfYnPWCrQInIE4at/qLkjUv99zx7c4DET6np8ayBeHWBI27MRMso2wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=jJW1YBwm;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA260A2601;
	Wed, 18 Nov 2026 11:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1CA260A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=jJW1YBwm
Message-ID: <51593f27903fb901f7c34e3c084d1c34a126e567.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1795000552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4hHKOCSU2CmbP8FEKSLsQJzoNedloCjuCXqEcxU9FM=;
	b=jJW1YBwm3C78/3vUAUiLSB5okP4vTdUjECOQRa/X+YgAfsFTxxScUebAebdNRx2YHvcXgO
	bC0U4bXiHqhVGbhwNoUcSAnw/ZAbAU6E646B9nm9z30+Ck6BJWxDWz4alVSQ/4sY4Su5BF
	5s/Slsky5tEZ0eMUjECFdYqQSuOTY7E=
Subject: Re: [PATCH] sparc64: Read qemu,hwcap-list from the OF cpu node on
 sun4u
From: Stian Halseth <stian@itx.no>
To: Eric Biggers <ebiggers@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sparclinux@vger.kernel.org, Andreas
 Larsson <andreas@gaisler.com>, "David S . Miller" <davem@davemloft.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 12:15:51 +0100
In-Reply-To: <20261118043857.GA3400@sol>
References: <20261117112914.2300417-1-stian@itx.no>
	 <sashiko-outbox-218725@kernel.org>
	 <8c0c3734b9ad1ba0072ce1fbcf895b544563798f.camel@itx.no>
	 <20261118043857.GA3400@sol>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-siijRfQfDx5NwjZLvIFT"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-siijRfQfDx5NwjZLvIFT
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 2026-11-17 at 20:38 -0800, Eric Biggers wrote:
> The following series migrates the remaining SPARC crypto opcodes
> accelerated AES modes into lib/crypto/:
> https://lore.kernel.org/linux-crypto/20261118041033.50014-1-ebiggers@kern=
el.org/

Thanks, that was quick! I'll send a v2 of this patch with your
Tested-by. It also gets a new first patch=A0that addresses the Sashiko
finding.

I've also tested directly from your branch. With +crypto, the KUnit
tests and the full self-tests pass. To make sure the=A0library really
uses the opcodes, I broke the AES round instruction in a local QEMU
build. The AES tests then failed with +crypto and passed without it.
I'll also try it on real hardware, a T4 and an M7, and reply on your
series.

> I think this is the only case where a Linux architecture has
> restrictions on when memcpy() can be called, though.  It would be worth
> finding a way to remove that footgun

Agreed. Not a full proposition (yet), but perhaps U1memcpy and
U3memcpy could fall back to integer copies when the FPU is in use,
like NG4memcpy and M7memcpy do. I haven't properly looked into it,=A0
but I might later.

/Stian


--=-siijRfQfDx5NwjZLvIFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCav2I5wAKCRDoeAEuJe36
VifkAQC/AxmvDhLO+ORuG8DbZsBS/uFyjlZEJpTFUiDZAQfzCgD+K/aguaFLYTg8
r4fGVnSPHVzb+dt1eX4ggNH+QtwkKQQ=
=jGxd
-----END PGP SIGNATURE-----

--=-siijRfQfDx5NwjZLvIFT--
