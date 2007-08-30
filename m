From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 30 Aug 2007 10:09:39 +0000
Subject: Re: [PATCH] fix ALSA compilation on Sparc32
Message-Id: <20070830110939.23146ea3@the-village.bc.nu>
List-Id: <sparclinux.vger.kernel.org>
References: <20070830092604.GA17041@vimes.madsworld.lan>
In-Reply-To: <20070830092604.GA17041@vimes.madsworld.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Markus Dahms <mad@automagically.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 30 Aug 2007 11:26:04 +0200
Markus Dahms <mad@automagically.de> wrote:

> The dma_alloc_coherent and dma_free_coherent function seem to be not
> available on sparc(32) architecture. It is not used by SBus sound
> drivers, so it's disabled via #ifndef for CONFIG_SPARC32.

It would probably look a lot cleaner if you either provided dummy
dma_alloc_coherent/free coherent inlines for SPARC32, fixed it (if
sparc32 can do coherent DMA) or if you must ifdef it provide dummy
functions in the memalloc code so its a single ifdef

