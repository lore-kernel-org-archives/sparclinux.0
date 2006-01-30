From: Ferris McCormick <fmccor@gentoo.org>
Date: Mon, 30 Jan 2006 19:34:26 +0000
Subject: afbinit failure with 2.6.15 kernels (can no longer load Elite
Message-Id: <1138649666.7197.17.camel@polylepis.inforead.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-XzHN8dS4jZh3N9Vr7noL"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-XzHN8dS4jZh3N9Vr7noL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


With kernel-2.6.15 series, the program for loading Elite graphics
microcode fails:

Is this a known problem, or is the fix for afbinit known?
With the 2.6.15 kernel series (on SB1000), an attempt to load the
Elite graphics microcode with the afbinit program:
/* $Id: afbinit.c,v 1.1.1.1 1999/09/08 06:42:36 davem Exp $
(e.g., using
afbinit /dev/fb/0 /usr/lib/afb.ucode)
results in
mmap user regs: Invalid argument --- this comes from this bit of code:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 uregs =3D mmap(0, 0x2000,
             PROT_READ | PROT_WRITE,
             MAP_PRIVATE,
             afb_fd,
             0x04000000);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I'd be happy to just fix it if I knew what the mmap call should look
like with this kernel, but I don't.  (The Elite did open OK; to get this
far,
afb_fd =3D open(afb_fname, O_RDWR);
has to have worked.

Regards,
Ferris
--=20
Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
Developer, Gentoo Linux (Sparc, Devrel)

--=-XzHN8dS4jZh3N9Vr7noL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD3mpBQa6M3+I///cRAqdFAJ9B5a35+qKmuzHpPzIEF8QvgbLFGACfU7wb
LjzoAtlBggrcVVLs/7LTz4g=
=9EbM
-----END PGP SIGNATURE-----

--=-XzHN8dS4jZh3N9Vr7noL--

