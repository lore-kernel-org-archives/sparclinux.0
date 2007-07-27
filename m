From: Meelis Roos <mroos@linux.ee>
Date: Fri, 27 Jul 2007 16:06:50 +0000
Subject: Re: autoloading snd_sun_cs4231?
Message-Id: <Pine.SOC.4.64.0707271904110.27338@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705171123520.18408@math>
In-Reply-To: <Pine.SOC.4.64.0705171123520.18408@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > What is needed to autoload snd_sun_cs4231 on Ultra 5? It's not pci but 
> > ebus - do we have ebus modalias support, or what would I need to know to 
> > write one?
> 
> of_device autoloading is what you need, powerpc probably has some
> infrastructure for this already.
> 
> Oh I see, I didn't convert cs4231 over to of_device yet.  I
> can't do that until I fix up the SBUS stuff so that everything
> can go through the generic dma_*() mapping interfaces.

Does the same method provide sbus autoloading? sbus module autoloading 
seems to be broken currently - neither my owrn nor Debian 2.6.22-1 
kernels do sbus autoloading and so Debian's initrd does not even load 
sun_esp and fails to boot. It used to function somehow before (not 
of_device autoloading) - I do not know how it worked for initrd, but it 
seemed to use discover for the rest of the modules. discover too has 
stopped finding sbus modules :(

-- 
Meelis Roos (mroos@linux.ee)
