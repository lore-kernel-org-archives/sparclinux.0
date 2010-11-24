From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Date: Wed, 24 Nov 2010 18:32:11 +0000
Subject: RE: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <ee487d0b-ec9d-42a9-9c8e-39f83858cffc@SG2EHSMHS007.ehs.local>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
	<fa44e045-9600-4c46-939a-af246afab4f6@VA3EHSMHS019.ehs.local>
	<4CED48CE.5060300@caviumnetworks.com>
In-Reply-To: <4CED48CE.5060300-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: linux-mips <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



> -----Original Message-----
> From: David Daney [mailto:ddaney@caviumnetworks.com]
> Sent: Wednesday, November 24, 2010 9:18 AM
> To: Stephen Neuendorffer
> Cc: michael@ellerman.id.au; LKML; linux-mips; microblaze-uclinux@itee.uq.=
edu.au; devicetree-
> discuss@lists.ozlabs.org; linuxppc-dev list; sparclinux@vger.kernel.org
> Subject: Re: Mega rename of device tree routines from of_*() to dt_*()
>=20
> On 11/24/2010 09:02 AM, Stephen Neuendorffer wrote:
> >
> >
> >> -----Original Message-----
> >> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.or=
g [mailto:linuxppc-dev-
> >> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Mic=
hael Ellerman
> >> Sent: Wednesday, November 24, 2010 6:04 AM
> >> To: LKML
> >> Cc: linux-mips; microblaze-uclinux@itee.uq.edu.au; devicetree-discuss@=
lists.ozlabs.org; linuxppc-
> dev
> >> list; sparclinux@vger.kernel.org
> >> Subject: RFC: Mega rename of device tree routines from of_*() to dt_*()
> >>
> >> Hi all,
> >>
> >> There were some murmurings on IRC last week about renaming the of_*()
> >> routines. I was procrastinating at the time and said I'd have a look at
> >> it, so here I am.
> >>
> >> The thinking is that on many platforms that use the of_() routines
> >> OpenFirmware is not involved at all, this is true even on many powerpc
> >> platforms. Also for folks who don't know the OpenFirmware connection it
> >> reads as "of", as in "a can of worms".
> >>
> >> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> >> it would be nice to get rid of, but it's a lot of churn.
> >>
> >> So I'm hoping people with either say "YES this is a great idea", or "NO
> >> this is stupid".
> >
> > Personally, I think it's a great idea, if only because I stared long an=
d hard
> > at the code once upon a time trying to figure out what is really OF-rel=
ated
> > and what isn't.  It's somewhat clearer now that drivers/of has been fac=
tored
> > out (although, shouldn't it be drivers/dt???)
> >
> > That said, it *is* alot of code churn.  If it's going to be done, I thi=
nk it should be
> > done in concert with fixing a bunch of the function names which don't r=
eally follow any
> > sane naming convention, so that the backporting discontinuity only happ=
ens once.
> >
>=20
> Oh, you mean things like:
>=20
> of_{,un}register_platform_driver vs. platform_driver_{,un}register
>=20
> That one is particularly annoying to me.
>=20
> David Daney

Actually, I was particularly thinking of drivers/of/fdt.c, which I was rece=
ntly hacking around with,
but I'm sure there are others... :)

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
