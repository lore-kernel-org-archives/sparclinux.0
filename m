From: Meelis Roos <mroos@linux.ee>
Date: Sat, 07 Feb 2009 08:34:04 +0000
Subject: Re: SBus HME startup failure
Message-Id: <Pine.SOC.4.64.0902071031430.28855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Meelis and Eric, does the following patch do the trick?

Yes, thank you very much!

However, do we need to fix the second prpblem too that's now not 
appearing - registering quatrro sbus irqs anyway if some hme was found 
and a quattro HME exists in the system?

> --------------------
> sunhme: Don't match PCI devices in SBUS probe.
> 
> Unfortunately, the OF device tree nodes for SBUS and PCI
> hme devices have the same device node name on some systems.
> 
> So if the name of the parent node isn't 'sbus', skip it.
> 
> Based upon an excellent report and detective work by
> Meelis Roos and Eric Brower.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Tested-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos (mroos@linux.ee)
