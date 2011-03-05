From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 05 Mar 2011 16:25:10 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq
Message-Id: <20110305162510.GA14644@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Mar 05, 2011 at 03:49:08PM +0100, Marcel van Nies wrote:
> Hi Sam,
> 
> > The patchset will likely not see testing on:
> > -  Javastation (the pcic changes)
> > - sun4m with multiple CPUs
> > - sun4c
> >
> > I have checked the nearby ebay's for relevant boxes - no luck.
> > On the other hand there is also a limit for the size of
> > my SUN museum :-)
> 
> I've got a small "SUN museum" ...
> sun4c: SPARCstation IPX
> sun4m: SPARCstation5 (microSPARC II)
> sun4m: SPARCstation20 (two-way superSPARC II)
> sun4m: SPARCstation20 (four-way hyperSPARC Colorado-3)
> 
> Never got the IPX running on 2.6, but the others are spinning just
> fine on some 2.6.1x UP (x=low).
> I'm looking forward to give your patchset a try.

Great!

If you fetch sparc-next-2.6.git:

   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next-2.6.git

then you only need to apply the patch from this mail:

    http://marc.info/?l=linux-sparc&m9823440700712&w=2

I'm looking forward for the result of the tests.

	Sam
