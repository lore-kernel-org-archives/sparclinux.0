From: "David S. Miller" <davem@redhat.com>
Date: Sat, 26 Jun 2004 23:26:03 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <20040626162603.1874e174.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 26 Jun 2004 17:25:24 -0600 (MDT)
Jason Wever <weeve@gentoo.org> wrote:

> On a side note, has cs4231 ever been at a point in the 2.5 or 2.6 kernels 
> where it has been usable?  It'll compile, build and load fine at least for 
> PCI systems (SBUS is hit and miss whether it'll build but that's more 
> typically core ALSA components) but the audio produced is never  
> understandable.  On PCI I have tried turning on all of the debugging 
> options but it doesn't seem to generate any helpful errors.

I had it %90 working mid-2.5.x, but I simply haven't fiddled with it
since.  I also lack any interesting in working on it as I have my
hands full with enough other things at the moment. :)
