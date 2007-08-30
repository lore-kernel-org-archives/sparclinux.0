From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 30 Aug 2007 11:50:42 +0000
Subject: Re: [PATCH] fix ALSA compilation on Sparc32
Message-Id: <s5hwsvdgs19.wl%tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20070830092604.GA17041@vimes.madsworld.lan>
In-Reply-To: <20070830092604.GA17041@vimes.madsworld.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Markus Dahms <mad@automagically.de>
Cc: perex@suse.cz, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

At Thu, 30 Aug 2007 11:26:04 +0200,
Markus Dahms wrote:
> 
> The dma_alloc_coherent and dma_free_coherent function seem to be not
> available on sparc(32) architecture. It is not used by SBus sound
> drivers, so it's disabled via #ifndef for CONFIG_SPARC32.
> 
> Signed-off-by: Markus Dahms <mad@automagically.de>

Actually, the fix has been in ALSA tree (found in git-alsa.patch in mm
tree) since long time ago, but it was never pushed. 

Jaroslav, could you push the fixes please...?


thanks,

Takashi
