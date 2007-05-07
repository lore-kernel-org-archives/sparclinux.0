From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 20:17:31 +0000
Subject: Re: [2.6.21.1] Nat trouble
Message-Id: <20070507.131731.14973843.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <463F1417.80409@systella.fr>
In-Reply-To: <463F1417.80409@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Mon, 07 May 2007 13:57:11 +0200

> 	Hello,
>=20
> 	I have built a 2.6.21.1 kernel to replace a working 2.6.20 on an=20
> U60/SMP. NAT (iptables) worked fine with 2.6.20 but not with 2.6.21.1.=20
> That being said, all other iptables rules seem to works fine with 2.6.21.=
1.
>=20
> My /var/lib/iptables/active script :

Please report this to the netfilter developer lists, this doesn't
look sparc specific.

Please also make sure you have all the proper netfilter modules
enabled in your kernel config, some things have changed in the
past few releases.  For example, the connection tracking modules
are called "NF_FOO" instead of "IP_FOO"
