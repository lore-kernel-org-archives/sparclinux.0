From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 27 Jul 2007 10:33:51 +0000
Subject: Re: ALSA & missing dma_*_coherent on sparc32
Message-Id: <s5h1weuw2y8.wl%tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707261317001.20971@math.ut.ee>
	<s5h7ionv0xc.wl%tiwai@suse.de>
	<Pine.SOC.4.64.0707261501130.24473@math.ut.ee>
	<s5h6447uzrk.wl%tiwai@suse.de>
	<20070726125834.GA4041@uranus.ravnborg.org>
	<s5hzm1jtiy1.wl%tiwai@suse.de>
	<Pine.SOC.4.64.0707271257570.20751@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707271257570.20751@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

At Fri, 27 Jul 2007 12:58:57 +0300 (EEST),
Meelis Roos wrote:
> 
> > [ALSA] Fix build error without CONFIG_HAS_DMA
> > 
> > The recent change of include/asm-generic/dma-mapping-broken.h breaks
> > the build without CONFIG_HAS_DMA.  This patch is an ad hoc fix.
> 
> This seems to fix the issue, thnaks!

Thanks for confirmation.  The patch is queued in ALSA tree now for the
next push.


Takashi
