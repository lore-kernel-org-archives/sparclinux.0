From: David Miller <davem@davemloft.net>
Date: Wed, 16 Jun 2010 20:36:42 +0000
Subject: Re: How to printk/sprintf uint64_t on Sparc without format and
Message-Id: <20100616.133642.112602306.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTimuv7nOlcGFxqPZlwcAjLmFMiLAvbA5O7F32Wbg@mail.gmail.com>
	<4C192113.7030101@vlnb.net>
In-Reply-To: <4C192113.7030101@vlnb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: vst@vlnb.net
Cc: sparclinux@vger.kernel.org, simone.ricci@gmail.com, scst-devel@lists.sourceforge.net, jeykholt@cisco.com, linux-kernel@vger.kernel.org

From: Vladislav Bolkhovitin <vst@vlnb.net>
Date: Wed, 16 Jun 2010 23:08:03 +0400

> We in SCST project need to printk/sprintf variables of type
> uint64_t. Size of those variables is required to be 64-bit integer. On
> x86 we printk/sprintf them as %lld, but on Sparc we have a compiler
> warnings like:
>=20
> scst/src/scst_targ.c:2136: warning: format =A1%llx=A2 expects type =A1long
> long unsigned int=A2, but argument 4 has type =A1uint64_t=A2.
>=20
> It is because on Sparc uint64_t defined as unsigned long, but on x86 -
> as unsigned long long.

You must use %ll and explicitly cast the argument to "long long".
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
