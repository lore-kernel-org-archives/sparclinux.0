From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date: Mon, 12 Jan 2004 17:51:30 +0000
Subject: Re: Betr: [2.6.1] still no working keyboard/mouse on ultra-enterprise 2
Message-Id: <20040112175130.GG14285@lug-owl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="abN2VRGcDj5Z284b"
List-Id: <sparclinux.vger.kernel.org>
References: <3FFB0C8D00008F60@ocpmta7.freegates.net>
In-Reply-To: <3FFB0C8D00008F60@ocpmta7.freegates.net>
To: sparclinux@vger.kernel.org


--abN2VRGcDj5Z284b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-12 16:36:11 +0100, jbelshaw@tiscali.nl <jbelshaw@tiscali.nl>
wrote in message <3FFB0C8D00008F60@ocpmta7.freegates.net>:
> Looking at your dmesg I see that you have a mouse entry which at first gl=
ance
> looks a bit odd to me.
>=20
> >Console: switching to colour frame buffer device 144x56
> >mice: PS/2 mouse device common for all mice
> >input: Sun Mouse on zs/serio1

What is odd in your eyes? "PS/2 mouse device common for all mice" is a
message from the generic userspace-side PS/2 mouse driver. So, you may
have any cryptic mouse issueing Input Layer events and userspace will
*always* see a pure PS/2 mouse.

Then, the sun mouse appears. Nothing wrong here IMHO...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--abN2VRGcDj5Z284b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAt6iHb1edYOZ4bsRAp/KAJoCblo3fxGLx4uZPdM6197a7h/1nACaA56Y
+WQLP+J/yQntAO0Ai8gYfHk=
=8Rzf
-----END PGP SIGNATURE-----

--abN2VRGcDj5Z284b--
