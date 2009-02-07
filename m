From: David Miller <davem@davemloft.net>
Date: Sat, 07 Feb 2009 10:20:03 +0000
Subject: Re: SBus HME startup failure
Message-Id: <20090207.022003.260994505.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sat, 7 Feb 2009 10:34:04 +0200 (EET)

> > Meelis and Eric, does the following patch do the trick?
> 
> Yes, thank you very much!

Thanks for testing.

> However, do we need to fix the second prpblem too that's now not 
> appearing - registering quatrro sbus irqs anyway if some hme was found 
> and a quattro HME exists in the system?

Hmmm... one thing we could do is only register the IRQ if all 4
slots of the per-quattro array are filled in.

Similar checks would be needed in quattro_sbus_free_irqs().

This means we'll also have to add some code to the error paths
of happy_meal_sbus_probe_one() to make it NULL out the
qp->happy_meals[qfe_slot] entry on failure.

Maybe you could work on this patch? :-)

