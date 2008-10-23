From: David Miller <davem@davemloft.net>
Date: Thu, 23 Oct 2008 21:19:51 +0000
Subject: Re: [PATCH] sparc64: remove byteshifting from out* helpers
Message-Id: <20081023.141951.142725206.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1224701424.6823.2.camel@brick>
In-Reply-To: <1224701424.6823.2.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 23 Oct 2008 14:08:19 -0700 (PDT)

> From: Harvey Harrison <harvey.harrison@gmail.com>
> Date: Wed, 22 Oct 2008 11:50:24 -0700
>=20
> > __raw_write avoids the need to byteswap twice, as we are reading from a
> > host-endian (big) area, just deref the pointers directly, taking care
> > of alignment.
> >=20
> > As before, outsw must still be called with a 2-byte aligned pointer.
> >=20
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
>=20
> Applied, thanks Harvey.

Sorry, I had to revert this, it doesn't even build.

arch/sparc64/lib/PeeCeeI.c: In function =E2=80=98outsl=E2=80=99:
arch/sparc64/lib/PeeCeeI.c:57: error: expected expression before =E2=80=98u=
32=E2=80=99
arch/sparc64/lib/PeeCeeI.c:59: error: =E2=80=98l=E2=80=99 undeclared (first=
 use in this function)
arch/sparc64/lib/PeeCeeI.c:59: error: (Each undeclared identifier is report=
ed only once
arch/sparc64/lib/PeeCeeI.c:59: error: for each function it appears in.)
arch/sparc64/lib/PeeCeeI.c:63: error: =E2=80=98l2=E2=80=99 undeclared (firs=
t use in this function)
arch/sparc64/lib/PeeCeeI.c:72: error: expected expression before =E2=80=98u=
32=E2=80=99
make[1]: *** [arch/sparc64/lib/PeeCeeI.o] Error 1
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
