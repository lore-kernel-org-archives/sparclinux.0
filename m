From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 30 Aug 2007 10:52:06 +0000
Subject: Re: [PATCH] fix ALSA compilation on Sparc32
Message-Id: <s5h7indi9bd.wl%tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20070830092604.GA17041@vimes.madsworld.lan>
	<20070830110939.23146ea3@the-village.bc.nu>
In-Reply-To: <20070830110939.23146ea3@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Markus Dahms <mad@automagically.de>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

At Thu, 30 Aug 2007 11:09:39 +0100,
Alan Cox wrote:
> 
> On Thu, 30 Aug 2007 11:26:04 +0200
> Markus Dahms <mad@automagically.de> wrote:
> 
> > The dma_alloc_coherent and dma_free_coherent function seem to be not
> > available on sparc(32) architecture. It is not used by SBus sound
> > drivers, so it's disabled via #ifndef for CONFIG_SPARC32.
> 
> It would probably look a lot cleaner if you either provided dummy
> dma_alloc_coherent/free coherent inlines for SPARC32, fixed it (if
> sparc32 can do coherent DMA) or if you must ifdef it provide dummy
> functions in the memalloc code so its a single ifdef

It's been indeed inline on 2.6.22 or ealier in
include/asm-generic/dma-mapping.h, but it's changed to extern without
defining functions.

I don't think it's a good idea to have function declarations even
though we surely know that there are no real function definitions...


Takashi
