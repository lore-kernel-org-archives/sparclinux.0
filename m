From: Brad Boyer <flar@allandria.com>
Date: Wed, 07 Oct 2009 22:57:58 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <20091007225758.GD6138@cynthia.pants.nu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
	<646765f40910062218s19d540f9q14c9086bedd1d9da@mail.gmail.com>
	<20091007135243.GC21646@anhedonia>
In-Reply-To: <20091007135243.GC21646@anhedonia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Creasey <sammy@sammy.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Julian Calaby <julian.calaby@gmail.com>, devicetree-discuss@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Wed, Oct 07, 2009 at 09:52:43AM -0400, Sam Creasey wrote:
> On Wed, Oct 07, 2009 at 03:18:04PM +1000, Julian Calaby wrote:
> > On the subject of merging code, I know that the SUN3 code in m68k uses
> > a similar prom interface to the sparc32 code. (and I've also
> > considered unifying that and ... well ... see above) Does anyone know
> > if it has an OpenFirmware interface for it's devices? Is OF on SUN3
> > even remotely useful? Does Linux on SUN3 even work with modern
> > kernels?
> 
> Sun3 doesn't have OF, though I've got some dormant patches to add an
> OF emulation layer to make it easier to reuse Sparc drivers on
> Sun3...   Never finished enough to submit, so it probably shouldn't
> affect anything you're doing here.

I was also looking at using the OF code on m68k, but for a different
reason. My goal was to get macio_bus working so we can merge a few
of the m68k Mac drivers into the ppc Mac drivers. The simplest way
to do that seemed to be supporting OF since macio_dev is a wrapper
for of_device. It was also a nice way to build up a table of all the
onboard devices in memory. Hopefully it would enable better user-space
device detection as well.

I got the framework built against an older kernel, but it wasn't enough
to be useful at that point. This set of patches could help quite a bit.

	Brad Boyer
	flar@allandria.com

