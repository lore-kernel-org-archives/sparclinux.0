From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sun, 25 Nov 2007 19:12:25 +0000
Subject: Re: Bus error while building Erlang
Message-Id: <4749C919.9000504@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <47498C71.2080206@systella.fr>
In-Reply-To: <47498C71.2080206@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Josip Rodin wrote:
> On Sun, Nov 25, 2007 at 03:53:37PM +0100, BERTRAND Jo=EBl wrote:
>>> Recent build of erlang package failed on sparc architecture
>>> (http://buildd.debian.org/build.php?&pkg=3Derlang&arch=3Dsparc&file=3Dl=
og).
>>> I cannot find a reason looking at the log file, and I don't have an
>>> access to any sparc machine to debug the failure.
>> 	I have seen the same bus error with gcc 4.x (internal error that=20
>> returns a bus error on Sbus based sparc _and_ sparc64 linux boxes). I'm =

>> trying to find this bug for a long time without any success. I never=20
>> have seen this bug on PCI based sparc64 boxes. Please note that I'm not =

>> sure that this trouble comes from Sbus subsystem ;-) I suspect a bug in =

>> sparc/sparc64 kernel.
>=20
> FWIW, the box that produced that log linked above was running 2.6.23.8, a=
nd
> it's a sparc64 CPU with PCI.

	For me, it's the same bug... I've never seen it on PCI boxes, but=20
result is the same :-(

	Regards,

	JKB
