From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 10 Sep 2010 01:29:48 +0000
Subject: bugs compiling 2.6.35.4
Message-Id: <201009092029.52510.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart3206096.bclhWbxIis"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart3206096.bclhWbxIis
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Trying to compile the current Fedora 14 kernel=20
im getting=20
drivers/built-in.o: In function `n2_des_setkey':
/builddir/build/BUILD/kernel-2.6.35.fc14/linux-2.6.35.sparc64/drivers/crypt=
o/n2_core.c:701:=20
undefined reference to `des_ekey'
`.exit.text' referenced in section `.devexit.text' of drivers/built-in.o:=20
defined in discarded section `.exit.text' of drivers/built-in.o

we have CONFIG_CRYPTO_DEV_NIAGARA2=3Dy and CONFIG_CRYPTO_DES=3Dm=20


With CONFIG_DEBUG_STRICT_USER_COPY_CHECKS=3Dy  i get the following while=20
unsetting it allows compilation to move on

In file included from=20
/builddir/build/BUILD/kernel-2.6.35.fc14/linux-2.6.35.sparc64/arch/sparc/in=
clude/asm/uaccess.h:4,
                 from=20
/builddir/build/BUILD/kernel-2.6.35.fc14/linux-2.6.35.sparc64/arch/sparc/in=
clude/asm/elf_64.h:10,
                 from=20
/builddir/build/BUILD/kernel-2.6.35.fc14/linux-2.6.35.sparc64/arch/sparc/in=
clude/asm/elf.h:4,
                 from include/linux/elf.h:7,
                 from include/linux/module.h:14,
                 from fs/debugfs/file.c:16:
In function 'copy_from_user',
    inlined from 'write_file_bool' at fs/debugfs/file.c:434:
/builddir/build/BUILD/kernel-2.6.35.fc14/linux-2.6.35.sparc64/arch/sparc/in=
clude/asm/uaccess_64.h:232:=20
error: call to 'copy_from_user_overflow' declared with attribute error:=20
copy_from_user() buffer size is not provably correct
make[2]: *** [fs/debugfs/file.o] Error 1

Dennis

--nextPart3206096.bclhWbxIis
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyJihAACgkQkSxm47BaWffo3QCeJaqthQo7al3SXYOY7BnpnvoG
xC8AnRKp15FVv/7qdkiF9VCaLPHVXv18
=aBCy
-----END PGP SIGNATURE-----

--nextPart3206096.bclhWbxIis--
