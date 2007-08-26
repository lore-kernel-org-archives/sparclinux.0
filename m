From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 26 Aug 2007 17:45:42 +0000
Subject: Re: [parisc-linux] errno codes intertwined
Message-Id: <200708261345.43165.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1819878.TuRHXF6Vkq"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
In-Reply-To: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
To: parisc-linux@lists.parisc-linux.org
Cc: Jan Engelhardt <jengelh@computergmbh.de>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org

--nextPart1819878.TuRHXF6Vkq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 August 2007, Jan Engelhardt wrote:
> So I'm just asking: can I rely on the same errno across Linuxes?

nope

> And should the errno values be fixed up?

i guess that depends on whether you think it's even broken :)

no spec requires any errno symbol have an exact numeric value ... i'm guess=
ing=20
your FUSE is only cross-Linux and you're not planning on dipping into any=20
other OS ?
=2Dmike

--nextPart1819878.TuRHXF6Vkq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.6 (GNU/Linux)

iQIVAwUARtG8R0FjO5/oN/WBAQLNaBAAgL/r99LpXcw78k3iY24nKFWFk87IUaeK
HIgQMg2IQm+6LfFvB2iZXdeFjjFIXRgdTMnfXs1G+6W1gR5cXPg0DXzLR98Z5cuU
NPxpS4k2DQq36tnKCekLkV5cM7BzVtzcgJIEuHvxhxBnNavfqCBMkz6BGxHGcfBI
FlNuBWZ/5W/RC0jhJBfTIn7Bz20xJ+PLZ8VDl5a3mmPPq/lJyxG8UBRmffF76B3A
THo85UG1/J48GyNFgTlBz7pNsjDx1U5+xUPEeRRTZcmPsipLuesCn2OHlUcsv2H8
1z73y0DGJUXlKOWrEL0MoH0qbLQNHQHWjZogfyjOd4CxOmFs6Yqire6HPoJ0c3IE
vv4PIn4nGv6LVbsvqWHb/d0x+vBL0jz5d1T/gvS4O8i2mVy91Xpdk6zGxBCsKjo+
w3NS8G9RNxDQTCV594hmeRDdCOoX3DBXp8oKlVKGDSq6uqlA0a8ZxYe5HNvn3C7d
1wxGnhc3wUqDLLPY4vfWBcOGiO+mkR+VUDrFYSKVwAuPZCrpbnj4S/JAfd3swmtP
+u4Y7paErUhVKfM1BsOZ1bAmVetPdKnU+A053sCljPh17Ld6WyoOIG8fYi+KV0qa
0e/0Dpb39nTdxNwCQ0WAnGJJjq4ayOEbcmUTxKMga81giIFbUjPQai1LLNq9Opva
u2c7NlXE12E=
=C4n6
-----END PGP SIGNATURE-----

--nextPart1819878.TuRHXF6Vkq--
