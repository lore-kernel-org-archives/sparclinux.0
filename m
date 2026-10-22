Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688159;
	b=i536RmQdjnj+m7a5nTY9RuPGljp84wiE24YRfNj0JtPA2YuidWf1zTJVTRjfYzSo/6aw
	 1EI0zXrtKoxatcNjPcy+mr73kRQhUjTnuggBpJFoYleTdcQjdUxNOLboV0V0xJ6uaWKO6
	 YgtJAbm/Wn9zeY4nP4evpd+rN0r1d7MPCo3YLSq0CLgiIh2yXY0yMrbI+blSvmdk7PF6I
	 OZrNI9NaUy/YsBPUDkVN46cnnzio778Ay6+ME+lStrXAaDN3R0iPLqAXDytFITTGqVMXn
	 F28aWgV3KCFuTlof4LoR/8Yimsx0FqcNkl26blW+XLLr+SiuZDIORpr0xUDJl4/vcOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688159;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=R2IZqvIzzorErZi4Ho3QQX7U3ldVlNP9iI88AjPpUWw=;
	b=eXy6QzMRtoF+2aaqWzaB+0J3IAmNYxfTSpjlhPVc2AtVn3s/6VJPj40Vrqn6JftQI5zr
	 5jVGz8iP0yxpbAEBUfS2ryushmdZQ9fD1FjwcbfqQlZNuBtYp85D8+Lwl9WVW0tyT8ZYm
	 8wB0C48fsqGMO4/7c0XC7FDzjpfhqu5R4yRdaWl3F+WmlflhAVBDKcNAgoR9AbKn8gvma
	 LbLLes8T+ejwarlhFnGv3r10DevKX6SzvFLJ26UJY/tnlw/gNOAff+L7Ug4WlHSYzH+Xd
	 1ot/5UYFkEAJotYt5CZXuQtNCXtweb4isbmRg/GGPI7MIsx7Lv9JIF9OTbeHkrzaOdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=YdykZMh5;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FD606A31B;
	Thu, 22 Oct 2026 16:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E54FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=YdykZMh5
Message-ID: <190b3c8b11b860dcd1dfed739f9f7a5690b35e5e.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792688155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2IZqvIzzorErZi4Ho3QQX7U3ldVlNP9iI88AjPpUWw=;
	b=YdykZMh5sAD+vBAuyu6vQHKV6wsMK2EKWquRmMGxdohn/LYDDhXwvzxwFwFuO4ETc2j1IJ
	JLLCa30v2FaoIOmijq0Xys8Z/uRIAjxg5VftRM2XTYCn0kSbSBIuDKkajB8yUGPd8mnflD
	rRWhP79P61whZb8z6Zq7Pv2CN3tsjzs=
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on
 sun4v
From: Stian Halseth <stian@itx.no>
To: Jan Engelhardt <ej@inai.de>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>
Date: Thu, 22 Oct 2026 18:55:54 +0200
In-Reply-To: <oo23630s-96q9-69n0-9457-764233rs5496@vanv.qr>
References: <20261018222723.43442-1-jengelh@inai.de>
	 <156ed58445e869ffb783bfee0c07bc784f6178ad.camel@itx.no>
	 <oo23630s-96q9-69n0-9457-764233rs5496@vanv.qr>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RAaDVgVoJv1RsJiTAbgt"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-RAaDVgVoJv1RsJiTAbgt
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Thu, 2026-10-22 at 18:17 +0200, Jan Engelhardt wrote:
> I did not even expect this to do anything sensible on V240.
> That is just an accident - and multicore-per-package (MC)
> sun4u are expected to be still misreported. That needs again=20
> different logic.

Right, so maybe just return -ENOENT on sun4u and leave it as it is? The
lscpu fallback already gets the single-core ones right.

>=20
> > Maybe it's simpler to just walk the MD directly in
> > init_cache_level()
> > and populate_cache_leaves(), following the same arcs as
> > fill_in_one_cpu(), and add one leaf per cache node?
>=20
> After some pondering and in anticipation of MC sun4u, I think
> re-walking is sensible. I expect there to be a few savings
> (just 24 per strand) and a bunch of LOC removals.

Sounds good. I'm happy to test v2 on my T4-1, T7-1 and V240 when it's
ready.

/Stian

--=-RAaDVgVoJv1RsJiTAbgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatpAGgAKCRDoeAEuJe36
Vl5XAP9c3rieeWgRLt9fXwGssena4rsCRZWjjcnNRxEbVqKa9wEAxqIfKJdZZ7SI
1RmyZGBlO1NjsiUb1E0VelRfAIFQ+wI=
=XBL7
-----END PGP SIGNATURE-----

--=-RAaDVgVoJv1RsJiTAbgt--
