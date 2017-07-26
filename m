From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 16:54:32 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170726.095432.169004918437663011.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726152315.00003d61@huawei.com>
 <20170726163340.0000014f@huawei.com>
 <20170726154900.GQ3730@linux.vnet.ibm.com>
In-Reply-To: <20170726154900.GQ3730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 08:49:00 -0700

> On Wed, Jul 26, 2017 at 04:33:40PM +0100, Jonathan Cameron wrote:
>> Didn't leave it long enough. Still bad on 4.10-rc7 just took over
>> an hour to occur.
> 
> And it is quite possible that SOFTLOCKUP_DETECTOR=y and HZ_PERIODIC=y
> are just greatly reducing the probability of the problem rather than
> completely preventing it.
> 
> Still, hopefully useful information, thank you for the testing!

I guess that invalidates my idea to test reverting recent changes to
the tick-sched.c code... :-/

In NO_HZ_IDLE mode, what is really supposed to happen on a completely
idle system?

All the cpus enter the idle loop, have no timers programmed, and they
all just go to sleep until an external event happens.

What ensures that grace periods get processed in this regime?
