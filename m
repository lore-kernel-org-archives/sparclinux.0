From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date: Tue, 06 Apr 2004 10:25:33 +0000
Subject: Re: [PATCH] Add amd7930 to include/sound/sndmagic.h
Message-Id: <20040406102533.GT27362@lug-owl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KpVviUS5LkgMNJxi"
List-Id: <sparclinux.vger.kernel.org>
References: <20040405231229.4ae000fe@enterprise.weeve.org>
In-Reply-To: <20040405231229.4ae000fe@enterprise.weeve.org>
To: sparclinux@vger.kernel.org


--KpVviUS5LkgMNJxi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-04-05 23:12:29 -0600, Jason Wever <weeve@gentoo.org>
wrote in message <20040405231229.4ae000fe@enterprise.weeve.org>:
> The included patch adds amd7930 to the include/sound/sndmagic.h in 2.6,
> allowing the sun-snd-amd7930 driver to build.
>=20
> According to the ALSA doc about writing drivers, the define in sndmagic.h
> doesn't need to be a particular value as long as it is
> unique, so that is what I did here.

Nice :)  This may fix a compile-time bug when enabling the MAGIC things.
I've done a port of the amd driver to the VAX and stumpled over this,
but was too lazy to fix it (-> module loading not yet finished, as well
as extending the kernel PTE table at run-time).

Thanks for doing the work, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--KpVviUS5LkgMNJxi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcoWdHb1edYOZ4bsRAjeiAJkBqFP9rwyS6FxusKi9zBNWk+6QqQCggZ14
tTKOtUdLBd8fnkuGr6AUt4o=
=lBUZ
-----END PGP SIGNATURE-----

--KpVviUS5LkgMNJxi--
