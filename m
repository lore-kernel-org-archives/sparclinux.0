From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 03 Oct 2005 21:32:11 +0000
Subject: Re: cs4231 on sbus (ultra 2)
Message-Id: <20051003.143211.86590656.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4341291E.5060001@triaton-webhosting.com>
In-Reply-To: <4341291E.5060001@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Zimmermann <madroach@zakweb.de>
Date: Mon, 3 Oct 2005 18:47:36 +0200

> > 2) Is it correct that not incrementing p_periods_sent when the
> >    first block of data is transfered will lead to playing the same
> >    block twice?
> 
> This part was a riddle to me when programming this thing. I don't know
> why you have to skip the first period, but for me it only works when it
> is skipped, otherwise I get only noice. You could play with the call of
> sbus_advance_dma in cs4231_dma_trigger and the formula in
> snd_cs4231_playback_pointer a bit. I ended up using that solution using
> this dummy thingy. An alternative would be using a different formula in
> snd_cs4231_playback_pointer for sbus.

The SBUS and EBUS dma engines have a peculiar feature that might be
causing this weird behavior.

The DMA address and DMA length registers are each actually a 2-entry
deep fifo.  So you can load two address+length pairs at once.

I think the EBUS side is documented online somewhere, let me check...
Yes, in this document:

     http://www.sun.com/processors/manuals/802-7837.pdf

In Chapter 7, around page 117, it describes the programming of the
EBUS DMA registers, and in particular how the "next address" feature
operates.

This behavior is controlled by a bit in the EBUS DMA control register
for the channel.  This, along with other details of behavior, might be
different in the SBUS APC but the ideas are definitely similar.

I hope this helps.

To be honest, I found it confusing how the ALSA layer play/record engine
triggers things in the driver, and what state the driver is supposed to
maintain and update around such operations.
