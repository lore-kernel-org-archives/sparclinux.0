From: David Miller <davem@davemloft.net>
Date: Wed, 11 Jul 2007 20:43:24 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070711.134324.85409780.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Wed, 11 Jul 2007 12:24:07 +0200

> Root rayleigh:[/etc/mail] > ps -eLf | grep clamd
> clamav    3502     1  3502  1    2 10:53 ?        00:01:23 /usr/sbin/clamd
> clamav    3502     1  7226  0    2 12:00 ?        00:00:00 /usr/sbin/clamd
> root      8091  5893  8091  0    1 12:18 pts/0    00:00:00 grep clamd
>=20
> 	clamd remains in S mode.
>=20
> 	I have tried to obtain mode information with sysrq+w without any=20
> success, sysrq+w returns no blocked task. In this example, clamd is=20
> blocked, but some other tasks can be blocked.

This is not enough information to debug this problem, sorry.

You'll need to do some thinking about what kind of other information
you can fetch from this stuck process.  Perhaps running
clamd under strace will provide a good debugging trace so we can
see exactly what kind of socket it is stuck on, and in what way.

Otherwise, I wish you luck in debugging this problem :-)
