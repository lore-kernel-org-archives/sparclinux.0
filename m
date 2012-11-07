From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 07 Nov 2012 06:52:58 +0000
Subject: Re: SPARC and OF_GPIO
Message-Id: <20121107065258.GA22325@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
List-Id: <sparclinux.vger.kernel.org>
References: <20121105095315.GG5847@avionic-0098.mockup.avionic-design.de>
 <20121106.184058.636480855516538607.davem@davemloft.net>
In-Reply-To: <20121106.184058.636480855516538607.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2012 at 06:40:58PM -0500, David Miller wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
> Date: Mon, 5 Nov 2012 10:53:15 +0100
>=20
> > Are you aware of any reasons why this conflict would still be necessary?
>=20
> No reason that I can see, I'll push something like the patch below
> via the sparc tree.

Thanks for doing this.

> > This is not only the case for OF_GPIO but likely also for OF_SPI,
> > OF_I2C, OF_IRQ and OF_ADDRESS. Shouldn't those all work even on SPARC
> > nowadays?
>=20
> Those also would need to be tested on an individual basis, but
> there are no fundamental problems that I am aware of.

It seems like OF_ADDRESS would be trickier. A comment around line 60 in
drivers/of/platform.c says that SPARC doesn't need functions defined in
the enclosing #ifdef CONFIG_OF_ADDRESS block. I'm not sure it would be
acceptable to remove the conflict nonetheless, even if the functions
aren't used. One benefit would be that the code could receive some extra
compile coverage.

Oddly I'm no longer able to find any reference to OF_SPI, so maybe I
just made that up...

The code conditionalized on OF_I2C looks very generic, so I think there
shouldn't be a problem to remove that conflict either.

Finally, OF_IRQ is again just generic code to map device tree data to
IRQ domains. While I didn't see the IRQ_DOMAIN symbol selected anywhere
in SPARC it should still be possible to run drivers that properly
implement IRQ domains on SPARC, right? Or is there any reason why they
wouldn't work?

So this seems like all conflicts except the one for OF_ADDRESS can
easily be removed. And even for OF_ADDRESS there may be some value in
removing the conflict.

Thierry

>=20
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index b6b442b..f0a5391 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -14,6 +14,7 @@ config SPARC
>  	default y
>  	select OF
>  	select OF_PROMTREE
> +	select OF_GPIO
>  	select HAVE_IDE
>  	select HAVE_OPROFILE
>  	select HAVE_ARCH_KGDB if !SMP || SPARC64
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d055cee..f11d8e3 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -47,7 +47,7 @@ if GPIOLIB
> =20
>  config OF_GPIO
>  	def_bool y
> -	depends on OF && !SPARC
> +	depends on OF
> =20
>  config DEBUG_GPIO
>  	bool "Debug GPIO calls"
>=20

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQmgVJAAoJEN0jrNd/PrOhI6kP/0lLkBPfdBdzkezZTJDmwXS9
ruhDyOQtLHVFmMHhxL+nRUt/l9gv0RfESKcR+qZDbKZTaCTwvfaJ0FK24UaSQWdq
asXZQ7uqr3OR7kgViKAGuv5SaSa624Hf/QgVScMGzYvZs0QqHtTFURVRkP7j96uI
Y3AHfxJWHWNep5i7grgj4MavY9SgRGBPgkGOKGldRBxIz0C5flc4mAl9QsUT9MDa
8dCbvFcwVMhBPpjgnP+yDC8bcJz+tzRWoyMtIFDNs/wUZDXos9kNPBiyJykTzHbk
Z9uV7crD66lGKGY9QbtJpdIBSTjQJnJME8PrBdwVkU2CEBJwRg/MfKihq24l3OtA
ckoYs0qGLs085eIaiHtIdGrpS5sP34M0s3/Zm/CQWl7WvaNWDtg1Cmsq/tiPvX0O
/U6+FbbahSdlalzvQKw4dYmf9KPNJTxklAhlSS5Qg3EAVKgWC7NaJAurvwk/KjWT
cbxPO/TBe22HZtCn9G72udz+PR35zjyUTpRW1y3uFkX1knyDlE7maz1WtbPplUsj
W/44f0ECdb0+UgrgkpviH6M27aT9QIPKSssFfgMWj000XybdoSjMqRA6tViqSrta
b9yBjSJ/Vg8+SPhN6npX7eFJqEdkCAiRl6eirKW6BboCdzKl+C2UvKyLluKdR8mt
sqAjkUbmdODP8CL6u/FR
=SuSx
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
