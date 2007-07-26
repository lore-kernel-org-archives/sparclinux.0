From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2007 12:58:34 +0000
Subject: Re: ALSA & missing dma_*_coherent on sparc32
Message-Id: <20070726125834.GA4041@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707261317001.20971@math.ut.ee> <s5h7ionv0xc.wl%tiwai@suse.de> <Pine.SOC.4.64.0707261501130.24473@math.ut.ee> <s5h6447uzrk.wl%tiwai@suse.de>
In-Reply-To: <s5h6447uzrk.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Meelis Roos <mroos@linux.ee>, Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Thu, Jul 26, 2007 at 02:15:43PM +0200, Takashi Iwai wrote:
> At Thu, 26 Jul 2007 15:02:51 +0300 (EEST),
> Meelis Roos wrote:
> > 
> > > > ERROR: "dma_free_coherent" [sound/core/snd-page-alloc.ko] undefined!
> > > > ERROR: "dma_alloc_coherent" [sound/core/snd-page-alloc.ko] undefined!
> > > 
> > > Could you show .config?  Does it have CONFIG_HAS_DMA?
> > 
> > No, CONFIG_NO_DMA=y - and this was recently changed on sparc32 IIRC.
> 
> OK, then could you try the patch below?

Hi Takashi-san.

Can I ask you to introdue use of the -y syntax for composite objects.
This would simplify soucd/core/Makefile

The below would then become:
>  
> -snd-page-alloc-objs := memalloc.o sgbuf.o
> +snd-page-alloc-y := memalloc.o
> +snd-page-alloc-$(CONFIG_HAS_DMA) += sgbuf.o
>  
>  snd-rawmidi-objs  := rawmidi.o
>  snd-timer-objs    := timer.o

Ask if you have questions.

Thanks,
	Sam
