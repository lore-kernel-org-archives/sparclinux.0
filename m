From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 05 Sep 2010 06:22:07 +0000
Subject: Re: [PATCH 1/9] of: move phandle/ihandle into types.h
Message-Id: <20100905062207.GA31275@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100829235100.6dcedcb8@debxo> <20100829235352.1744e7e3@debxo> <20100830050627.GA12153@merkur.ravnborg.org> <20100903041715.573471e4@debxo>
In-Reply-To: <20100903041715.573471e4@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, grant.likely@secretlab.ca, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

On Fri, Sep 03, 2010 at 04:17:15AM -0400, Andres Salomon wrote:
> On Mon, 30 Aug 2010 07:06:27 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Sun, Aug 29, 2010 at 11:53:52PM -0400, Andres Salomon wrote:
> > > 
> > > We need phandle for some exported sparc headers; of.h isn't an
> > > exported header, and it would be silly to export it when all we
> > > really need is one or two types from it.  So, move the
> > > phandle/ihandle definitions into types.h.
> > > 
> > > diff --git a/include/linux/types.h b/include/linux/types.h
> > > index 01a082f..26526ea 100644
> > > --- a/include/linux/types.h
> > > +++ b/include/linux/types.h
> > > @@ -219,6 +219,10 @@ struct ustat {
> > >  	char			f_fpack[6];
> > >  };
> > >  
> > > +/* Basic openboot/openfirmware types */
> > > +typedef u32 phandle;
> > > +typedef u32 ihandle;
> > > +
> > >  #endif	/* __KERNEL__ */
> > 
> > The above is inside #ifdef __KERNEL__ / #endif
> > so it is not exported as we drop code protected
> > by __KERNEL__ when we prepare for export.
> 
> 
> 
> At least for me, that's fine; I don't need phandle/ihandle to be
> available to userspace.  The folks who work on the userspace fdt code
> may feel differently, however.
> 
> (I'm not sure if you're suggesting it be outside the __KERNEL__ ifdef
> or not..)

If the goal is to get ihandle/phandle exported to userspace then
they have to be moved outside __KERNEL__.

I just tried to export sparc64 headers,
and here I found references to ihandle/phandle in a comment
only sparc does not need these types today.

The relevant function took and returns an int btw.

So the above looks good considerign that userspace
so far does not require ihanlde/phandle.

	Sam
