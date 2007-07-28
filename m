From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 28 Jul 2007 08:25:36 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <46AAFD80.8050906@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Sat, 28 Jul 2007 09:59:44 +0200
>=20
>> 	I have tested your patch for two days. Now, I can affirm that
>> it does not fix futex trouble. I have seen exactly same bug report
>> on sparc-debian mailing list.
>=20
> Thanks for your continual feedback.

	You're welcome.

> I want to reproduce this here, that will get this fixed most
> quickly.
>=20
> What version of debian do you have installed on the machine that shows
> this, and what exact kind of system and cpu configuration does it
> have?

	I have three workstations to do some tests, all of these run=20
debian/testing up to date.

1/ U2 with two Uii@296 MHz, 2 GB -> I cannot reproduced this bug
fermat:[~] > uname -a
Linux fermat 2.6.22.1 #2 SMP PREEMPT Wed Jul 11 11:01:38 CEST 2007=20
sparc64 GNU/Linux

2/ U60 with two Uii@450 MHz, 1 GB -> bug
rayleigh:[~] > uname -a
Linux rayleigh 2.6.22.1 #2 SMP Wed Jul 25 09:48:50 CEST 2007 sparc64=20
GNU/Linux

3/ U80 with four Uii@450 MHz, 2 GB -> bug
kant:[~] > uname -a
Linux kant 2.6.20.11-netfilter-route-patch #1 SMP Wed May 9 12:27:15=20
CEST 2007 sparc64 GNU/Linux
I have patched this kernel with netfilter route patch (and no one other).

All stations run with 2.6-2 libc.

> I think I can reproduce this most easily using firefox, or whatever
> they have renamed it to under debian, do you just startup the web
> browser and it hangs soon?

	I have see a bug report with Iceweasel (debian name for firefox). Thus,=20
I think you can reproduce this bug with firefox. On U60 or U80,=20
Seamonkey is unusable (it quickly hangs).

	Regards,

	JKB
