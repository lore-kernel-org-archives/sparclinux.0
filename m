From: Joshua Kwan <joshk@triplehelix.org>
Date: Fri, 27 Aug 2004 19:22:22 +0000
Subject: [sparc32] unversioned udiv taints kernel
Message-Id: <cgo1li$t40$1@sea.gmane.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigDC641BF773586C6CCEFFE903"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC641BF773586C6CCEFFE903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I finally got some kernel-images for 2.6 built up on sparc32, but one 
thing I had to do to get stuff to fit the 2500KB limit was to break out 
scsi into modules and use an initial ramdisk. However:

$ dmesg | grep udiv
scsi_mod: no version for "udiv" found: kernel tainted.

This is the only such occurrence. arch/sparc/kernel/sparc_ksyms.c says:

EXPORT_SYMBOL(udiv);

Christoph Hellwig suggested EXPORT_SYMBOL_NOVERS but:

/* We don't mangle the actual symbol anymore, so no need for
  * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
#define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)

What's the right way to fix this?

-- 
Joshua Kwan

--------------enigDC641BF773586C6CCEFFE903
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQS+J8KOILr94RG8mAQIh9RAAxu4iGtv4XpSk9Pd1O2RO4nOohg5HcO4l
w87gRl/HlrNh3/scZpw9Acm05NIhVnWe5utRTj9arAICFP6UdNXq4LnUFyJ7ZOG0
m/QoChPSO2DfM9tWCIQCtp5Awwx4PyaPyFt8c2vE7c+RSwy2k1LCgPXPPgJ7PWKZ
noOTzknulJUVBQNGdy84G2dMJJ3mZHd7HZjQeAOK+0Ac7BXp6TPrMV++cdCLDFzo
BB5q0fmlkLVKBl5HdQvyKcl3mBRU6C1RH10mOENUGqnX2Y+4B1tKSzLPJUkNGhFK
i4RlkWNMDMP7vwvK9mX0Xt43T6ARixACSKlBNuJLSYdhaiikTz+geuhVVRGYMCZa
nA3d4EfOTUB7di6rFR0ka9XlWM5P4yiA8QGGAd1krs1zomlhWYznqg9BKnkx5vjj
8MktvnzcnRnHBQmc7wEegGpCRB4n4QmvZ9mIzhX7MkQOAqux8n0/zQULBp1N/0DG
mOdgS6V6zxMZe/0HLokRNuBGDOZWwP2I64idFYdiXfxx+tg+VPX58ROd+3Hsx595
oPS9a60xJ/PmHoPM/fMOrpFJiBs/wsWmajaBjf8Fm+r7aOqUo3i0a45wQplNzDNr
xCNpmteRyqZYRytd0gGnZscStlFkuXVZubgE2hJHhvYOUAWFdjIay2Ch0lsQ2Z0r
Xa2XNa8TDN8=
=mATB
-----END PGP SIGNATURE-----

--------------enigDC641BF773586C6CCEFFE903--

