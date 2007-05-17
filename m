From: David Miller <davem@davemloft.net>
Date: Thu, 17 May 2007 08:27:38 +0000
Subject: Re: autoloading snd_sun_cs4231?
Message-Id: <20070517.012738.41635708.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705171123520.18408@math>
In-Reply-To: <Pine.SOC.4.64.0705171123520.18408@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 17 May 2007 11:25:34 +0300 (EEST)

> What is needed to autoload snd_sun_cs4231 on Ultra 5? It's not pci but 
> ebus - do we have ebus modalias support, or what would I need to know to 
> write one?

of_device autoloading is what you need, powerpc probably has some
infrastructure for this already.

Oh I see, I didn't convert cs4231 over to of_device yet.  I
can't do that until I fix up the SBUS stuff so that everything
can go through the generic dma_*() mapping interfaces.

Maybe in the 2.6.23 timeframe this will be doable, thanks for
mentioning it I'll add it to my todo list.
