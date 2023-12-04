Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D9518A
	for <sparclinux@vger.kernel.org>; Mon,  4 Dec 2023 03:05:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA6lG-0001ei-Hc; Mon, 04 Dec 2023 12:05:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA6lF-00DVGf-5F; Mon, 04 Dec 2023 12:05:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA6lE-00Dzcg-SA; Mon, 04 Dec 2023 12:05:12 +0100
Date: Mon, 4 Dec 2023 12:05:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org,
	kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Message-ID: <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="larezghpujxbdkyi"
Content-Disposition: inline
In-Reply-To: <20230713145536.GA5300@ravnborg.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: sparclinux@vger.kernel.org


--larezghpujxbdkyi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 13, 2023 at 04:55:36PM +0200, Sam Ravnborg wrote:
> On Thu, Jul 13, 2023 at 09:52:35AM +0200, Uwe Kleine-K=F6nig wrote:
> > My build test setup compiles allmodconfig all various architectures
> > (arm64 m68k powerpc riscv s390 sparc64 x86_64) using make -s. If there
> > is no warning, the only output is
> >=20
> >           kernel: arch/sparc/boot/image is ready
> >           kernel: arch/sparc/boot/zImage is ready
> >=20
> > from the sparc64 build. Copy the incantation from x86 which is silent
> > when building with make -s and also mentions a version indication.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> I hope Arnd or someone else can pick it up as davem is not active on
> sparc for the time being.

Nobody did pick this up. Would resending make sense?

The patch still applies to today's next.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--larezghpujxbdkyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVtsmcACgkQj4D7WH0S
/k46Sgf+JvF1H/ofz7Pfhb4/a0P5/GF0BQkTg+9h+R1llvB9ys7wuq28ar7sbYv9
5zwWHzxoz9W16qCSEGSthNuglByGD+VN7wR5kdc/DADWBbKYEqX/dtYg74/fIlN4
yhkCSkf/556I1CQb5I0/laNCTAbVpjwXBop06EMeOiW6N/8NwOgfZEc6yWuvkaMZ
X1jvXe1SFbY8aACoPjBvImCAXPmtvSQUPyCREh8cXTjD94vtg8mQYJ1xxWI+eisj
kAs9sA+pMY8u8THXDkOuag2wXGNDj18m5ZzPBi2UA1vjbYSg+lOITC0bBf546t3N
L3aQ7OYhY9kMYzRq/44XweDapin95g==
=6Pha
-----END PGP SIGNATURE-----

--larezghpujxbdkyi--
