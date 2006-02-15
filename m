From: Jason Wever <weeve@gentoo.org>
Date: Wed, 15 Feb 2006 14:03:42 +0000
Subject: 2.6.16-rc1 failed to boot on Blade 100
Message-Id: <20060215070342.28c7b14c@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_KPUT=7e6nbGxbCH/moJiZXE"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Sig_KPUT=7e6nbGxbCH/moJiZXE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

Had what may appear to be a fluke occurance of the 2.6.16-rc1 kernel
failing to boot on a Blade 100 running OBP 4.17.1.  I've booted this
kernel before without seeing this problem, and when I rebooted (with
the -p argument), I didn't run into it.

Failure is as follows:

boot: 2.6.16-rc1
Allocated 8 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.16

Remapping the kernel... done.
Registering callbacks... done.
Booting Linux...
PCI: Bogus PROM assignment. BUS[00] DEVFN[40]
PCI: phys[81004010:00000000:00000900] size[00000000:00000100]
PCI: RES[0000000000000c00-->0000000000000cff:(101)]
Please email this information to davem@redhat.com
Program terminated
ok=20

I've also tried 2.6.16-rc3-git3 and that seems to boot normally.  I'll
keep an eye on it to see if it has this type of problem.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_KPUT=7e6nbGxbCH/moJiZXE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFD8zS+dKvgdVioq28RAsRZAKCyNExDb3ctl+yWb0GKmc2/DY/PiwCYt+Jx
tb1aAHpBUGmllga04aWlgg==
=3+FE
-----END PGP SIGNATURE-----

--Sig_KPUT=7e6nbGxbCH/moJiZXE--
