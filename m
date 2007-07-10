From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 10 Jul 2007 18:05:11 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <4693CA57.2080104@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 10 Jul 2007 09:53:12 +0200
>=20
>> 	When clamav-daemon (or all other daemons) remain in sleep mode, I=20
>> cannot quickly restart this daemon by /etc/init.d/$(daemon) restart, I=20
>> have to wait for a timeout.
>=20
> Use the kernel sysrq keystrokes to get a task dump to see where
> clamav-daemon is sleeping,

	I will try tomorrow. I have to build a 2.6.22 (to see if nis works=20
because it doesn't with 2.6.22-rc7).

> my suspicion is that it is stuck
> in the kernel futex code somewhere.

	I think too.

	JKB
