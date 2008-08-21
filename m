From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 09:02:10 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080821.020210.261128029.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 21 Aug 2008 11:50:32 +0300 (EEST)

> > Did you already test soemthing, such as get rid of USB support in your
> > configuration, and after a successful boot try and use sysrq over your
> > serial console?
> 
> Not yet, have tried with instrumenting the usb code as the first 
> priority.

I truly suspect that the cpu that the serial interrupts go to is
looping somewhere with interrupts disabled, and that's the only reason
why sysrq doesn't work.
