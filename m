From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2008 07:58:53 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080917.005853.31648370.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Wed, 17 Sep 2008 09:44:42 +0300 (EEST)

> > Ok, the patch below should fix the OOPS with the debugging
> > features enabled.  Please give it a test and let me know if
> > it works.
> > 
> > Thanks.
> > 
> > sparc64: Fix SMP bootup with CONFIG_STACK_DEBUG or ftrace.
> 
> Thank you! It cures the known-bad config with stack overflow detection 
> turned on. Instead of the hang, it now displays
> 
> Calibrating delay using timer specific routine.. 801.66 BogoMIPS (lpj@08300)
> Mount-cache hash table entries: 512
> CPU 7: synchronized TICK with master CPU (last diff -2 cycles, maxerr 685 cycles)
> Brought up 2 CPUs
> 
> And continues with other things and boots fine to SMP multiuser.
> 
> Will try it against todays git next - expecting no surprises :)

Thanks for your testing, as usual.
