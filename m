From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date: Tue, 06 Jul 2004 09:05:06 +0000
Subject: Re: [PATCH 2.4] drivers/scsi/esp.c is GPL'd
Message-Id: <20040706090506.GS18841@lug-owl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hc1Ad1NXUysMDyjB"
List-Id: <sparclinux.vger.kernel.org>
References: <20040706084302.GA3597@darjeeling.triplehelix.org>
In-Reply-To: <20040706084302.GA3597@darjeeling.triplehelix.org>
To: sparclinux@vger.kernel.org


--hc1Ad1NXUysMDyjB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-06 01:43:02 -0700, Joshua Kwan <joshk@triplehelix.org>
wrote in message <20040706084302.GA3597@darjeeling.triplehelix.org>:
> --- kernel-source-2.4.26/drivers/scsi/esp.c~	2004-07-06 01:34:22.00000000=
0 -0700
> +++ kernel-source-2.4.26/drivers/scsi/esp.c	2004-07-06 01:35:00.000000000=
 -0700
> @@ -4368,4 +4368,6 @@
> =20
>  #include "scsi_module.c"
> =20
> +MODULE_LICENSE("GPL");
> +
>  EXPORT_NO_SYMBOLS;


While you work on it, you could have removed EXPORT_NO_SYMBOLS, too...
It's no longer needed these days, IIRC.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--hc1Ad1NXUysMDyjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6mtCHb1edYOZ4bsRAsU4AJ0R6zq+D44r9pvhsTV4oYXmi+KAgQCfSyhc
y6pNj2SvazzJsiCZ9i0AGrk=
=4ol2
-----END PGP SIGNATURE-----

--hc1Ad1NXUysMDyjB--
