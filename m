From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 26 Jul 2017 17:13:12 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170726181312.0000040d@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726152315.00003d61@huawei.com>
 <20170726163340.0000014f@huawei.com>
 <20170726154900.GQ3730@linux.vnet.ibm.com>
 <20170726.095432.169004918437663011.davem@davemloft.net>
In-Reply-To: <20170726.095432.169004918437663011.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 26 Jul 2017 09:54:32 -0700
David Miller <davem@davemloft.net> wrote:

> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Wed, 26 Jul 2017 08:49:00 -0700
> 
> > On Wed, Jul 26, 2017 at 04:33:40PM +0100, Jonathan Cameron wrote:  
> >> Didn't leave it long enough. Still bad on 4.10-rc7 just took over
> >> an hour to occur.  
> > 
> > And it is quite possible that SOFTLOCKUP_DETECTOR=y and HZ_PERIODIC=y
> > are just greatly reducing the probability of the problem rather than
> > completely preventing it.
> > 
> > Still, hopefully useful information, thank you for the testing!  

Not sure it actually gives us much information, but no issues yet
with a simple program running every cpu that wakes up every 3 seconds.

Will leave it running overnight and report back in the morning.

> 
> I guess that invalidates my idea to test reverting recent changes to
> the tick-sched.c code... :-/
> 
> In NO_HZ_IDLE mode, what is really supposed to happen on a completely
> idle system?
> 
> All the cpus enter the idle loop, have no timers programmed, and they
> all just go to sleep until an external event happens.
> 
> What ensures that grace periods get processed in this regime?
