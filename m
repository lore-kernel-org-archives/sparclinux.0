From: Josh Grebe <josh@brokedown.net>
Date: Wed, 08 Mar 2006 22:33:52 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <440F5BD0.9010601@brokedown.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_unix1.shortcutsolutions.net-16807-1141857418-0001-2"
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
To: sparclinux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_unix1.shortcutsolutions.net-16807-1141857418-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> 
> Josh please give this a test as soon as you can, thanks a lot:

Hi Dave,

Different, but still a crash. Here is the first ERROR per cpu.
The entire dmesg (including System.map references for all TPCs)
is at: http://dev.gentoo.org/~squash/v240crash.txt

For my reference, are the TPCs following the initial ERROR lines useful?
I want to make sure all useful info is in these while keeping the SNR low...

Josh


[    2.230494] VFS: Mounted root (ext3 filesystem) readonly.
[    2.517749] ERROR(0): Cheetah error trap taken afsr[0020400000000000] afar[000007f600001180] TL1(0)
[    2.517842] ERROR(1): Cheetah error trap taken afsr[0010100000000000] afar[000000007fcea000] TL1(0)
[    2.517851] ERROR(1): TPC[000000000051ff18] TNPC[000000000051ff1c] TSTATE[0000000080009604]
000000000051fbc0 T U3memcpy

[    2.517857] ERROR(1): M_SYND(0),  E_SYND(0), Privileged
[    2.517864] ERROR(1): Highest priority error (0000100000000000) "Unmapped error from system bus"
[    2.517871] ERROR(1): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
[    2.517877] ERROR(1): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[    2.517885] ERROR(1): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
[    2.517893] ERROR(1): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[    2.517901] ERROR(1): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[    2.517908] ERROR(1): E-cache idx[800] tag[000000001e040fcf]
[    2.517915] ERROR(1): E-cache data0[0000000001724000] data1[0000000001724000] data2[0000000001724000] data3[0000000001724000]
[    2.517923] Kernel panic - not syncing: Irrecoverable deferred error trap.
[    2.517927]
[    2.517929]  <0>Press Stop-A (L1-A) to return to the boot prom
[    4.200187] ERROR(0): TPC[0000000000405138] TNPC[000000000040513c] TSTATE[0000000011f09604]
0000000000405164 T etraptl1

[    4.309986] ERROR(0): M_SYND(0),  E_SYND(0), Multiple Errors
[    4.384332] ERROR(0): Highest priority error (0000400000000000) "Error due to unsupported store"
[    4.499848] ERROR(0): AFAR E-syndrome [???]
[    4.554748] ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
[    4.679417] ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[    4.828105] ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
[    4.998524] ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[    5.147212] ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[    5.295901] ERROR(0): E-cache idx[1080] tag[000000001e040fb4]
[    5.371388] ERROR(0): E-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]


--=_unix1.shortcutsolutions.net-16807-1141857418-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFED1vVT/OY5rt9JCMRAyhsAKDHKbujTO/eTaYljpEk7F305QA0AgCgyrbq
QmLnOVIUhPIyNkxuBVjwp8s=
=BEwM
-----END PGP SIGNATURE-----

--=_unix1.shortcutsolutions.net-16807-1141857418-0001-2--
