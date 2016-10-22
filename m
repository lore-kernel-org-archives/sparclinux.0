From: James Clarke <jrtc27@jrtc27.com>
Date: Sat, 22 Oct 2016 09:51:28 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <20161022095128.GA55483@Jamess-MacBook.local>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
To: sparclinux@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2016 at 09:07:26PM -0400, David Miller wrote:
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Fri, 21 Oct 2016 22:52:45 +0100
>=20
> > This indeed was the case. The attached patch fixes the problem for me,
> > generating 0x106ffff2, which gdb can verify is sensible (of course, the
> > addresses have shifted slightly):
>=20
> Please don't use attachments for patch submissions.
>=20
> Patches must be inline so that they can be commented upon properly
> using simply email quoting mechanisms.
>=20
> Thank you.

Ok; same patch inline:

=46rom 27ecad347d19c613d4e85665e710f1bd6bd56117 Mon Sep 17 00:00:00 2001
=46rom: James Clarke <jrtc27@jrtc27.com>
Date: Fri, 21 Oct 2016 19:11:10 +0100
Subject: [PATCH] sparc: Handle negative offsets in arch_jump_label_transform

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 arch/sparc/kernel/jump_label.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/jump_label.c b/arch/sparc/kernel/jump_label.c
index 59bbeff..dec09ce 100644
--- a/arch/sparc/kernel/jump_label.c
+++ b/arch/sparc/kernel/jump_label.c
@@ -19,12 +19,20 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	if (type =3D=3D JUMP_LABEL_JMP) {
 		s32 off =3D (s32)entry->target - (s32)entry->code;
=20
+		BUG_ON(off & 3);
+
 #ifdef CONFIG_SPARC64
-		/* ba,pt %xcc, . + (off << 2) */
-		val =3D 0x10680000 | ((u32) off >> 2);
+		/* WDISP19 - target is . + (immed << 2) */
+		BUG_ON(off > 0xfffff);
+		BUG_ON(off < -0x100000);
+		/* ba,pt %xcc, . + off */
+		val =3D 0x10680000 | (((u32) off >> 2) & 0x7ffff);
 #else
-		/* ba . + (off << 2) */
-		val =3D 0x10800000 | ((u32) off >> 2);
+		/* WDISP22 - target is . + (immed << 2) */
+		BUG_ON(off > 0x7fffff);
+		BUG_ON(off < -0x800000);
+		/* ba . + off */
+		val =3D 0x10800000 | (((u32) off >> 2) & 0x3fffff);
 #endif
 	} else {
 		val =3D 0x01000000;
--=20
2.9.3


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYCzagAAoJELGTdwwYahx9RxUP/1LDpeYEvV1Nzp1OVPKkdSdx
hPjQREiiopP5ap7iKq8chUnwjlN5968dzlN9X0Tpr2fYxD+qrKf/hlk3Io+t1h8V
KsgkFIPt5+zUW5u9F2iFQ+Sy5JrIPg5ohpuCu59NVS4hkUZmSLobw10AxdS0CH/z
anfA6gRpytMjf35bmNNBCAVly5jqPwFIHxYfZKoMCT03SgubAU5GbZjqQ+5up3ij
Pe+mbnz0OeL8HLQSUtEhD8bkccMddzSy1DnuKJDZAQ4N0FsgKkrKUJSNW4GV2t5o
x+/o/psvdCLTug/714qfCteTNSUWZ6Z23OiCCb048hPEMKBDnjMfzNGTjuj3T6uF
h5ILZgTlB3jCaDnXdgR9asRz+JaMTooPVxEn6ZiIFfFNPPRkEuo8vOUaa53MgbVF
6TbE0J7WU1Y/9hDSt//y3jR9N+XvE4u0QinJ4dGDHkbgZD7++7A3yvJ0kTwgzdM/
BtYs3HWY63mH4QyqnUec/P9o4rNhJYHTDuhfTumA6qixJvAhNpZJ5orcsQnS+pk7
TOWQ+JaVPgIIyyY42ha1LbzY7Zp0ws/T5pNkaWDXjHDZejp+jZqzesKUu0LzVb+9
2eiC+iely1m3qGsgJNswU9NM+o6O32qtvkRyLJxvzMs7llfDSWkPbvzBnvwGryGu
0ypDgBc0zy51x5AkCu54
=rRDi
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
