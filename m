From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 09 Feb 2008 11:49:15 +0000
Subject: Re: gcc 4.2 or kernel bug ?
Message-Id: <47AD933B.8060909@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <47AC34B6.4000302@systella.fr>
In-Reply-To: <47AC34B6.4000302@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Fri, 08 Feb 2008 12:05:43 +0100
>=20
>> 	Same constatation on U2/SMP. On a 32-threads T1000, I obtain :
>> BUG: soft lockup - CPU#1 stuck for 11s! [md2_raid1:2736]
>=20
> Unlike the other message, this might be a real problem.
>=20
>> 	I'm not sure that both constatations come from the same bug.
>=20
> They are not.

	David,

	I have rebuild the _same_ kernel (2.6.24) with gcc 4.1 and I don't see=20
any soft lockups for 24 hours.

	Regards,

	JKB
