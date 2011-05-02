From: David Miller <davem@davemloft.net>
Date: Mon, 02 May 2011 21:51:51 +0000
Subject: Re: SBus devices sometimes detected, sometimes not
Message-Id: <20110502.145151.112612233.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1105021259220.6200@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1105021259220.6200@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 2 May 2011 13:39:46 +0300 (EEST)

> This is 2.6.39-rc3..rc5 on Sun Ultra 1 with SBus hme card.
> On about 50% of boots, hme is found fine and works. On other half boots 
> (not strictly in any order) SBus hme is not detected with this error:
> 
> hme: probe of f006be34 failed with error -22
> 
> grepping the logs, I sometimes also find similar errors about qlogicpti:
> 
> qpti: probe of f00798c4 failed with error -22
> 
> The node addresses are always the same for the device.
> 
> 2.6.38 did not have this problem.
> 
> On SBus-only E3000 and SBus+PCI E3500, SBus HME and other SBus 
> devices are detected fine so far in a handful of tests.

Thanks for this report, I'll take a look at it soon.
