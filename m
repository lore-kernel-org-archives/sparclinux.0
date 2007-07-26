From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 26 Jul 2007 11:50:39 +0000
Subject: Re: ALSA & missing dma_*_coherent on sparc32
Message-Id: <s5h7ionv0xc.wl%tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707261317001.20971@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707261317001.20971@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

At Thu, 26 Jul 2007 13:21:01 +0300 (EEST),
Meelis Roos wrote:
> 
> Tried to compile current 2.6.23-rc1+git on sparc32, along with sparc 
> ALSA drivers as usual. But now the compilation is broken because of 
> missing dma_*_coherent on sparc32. ISTR this got chenged recently on 
> sparc32...
> 
> ERROR: "dma_free_coherent" [sound/core/snd-page-alloc.ko] undefined!
> ERROR: "dma_alloc_coherent" [sound/core/snd-page-alloc.ko] undefined!

Could you show .config?  Does it have CONFIG_HAS_DMA?


Takashi
