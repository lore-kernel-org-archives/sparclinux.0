From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 08 May 2007 10:07:58 +0000
Subject: Re: [2.6.21.1] Nat trouble
Message-Id: <46404BFE.3030109@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <463F1417.80409@systella.fr>
In-Reply-To: <463F1417.80409@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Mon, 07 May 2007 13:57:11 +0200
>=20
>> 	Hello,
>>
>> 	I have built a 2.6.21.1 kernel to replace a working 2.6.20 on an=20
>> U60/SMP. NAT (iptables) worked fine with 2.6.20 but not with 2.6.21.1.=20
>> That being said, all other iptables rules seem to works fine with 2.6.21=
.1.
>>
>> My /var/lib/iptables/active script :
>=20
> Please report this to the netfilter developer lists, this doesn't
> look sparc specific.
>=20
> Please also make sure you have all the proper netfilter modules
> enabled in your kernel config, some things have changed in the
> past few releases.  For example, the connection tracking modules
> are called "NF_FOO" instead of "IP_FOO"

	I have all conntrack modules (and modules are loaded). I have some=20
trouble a long time ago with conntrack modules with iproute2. I don't=20
have any i386 nor amd64 to test on these architectures.

	Regards,

	JKB
