From: joshk@triplehelix.org (Joshua Kwan)
Date: Thu, 19 Aug 2004 09:09:37 +0000
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040819090937.GG8070@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1Ow488MNN9B9o/ov"
List-Id: <sparclinux.vger.kernel.org>
References: <20040818235528.GA8070@triplehelix.org> <20040818184303.1ae13c98.davem@redhat.com>
In-Reply-To: <20040818184303.1ae13c98.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2004 at 06:43:03PM -0700, David S. Miller wrote:
> Oops, it's possible that the bug fixed by this patch
> might fix your problem...

It doesn't. :(

                                                                RMIK opesdi=
aefuda lc
VS one ot(x2flsse)
Setting up filesystem, please wait ...
mount: Mounting tmpfs oKre ai:Atmtdt ilii!
                                          n 0PesL- ortr otebo rm
                                                                 /mnt faile=
d: Bad address
mount: Mounting shm on /mnt failed: Bad address

(May I note that sparc64 serial output for printks continues to miss every
other character, making reading kernel messages and hence debugging a
nightmare.

VS one ot(xtflsse)

is=20

VFS: Mounted root (ext2 filesystem), I think.)

This is 2.6.8 with your new two patches applied on top of each other.

--=20
Joshua Kwan

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQSRuT6OILr94RG8mAQLlpg//QA706e7sD6FyLmi18OsSy3zIZ16xCKgD
54QEexJzhwNrPBQSPGsv7fZPwusV8xSERKL513UnBqygo5Hb1Y/ZMB6+cr/hC6Nk
nFm4n53bd6gEtoMYwads1Wy4RocjWmK0ORLOp2GZjELWBXXBRsdb6o++A90VwAwm
2LVM6sZ18CWApsg6f/SJOVgrdknEn6A2SrrvapgMqcyT6ZrNq1uFppLnDAZGOrwl
WiGNn+Q1400HBc3gdwvMVLlHbGhY9NjG/4jDuPxQXuPbPWS2H3nD7GR9opMOExO7
gqtUwWKHn6Bly0cKiSlcEY6i8lmRyE49a83DEQiaeImluZqchLr9pUxZ02HJPXoR
IXkFTEJ1VsntVvYb/eauZcznzAxPY9l6ww0+XaeuTCEGeDttyKA4nBvtvWqN29I8
whpKQx67xFSvLDQ/V6J3PXdtbLPK5rQeBtVK6c0OtoG4p0wi0JvwXFuX2ZwnslcH
2OmwCMVK3doLDc5oq4HBHLCx4gn/L8zPs4G+64hjnovi/Tn2q7cUYw/zPmVMc1St
R+j4wXngPplOc/xTxwDPqCHYV5yrxZd+lozyC5YIBdWfQSQiS91NKP4cK8fjL9gq
pMz+ISbYvhJFikNHhwXzHKtUoepAZ456VO0eRByAuaoNpDSKHwip3scPPa+m8lz2
u+Jl2C6CgHU=
=Ssf/
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
