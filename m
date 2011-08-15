From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 15 Aug 2011 15:33:05 +0000
Subject: Re: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <1313422385.15704.7.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110815152102.GK11398@pengutronix.de>
In-Reply-To: <20110815152102.GK11398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, 2011-08-15 at 17:21 +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> when I enable CONFIG_FUNCTION_TRACER and CONFIG_DYNAMIC_FTRACE for the
> Debian kernel the build fails with:
>=20
>   CC      init/do_mounts_initrd.o
> Arch sparc is not supported with CONFIG_FTRACE_MCOUNT_RECORD at .../scrip=
ts/recordmcount.pl line 368.
>=20
> This happens because the kernel package build scripts call
>=20
> 	make ARCH=3Dsparc
>=20
> $(ARCH) is passed to scripts/recordmcount.pl and the latter only knows
> about "sparc64".
>=20
> There are several options to fix that:
>=20
>  a) let the package pass ARCH=3Dsparc64 instead of ARCH=3Dsparc
>     Then sparc would be the only architecture that doesn't pass the
>     (Debian) arch here. I'm not sure there are other reasons to stick to
>     ARCH=3Dsparc. Bastian?
>     It seems only recordmcount.pl chokes on that because Debian uses
>     ARCH=3Dsparc since at least 2.6.32, probably much longer.
>=20
>  b) pass SRCARCH instead of ARCH to recordmcount.pl and do
>     s/sparc64/sparc/ in recordmcount.pl.

b may break other archs.

>=20
>  c) do the following in recordmcount.pl:
> 	if ($arch =3D~ /sparc(32|64)?/) {
> 	    if ($bits =3D 64) {
> 	        $arch =3D "sparc64";
> 	    } else {
> 	        $arch =3D "sparc"; # or "sparc32"?
> 	    }
> 	}

c is fine with me.

>=20
>     Something like that is already done for x86.
> =20
> Personally I prefer b), but I'm not sure I see all the consequences.

It may break other archs. I rather not do a change that affects all
archs. This is a sparc specific problem. The solution should only affect
sparc. Which to me is option c.

-- Steve

>=20
> What do you think?
>=20
> Best regards
> Uwe
>=20


