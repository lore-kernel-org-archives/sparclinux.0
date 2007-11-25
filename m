From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 25 Nov 2007 15:10:15 +0000
Subject: Re: Bus error while building Erlang
Message-Id: <20071125151015.GA6538@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <47498C71.2080206@systella.fr>
In-Reply-To: <47498C71.2080206@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sun, Nov 25, 2007 at 03:53:37PM +0100, BERTRAND Jo=EBl wrote:
> >Recent build of erlang package failed on sparc architecture
> >(http://buildd.debian.org/build.php?&pkg=3Derlang&arch=3Dsparc&file=3Dlo=
g).
> >I cannot find a reason looking at the log file, and I don't have an
> >access to any sparc machine to debug the failure.
>=20
> 	I have seen the same bus error with gcc 4.x (internal error that=20
> returns a bus error on Sbus based sparc _and_ sparc64 linux boxes). I'm=20
> trying to find this bug for a long time without any success. I never=20
> have seen this bug on PCI based sparc64 boxes. Please note that I'm not=20
> sure that this trouble comes from Sbus subsystem ;-) I suspect a bug in=20
> sparc/sparc64 kernel.

FWIW, the box that produced that log linked above was running 2.6.23.8, and
it's a sparc64 CPU with PCI.

--=20
     2. That which causes joy or happiness.
