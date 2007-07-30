From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jul 2007 05:19:46 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070729.221946.48807641.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Sat, 28 Jul 2007 10:25:36 +0200

> 1/ U2 with two Uii@296 MHz, 2 GB -> I cannot reproduced this bug
> fermat:[~] > uname -a
> Linux fermat 2.6.22.1 #2 SMP PREEMPT Wed Jul 11 11:01:38 CEST 2007=20
> sparc64 GNU/Linux
>=20
> 2/ U60 with two Uii@450 MHz, 1 GB -> bug
> rayleigh:[~] > uname -a
> Linux rayleigh 2.6.22.1 #2 SMP Wed Jul 25 09:48:50 CEST 2007 sparc64=20
> GNU/Linux
>=20
> 3/ U80 with four Uii@450 MHz, 2 GB -> bug
> kant:[~] > uname -a
> Linux kant 2.6.20.11-netfilter-route-patch #1 SMP Wed May 9 12:27:15=20
> CEST 2007 sparc64 GNU/Linux
> I have patched this kernel with netfilter route patch (and no one other).
 ...
> 	I have see a bug report with Iceweasel (debian name for firefox). Thus, =

> I think you can reproduce this bug with firefox. On U60 or U80,=20
> Seamonkey is unusable (it quickly hangs).

Try as I might I cannot reproduce this on my Ultra60
with 360Mhz Ultra-II cpus.

You seem to see the problem only on the systems that have the 450Mhz
cpus, any chance you can test the ultra60 with a different cpu
variant?  Perhaps those chips are part of the problem.
