From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sat, 04 Dec 2004 01:34:25 +0000
Subject: [PATCH] missing include in asm-sparc/signal.h
Message-Id: <1102124065.20364.4.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-XITFlbPy4WQ1DrFCdGn+"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-XITFlbPy4WQ1DrFCdGn+
Content-Type: multipart/mixed; boundary="=-XBRU2ZHf1tuMu2Ba5GSe"


--=-XBRU2ZHf1tuMu2Ba5GSe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

asm-sparc/signal.h needs:

#include <linux/compiler>

because it uses __user around line 214.  Without this include, userland
code including asm/signal.h will fail to compile.

--=20
Jeremy Huddleston <eradicator@gentoo.org>

--=-XBRU2ZHf1tuMu2Ba5GSe
Content-Disposition: attachment; filename=linux26-headers-2.6.8.1-sparc-signal_h.patch
Content-Type: text/x-patch; name=linux26-headers-2.6.8.1-sparc-signal_h.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2luY2x1ZGUvYXNtLXNwYXJjL3NpZ25hbC5oLm9yaWcJMjAwNC0wNy0yMCAxMTow
NDozOC40NTk3MjE0ODAgLTA3MDANCisrKyBsaW51eC9pbmNsdWRlL2FzbS1zcGFyYy9zaWduYWwu
aAkyMDA0LTA3LTIwIDExOjA2OjA2Ljk0NTA2NzgxNCAtMDcwMA0KQEAgLTMsNiArMyw3IEBADQog
I2RlZmluZSBfQVNNU1BBUkNfU0lHTkFMX0gNCiANCiAjaW5jbHVkZSA8YXNtL3NpZ2NvbnRleHQu
aD4NCisjaW5jbHVkZSA8bGludXgvY29tcGlsZXIuaD4NCiANCiAjaWZkZWYgX19LRVJORUxfXw0K
ICNpZm5kZWYgX19BU1NFTUJMWV9fDQo=


--=-XBRU2ZHf1tuMu2Ba5GSe--

--=-XITFlbPy4WQ1DrFCdGn+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBsRQgOpjtAl+gMRURAgqJAKCTKtcKptQsyRMeQSDvOy5vIfg64QCg0GdU
VKGdxXU6THxk6kLaYiCyUDM=
=dZ2f
-----END PGP SIGNATURE-----

--=-XITFlbPy4WQ1DrFCdGn+--

