From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date: Tue, 21 Dec 2004 08:57:46 +0000
Subject: Re: [2/3] sun4d updates (guys, please send me real descriptions!)
Message-Id: <20041221085746.GG2460@lug-owl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="L+ofChggJdETEG3Y"
List-Id: <sparclinux.vger.kernel.org>
References: <20041221042836.GZ771@holomorphy.com>
In-Reply-To: <20041221042836.GZ771@holomorphy.com>
To: sparclinux@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-20 20:28:36 -0800, William Lee Irwin III <wli@holomorphy.co=
m>
wrote in message <20041221042836.GZ771@holomorphy.com>:
> Index: sparc32-2.6.10-rc3/arch/sparc/prom/ranges.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- sparc32-2.6.10-rc3.orig/arch/sparc/prom/ranges.c	2004-06-15 22:19:22.=
000000000 -0700
> +++ sparc32-2.6.10-rc3/arch/sparc/prom/ranges.c	2004-12-20 19:25:00.39123=
8554 -0800
> @@ -34,7 +34,7 @@
>  	}
>  }
> =20
> -static void
> +/* static */ void
>  prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
>  		   struct linux_prom_ranges *ranges2, int nranges2)
>  {

I don't know this function (or where it is ment to be called from), but
isn't this an example for __attribute__((unused)) ?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBx+WJHb1edYOZ4bsRAm17AKCMyFWpfOLnWy9G5HkIJO4EPt+p7wCfVFMD
BwhxXaxl/RCK6nz2Mmrijm4=
=PDQT
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
