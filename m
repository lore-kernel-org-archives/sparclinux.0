From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sat, 26 Jun 2004 22:22:58 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <1088288578.12842.67.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-ic5wV0f4oa6MZ8K7/8rt"
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
To: sparclinux@vger.kernel.org


--=-ic5wV0f4oa6MZ8K7/8rt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-26 at 14:37, David S. Miller wrote:
> On Sat, 26 Jun 2004 12:17:37 -0700
> Jeremy Huddleston <eradicator@gentoo.org> wrote:
>=20
> > > Which card are you enabling in the build?
> >=20
> > dmabuf.o (which has the reference to DMA_AUTOINIT) is compiled
> > regardless of which oss modules you select.  I caught this with just
> > emu10k1, es1370, and es1371 selected under OSS.
>=20
> There are perfectly compilable ALSA drivers for these cards,
> why not use those?

Because I was having trouble with the alsa drivers, so I thought I'd
give the oss drivers a try...

> Yes, the OSS layer does a lot of PC-centric stuff, better to
> stick with the ALSA drivers as I do watch over them for
> portability when changes are made.

Yeah, I figure that's a safe bet... I just wanted to check it out...
perhaps the Kconfig should be updated to exclude OSS as a selectable
option on sparcs since it won't even compile because of the PC-centric
stuff.

And an odd thing I've noticed with my es1371 (Ensoniq 5880 AudioPCI (rev
02)) card... I can use it through the OSS emulation layer, but I can't
use alsa-specific applications with it... ie. I can use aumix/sox but
not alsamixer/aplay.  I'm going to try updating alsa-{lib,utils} from
1.0.4 to 1.0.5 right now, but I don't think that's the problem...


--=-ic5wV0f4oa6MZ8K7/8rt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3fdCgKpk8srJOlIRAoehAJ0a4gcmyX3a8erAehMZVQYRdhQ8SQCeMt/Z
MOwKpr3xur7s9hPCV+0kkBM=
=hL2c
-----END PGP SIGNATURE-----

--=-ic5wV0f4oa6MZ8K7/8rt--

