Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B86414A1F;
	Sun, 18 Oct 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330695; cv=none; b=dRYly4t2mFS1Oqeug5KZuN3mzBP8Mfwr6D3lqH/dxZNpgoiW+iEfFl9/ZmEEqDsldjTgxjPQPsJyt78J0LuuZNxRoKxh245xMv2oKwGdiaoKhxeykHPat1VkrwUIKcrzHbCirwCfX60gN/HqaYctbnth3V1jzkaHzDRBuDXMbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330695; c=relaxed/simple;
	bh=O3PNJs4NiGtilEQpWdRqiG+quBu7ASA7JyGTHSsV4qc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhM5DBzse+Q3rKM6r3b4Mw+JhCoHFeUnkorcaOP5J5UOarjJkPeJWPJuxRZYuwC9uXVS+uAYvARjanNoAO2DH09Y0uQ1ARSFsmB5WZFvXrp+2qoNp9wwvZl6/hUVNRwHn2DiZuP45G8Ru6VlabRTU+cRzFyVxgX39ybMgxW1NEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=QQaIQZeZ; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="QQaIQZeZ"
Message-ID: <4f7dacd9b4cf0a43209be84f2408e6f7e033fd3d.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792330692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3PNJs4NiGtilEQpWdRqiG+quBu7ASA7JyGTHSsV4qc=;
	b=QQaIQZeZxo16u7UdAOq4kPy1bHh5wCdCBH3QZYCg5PimPB58GI9wTdfFUotn+h0Z6v2BVp
	u1poagQVYS3BGkVyq/Md3JtwjPxUGO4tWjKXdDBlmhiq53uFEsv4XbrV1lGHtHYHOXUfLl
	cIxyUDqNWLy862uBUKeV5H2v+UifeUU=
Subject: Re: [PATCH v2 0/3] sparc64: Randomize mmap base and PIE executables
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas
 Larsson <andreas@gaisler.com>, "David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>, Michel Lespinasse <michel@lespinasse.org>, 
 Jan Engelhardt
	 <jengelh@inai.de>, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 15:38:11 +0200
In-Reply-To: <6e2d2b2b7aa4029c261831016d8b6c40bc335341.camel@itx.no>
References: <20261018122734.2594904-1-stian@itx.no>
	 <e3068b5c97884032e7cbd12c78f6b5534d75e30c.camel@physik.fu-berlin.de>
	 <6e2d2b2b7aa4029c261831016d8b6c40bc335341.camel@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-PHAaQr8Laoy3OBzen5hN"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-PHAaQr8Laoy3OBzen5hN
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


On Sun, 2026-10-18 at 15:33 +0200, Stian Halseth wrote:
> Hi Adrian,
>=20
> On Sun, 2026-10-18 at 15:09 +0200, John Paul Adrian Glaubitz wrote:
> >=20
> > What about sparc32? Does it use address base randomization at all?
> >=20
>=20
> sparc32 is at the same state as sparc64 was before this series. Only
> the stack moves.
>=20
> I've only tested 32-bit programs on sparc64. The same approach will
> probably work, but needs testing on real sparc32. Could be possibly
> be
> added as a follow up, if someone with sparc32 hardware can test it.
>=20
> /Stian
>=20

Additionally, outside of qemu testing, I'm a bit worried about sparc32
machines with virtually indexed caches. I've heard those can be fun,
and I wouldn't feel confident about implementing it without testing on
the "real thing".

/Stian

--=-PHAaQr8Laoy3OBzen5hN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatTLwwAKCRDoeAEuJe36
Vl7RAP48VGMJlbwWIQ7VHqi25QkjzG+Eh44RA0bTgOXyVfzwmgEA8nOr9l4i+AbW
Ux5a921hTL1xjAjla4+mWeEC5nU7dwY=
=2Xlx
-----END PGP SIGNATURE-----

--=-PHAaQr8Laoy3OBzen5hN--
