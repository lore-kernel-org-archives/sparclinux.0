Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70D4A2E1F;
	Sun, 18 Oct 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330420; cv=none; b=azWObNaIxUldvLOVXJ+6p2m+5N9seHs1LZQiNntCyJgvw/vXQjCuVdwK2WTC0sqGprPVp4xSzG/pjIjyoYbdJEwXRokBeXQiE2gZXi7oJyXsCkVwswJKAMU+JfLhSCI+/yS1FThH/xHKzkjtEqSXlVXHF85DU/S9mjFVDG04hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330420; c=relaxed/simple;
	bh=AQQHc8mqQwzEWaZJKjdUsWnAkv2Pj7ElJzu+1c/Y+0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnZJYauelWsFPA3pgmqkDmdnPqBWpNv/SPnKghuiFHMooGM2sCPzwHpthaRe1quiey9syHPywSFmP4JXR043inRMIwzNLKSIgGZyqGbfCaV4/nasLc6A9tgx5LKKtyQW7EP/JJp0WyhWrVpoJC2SYwUuiC1s5OwS6aqUB7d1ZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=BiS4kDin; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="BiS4kDin"
Message-ID: <6e2d2b2b7aa4029c261831016d8b6c40bc335341.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792330416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQQHc8mqQwzEWaZJKjdUsWnAkv2Pj7ElJzu+1c/Y+0s=;
	b=BiS4kDin0j8DjT8+hG7vAf4x5wPII63Po2he4KcBSryhUiXa5G20MxsgjOMRqulB3rq9yW
	vcx3yVrlzrFOkx2P5nqG+ihL/r30eWeGeZ9TV0ajYl6ANaQcheFjI/8ImujmrA1EoRbK1K
	aHDUXh2nSuCmdFKIcyhkDiMquf4tQgw=
Subject: Re: [PATCH v2 0/3] sparc64: Randomize mmap base and PIE executables
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas
 Larsson <andreas@gaisler.com>, "David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>, Michel Lespinasse <michel@lespinasse.org>, 
 Jan Engelhardt
	 <jengelh@inai.de>, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 15:33:34 +0200
In-Reply-To: <e3068b5c97884032e7cbd12c78f6b5534d75e30c.camel@physik.fu-berlin.de>
References: <20261018122734.2594904-1-stian@itx.no>
	 <e3068b5c97884032e7cbd12c78f6b5534d75e30c.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-bIu7sUj6+qWNPVLdLyj3"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-bIu7sUj6+qWNPVLdLyj3
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Sun, 2026-10-18 at 15:09 +0200, John Paul Adrian Glaubitz wrote:
>=20
> What about sparc32? Does it use address base randomization at all?
>=20

sparc32 is at the same state as sparc64 was before this series. Only
the stack moves.

I've only tested 32-bit programs on sparc64. The same approach will
probably work, but needs testing on real sparc32. Could be possibly be
added as a follow up, if someone with sparc32 hardware can test it.

/Stian


--=-bIu7sUj6+qWNPVLdLyj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatTKrgAKCRDoeAEuJe36
ViR/AP9tapuPdb5PXwlCO57ZKvq0FZAci5TKBLwYZdBFllCb5AEAj6ZOxLutAtOH
qbE2uywIGrfhHh3lY+nx1C7LstUqPwI=
=x5yr
-----END PGP SIGNATURE-----

--=-bIu7sUj6+qWNPVLdLyj3--
