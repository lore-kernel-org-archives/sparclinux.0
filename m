From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 12 Jul 2007 09:50:38 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <4695F96E.5020909@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Thu, 12 Jul 2007 11:11:32 +0200
>=20
>> 	I'm lucky ;-) First mail in clamd and clamd sleeps... You can find in=20
>> attachement complete strace log (strace -ff ...).
>=20
> It is looping at the end servicing SIGINT over and over, are
> you pressing Ctrl-C at the terminal where clamav is running
> or sending it signals with "kill"?
>=20

	Process stops at line 17384 in clamav-strace:

futex(0x25944f0, FUTEX_WAIT

Line terminaison was written ("2, NULL)   =3D ? ERESTARTSYS (To be=20
restarted)") when I have pressed ctrl+C, but process remains in sleep=20
state. I have tried kill -15 (without any success). Only kill -9 kills=20
clamd.

	Regards,

	JKB
