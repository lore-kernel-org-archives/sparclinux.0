Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2747607C;
	Wed,  7 Oct 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378341; cv=none; b=d+gCwEr+YAhJXnF+zvEpKoblSX6ya2Z+GTGp1j5sXFJLSX2WocaLXjxxyu90PPOsyv1bujAxpDDZ1qHQ3bUObTFpOdym3wM1NZZ/RG7XiiEvXI0nwNx3KpQ9RbmBzbFB6fGRYGoS0lQLfsxjn2KxGUGjEK23PU/wGip2RGkGTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378341; c=relaxed/simple;
	bh=IjkNsgkNqXoyyYZEoNEjzGTf95XgDV8vZw132G5VM2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8EWf49Tdj2UjKpzIkQawE+bXhHNWGExwypYZsuv6RUYrOktJQJdY86QoDDZ55prdzRsCavKQikzl1bR3Lm8PRMniWpJnABnnnMiiBV0px3tt8G6jkVtQ9+FSG4Wc9coBRBj2p+A+hu+jGT7Ugh9q7cmkZxjFHZ9lV9/9Kt2lqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=QMfUwZq3; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="QMfUwZq3"
Message-ID: <61d42d33b9dd361bf76784e5b6bee677a9837825.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791378331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjkNsgkNqXoyyYZEoNEjzGTf95XgDV8vZw132G5VM2Y=;
	b=QMfUwZq3L+jor6OonGqdtAV6hNsHIfPWrsAkS3uHyhIuZiwNu8PNsMIyfET8u3OeJetXoA
	WxC/u52/4SJ7BNn9n12mPTYCw1gO3zGdBfLrMqwWQ6Y+uSOMvuuc8oPvzYVzbp4kEKNeL5
	sMCL4czXYU0nw+UMYU2VzA58moqZE6Q=
Subject: Re: [PATCH v2 0/3] sparc64: fix a window fill fixup lockup and two
 fault bugs
From: Stian Halseth <stian@itx.no>
To: Andreas Larsson <andreas@gaisler.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de
Date: Wed, 07 Oct 2026 15:05:29 +0200
In-Reply-To: <2ba74adc-fb41-4317-a11d-03db8e5dbe18@gaisler.com>
References: <20261007085347.256789-1-stian@itx.no>
	 <2ba74adc-fb41-4317-a11d-03db8e5dbe18@gaisler.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9GbOFZbCRGwAppzOP4FQ"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-9GbOFZbCRGwAppzOP4FQ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-07 at 13:40 +0200, Andreas Larsson wrote:
> The Tested-by from v1 was unfortunately not incorporated in this
> version, so I add it here:
>=20
> Tested-by: Imre Kaloz <kaloz@kernel.org>
>=20
>=20
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>
>=20
> Picking this up to my for-next.
>=20
Thanks, just let me know if you rather want a V3 with the Tested-By.

/Stian

--=-9GbOFZbCRGwAppzOP4FQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCasZDmQAKCRDoeAEuJe36
VmQwAP9qhpZc2pKV1HGnpsi/GTfgogpMHbuzJMb9/8XR52myTQEA3nH7+kEF9hz6
zDsv+WbvtHSyL9eRbqXT3PrXJbzq+Q8=
=Vjcl
-----END PGP SIGNATURE-----

--=-9GbOFZbCRGwAppzOP4FQ--
