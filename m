From: David Miller <davem@davemloft.net>
Date: Wed, 28 Feb 2007 19:53:47 +0000
Subject: Re: parport_pc broken on sparc64
Message-Id: <20070228.115347.27951024.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0702282131050.5156@math>
In-Reply-To: <Pine.SOC.4.64.0702282131050.5156@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 28 Feb 2007 21:38:23 +0200 (EET)

> WARNING: "request_dma" [drivers/parport/parport_pc.ko] undefined!
> WARNING: "free_dma" [drivers/parport/parport_pc.ko] undefined!
> make[1]: *** [__modpost] Error 1

The parport code really shouldn't be making calls to these
functions if the architecture does not set CONFIG_GENERIC_ISA_DMA.

I'll see what I can do to fix this, thanks for the report.
