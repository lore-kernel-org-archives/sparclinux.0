From: David Miller <davem@davemloft.net>
Date: Mon, 11 Apr 2016 03:45:26 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160410.234526.903627858061725975.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 7 Apr 2016 11:22:10 +0300 (EEST)

>> Just got power & cooling back to my computer lab (and I'm back to 
>> reporting bugs). I have a bqacklog of things to test but on E420R I got 
>> a halt during early bootup:
> 
>> [    0.000000] Kernel: Using 5 locked TLB entries for main kernel image.
>> [    0.000000] Remapping the kernel... done.
>> 
>> RED State Exception
> 
> Bisected:
> 
> commit 1a40b95374f680625318ab61d81958e949e0afe3
> Author: Mike Frysinger <vapier@gentoo.org>
> Date:   Mon Jan 18 06:32:30 2016 -0500
> 
>     sparc: Fix system call tracing register handling.
 ...
> Actually this commit juts makes the system hang here, not RED state 
> exception. a couple of last bisect targets were like that so if needed, 
> I can also bisect where the hang transformed into RED State Exception.

Thanks for tracking this down.  I'll try to figure out what might be
wrong with this change.
