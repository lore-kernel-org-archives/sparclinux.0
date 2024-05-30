Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905580058;
	Thu, 30 May 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096876; cv=none; b=fAGhi+sqfLzSRpeMl/URG7AF/5Io3kndjO1tWFBMSHuLiSR6moESI8tI9uKJL5udcDBV0SA77Y8PPDMy8Lk29yTCxlnGNzqt21yeQlvWfCcrc9v2w9bukCyrTIJnQzEgfTkdJFIZqlulVSaICmajp52v5rY2QqHG/tN5mmh12j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096876; c=relaxed/simple;
	bh=Cw8n9sFkdrnSp+hf2gxi3CiALqLFC0iIHAkCCK3RWpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpN8/cwqjyCFkxr7hWLXCmMeNTFzLg5z5Qu+rUZu/WE+LctnyEK0m9C/+Dd3iPRSdK69TtuHX7r5hvXd3b6S7G/e1DZvvynaWN0cora7xsuBBwdqA1mK/z5CsXcddbE14WQMIyQEYInIiI9CavgLv7qGI0s9ee9ZgTqusFvNHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUGnaW8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUGnaW8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7247BC32781;
	Thu, 30 May 2024 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717096876;
	bh=Cw8n9sFkdrnSp+hf2gxi3CiALqLFC0iIHAkCCK3RWpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUGnaW8yWgrWo8eF7SIlAJEpzMRH8uRwBqHW9GhFFYgH7ykzfFYQtNpnxfLBDF3tv
	 2SmM+Mfr4KDq7EpNiXMeZReMzRU11FKTbrpjtOCfy9P/55oITXXczNf3BBEcEugAqN
	 LjjiXN0HU8tGVrZaVQkJkYaplYgBR0Spb+WP8wPIJ7Coo7A7/nLF4r76pBEHc+tx3S
	 SYNyDYMQbPBULrnCo4S2i+i1OjBe1kynXN6xrdFrPBiivkj82ZvpZmwhDBKiQDIugN
	 63y6hkf7jGgL7DLGo/myCxZjzGkpqRixj9NSQyUJ3dMrVeUm+mM9J0vnYDXUxnXLJO
	 PbizAY47q5btw==
Date: Thu, 30 May 2024 20:21:12 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: WARN on using default root node
 #address-cells/#size-cells
Message-ID: <20240530-surging-sprinkled-f209b2452395@spud>
References: <20240530185049.2851617-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o3RC6Q1iZAKXXjOs"
Content-Disposition: inline
In-Reply-To: <20240530185049.2851617-1-robh@kernel.org>


--o3RC6Q1iZAKXXjOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 01:50:48PM -0500, Rob Herring (Arm) wrote:
> While OpenFirmware originally allowed default values of #address-cells
> and #size-cells, FDT has long required explicit values. It's been a
> warning in dtc for the root node since the beginning (2005) and for
> any parent node since 2007. Of course, not all FDT uses dtc, but that
> should be the majority by far. The various extracted OF devicetrees I
> have dating back to the 1990s (various PowerMac, OLPC, PASemi Nemo)
> all have explicit root node properties.
>=20
> I have no idea what exists for Sparc, so disabling the warning for it.
> If any other platforms hit the warning, then the warning can be
> disabled for them.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Sparc folks, If anyone can dump DTs from some Sparc systems it would be
> helpful.
> ---
>  drivers/of/base.c | 2 ++
>  drivers/of/fdt.c  | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 61fff13bbee5..6930aa29fec1 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -96,6 +96,7 @@ int of_bus_n_addr_cells(struct device_node *np)
>  			return cells;
> =20
>  	/* No #address-cells property for the root node */
> +	WARN_ONCE(!IS_ENABLED(CONFIG_SPARC), "Only listed platforms should rely=
 on default '#address-cells'\n");

I assume "listed platforms" means things in the first parameter of
WARN_ONCE()? Since that's only SPARC, why not just say it? The error
message is rather obtuse as-is I think.

--o3RC6Q1iZAKXXjOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZljRqAAKCRB4tDGHoIJi
0iAJAP4k8TUjNgnDOrkaQcs4tKHQQ+uHNIjHDX/hmEsUeWCHyQEAiDFnImvrWsQE
tUUrWkbqwMYUZynPihdkGtIsqQmhNQA=
=HErS
-----END PGP SIGNATURE-----

--o3RC6Q1iZAKXXjOs--
