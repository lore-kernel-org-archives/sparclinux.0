From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 31 Jul 2007 11:04:44 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <46AF174C.6010302@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 31 Jul 2007 11:52:59 +0200
>=20
>> 	I cannot reboot this workstation now. Is it possible to only
>> stop netfilter ?
>=20
> It would be an interesting test to just stop netfilter, but not
> conclusive because if netfilter has corrupted something already only a
> reboot would ensure it did not occur.

	David,

	I have rebooted my U60 without fail2ban and wihtout iptables. iceape=20
quickly hangs too. Last line in strace output is

	futex(0xf3e00010, FUTEX_WAIT, 2, NULL

	I use CONFIG_DEFAULT_CFQ=3Dy.

	Regards,

	JKB
