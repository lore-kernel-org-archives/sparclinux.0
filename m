From: Tom Duffy <tomduffy@dslextreme.com>
Date: Thu, 13 Jan 2005 23:12:14 +0000
Subject: mmap(/dev/mem) causing sigbus
Message-Id: <1105657934.2527.96.camel@duffman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-tX9e+t6AozGpXqhowTjY"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-tX9e+t6AozGpXqhowTjY
Content-Type: multipart/mixed; boundary="=-SmjUYWlnUanDT+e3yYzZ"


--=-SmjUYWlnUanDT+e3yYzZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

It seems that there is an issue with either mmap or mmap'ing /dev/mem on
sparc64.  A tool (mstflint) for flashing firmware for Mellanox
Infiniband HCA's is crashing on sparc64.  It mmap's /dev/mem and when it
accesses it, a bus error is generated.

Should this work?

Attached is a small test program to demonstrate.  Change BAR0 to
something in your PCI address space (grab an address from /proc/iomem).

# cat /proc/iomem
<snip>
  1ff00100000-1ff001fffff : 0000:81:00.0
    1ff00180680-1ff0018070f : ib_mthca
    1ff001f00d8-1ff001f00df : ib_mthca
  1ff00800000-1ff00ffffff : 0000:81:00.0
    1ff00800000-1ff00ffffff : ib_mthca
  1ff08000000-1ff0fffffff : 0000:81:00.0

# gdb ./mmap-test
(gdb) run
Starting program: /root/mmap-test
warning: linux_test_for_tracefork: unexpected result from waitpid (3298, st=
atus 0xb7f)

Program received signal SIGBUS, Bus error.
0x00010630 in main () at mmap-test.c:29
29              value=3D *( (unsigned*)(ptr + 0x000f0014) );
(gdb) print ptr
$1 =3D (void *) 0x7018c000
(gdb) print ptr + 0x000f0014
$2 =3D (void *) 0x7027c014
(gdb) x 0x7027c014
0x7027c014:     Cannot access memory at address 0x7027c014

# cat /proc/3317/maps
<snip>
7018c000-7028c000 rw-s 1ff00100000 00:0d 316                             /d=
ev/mem

# uname -a
Linux tat 2.6.10 #14 SMP Mon Jan 3 12:30:51 PST 2005 sparc64 GNU/Linux

-tduffy

--=-SmjUYWlnUanDT+e3yYzZ
Content-Disposition: attachment; filename=mmap-test.c
Content-Type: text/x-csrc; name=mmap-test.c; charset=UTF-8
Content-Transfer-Encoding: base64

I2RlZmluZSBCQVIwIDB4MWZmMDAxMDAwMDB1bGwNCiNkZWZpbmUgX1hPUEVOX1NPVVJDRSA1MDAN
CiNkZWZpbmUgX0ZJTEVfT0ZGU0VUX0JJVFMgNjQNCiNpbmNsdWRlIDxzeXMvbW1hbi5oPg0KI2lu
Y2x1ZGUgPGZjbnRsLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3RkaW8uaD4N
Cg0KaW50IG1haW4oKQ0Kew0KCWludCBmZDsNCgl2b2lkICpwdHI7DQoJdW5zaWduZWQgdmFsdWU7
DQoJdW5zaWduZWQgbG9uZyBsb25nIG9mZnNldCA9IEJBUjA7DQoJZmQgPSBvcGVuKCIvZGV2L21l
bSIsT19SRFdSIHwgT19TWU5DKTsNCglpZiAoZmQ8MCkgew0KCQlwZXJyb3IoIm9wZW4iKTsNCgkJ
cmV0dXJuIDE7DQoJfQ0KDQoJcHRyID0gbW1hcChOVUxMLCAweDEwMDAwMCwgUFJPVF9SRUFEIHwg
UFJPVF9XUklURSwNCgkJCU1BUF9TSEFSRUQsIGZkLCBvZmZzZXQpOw0KDQoJaWYgKCAoISBwdHIp
IHx8IChwdHIgPT0gTUFQX0ZBSUxFRCkgKSB7DQoJCXBlcnJvcigibWFwIik7DQoJCXJldHVybiAx
Ow0KCX0NCg0KCXZhbHVlPSAqKCAodW5zaWduZWQqKShwdHIgKyAweDAwMGYwMDE0KSApOw0KCQ0K
CXByaW50ZigidmFsdWUgYXQgMHgwMDBmMDAxNCBpcyAlIzguOHhcbiIsIHZhbHVlKTsNCg0KCXJl
dHVybiAwOw0KZXJyOg0KCXJldHVybiAxOw0KfQ0KDQo=


--=-SmjUYWlnUanDT+e3yYzZ--

--=-tX9e+t6AozGpXqhowTjY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB5wBOdY502zjzwbwRAh4uAKCILj+KKKyPAsFVLUsbVKO+uU93SwCdHCHJ
V6jssVktq0pfCPZCp6c0Wrg=
=pKZ4
-----END PGP SIGNATURE-----

--=-tX9e+t6AozGpXqhowTjY--

