From: "David S. Miller" <davem@redhat.com>
Date: Sat, 26 Jun 2004 23:37:47 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <20040626163747.11f47964.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 26 Jun 2004 17:33:33 -0600 (MDT)
Jason Wever <weeve@gentoo.org> wrote:

> Gotcha.  Are there any resources on-line or otherwise that could be used 
> by others to help get this working?  I'm interested in getting it working 
> but I'm thinking my enthusiasm outweighs my coding skills at the moment :)  

The best reference is the 2.4.x driver.  The netbsd driver is not a
bad refernce either.

The EBUS DMA engine is documented at:

http://www.sun.com/oem/products/manuals/802-7837.pdf

And that's likely where the problem are, the DMA controller and
the CS4321 chip aren't sync'ing up correctly.  That was the most
difficult part of the driver to get right.

> Also were the ALSA folks been much involved with the work on the driver in 
> the 2.5 days and if so, is there someone good to follow-up with over 
> there?

None at all, I wrote it all by myself using the ALSA ISA cs432x driver as
a guide.
