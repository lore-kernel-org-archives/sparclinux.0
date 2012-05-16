From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 16 May 2012 17:20:57 +0000
Subject: Re: [RFC PATCH] sparc32,leon: always include leon code in build
Message-Id: <20120516172057.GA1352@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120514202951.GA4439@merkur.ravnborg.org>
In-Reply-To: <20120514202951.GA4439@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, May 16, 2012 at 04:58:26PM +0200, Sam Ravnborg wrote:
> Hi Jiri.
> 
> > 
> > > Konrad / Daniel - any inputs on why LEON uses a different ASI?
> > > As we uses this in head_32.S this is really annoying...
> > 
> > It is not difficult to change the MMU reg ASI from 0x19 to 0x4
> > (as defined in the SRMMU spec). However, all available LEON2/3/4
> > chips in production uses 0x19 due to a decision take about 10
> > years ago.
> Then I consider that cast in stone :-(
> We have leon boards out that uses ASI = 0x19.
> 
> What we really need is an implementation of head_32.S that transparently
> handle the existing sun4m + sun4d boxes + the leon based boards.
> 
> If there is a way we reliably early on can decide if we run
> one of the leon chips then we can always use a separate track in
> head_32.S for the leon stuff.

I have looked at what they do in BSD - and if I combinethat
with what we have in Linux I think I can come up with something.
It requre that we read PSR early to determine the CPU type,
but we already read PSR so this should not be an issue.

Let me try to cook up something.
It will take some days - so do not hold your breath...

	Sam
