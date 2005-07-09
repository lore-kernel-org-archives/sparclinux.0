From: Jason Wever <weeve@gentoo.org>
Date: Sat, 09 Jul 2005 15:01:26 +0000
Subject: Compilation issue on 2.6.13-rc2
Message-Id: <20050709090126.0e8096ed@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Sat__9_Jul_2005_09_01_26_-0600_mSffwx7jSYfESz7O"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature_Sat__9_Jul_2005_09_01_26_-0600_mSffwx7jSYfESz7O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In trying to build 2.6.13-rc2 on an SMP Blade 1000, I get the following
error;

  CC      arch/sparc64/kernel/irq.o
arch/sparc64/kernel/irq.c: In function `irq_affinity_read_proc':
arch/sparc64/kernel/irq.c:920: warning: initialization from incompatible
pointer type make[1]: *** [arch/sparc64/kernel/irq.o] Error 1
make: *** [arch/sparc64/kernel] Error 2

One thing to note is that this only manifests itself in an SMP enabled
kernel config, single processor does not throw it.

--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Sat__9_Jul_2005_09_01_26_-0600_mSffwx7jSYfESz7O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCz+bJdKvgdVioq28RAhKjAJ4lT0nHSAT2Wlt03O26U+iCD510XwCfat4N
8f91pUcFS35fq0xS5XuhwPg=
=Oufo
-----END PGP SIGNATURE-----

--Signature_Sat__9_Jul_2005_09_01_26_-0600_mSffwx7jSYfESz7O--
