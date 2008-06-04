From: Frans Pop <elendil@planet.nl>
Date: Wed, 04 Jun 2008 00:04:02 +0000
Subject: Re: [BUG] 2.6.26-rc1 broke X on SPARC Ultra5
Message-Id: <200806040204.03518.elendil@planet.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1507514.Ml7E7E0bAx"
List-Id: <sparclinux.vger.kernel.org>
References: <20080603.062253.17158135.davem@davemloft.net> <18501.39659.952880.727014@alkaid.it.uu.se> <21d7e9970806031345u4e7838fdp60bbedadd65b5f2a@mail.gmail.com> <21d7e9970806031345u4e7838fdp60bbedadd65b5f2a@mail.gmail.com> <20080603.135449.193702216.davem@davemloft.net>
In-Reply-To: <20080603.135449.193702216.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: airlied@gmail.com, mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1507514.Ml7E7E0bAx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

David Miller wrote:
> Meanwhile X itself shipped mostly-non-working for PCI devices on sparc
> for years.  And would you also not argue that it's broken to begin
> with that the older X servers cannot work properly without a root PCI
> controller being there?

I can relate to that as starting X at one point ate the partition table on=
=20
both my harddrives due to a PCI handling bug :-/
=20
I assume this is not an issue with X.Org 7.3 (which is what Debian Lenny=20
will probably release with)?

> I'm the only sparc64 platform developer, so my time is better spent
> moving forward and making sure that libpciaccess based X servers
> aren't so broken and do the right thing in a way which works in a
> maintainable long term manner.

=46rom my limited perspective: agreed. And thanks for all the work you do.

Cheers,
=46JP

--nextPart1507514.Ml7E7E0bAx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIRdvzgm/Kwh6ICoQRAmAdAKDao8akwS/hfR3mmhhFaRfeSzrwagCgqBb5
VJl8NieSGu7Q8/j5892C0f0=
=E75n
-----END PGP SIGNATURE-----

--nextPart1507514.Ml7E7E0bAx--
