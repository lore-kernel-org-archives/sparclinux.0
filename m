Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D87483;
	Fri, 31 May 2024 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168279; cv=none; b=aO3Z3JFl0NLQ3eT/scJPnEvjteSH5gor5c/Xi1yGn+qfiAi7l4NXuS58kGD1ndFKGSTYMmSEMQXf7Mr3odO/S+8mEjDe2OJHyAlRZR4LyKYDHoIZJvT33dTNPQ9dchSjxQLjo0j9+Q/RPNL/C7iZZBUcQxZeB82WEpiqIqR4TIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168279; c=relaxed/simple;
	bh=BGnnpDBcKYL3dKJjZSbZGcYNM5FmYIuUanB00h62RZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixyO+IWfnZl3xk2E5CU7dfT1HjX5ic/2JGchrFHSkk2BbS0j4G9NMkMia0vKjL6QdRbcmgHGnN7585zYjQlez/rtvXoF43FL9ZIyaVkGNk3qrOQprbu0D8Bmoj60h9OY9svl9TneRj30HK1WXGHTTnihc9ZBC60OF9PSFCNjfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhVY1QDU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhVY1QDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B9BC116B1;
	Fri, 31 May 2024 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717168278;
	bh=BGnnpDBcKYL3dKJjZSbZGcYNM5FmYIuUanB00h62RZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhVY1QDU+pk0ZiuCfmbyiENiKCKaBpbqyaTe087TxsNKREnXaqiYYkhZTSxI6wk1h
	 j1TQiMRQN4/y5gdcUdM1Nl2GCByWf+Bp5nRm/ENGXrIuR85+rHtWrYjwirJbUuVgWd
	 V4Jh1kBxdE3JHJUb/6QVtpSQ59yr0+bKFqjVrnSl+pDKFJ+V+enMDQaLbNUUnlPa1F
	 eVM7Ms4+CviV96OPCO4SSoLHMCyQgZ9XglgaPN2qeUKQcCjjq4WBPHhyI8hAcrNzwX
	 LqJwTprQkIDkgktw/BswwKu+7ub6hzGFxO6D9EO3Qkicf1cu6WapKhx4qyGWqKXQpQ
	 LwiNnZVNVn0rg==
Date: Fri, 31 May 2024 16:11:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: WARN on using default root node
 #address-cells/#size-cells
Message-ID: <20240531-excursion-synapse-13c198fc61cb@spud>
References: <20240530185049.2851617-1-robh@kernel.org>
 <20240530-surging-sprinkled-f209b2452395@spud>
 <CAL_JsqKC5kkMvWDHVdt-3gS-sW=t=cvLctVVbHhcvPXpe-2nSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uyjlUp5eqmodPrmz"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKC5kkMvWDHVdt-3gS-sW=t=cvLctVVbHhcvPXpe-2nSQ@mail.gmail.com>


--uyjlUp5eqmodPrmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 07:33:57PM -0500, Rob Herring wrote:
> On Thu, May 30, 2024 at 2:21=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, May 30, 2024 at 01:50:48PM -0500, Rob Herring (Arm) wrote:
> > > While OpenFirmware originally allowed default values of #address-cells
> > > and #size-cells, FDT has long required explicit values. It's been a
> > > warning in dtc for the root node since the beginning (2005) and for
> > > any parent node since 2007. Of course, not all FDT uses dtc, but that
> > > should be the majority by far. The various extracted OF devicetrees I
> > > have dating back to the 1990s (various PowerMac, OLPC, PASemi Nemo)
> > > all have explicit root node properties.
> > >
> > > I have no idea what exists for Sparc, so disabling the warning for it.
> > > If any other platforms hit the warning, then the warning can be
> > > disabled for them.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > > Sparc folks, If anyone can dump DTs from some Sparc systems it would =
be
> > > helpful.
> > > ---
> > >  drivers/of/base.c | 2 ++
> > >  drivers/of/fdt.c  | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > index 61fff13bbee5..6930aa29fec1 100644
> > > --- a/drivers/of/base.c
> > > +++ b/drivers/of/base.c
> > > @@ -96,6 +96,7 @@ int of_bus_n_addr_cells(struct device_node *np)
> > >                       return cells;
> > >
> > >       /* No #address-cells property for the root node */
> > > +     WARN_ONCE(!IS_ENABLED(CONFIG_SPARC), "Only listed platforms sho=
uld rely on default '#address-cells'\n");
> >
> > I assume "listed platforms" means things in the first parameter of
> > WARN_ONCE()? Since that's only SPARC, why not just say it? The error
> > message is rather obtuse as-is I think.
>=20
> My intent is if you hit this warning, add the platform here.

Aye, I figured as much. My point was mostly that if you see this warning
during boot etc the message doesn't make that much sense. It only really
makes sense when you look at the kernel sources.

> I imagine
> it will be older stuff we can't or don't want to fix. Maybe I should
> just say that as a comment instead.

--uyjlUp5eqmodPrmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlnokwAKCRB4tDGHoIJi
0igyAP9ZMYa40yBgxnzlWirEDEOVEZkczT/VxnyqupfD+G1u1QD+LK3+LfsxDO2D
LrADJ6wRuOK7XFE8wdPAexoqL7dTMgM=
=uUF7
-----END PGP SIGNATURE-----

--uyjlUp5eqmodPrmz--
