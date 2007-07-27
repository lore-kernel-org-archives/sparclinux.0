From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 09:58:57 +0000
Subject: Re: ALSA & missing dma_*_coherent on sparc32
Message-Id: <Pine.SOC.4.64.0707271257570.20751@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707261317001.20971@math.ut.ee> <s5h7ionv0xc.wl%tiwai@suse.de>
 <Pine.SOC.4.64.0707261501130.24473@math.ut.ee> <s5h6447uzrk.wl%tiwai@suse.de>
 <20070726125834.GA4041@uranus.ravnborg.org> <s5hzm1jtiy1.wl%tiwai@suse.de>
In-Reply-To: <s5hzm1jtiy1.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

> [ALSA] Fix build error without CONFIG_HAS_DMA
> 
> The recent change of include/asm-generic/dma-mapping-broken.h breaks
> the build without CONFIG_HAS_DMA.  This patch is an ad hoc fix.

This seems to fix the issue, thnaks!

-- 
Meelis Roos (mroos@linux.ee)
