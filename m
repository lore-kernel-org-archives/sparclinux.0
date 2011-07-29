From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 29 Jul 2011 12:21:06 +0000
Subject: Re: sparc: rename atomic_add_unless
Message-Id: <20110729222106.bd1b770c53f035007e312986@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__29_Jul_2011_22_21_06_+1000_gOl2Se3NH8ELW/0i"
List-Id: <sparclinux.vger.kernel.org>
References: <20110728104017.GA27861@entuzijast.net>
In-Reply-To: <20110728104017.GA27861@entuzijast.net>
To: sparclinux@vger.kernel.org

--Signature=_Fri__29_Jul_2011_22_21_06_+1000_gOl2Se3NH8ELW/0i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 28 Jul 2011 12:40:17 +0200 Josip Rodin <joy@entuzijast.net> wrote:
>
> This patch[0] seems to fix a build issue, but it doesn't fix the
> functionality - the previous change[1] changed the return value semantics,
> it's now supposed to be to be just the old value, rather than a compariso=
n.
>=20
> [0] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommitdiff;h=3D678624e401b0b7747762b5223fb23f86dcdacc93
> [1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommitdiff;h=3Df24219b4e90cf70ec4a211b17fbabc725a0ddf3c

Ooops, sorry about that. Thanks for pointing it out.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__29_Jul_2011_22_21_06_+1000_gOl2Se3NH8ELW/0i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMqWyAAoJEDMEi1NhKgbsl/4H/3HRrrEP2ayxug4Vu9aSHm86
dQQ0otaH3zYHMykK7YVRYV0uwJeTOlF+Riu1AJHdGAZPnGUFaa2NMQM6G7Dlkj7S
7fHunh57OUf/4GfyePJA3UzDdaSvJc3vK1CBFm0tWu+VZd2aqNW3X6/g5jOmC/Fa
REtns485X8Af4ZNerMgVkwXb7LCO4D42Q6WM9bYK0+5EzCJGjxqxKsggVYnEqxkO
2ObFAGciCR0ACIrmqJQjx7mgF8GYDbEQcw8W+UGZOxuVNxqLiWbWvHxN8wFz0duY
v+AJBZ9VUXhi6OmVGpE0agXT8k0+d1IrCeaujxtdrzmzvWJMS4tqAjZoLi4bzE0=
=V6Q4
-----END PGP SIGNATURE-----

--Signature=_Fri__29_Jul_2011_22_21_06_+1000_gOl2Se3NH8ELW/0i--
