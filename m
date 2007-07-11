From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Wed, 11 Jul 2007 10:24:07 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <4694AFC7.60106@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl wrote:
> David Miller wrote:
>> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
>> Date: Tue, 10 Jul 2007 09:53:12 +0200
>>
>>>     When clamav-daemon (or all other daemons) remain in sleep mode, I=20
>>> cannot quickly restart this daemon by /etc/init.d/$(daemon) restart,=20
>>> I have to wait for a timeout.
>>
>> Use the kernel sysrq keystrokes to get a task dump to see where
>> clamav-daemon is sleeping,
>=20
>     I will try tomorrow. I have to build a 2.6.22 (to see if nis works=20
> because it doesn't with 2.6.22-rc7).

	Tests made with a 2.6.22.1 (NIS works with 2.6.22.1 and not with=20
2.6.22-rc7, but I don't know why... ;-) )

>> my suspicion is that it is stuck
>> in the kernel futex code somewhere.
>=20
>     I think too.

	When I write these lines, my mail server is blocked due to clamd socket=20
trouble :

Root rayleigh:[/etc/mail] > ps -eLf | grep clamd
clamav    3502     1  3502  1    2 10:53 ?        00:01:23 /usr/sbin/clamd
clamav    3502     1  7226  0    2 12:00 ?        00:00:00 /usr/sbin/clamd
root      8091  5893  8091  0    1 12:18 pts/0    00:00:00 grep clamd

	clamd remains in S mode.

	I have tried to obtain mode information with sysrq+w without any=20
success, sysrq+w returns no blocked task. In this example, clamd is=20
blocked, but some other tasks can be blocked.

	Regards,

	JKB
