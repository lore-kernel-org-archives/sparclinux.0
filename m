From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 17 Sep 2012 10:07:00 +0000
Subject: Random segmentation fault on UltraSparc T1 based machines
Message-Id: <20120917100700.GA6459@ohm.aurel32.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi,

Debian is using among other machines Sun Fire T2000 machines for
building the current sparc port and for the development of the
sparc64 one.

We are experiencing random non-reproducible segmentation faults when
doing parallel building, calling make with -jX and X > 1. This seems
to happen more and more as X increases. We seems to experience that
only with GCC, but that might be due to the fact that these machines
are build daemons and that GCC is the most used program. When it
happens we get this kind of error:

| /build/buildd-qemu_1.1.0+dfsg-1-sparc64-dWbLRR/qemu-1.1.0+dfsg/target-i386/translate.c:
| In function 'disas_insn':
| /build/buildd-qemu_1.1.0+dfsg-1-sparc64-dWbLRR/qemu-1.1.0+dfsg/target-i386/translate.c:7642:1:
| internal compiler error: Segmentation fault
| Please submit a full bug report,
| with preprocessed source if appropriate.
| See <file:///usr/share/doc/gcc-4.6/README.Bugs> for instructions.
| The bug is not reproducible, so it is likely a hardware or OS problem.

We don't have this kind of issue with other machines (mostly UltraSparc
II and III) setup in the same way. Given it happens on all UltraSparc T1
based machines, hosted at different places in the world, we doubt it's a
hardware issue (RAM for example). We have seen the issue with both
kernels 2.6.32 and 3.2.

Do you maybe have an idea about what could be the issue, and how to
debug/solve it?

Regards,
Aurelien

--
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD4DBQFQVvZEw3ao2vG823MRAmQ4AJsG9yLO1OwK1LfV08g7s2hdyfmvCwCXdO0H
h27tMKqtkJer8Tob8sEx3Q==
=etvP
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
