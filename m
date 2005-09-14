From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Wed, 14 Sep 2005 15:42:29 +0000
Subject: Re: Sun v440 and 2.6.13-1.1552sp1smp (Aurora) kernel
Message-Id: <432844E5.3020303@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509132211530.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509132211530.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David S. Miller wrote:

> The problem is that the people who can work on fixing
> this problem (whether it is in the kernel or SILO,
> we still don't know) are not able to reproduce it.

The problem lies in SILO, we're using 1.2.6 in our (gentoo) v240 just
fine to boot off disk.
No kernel is rock-solid stable on the v240, though 2.4 lasts longer.
I'm guessing it has to do with IIIi SMP since we get tons of "CPU[1]:
Cheetah+ D-cache parity error at TPC[00000000005d3328]" (with varying
CPU number and addresses) before one of the processors goes offline/gets
stuck at which point it's time to reboot.

- --
Gustavo Zacarias
Gentoo/SPARC monkey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDKETlV3G/IBCn/JARAhqdAJ4/Y+Y7Q+hLqWVteH96dSM+6j1BTwCfZ+8Y
9BfFesOsGyNf5wzGYkpqwvM=FlfU
-----END PGP SIGNATURE-----
