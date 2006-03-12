From: Jason Wever <weeve@gentoo.org>
Date: Sun, 12 Mar 2006 21:09:43 +0000
Subject: Re: ESP busted
Message-Id: <20060312140943.2325bd68@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_+7jOrYHXjpwcTQl.ynb0iVq"
List-Id: <sparclinux.vger.kernel.org>
References: <20060309.131637.114886710.davem@davemloft.net>
In-Reply-To: <20060309.131637.114886710.davem@davemloft.net>
To: sparclinux@vger.kernel.org

--Sig_+7jOrYHXjpwcTQl.ynb0iVq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Mar 2006 13:40:39 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> Josh, new patch, let me know if this makes ESP work
> better for you.
>=20
> I'm a little concerned, because this means gcc-3.3.x
> is doing this lack of inlining for the entire sparc64
> kernel, not just the ESP driver.
>=20
> We might have to add some -finline-limit options back
> onto the CFLAGS for gcc-3.3.x and previous on sparc64.

Assuming this sub-thread was meant to be directed at me :)

OK, just got time to test this.  Using gcc-3.3.5 and your patch
against 2.6.16-rc6, everything is booting fine on an Ultra 1.  Anything
you'd like to see from the compiled output?

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_+7jOrYHXjpwcTQl.ynb0iVq
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEFI4YdKvgdVioq28RAhY1AKCIqRHXgPf3iaH30eHT0DoRa6qRGwCfdbxd
qIbZ73cRaGjUprsEilGvBDI=
=x5nF
-----END PGP SIGNATURE-----

--Sig_+7jOrYHXjpwcTQl.ynb0iVq--
