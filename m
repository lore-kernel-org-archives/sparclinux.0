From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 04 Aug 2011 09:39:16 +0000
Subject: Re: sparc: rename atomic_add_unless
Message-Id: <20110804193916.7539e625078644f46ed33a72@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__4_Aug_2011_19_39_16_+1000_M35Yl/6b3i0Bv4_n"
List-Id: <sparclinux.vger.kernel.org>
References: <20110728104017.GA27861@entuzijast.net>
In-Reply-To: <20110728104017.GA27861@entuzijast.net>
To: sparclinux@vger.kernel.org

--Signature=_Thu__4_Aug_2011_19_39_16_+1000_M35Yl/6b3i0Bv4_n
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Thu, 04 Aug 2011 01:21:46 -0700 (PDT) David Miller <davem@davemloft.net>=
 wrote:
>
> From: Josip Rodin <joy@entuzijast.net>
> Date: Thu, 28 Jul 2011 12:40:17 +0200
>=20
> > This patch[0] seems to fix a build issue, but it doesn't fix the
> > functionality - the previous change[1] changed the return value semanti=
cs,
> > it's now supposed to be to be just the old value, rather than a compari=
son.
> >=20
> > [0] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommitdiff;h=3D678624e401b0b7747762b5223fb23f86dcdacc93
> > [1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommitdiff;h=3Df24219b4e90cf70ec4a211b17fbabc725a0ddf3c
>=20
> Stephen please post a fix for this before a 32-bit sparc person
> loses their filesystem or worse.

Um, I could try to figure out how to do that, but what I did was respond
in July 29 to the message above cc'ing the author of the orignal patch in
the hope that they would write a fix.  Clearly that hope was in vain :-(

> The return value semantics have changed for this function, you
> can't just put two underscores in front of the name, export
> the symbol, and say "Ship it!" :-)

Well, I never actaully said that about my original build fix patch. :-(

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Aug_2011_19_39_16_+1000_M35Yl/6b3i0Bv4_n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOmjEAAoJEDMEi1NhKgbsI3AH/ic1ySx8PLsoRMG+jU77wyR1
zS7g6+eQAajiLFGCF7t0CvHdEHsFPkuPa6Ab+PDvapp4Gz3hdvt2vjqGL2KEY8S9
Wc8mQE6aMjVW3bd3c8yrsZ/YTHM86/D1lPx4eeuBa7u79HWmQScJ53VhkspiL0cL
Z37Ew+uKPjn5irWnR02VKFPJRu/Ru8C6jeXptyTNuFqWX+Bg5nGhvTdzBmzgKXOD
XFBbJqPgIAMl+OriEELWgwl1qcnlNxqr/Tfk0pdi1GEtRHrSRneBDwbMs8ODwG4b
sReKY5yZcjc7hzNZuMbslSejhxDdHRHK/trvfIb12jdfbXFsPYTNYhWBvg9jaQc=
=KYUG
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Aug_2011_19_39_16_+1000_M35Yl/6b3i0Bv4_n--
