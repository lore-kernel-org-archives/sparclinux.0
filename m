From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 06 Nov 2008 05:36:26 +0000
Subject: sparc/staging compile error
Message-Id: <20081106163626.2306ad75.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__6_Nov_2008_16_36_26_+1100_2zsy5uoX1u7LpmYt"
List-Id: <sparclinux.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "William L. Irwin" <wli@holomorphy.com>, sparclinux@vger.kernel.org

--Signature=_Thu__6_Nov_2008_16_36_26_+1100_2zsy5uoX1u7LpmYt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's tree from Linus gets the following error from a sparc
allmodconfig build:

ERROR: "___f_flush_cache_range" [drivers/staging/poch/poch.ko] undefined!

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__6_Nov_2008_16_36_26_+1100_2zsy5uoX1u7LpmYt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkSgloACgkQjjKRsyhoI8zIfwCgmJGxkMljrEV+GcCuSvYw1g42
6PYAn02mQtb8kVGDbDs3NqP8El/bpIsK
=xeay
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Nov_2008_16_36_26_+1100_2zsy5uoX1u7LpmYt--
