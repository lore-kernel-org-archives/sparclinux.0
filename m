From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Fri, 18 May 2007 09:14:39 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <464d6e7fac1d2@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Dnia 18-05-2007 o godz. 8:43 David Miller napisa=B3(a):
> From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
> Date: Fri, 18 May 2007 07:50:31 +0200
>=20
> > I have tried to load the latest 2.6.22-rc1 and failed miserably.
> > I got 2.6MB kernel after modularization and famous "strip -R.
> > note -R .commend" trick. Nevertheless, it is still too big.
> >=20
> > I upgrades SILO to 1.4.13 and still no luck.
> >=20
> > Any hints? Are there any silo patches to allow bigger kernels.
>=20
> Sparc64 can handle up to ~10.5MB kernels, so I guess you are
> on sparc32?

Exactly, I tried on sparc32 (SS20). Is it solvable in any way
except hacking the silo? I don't know how hack it yet.

Regards,
Krzysztof

----------------------------------------------------
Esej Michela Houellebecqa o Samotniku z Providence=20
"H.P Lovecraft. Przeciw =B6wiatu, przeciw =BFyciu" ju=BF w ksiegarniach!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd105.html&si=
d=1146


