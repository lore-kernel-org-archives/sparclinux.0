From: "David S. Miller" <davem@redhat.com>
Date: Sat, 26 Jun 2004 17:02:00 +0000
Subject: Re: DMA_AUTOINIT missing in asm-sparc64/dma.h
Message-Id: <20040626100200.0ec94802.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1088244683.12842.45.camel@cid.outersquare.org>
In-Reply-To: <1088244683.12842.45.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 26 Jun 2004 03:11:23 -0700
Jeremy Huddleston <eradicator@gentoo.org> wrote:

> I was going to test out various PCI sound cards I've had lying around
> when I noticed that DMA_AUTOINIT isn't defined in asm-sparc64/dma.h like
> it is in other archs... most archs defined it as 2 while arm defines it
> as 4.

These pieces of code you are trying to compile are attempting
to do ISA DMA controller programming.  Such things do not
exist on Sparc.

I never get these errors and I have a large number of PCI sound
cards enabled in my config, which is arch/sparc64/defconfig BTW.

Which card are you enabling in the build?
