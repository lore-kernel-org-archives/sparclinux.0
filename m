From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Aug 2008 01:46:02 +0000
Subject: sparc build failure
Message-Id: <20080828114602.6c6df4a2.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__28_Aug_2008_11_46_02_+1000_08DEFSLk7n2IRWKB"
List-Id: <sparclinux.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "William L. Irwin" <wli@holomorphy.com>

--Signature=_Thu__28_Aug_2008_11_46_02_+1000_08DEFSLk7n2IRWKB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Linus' tree fails to build for sparc32 allmodconfig:

kernel/relay.c:701: undefined reference to `smp_call_function_single'

This is because it has CONFIG_SMP but not CONFIG_USE_GENERIC_SMP_HELPERS.

I am not sure what to do about this.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__28_Aug_2008_11_46_02_+1000_08DEFSLk7n2IRWKB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki2A1oACgkQjjKRsyhoI8yBQQCdFvwQA1Rl6dfDQrO01c7zhH0e
7ysAoL9mlQ3tiqZiggMBiV+qXojFvKZ9
=dAEX
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Aug_2008_11_46_02_+1000_08DEFSLk7n2IRWKB--
