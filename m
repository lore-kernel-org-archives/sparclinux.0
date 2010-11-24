From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Date: Wed, 24 Nov 2010 17:02:18 +0000
Subject: RE: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
In-Reply-To: <1290607413.12457.44.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: michael@ellerman.id.au, LKML <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-mips <linux-mips@linux-mips.org>, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au



> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org [=
mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Michae=
l Ellerman
> Sent: Wednesday, November 24, 2010 6:04 AM
> To: LKML
> Cc: linux-mips; microblaze-uclinux@itee.uq.edu.au; devicetree-discuss@lis=
ts.ozlabs.org; linuxppc-dev
> list; sparclinux@vger.kernel.org
> Subject: RFC: Mega rename of device tree routines from of_*() to dt_*()
>=20
> Hi all,
>=20
> There were some murmurings on IRC last week about renaming the of_*()
> routines. I was procrastinating at the time and said I'd have a look at
> it, so here I am.
>=20
> The thinking is that on many platforms that use the of_() routines
> OpenFirmware is not involved at all, this is true even on many powerpc
> platforms. Also for folks who don't know the OpenFirmware connection it
> reads as "of", as in "a can of worms".
>=20
> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
>=20
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".

Personally, I think it's a great idea, if only because I stared long and ha=
rd
at the code once upon a time trying to figure out what is really OF-related
and what isn't.  It's somewhat clearer now that drivers/of has been factored
out (although, shouldn't it be drivers/dt???)

That said, it *is* alot of code churn.  If it's going to be done, I think i=
t should be
done in concert with fixing a bunch of the function names which don't reall=
y follow any
sane naming convention, so that the backporting discontinuity only happens =
once.

Steve

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
