From: valdis.kletnieks@vt.edu
Date: Sat, 30 Dec 2017 12:38:17 +0000
Subject: Re: building debug version of klibc
Message-Id: <242563.1514637497@turing-police.cc.vt.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="==_Exmh_1514637497_2626P"
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqz24hXaLZzSgn=4ZC-Mj53ecbq7J=AcwxVyypU6eNQVqA@mail.gmail.com>
	<238034.1514635201@turing-police.cc.vt.edu>
	<CADxRZqy1+ovSHdoUS+kr8=vMgLDmq+gmsz=uw2K=6JQzrxRYPQ@mail.gmail.com>
	<239797.1514636055@turing-police.cc.vt.edu>
	<CADxRZqz54xbBVucSfipzjViAa7=j5WiLodM_5i0-88szjbxB5Q@mail.gmail.com>
In-Reply-To: <CADxRZqz54xbBVucSfipzjViAa7=j5WiLodM_5i0-88szjbxB5Q@mail.gmail.com>
To: kernelnewbies@lists.kernelnewbies.org

--==_Exmh_1514637497_2626P
Content-Type: text/plain; charset=us-ascii

On Sat, 30 Dec 2017 15:27:17 +0300, Anatoly Pugachev said:

> I'm using / testing a git kernel upstream on my hardware (sparc64 /
> ppc64 / ia64 ).
> Only this time, installing latest git kernel, I get a sigserv on
> sparc64 from klibc utility (fstype), and posted about it to mailing
> list.
> So, to properly report with gdb backtrace, i was need to build klibc

You didn't have to re-install the kernel, just get the klibc files installed.
At worst, you only have to rebuild an initramfs.


--==_Exmh_1514637497_2626P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWkeIuY0DS38y7CIcAQKFvgf+KDp8vuNHKnJRySZoKqO/8OwVMxeCUXnk
doHLDcZNP1wvhcXN26fx6nwjuarSMeHJiNv+i4B5X1X/A444uV7gTg/D/DgqmNFq
muhIhfinat+teY+F8LPy8UO+uW8iz+ACWj6nA80nWnrjwSZHC54gPrxXXtic71SA
od3R/A15x/zcotGRfOTDfZTw395GnGqpLjd12eCL/+6yN9tDdBZ8D+i3t3qd1D0w
wmvBEOni1qwzUbbF5Tz1pdboXG61TjugWFEX7lPqR8UhvYjsUgC2ddmtMolrC180
4yVWmLmgVDlOllouHKYbBgJrjrjtwjNJj4TJjz2ACZjzOqHr7nH2iQ==
=Do8q
-----END PGP SIGNATURE-----

--==_Exmh_1514637497_2626P--
