From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Tue, 13 Dec 2005 18:07:06 +0000
Subject: 2.6.15* regression?
Message-Id: <439F0DCA.8020203@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Situation: ultra 5, ensoniq/creative ens1371 board for sound, kernel
builtin alsa driver using oss compat.
Kernel 2.6.15-rc5 or 2.6.15-rc5-git3 built with gcc 3.4.5.
Log snip:

- -----
Bad page state at free_hot_cold_page (in process 'esd', page
fffff80000335f08)
flags:0x0000000000000414 mapping:0000000000000000 mapcount:0 count:0
Backtrace:
Call Trace:
 [000000000046d4f4] unmap_vmas+0x574/0x6e0
 [000000000047124c] unmap_region+0x6c/0x140
 [00000000004715a4] do_munmap+0x164/0x240
 [0000000000471d7c] sys_munmap+0x1c/0x40
 [0000000000406c94] linux_sparc_syscall32+0x34/0x40
 [00000000701d95e0] 0x701d95e0
Trying to fix it up, but a reboot is needed
- -----

Anyone else seen this under other circumstances?
Basically it gets triggered when esd (or other sound-driving
application) ends, be it either a normal or killed scenario.
Sound sounds (sic) fine though.
This doesn't happen with previous 2.6.14* kernels.

- --
Gustavo Zacarias
Gentoo/SPARC monkey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDnw3KV3G/IBCn/JARAvpJAJ9Y/XiS+k2s3T63DLTIiXfpzbWlvgCeLcEC
AvxrmHBczyOyEdvjqx7n7B8=tC8/
-----END PGP SIGNATURE-----
