From: Sam Creasey <sammy@sammy.net>
Date: Wed, 07 Oct 2009 13:52:43 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <20091007135243.GC21646@anhedonia>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua> <fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com> <646765f40910062218s19d540f9q14c9086bedd1d9da@mail.gmail.com>
In-Reply-To: <646765f40910062218s19d540f9q14c9086bedd1d9da-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Sam Creasey <sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org>

On Wed, Oct 07, 2009 at 03:18:04PM +1000, Julian Calaby wrote:
> On Wed, Oct 7, 2009 at 14:49, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> > On Tue, Oct 6, 2009 at 10:29 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> >>
> >> So here goes. =A0I've begun the work to merge and clean up the OF devi=
ce
> >> tree handling code and this is my first set of patches. =A0Not fully
> >> tested yet, but I'm getting them out to the lists so that I can start
> >> responding to comments and collecting acks. =A0This first batch isn't
> >> anything exciting, just a merge of common code
>=20
> Good work, for what it's worth, this all looks good to me.
>=20
> > However, I've completely devoted to this work for at least the next
> > two months, so there are plenty more patches to follow. =A0Once I've
> > got all the common code merged between Microblaze, PowerPC and Sparc
> > I'll be fix the endian problems and making it easily usable by other
> > architectures like ARM and MIPS. =A0Lots of work to be done.
>=20
> On the subject of merging code, I know that the SUN3 code in m68k uses
> a similar prom interface to the sparc32 code. (and I've also
> considered unifying that and ... well ... see above) Does anyone know
> if it has an OpenFirmware interface for it's devices? Is OF on SUN3
> even remotely useful? Does Linux on SUN3 even work with modern
> kernels?

Sun3 doesn't have OF, though I've got some dormant patches to add an
OF emulation layer to make it easier to reuse Sparc drivers on
Sun3...   Never finished enough to submit, so it probably shouldn't
affect anything you're doing here.

As for recent kernels, I think 2.6.19 was the last sun3 I distributed
patches for, so modern might be pushing it...

-- Sam

