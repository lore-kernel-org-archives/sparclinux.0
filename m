From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Fri, 09 Apr 2004 16:42:27 +0000
Subject: Kernel compilation issue when enabling Stack Overflow Detection in
Message-Id: <1081528947.9655.134.camel@eradicator.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-OQ51vCkaXSM0aeyqOkSC"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-OQ51vCkaXSM0aeyqOkSC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

When I enable 'Stack overflow detection' (CONFIG_STACK_DEBUG) in 2.6.5
and earlier (tried 2.6.4 and 2.6.5-rcX), it caused the kernel
compilation to die with the a warning that -pg and -fomit-frame-pointer
should not be used simultaneously.  I edited Makefile to remove the
addition of -fomit-frame-pointer from the CFLAGS.  Compilation
continued, but when the kernel was linking .tmp_vmlinux1, I got
unresolved symbol messages for '_mount'

Turning off CONFIG_STACK_DEBUG fixed the problem for me.

--Jeremy

--=-OQ51vCkaXSM0aeyqOkSC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAdtJzgKpk8srJOlIRAqeSAJ9AjOzHpNZbldIB6tdn/WsLizZegwCfYUr8
hPVnqxTRRA/2cTLg01WOJ5g=
=XpKo
-----END PGP SIGNATURE-----

--=-OQ51vCkaXSM0aeyqOkSC--

