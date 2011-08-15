From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Mon, 15 Aug 2011 16:00:43 +0000
Subject: Re: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <20110815160043.GL11398@pengutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20110815152102.GK11398@pengutronix.de>
In-Reply-To: <20110815152102.GK11398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, Aug 15, 2011 at 11:40:23AM -0400, Steven Rostedt wrote:
> On Mon, 2011-08-15 at 11:33 -0400, Steven Rostedt wrote:
> > On Mon, 2011-08-15 at 17:21 +0200, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > >=20
> > > when I enable CONFIG_FUNCTION_TRACER and CONFIG_DYNAMIC_FTRACE for the
> > > Debian kernel the build fails with:
> > >=20
> > >   CC      init/do_mounts_initrd.o
> > > Arch sparc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at .../s=
cripts/recordmcount.pl line 368.
> > >=20
> > > This happens because the kernel package build scripts call
> > >=20
> > > 	make ARCH=3Dsparc
> > >=20
> > > $(ARCH) is passed to scripts/recordmcount.pl and the latter only knows
> > > about "sparc64".
> > >=20
> > > There are several options to fix that:
> > >=20
> > >  a) let the package pass ARCH=3Dsparc64 instead of ARCH=3Dsparc
> > >     Then sparc would be the only architecture that doesn't pass the
> > >     (Debian) arch here. I'm not sure there are other reasons to stick=
 to
> > >     ARCH=3Dsparc. Bastian?
> > >     It seems only recordmcount.pl chokes on that because Debian uses
> > >     ARCH=3Dsparc since at least 2.6.32, probably much longer.
> > >=20
> > >  b) pass SRCARCH instead of ARCH to recordmcount.pl and do
> > >     s/sparc64/sparc/ in recordmcount.pl.
> >=20
> > b may break other archs.
I think it doesn't, but in the presence of d) below I won't argue.

> > >  c) do the following in recordmcount.pl:
> > > 	if ($arch =3D~ /sparc(32|64)?/) {
> > > 	    if ($bits =3D 64) {
> > > 	        $arch =3D "sparc64";
> > > 	    } else {
> > > 	        $arch =3D "sparc"; # or "sparc32"?
> > > 	    }
> > > 	}
> >=20
> > c is fine with me.
> >=20
> > >=20
> > >     Something like that is already done for x86.
> > > =20
> > > Personally I prefer b), but I'm not sure I see all the consequences.
> >=20
> > It may break other archs. I rather not do a change that affects all
> > archs. This is a sparc specific problem. The solution should only affect
> > sparc. Which to me is option c.
> >=20
>=20
> Actually, I think option d) is the best.
>=20
> d) have sparc support recordmcount.c
I only have access to a sparc chroot without the possibility to make a
run test, so if you want to test d), it's just adding

	select HAVE_C_RECORDMCOUNT

to config SPARC64. Building a kernel with it seems to work (and should
be faster).

If you're lazy and a Debian-sparc user I can provide you a kernel
package to test that. Just tell me by private mail.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
