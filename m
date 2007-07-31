From: David Miller <davem@davemloft.net>
Date: Tue, 31 Jul 2007 20:12:39 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070731.131239.92586677.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 31 Jul 2007 13:04:44 +0200

> 	I have rebooted my U60 without fail2ban and wihtout iptables. iceape=20
> quickly hangs too. Last line in strace output is
>=20
> 	futex(0xf3e00010, FUTEX_WAIT, 2, NULL
>=20
> 	I use CONFIG_DEFAULT_CFQ=3Dy.

Thanks for testing.
