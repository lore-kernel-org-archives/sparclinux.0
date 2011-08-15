From: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 15 Aug 2011 16:29:41 +0000
Subject: Re: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <20110815162941.GN29924@decadent.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20110815152102.GK11398@pengutronix.de>
In-Reply-To: <20110815152102.GK11398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Mon, Aug 15, 2011 at 05:21:02PM +0200, Uwe Kleine-K=F6nig wrote:
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
=20
We are currently overriding ARCH and we set it to be the source
architecture name, so that $(ARCH) is always the same as $(SRCARCH).

> There are several options to fix that:
>=20
>  a) let the package pass ARCH=3Dsparc64 instead of ARCH=3Dsparc
>     Then sparc would be the only architecture that doesn't pass the
>     (Debian) arch here.

This is not the case.  For example. ARCH=3Darm and ARCH=3Dx86 do not match
the Debian architecture names.

[...]
>  b) pass SRCARCH instead of ARCH to recordmcount.pl and do
>     s/sparc64/sparc/ in recordmcount.pl.
[...]

This is probably the right thing to do.  As I understand it,
architecture variants (32- vs 64-bit, big-endian vs litle-endian)
should be distinguished by CONFIG variables now, not by $(ARCH).

However, the names of those CONFIG variables vary between source
architectures, so how do we decide what to pass to recordmcount.pl?
$(ARCH) is useful in that it provides all that information in a single
word.
=20
Ben.

--=20
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camus
