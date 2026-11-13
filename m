Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596716;
	b=wVjHSEB7dJ+fXftbsm1lGSClnkpzWouuBDj8FRO+QwHyIUjRvJNo7NluRRTuBmlyMKLI
	 CI5RxPtB0l/elQPfXCxObXjJcAKALWfrfMc0uQAcu9dLd+wuqncrijeJpIVUGdjAVgxuC
	 FmsoqyusludMnG1/pjUSuUly4M48RJhGOSc8uUPUmLciWpS28sPyBVYqcPSODJyNjMNaz
	 QyK9F890EO7BibO3gaifqNk0D5odU9Jc9+EgQR0K4TnyX/ezJqaDPIsDJ8yeu0XqU9vhc
	 hgyDuZe9O4KklGAUutlCLU2lYjVUSLeMns9CgfG4sbgrdIf82nIBfeZptccN+6Md7Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596716;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=m68+6e9UYsTpn2Djyyl8Zzpu9k08LsLIJVCjz15Adpg=;
	b=WQ84DquMHSAbyjAMB0SV5c6t6Uw28ylkN2yI8rAwPcbM598VY90RrqLLrAZB+RzD19ii
	 cewdh/luC6AwiOBmHpxZ5iYtn5/EvKzH1I8fLPNVA8GP1s/DaOdZbfhew5oegfrWFKy/y
	 sXj52hz7Xuh8Mg5ygEJOl3vScMTjqBy1kASIWdkFQs3I4uH9TwVYVmKHDGMaJ58FBC2wj
	 BGtqzbB/xQBdtlw3ekyKth6c84mLNgnn6oN2Y3BpQ2m/dRW9auosOFDgnVfce2jbwCAmF
	 wlg2XvWIs/fbvIWynoLKUguFa6M5BGioOnrL3lunkc4luy5yo5lRGsXemhCOEOTaJwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=JHuzPPA8;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64918606A323;
	Fri, 13 Nov 2026 19:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64918606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=JHuzPPA8
Message-ID: <a675c53a48b90c621510217500c81602f6709101.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794596713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m68+6e9UYsTpn2Djyyl8Zzpu9k08LsLIJVCjz15Adpg=;
	b=JHuzPPA8x2KETQDtfGUrbK5qd/18R7obE881vdXZt2S8UCcK51ohaN4ZssAIffhPqdMODu
	6oXYisiOVAg2InhYRh795AnS0ySPogh7EXDliVS+z9PHbp8my1MNUtWWmkJbRmobOL2TqK
	8+G0rmvdwT3A+J0oF4te0UYEpexF9p4=
Subject: Re: [PATCH v2 3/4] sparc64: kprobes: Resume after a delay slot at
 the saved next PC
From: Stian Halseth <stian@itx.no>
To: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	 <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao
 <naveen@kernel.org>,  Danish Khateeb <danishkhateeb03@gmail.com>,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 20:05:10 +0100
In-Reply-To: <20261113144057.1697874-4-stian@itx.no>
References: <20261113144057.1697874-1-stian@itx.no>
	 <20261113144057.1697874-4-stian@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-H0qdPGyXuTHWzNHFg9v8"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-H0qdPGyXuTHWzNHFg9v8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-13 at 15:40 +0100, Stian Halseth wrote:
> After single-stepping an instruction that does not branch, execution
> resumes at the saved next PC. The probed address plus 8 comes next.
> For an instruction in the delay slot of a taken branch the saved next
> PC is the branch target. Execution then goes back to the probed
> address plus 8. It should continue at the target plus 4.
>=20
> Use the saved next PC plus 4. For any other instruction that is the
> probed address plus 8.
>=20
> Link: https://github.com/sparclinux/issues/issues/110
> Signed-off-by: Stian Halseth <stian@itx.no>

Fixes: f08825896664 ("[SPARC64]: Fix several kprobes bugs.")

Andreas, please add it when applying, or I'll fold it into a v3 if one
is needed.

/Stian


--=-H0qdPGyXuTHWzNHFg9v8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCavdfZgAKCRDoeAEuJe36
VtjUAP96Nm2zKmTai0WBwiBREhmrGaPJwUB81LwTjE/pOSUoUwEA/YkzZoS2cQI7
0Oe2iTxdI0XEYbR8PZZMysWUoVf2HAo=
=0moT
-----END PGP SIGNATURE-----

--=-H0qdPGyXuTHWzNHFg9v8--
