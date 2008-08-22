From: "Yoder Stuart" <stuart.yoder@freescale.com>
Date: Fri, 22 Aug 2008 16:00:09 +0000
Subject: RE: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <9696D7A991D0824DBA8DFAC74A9C5FA304461060@az33exm25.fsl.freescale.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48AE4093.8050504@firmworks.com>	<fa686aa40808212130l365c6f5eu767b9969c8171e2@mail.gmail.com>	<fa686aa40808212134l1e226845q41831ee567bb1a2@mail.gmail.com><20080821.213747.159824681.davem@davemloft.net>
	<48AE4C4A.8040804@firmworks.com>
In-Reply-To: <48AE4C4A.8040804@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mitch Bradley <wmb@firmworks.com>, David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org, WOOD SCOTT <scottwood@freescale.com>

 

> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org 
> [mailto:linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org] 
> On Behalf Of Mitch Bradley
> Sent: Friday, August 22, 2008 12:19 AM
> To: David Miller
> Cc: linuxppc-dev@ozlabs.org; sparclinux@vger.kernel.org; 
> devicetree-discuss@ozlabs.org; Wood Scott
> Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
> 
> 
> 
> David Miller wrote:
> > From: "Grant Likely" <grant.likely@secretlab.ca>
> > Date: Thu, 21 Aug 2008 22:34:31 -0600
> >
> >   
> >> On Thu, Aug 21, 2008 at 10:30 PM, Grant Likely
> >> <grant.likely@secretlab.ca> wrote:
> >>     
> >>> On Thu, Aug 21, 2008 at 10:29 PM, Mitch Bradley 
> <wmb@firmworks.com> wrote:
> >>>       
> >>>> Hi, I wrote most of 1275.
> >>>>
> >>>> Mitch Bradley  (wmb@firmworks.com)
> >>>>         
> >>> Hi Mitch,
> >>>
> >>> What is your suggestion.  Where should we be discussing new device
> >>> tree bindings?  Whether it be real Open Firmware, or 
> flattened device
> >>> tree, or something in between
> >>>       
> >> ...and along those lines: is there a place for documenting new
> >> bindings?  Lacking anything better, those of us in 
> PowerPC-Linux-land
> >> have been adding documentation to 
> Documentation/powerpc/dts-bindings/*
> >> in the Linux kernel tree.
> >>     
> >
> > In a discussion I am having with Greg Onufer, David K. and Tayfun
> > at Sun, Greg said the some of the newer binding documents are
> > being published on the opensolaris site, and he is trying to
> > get some of the older cases (like this I2C one) published there
> > too.
> >
> >   
> 
> This collection of mailing lists is as good a place as any to discuss 
> new bindings.  I don't know how many Sun people are on the 
> lists, but we 
> might be able to persuade various Sun people to lurk on one 
> or more of 
> them;  I lurk on devicetree-discuss.
> 
> The opensolaris site seems as good as anywhere for publishing the 
> bindings, especially if they can pull over the old ones from e.g. 
> playground.sun.com .
> 
> Another possible site might be openbios.org .

I agree that the linuxppc-dev and devicetree-discuss mailing
lists are probably the best place to discuss bindings.  (I'm
not aware of other good options).

Once there is consensus as to what a binding should be, and publishing
is needed-- for general, common bindings some single place is needed.
Something that is ideally authoritative, with a committed organization
behind it.  One suggestion would be the power.org and follow on
versions of the ePAPR.  ePAPR 1.0 is out now and currently is a base
document-- defines the flat device tree concept, and basically extracts
the relevant parts of 1275 for how this is used in the embedded space.

There are a few bindings specified in the ePAPR, based on the old
Open Firmware working group stuff:
   -cpu
   -interrupt controllers
   -PCI
   -network devices
   -DCR devices
   -serial devices

ePAPR doc is at:
http://www.power.org/resources/downloads/

It's obvious that more bindings are needed, and the expecation from
those who worked on the ePAPR (most or all of which are on this
mailing list) was that as bindings are codified they could be
added to the ePAPR.

The best way to publish bindings will be on the web.  I've been
looking into getting power.org to host a wiki-based site
that could be used as a repository for bindings.  We could have
both an area for general bindings and company specific ones.
I've made some progress here and actually have a sandbox wiki
that I'm playing with.

Stuart Yoder
Freescale

