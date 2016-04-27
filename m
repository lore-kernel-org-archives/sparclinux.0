From: Meelis Roos <mroos@linux.ee>
Date: Wed, 27 Apr 2016 13:21:11 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <alpine.LRH.2.20.1604271619320.16434@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Just got power & cooling back to my computer lab (and I'm back to 
> > reporting bugs). I have a bqacklog of things to test but on E420R I got 
> > a halt during early bootup:
> 
> > [    0.000000] Kernel: Using 5 locked TLB entries for main kernel image.
> > [    0.000000] Remapping the kernel... done.
> > 
> > RED State Exception

Adding to todays discussion, my V240 also fails booting up post-4.5, 
proably the same. Maybe thew configurations are different enough...

My T5120 worked fine.

-- 
Meelis Roos (mroos@linux.ee)
