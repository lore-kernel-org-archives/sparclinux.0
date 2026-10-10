Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131111B7910
	for <sparclinux@vger.kernel.org>; Sat, 10 Oct 2026 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791665158; cv=none; b=anjmGoJjwHSO0lM84szhPxZh8Mbyd0oEjlHU8ZKrS15F5DTrkxMIcZgmgtRJAkqvo0+F79wSUGxVBnNC6oz+WOGfdTXdW+P7pJ8Sa68xivi30aPQiS+CaAuxXeDAumo/yMHdV0beNK0XjDGN0pxngdVcO7B/Ztx4hfG128BKPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791665158; c=relaxed/simple;
	bh=K8Jn3LBch8dyC4J0vytMW7qOTMEmSeT6ylBtqev+V2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgoCYwRlSYwVSKEXss7lP/r+kcQ9UNlygorbz+egXrS0ncrtM8Tt1p9/ODseAQaoaehS2e+pBlWfqewv7/+917apc71Xaiix8/46rbexfrjfnvy0kQ8Ulwta6MQZdWlQqDonQL2gDcf1YnSDNNeDy3N4cX+Qj856cp/sDCbkX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=ZdfHAPLI; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="ZdfHAPLI"
Message-ID: <6a37e24972e63cf3c6212644e7c3f18a8a9c06da.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791665154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K8Jn3LBch8dyC4J0vytMW7qOTMEmSeT6ylBtqev+V2E=;
	b=ZdfHAPLIz8iY/3YMdD6xi9XY0U3vrC148xe/vhnrR3C57y3A0Uj/ewOHyFQLAUBoYdABRc
	OYyrfge/Z/33FgP8cbztFlrGFxSKdjtnvh/WPitOqx8ZZvZBYn5WO1TRiZww6blDgACTwn
	1Gi7PSmQ1QLxTjr9Y2zKcWg28ENJtAc=
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: Stian Halseth <stian@itx.no>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux
	 <sparclinux@vger.kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
 Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 10 Oct 2026 22:45:51 +0200
In-Reply-To: <c4fd9e838043b2b552ea9c33dfaf716a5e9d5b6a.camel@physik.fu-berlin.de>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
	 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
	 <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
	 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
	 <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
	 <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
	 <b85e047233f5b38cdbfbd7af852ce30055680b47.camel@itx.no>
	 <c4fd9e838043b2b552ea9c33dfaf716a5e9d5b6a.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-io0lnNWaL6qKhdfPkOQA"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-io0lnNWaL6qKhdfPkOQA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-10-10 at 22:18 +0200, John Paul Adrian Glaubitz wrote:
> Did your kernel ever crash with CONFIG_CGROUP_BPF enabled? That was
> my original reproducer.
>=20

No, but my V240 (Sparco) runs OpenRC, so even the test kernels built
with CGROUP_BPF=3Dy had no cgroup BPF programs attached.=20

Since v2 fixes it for you, could you send your Tested-by in Imre's
thread?=20
https://lore.kernel.org/all/20260928132102.1707-1-kaloz@kernel.org/

--=-io0lnNWaL6qKhdfPkOQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCasqj/wAKCRDoeAEuJe36
Vs7mAQD4clCc1LB3Op66J8OnpYkuD0onkBfxjLCpY78ArctAwwD9EU5uVxqUuw2N
Ryorwx0zTj06kKaOeGGGUJQweQx1oQo=
=g3Bf
-----END PGP SIGNATURE-----

--=-io0lnNWaL6qKhdfPkOQA--
