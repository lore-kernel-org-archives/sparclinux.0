From: joshk@triplehelix.org (Joshua Kwan)
Date: Wed, 21 Jul 2004 08:16:53 +0000
Subject: Re: Weird serial problems in 2.6.7
Message-Id: <20040721081653.GG23921@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UFHRwCdBEJvubb2X"
List-Id: <sparclinux.vger.kernel.org>
References: <20040721064705.GE23921@triplehelix.org>
In-Reply-To: <20040721064705.GE23921@triplehelix.org>
To: sparclinux@vger.kernel.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2004 at 11:47:05PM -0700, Joshua Kwan wrote:
> eh:HPYMA PICerO 010ae tent 8:0:0:d:3:7

Something else seems to be up. I tried to halt, saw it hanging, opened
another SSH session and decided to strace:

open("/dev/ttyS0", O_WRONLY|O_NONBLOCK|O_LARGEFILE

It seems to be stuck there indefinitely. lsof /dev/ttyS0 returns
nothing. Same for fuser -a /dev/ttyS0.

The plot thickens...

--=20
Joshua Kwan

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQP4mc6OILr94RG8mAQKoYRAA9jgKxmEs/QFwmJNBtcDOz86jn7QfZGuN
reW+MSURBhgplkwSCO7p8TFh+Q6G2akB2Ypiyhx2QzJAg+5GfnJ5FwFwqpkoxESD
P+JFKRsEN7H9TVnYbqMIZDf+DqxpsREI7qm4/eDaMO77DpWRdMW3O51UQpCqPm29
WWTzAcbSkub3kM0UxxIzORWIuh3YufoLLxRa1RGC7xircc46PbSIx1amFf6jnb9m
COHjgLmkGkvwYfD4fJSpgjvwGb10+0bue95tlm1zUxMJjTujtH2P8Z9soHjINORI
G3Myz5TcC/nM0QBhBJvBzv7OncZG+BESBVZswCdGLBl6uBaZj6kingeHj3zHF/0w
CO8Z1im/SwzxnerYiG18QeHY2Ko4OpChtqLoPwuZs7rnwEFlMv15kmgihTMJjzEk
BWHj2PbCnN08YxIyt+14G+A04dxEDBMDkjKlCId0+Rz9/4ZvX/bxmlPiPoVPqNHd
Wt7fNA+7GuPMNMhi/mjk96//OdDuPrs+fDIQgwGeAx8E6z0BvQ5+oxCj14HwPZK6
qeKzJHxngxDPGsRJVPNZ7DQw0vcjWR4x96Wa8dkkaPuLOfQXZaeTpkMYuPKF77Q5
HmqvheJ2QVnaLCaslDZUJBPdcyFh5anAKKuGUkEUqEjs4QCox5lZQ+nuuG5hGQVj
sCdhu2DxetQ=
=imGa
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
