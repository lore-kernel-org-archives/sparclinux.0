From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 18 May 2007 13:26:12 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <1179494772.6254.126.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, 2007-05-18 at 11:14 +0200, Krzysztof Helt wrote:
> Dnia 18-05-2007 o godz. 8:43 David Miller napisa=C5=82(a):
> > From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
> > Date: Fri, 18 May 2007 07:50:31 +0200
> >=20
> > > I have tried to load the latest 2.6.22-rc1 and failed miserably.
> > > I got 2.6MB kernel after modularization and famous "strip -R.
> > > note -R .commend" trick. Nevertheless, it is still too big.
> > >=20
> > > I upgrades SILO to 1.4.13 and still no luck.
> > >=20
> > > Any hints? Are there any silo patches to allow bigger kernels.
> >=20
> > Sparc64 can handle up to ~10.5MB kernels, so I guess you are
> > on sparc32?
>=20
> Exactly, I tried on sparc32 (SS20). Is it solvable in any way
> except hacking the silo? I don't know how hack it yet.

Turn off things in your kernel? Modularize things where possible?

~spot

