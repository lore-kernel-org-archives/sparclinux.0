From: Friedrich Oslage <bluebird@porno-bullen.de>
Date: Sat, 10 May 2008 20:23:45 +0000
Subject: Re: [BUG] Kernel panic on heavy disk activity with esp_scsi
Message-Id: <1210451026.13300.6.camel@lya.porno-bullen.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-cl9ZT6np1MffasEirSpC"
List-Id: <sparclinux.vger.kernel.org>
References: <1210367903.21472.14.camel@lya.porno-bullen.de>
In-Reply-To: <1210367903.21472.14.camel@lya.porno-bullen.de>
To: sparclinux@vger.kernel.org


--=-cl9ZT6np1MffasEirSpC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> this one is reproducable with 2.6.25.2 and 2.6.26-rc1 but I never got it
> using 2.6.24.6.

I did more tests, first bad commit is:

commit 6232665040f9a23fafd9d94d4ae8d5a2dc850f65
Merge: 94ed294... c18d125...
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jan 31 11:48:53 2008 +1100

    Merge
git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86
   =20
    * git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86:
      alpha: fix x86.git merge build error
      ia64: on UP percpu variables are not small memory model
      x86: fix arch/x86/kernel/test_nx.c modular build bug
      s390: use generic percpu linux-2.6.git
      POWERPC: use generic per cpu
      ia64: use generic percpu
      SPARC64: use generic percpu
      percpu: change Kconfig to HAVE_SETUP_PER_CPU_AREA
      modules: fold percpu_modcopy into module.c
      x86: export copy_from_user_ll_nocache[_nozero]
      x86: fix duplicated TIF on 64-bit

Regards,
Friedrich Oslage

--=-cl9ZT6np1MffasEirSpC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgmBFEACgkQknxn9PmJ76XAgACfdGPN96w0rOkya3v/nU0m98dE
FEQAn3pSN7yUemhVBxtv0VePj8U5O9md
=DXMs
-----END PGP SIGNATURE-----

--=-cl9ZT6np1MffasEirSpC--

