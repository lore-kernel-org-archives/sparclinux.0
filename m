From: joshk@triplehelix.org (Joshua Kwan)
Date: Thu, 06 May 2004 22:28:28 +0000
Subject: Re: [PATCH] Enable i2c for sparc64
Message-Id: <20040506222828.GA29131@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

patch 1: rope in drivers/i2c/Config.in for arch/sparc64

A great deal of device drivers that are enabled for use on sparc64
depend on CONFIG_I2C, but due to what I believe is a shortcoming of the
2.4 configuration system, these drivers are selectable even when
CONFIG_I2C is not available at all. This results in unresolvable symbols
galore, especially for distribution kernels that rope in every damn
thing as a module.

I added i2c's Config.in to arch/sparc64/config.in and enabled it for
sparc64, and it seems to work OK.

--=20
Joshua Kwan

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_sparc64_i2c.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.4.26/arch/sparc64/config.in~	2004-04-19 12:13:17.000000=
000 -0400
+++ kernel-source-2.4.26/arch/sparc64/config.in	2004-04-19 12:13:39.0000000=
00 -0400
@@ -21,6 +21,8 @@
 mainmenu_option next_comment
 comment 'General setup'
=20
+source drivers/i2c/Config.in
+
 tristate 'UltraSPARC-III bootbus i2c controller driver' CONFIG_BBC_I2C
=20
 define_bool CONFIG_VT y

--3MwIy2ne0vdjdPXF--

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJq8C6OILr94RG8mAQKUhA/+NzfyHLEuhuhyfcHz5goIQMAjGQxpH0HU
RBDpHcr8P0Osxgbgkxs+pSU48cRjOiBW6T4d3WOouW0njM1JVDy8k15IsXtPFuAD
URapWu3i5LQRBxpVYEAekengsxbO8mH6NbOCgfqqXLzOxYHCpDZCDalF1cN29EVh
lb0eYyiYuysMLY5baPU4C9c8Lgnsegx4abzeuO5TE1Iq/djjM2/nPsgOupZH8/El
QrTPxZjstXmUj/tHUL3JOpauf1qam0opQd4gW1a4Bn6nMMx5BafkIMUTGVpGOxj0
znc8lKH5uh1r0gIoClGH/REWM1AZUWjV5VdZkXyjEb7MGjV0pe1ieM6ExWk2bYCn
by6+Y4KVMdiiW0xmUNb3hMiYPrYTX1UAfR6/n3n2GcJBBVeLkwSDF/dZJWBMoH8w
pKPyOluO75neTqY07um9VZLPpR+xa2vbieAH7uEjDNIeiJZLDtD210R2UODBmnXs
qkzIYiGIPSFLRlX8T7lwiy1PPnhQxgMBgGNIyEOfVEqDKSMKpSBJkdj7V3PDlBE0
lCeVqvKGg33YPFfAXgGizxcKhva2VYnE6gdymxTB5Y7JzwkCcIWtEJONEtu4sWJk
7MOKb2/fO+0nCGSOGkq47fe0B+OVjHxrsueMDgAlSnbv8dHrIRD/A5yxvyXYLeXp
XT/B3+upEik=
=Dwge
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
