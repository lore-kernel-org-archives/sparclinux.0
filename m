From: Denny Schierz <linuxmail@4lin.net>
Date: Mon, 27 Feb 2012 07:25:12 +0000
Subject: Don't get T2000 Enterprise booting (with any? kernel)
Message-Id: <B80DFA69-6F19-48DE-A39E-D9B32904BD60@4lin.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_25E72027-E257-41B2-AD87-901866B33981"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--Apple-Mail=_25E72027-E257-41B2-AD87-901866B33981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

hi,

I have a Sun Enterprise T2000 and I try to get Debian onto the disks, =
but it fails with kernel 2.6.32, 2.6.30, 3.2 and the latest stable =
kernel. I have build for my Sunfire v245 a NFS rescue system and I was 3 =
or 4 times able to boot into my NFS root from the T2000. But in most =
cases it fails:

[   60.554011] IP-Config: Got DHCP answer from 192.168.1.1, my address =
is 192.168.1.12
[   61.137949] IP-Config: Complete:
[   61.138047]      device=3Deth3, addr=3D192.168.1.12, =
mask=3D255.255.255.0, gw=3D192.168.1.1,
[   61.138243]      host=3De01, domain=3Dfoo, nis-domain=3D(none),
[   61.138428]      bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, =
rootpath=3D/srv/fai-sparc/nfsroot
[   61.138774] Warning: unable to open an initial console.
[   61.144119] Kernel panic - not syncing: Attempted to kill init!
[   61.144242] Call Trace:
[   61.144294]  [000000000045b8f8] do_exit+0xa8/0x6bc
[   61.144344]  [000000000045bf7c] do_group_exit+0x70/0xa8
[   61.144405]  [000000000045bfcc] SyS_exit_group+0x18/0x28
[   61.144472]  [0000000000405fd4] linux_sparc_syscall32+0x34/0x40
[   61.144583] Press Stop-A (L1-A) to return to the boot prom

[   83.503215] rtc-sun4v rtc-sun4v: setting system clock to 2012-02-25 =
11:06:56 UTC (1330168016)
[   85.678958] e1000e: eth3 NIC Link is Up 100 Mbps Full Duplex, Flow =
Control: Rx/Tx
[   85.679152] e1000e 0001:07:00.1: eth3: 10/100 speed: disabling TSO
[   85.693972] Sending DHCP requests ., OK
[   87.202052] IP-Config: Got DHCP answer from 192.168.1.1, my address =
is 192.168.1.12
[   87.786547] IP-Config: Complete:
[   87.786669]      device=3Deth3, addr=3D192.168.1.12, =
mask=3D255.255.255.0, gw=3D192.168.1.1,
[   87.786865]      host=3De01, domain=3Dfoo, nis-domain=3D(none),
[   87.786950]      bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, =
rootpath=3D/srv/fai-sparc/nfsroot
[   87.787123] Warning: unable to open an initial console.
[   87.792121] Kernel panic - not syncing: Attempted to kill init!
[   87.792197] Call Trace:
[   87.792249]  [000000000045b8f8] do_exit+0xa8/0x6bc
[   87.792299]  [000000000045bf7c] do_group_exit+0x70/0xa8
[   87.792360]  [000000000045bfcc] SyS_exit_group+0x18/0x28
[   87.792427]  [0000000000405fd4] linux_sparc_syscall32+0x34/0x40
[   87.792539] Press Stop-A (L1-A) to return to the boot prom

Complete boot dmesg : http://pastebin.com/NWp79bG3

I also tried different Debian installer, but older Lenny images and new =
Squeeze, fails:

=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 Loading additional =
components =
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
=E2=94=82                                                                =
         =E2=94=82
=E2=94=82                                   16%                          =
         =E2=94=82
=E2=94=82                                                                =
         =E2=94=82
=E2=94=82 [ 1753.931851] Unable to handle kernel paging request at =
virtual address 000000f203204000
[ 1753.932033] tsk->{mm,active_mm}->context =3D 000000000000018d         =
     =E2=94=82
[ 1753.932134] tsk->{mm,active_mm}->pgd =3D =
fffff801fd52a000=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98
[ 1753.932670] Kernel panic - not syncing: Aiee, killing interrupt =
handler!
[ 1753.933114] Press Stop-A (L1-A) to return to the boot prom


mostly accessing the hardware/ or detection from it.


So, I need some suggestions to get it working.

If it helps, I can make this host public for some people, to try out, =
what is the problem.

Also, I put the latest firmware on it, but it helps only a few times to =
get booting into the NFSroot.


cu denny=

--Apple-Mail=_25E72027-E257-41B2-AD87-901866B33981
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)

iEYEARECAAYFAk9LL9gACgkQKlzhkqt9P+CxmwCfTlYU/Gqp0W+lpHaHY/AaTvtm
HAsAoIzr0Bw4RsAHdEEt1kOeGrSpPwob
=wSFB
-----END PGP SIGNATURE-----

--Apple-Mail=_25E72027-E257-41B2-AD87-901866B33981--
