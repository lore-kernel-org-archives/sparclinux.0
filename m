From: Christopher Zimmermann <madroach@zakweb.de>
Date: Mon, 03 Oct 2005 16:47:36 +0000
Subject: Re: cs4231 on sbus (ultra 2)
Message-Id: <20051003164736.GA854@sparc>
List-Id: <sparclinux.vger.kernel.org>
References: <4341291E.5060001@triaton-webhosting.com>
In-Reply-To: <4341291E.5060001@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Oct 03, 2005 at 02:50:38PM +0200, Georg Chini wrote:
> Hello,
> 
> I am using 2.6.14-rc2-git4, which includes the patch for cs4231
> on sbus sent in by Christopher Zimmermann. It does not work
> properly on my machine, there is a lot of noise in the playback.
> As I am no kernel programmer, I need some help in sorting out
> the problems.
> After looking at the code I have a few questions:
> 
> 1) After playing some sound, the DMA-controller is not reset,
>    so that playing the next sound will start with the rest of the
>    recent sound. Is there a way to reset a single DMA channel?

On my Ultra2 it works well. Once I got only noice after I started and
stopped playback some times. After I removed the else parts in the
cs4231_dma_trigger function it worked well.

> 2) Is it correct that not incrementing p_periods_sent when the
>    first block of data is transfered will lead to playing the same
>    block twice?

This part was a riddle to me when programming this thing. I don't know
why you have to skip the first period, but for me it only works when it
is skipped, otherwise I get only noice. You could play with the call of
sbus_advance_dma in cs4231_dma_trigger and the formula in
snd_cs4231_playback_pointer a bit. I ended up using that solution using
this dummy thingy. An alternative would be using a different formula in
snd_cs4231_playback_pointer for sbus.

> 3) snd_cs4231_playback_pointer returns a value which is two
>    period_bytes larger than the DMA-pointer. Shouldn't it return
>    a value which reflects the state of the current DMA-process?
> 4) Other drivers use sbus_map_single or pci_map_single to get
>    hold of DMA-buffers. This is not the case with this driver. Is
>    it not needed here?

This is done by alsa.

> 
> Any comments and suggestions are welcome.
> 
> Regards
>             Georg Chini
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
