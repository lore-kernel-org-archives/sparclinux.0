From: Dennis Gilmore <dgilmore@redhat.com>
Date: Fri, 02 Jan 2009 20:35:19 +0000
Subject: opps building sparc64 packages
Message-Id: <200901021435.23972.dgilmore@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1274218.EjXnPt4qR6"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart1274218.EjXnPt4qR6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

trying to build openbabel sparc64=20
https://sparc.koji.fedoraproject.org/koji/taskinfo?taskID=3D112540  I got a=
n=20
opps=20

sun4v_data_access_exception: ADDR[ffffb83000000008] CTX[16ba] TYPE[0009], g=
oing.                                                                      =
       =20
              \|/ ____ \|/                                                 =
                                                                           =
       =20
              "@'/ .. \`@"                                                 =
                                                                           =
       =20
              /_| \__/ |_\                                                 =
                                                                           =
       =20
                 \__U_/                                                    =
                                                                           =
       =20
lt-atom(22311): Dax [#1]                                                   =
                                                                           =
       =20
TSTATE: 0000009911001600 TPC: 00000000004821d8 TNPC: 00000000004821dc Y:=20
00000000    Not tainted                                                    =
         =20
TPC: <exit_robust_list+0x78/0x10c>                                         =
                                                                           =
       =20
g0: 0000000000000064 g1: 0000000000000000 g2: fff8b83000000008 g3:=20
00000000000004ac                                                           =
               =20
g4: fffff803e10e9740 g5: fffff803ff392000 g6: fffff8038a094000 g7: 00000000=
00000001                                                                   =
       =20
o0: 00000014000014a4 o1: 000007fefff9d718 o2: 000007fefff9d728 o3:=20
0000000000000000                                                           =
               =20
o4: 0000000000000000 o5: 0000000000000001 sp: fffff8038a097441 ret_pc:=20
00000000004666c8                                                           =
           =20
RPC: <do_group_exit+0x8c/0xc4>                                             =
                                                                           =
       =20
l0: fffff803e10e9740 l1: 0000000000000800 l2: 00000014000014a4 l3:=20
fffff80100612790                                                           =
               =20
l4: 0000000000000000 l5: 0000000000000000 l6: fffff8038a097cf8 l7:=20
0000000000466700                                                           =
               =20
i0: fffff803e10e9740 i1: 0000000000000001 i2: 0000000000000001 i3:=20
0000000000000000                                                           =
               =20
i4: 0000000000000000 i5: 0000000000000001 i6: fffff8038a097511 i7:=20
0000000000465f64                                                           =
               =20
I7: <do_exit+0x1d0/0x8a8>                                                  =
                                                                           =
       =20
Caller[0000000000465f64]: do_exit+0x1d0/0x8a8                              =
                                                                           =
       =20
Caller[00000000004666c8]: do_group_exit+0x8c/0xc4                          =
                                                                           =
       =20
Caller[00000000004062d4]: linux_sparc_syscall+0x34/0x44                    =
                                                                           =
       =20
Caller[fffff80100a9203c]: 0xfffff80100a9203c                               =
                                                                           =
       =20
Instruction DUMP: a8102000  1068001d  ac07a7e7 <c6d8a000> 82100000  a0103ff=
2 =20
80a06000  90008015  92100018                                               =
    =20
=46ixing recursive fault but reboot is needed!      =20


Ive seen something similar building OOo also=20
22311 ?        D      0:00 /builddir/build/BUILD/openbabel-2.2.0b3-20080215-
r2249/test/.libs/lt-atom

the process that should be running ends up in a D state  so it is sleeping =
and=20
unkillable.  the processes hang around until a reboot.  any ideas where I=20
should start looking?  this happens on a T1000 and T2000 i've not yet tried=
 on=20
non-niagara hardware. =20

Dennis

--nextPart1274218.EjXnPt4qR6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkleeosACgkQkSxm47BaWfcxzgCdGFS5cXf1v7vPgkJC02mNCEB5
whcAoK55FysU6xYk12QA6wlzbjo0gsBj
=g5rA
-----END PGP SIGNATURE-----

--nextPart1274218.EjXnPt4qR6--
