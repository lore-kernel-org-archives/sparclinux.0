From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sat, 26 Jun 2004 19:17:37 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <1088277457.12842.56.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-52RUjiAB3B+s0pLsx7qE"
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
To: sparclinux@vger.kernel.org


--=-52RUjiAB3B+s0pLsx7qE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-26 at 10:02, David S. Miller wrote:
> On Sat, 26 Jun 2004 03:11:23 -0700
> Jeremy Huddleston <eradicator@gentoo.org> wrote:
>=20
> > I was going to test out various PCI sound cards I've had lying around
> > when I noticed that DMA_AUTOINIT isn't defined in asm-sparc64/dma.h lik=
e
> > it is in other archs... most archs defined it as 2 while arm defines it
> > as 4.
>=20
> These pieces of code you are trying to compile are attempting
> to do ISA DMA controller programming.  Such things do not
> exist on Sparc.
>=20
> I never get these errors and I have a large number of PCI sound
> cards enabled in my config, which is arch/sparc64/defconfig BTW.

arch/sparc64/defconfig does not enable OSS which is why you haven't
noticed this problem.

> Which card are you enabling in the build?

dmabuf.o (which has the reference to DMA_AUTOINIT) is compiled
regardless of which oss modules you select.  I caught this with just
emu10k1, es1370, and es1371 selected under OSS.



--=-52RUjiAB3B+s0pLsx7qE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3cvRgKpk8srJOlIRAs04AJwO9M7dE3pIb7oMSLB+4h2vlXUvTQCfZLCN
K4cOXIP24IiZMSeiMC0twTA=
=GSFo
-----END PGP SIGNATURE-----

--=-52RUjiAB3B+s0pLsx7qE--

