From: David Brownell <david-b@pacbell.net>
Date: Thu, 08 May 2008 00:12:27 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <200805071712.27681.david-b@pacbell.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wednesday 07 May 2008, Alan Stern wrote:
> > =A0 =A0 =A0ea0:=A0=A0=A0=A0=A002 c0 40 41 =A0=A0=A0=A0brz,pn =A0 %g1, f=
a4 <usb_hcd_poll_rh_status+0x124>
> > =A0 =A0 =A0ea4:=A0=A0=A0=A0=A001 00 00 00 =A0=A0=A0=A0nop=20

Delay slot ... NOP gets executed before BRZ completes.


> > =A0 =A0 =A0ea8:=A0=A0=A0=A0=A0c4 5e 20 d8 =A0=A0=A0=A0ldx =A0[ %i0 + 0x=
d8 ], %g2
> > =A0 =A0 =A0eac:=A0=A0=A0=A0=A0a4 07 a7 e7 =A0=A0=A0=A0add =A0%fp, 0x7e7=
, %l2
> > =A0 =A0 =A0eb0:=A0=A0=A0=A0=A090 10 00 18 =A0=A0=A0=A0mov =A0%i0, %o0
> > =A0 =A0 =A0eb4:=A0=A0=A0=A0=A0c2 58 a0 78 =A0=A0=A0=A0ldx =A0[ %g2 + 0x=
78 ], %g1
> > =A0 =A0 =A0eb8:=A0=A0=A0=A0=A09f c0 40 00 =A0=A0=A0=A0call =A0%g1
> > =A0 =A0 =A0ebc:=A0=A0=A0=A0=A092 10 00 12 =A0=A0=A0=A0mov =A0%l2, %o1

Delay slot ... "mov %l2, %o1" executed before CALLed %g1 routine
starts to execute.


> > =A0 =A0 =A0ec0:=A0=A0=A0=A0=A0a2 92 20 00 =A0=A0=A0=A0orcc =A0%o0, 0, %=
l1
> > =A0 =A0 =A0ec4:=A0=A0=A0=A0=A004 40 00 1f =A0=A0=A0=A0ble,pn =A0 %icc, =
f40 <usb_hcd_poll_rh_status+0xc0>
>=20
> I'm going to need a little help with this, since I'm not acquainted=20
> with SPARC assembler.
>=20
> The task dump showed that the address on the stack was
> usb_hcd_poll_rh_status+0x40/0x180, which would be ec0 above. =A0That
> looks like it is the second instruction past the call to
> hcd->driver->hub_status_data(). =A0Is that right? =A0And does one expect =

> the return address to be two past the call (call slot or some such=20
> thing)?

It's been a while since I used SPARC assembler too, but
I think the answer is "yes".

I don't think anyone would put delay slots into a new
instruction set today, but that hindsight wasn't known
when that instruction set was frozen.

- Dave

