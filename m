From: David Miller <davem@davemloft.net>
Date: Sun, 27 Apr 2008 05:29:53 +0000
Subject: Re: [PATCH] sparc: fix drivers/video/tcx.c warning
Message-Id: <20080426.222953.75359928.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48129FF4.7040701@earthlink.net>
In-Reply-To: <48129FF4.7040701@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 25 Apr 2008 23:22:28 -0400

> Fix compile warning:
>=20
> CC drivers/video/tcx.o
> drivers/video/tcx.c: In function =E2=80=98tcx_init_one=E2=80=99:
> drivers/video/tcx.c:477: warning: format =E2=80=98%lx=E2=80=99 expects ty=
pe =E2=80=98long=20
> unsigned int=E2=80=99, but argument 4 has type =E2=80=98resource_size_t=
=E2=80=99
>=20
> This was the only sparc driver to use the resource directly in the
> printk so I changed it to physbase like the other drivers.
> Boot tested on SS4.
>=20
> Signed-off-by: Robert Reif <reif@earthlink.net>

Thanks a lot for this bug fix, patch applied!
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
