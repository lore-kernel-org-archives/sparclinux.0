From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 12 Jul 2007 07:17:04 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <4695D570.200@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Wed, 11 Jul 2007 12:24:07 +0200
>=20
>> Root rayleigh:[/etc/mail] > ps -eLf | grep clamd
>> clamav    3502     1  3502  1    2 10:53 ?        00:01:23 /usr/sbin/cla=
md
>> clamav    3502     1  7226  0    2 12:00 ?        00:00:00 /usr/sbin/cla=
md
>> root      8091  5893  8091  0    1 12:18 pts/0    00:00:00 grep clamd
>>
>> 	clamd remains in S mode.
>>
>> 	I have tried to obtain mode information with sysrq+w without any=20
>> success, sysrq+w returns no blocked task. In this example, clamd is=20
>> blocked, but some other tasks can be blocked.
>=20
> This is not enough information to debug this problem, sorry.
>=20
> You'll need to do some thinking about what kind of other information
> you can fetch from this stuck process.  Perhaps running
> clamd under strace will provide a good debugging trace so we can
> see exactly what kind of socket it is stuck on, and in what way.

	OK. Now, I run clamd under strace. I hope that it will quickly hang ;-)=20
When,clamd hangs, I will post here its strace output. Are there=20
significative differences between futex management on sbus and pci=20
sparc64 ? I have tried to reproduce this bug on sbus workstation without=20
any success, but I can see it on all sparc64/PCI I have (U60, U80, U420)...

	Regards,

	JKB
