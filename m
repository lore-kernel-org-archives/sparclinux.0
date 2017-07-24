From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Mon, 24 Jul 2017 23:49:27 +0000
Subject: Re: RCU stall warnings...
Message-Id: <20170724234927.GK3730@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170724.153248.1457902120749226419.davem@davemloft.net>
 <20170724232033.GI3730@linux.vnet.ibm.com>
 <20170724.163458.1860624258080140141.davem@davemloft.net>
In-Reply-To: <20170724.163458.1860624258080140141.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Jul 24, 2017 at 04:34:58PM -0700, David Miller wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Mon, 24 Jul 2017 16:20:33 -0700
> 
> > It looks like the system isn't letting the rcu_sched grace-period kthread
> > run:
> > 
> > [402138.240512] rcu_sched kthread starved for 2757 jiffies! g53669 c53668 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> > 
> > This kthread tried to wait for a few jiffies (the exact number depends
> > on HZ and the number of CPUs), but 2,757 jiffies have elapsed and it is
> > still waiting.  This kthread is responsible for detecting idle CPUs and
> > reporting quiescent states on their behalf, so if this kthread doesn't
> > get a chance to run, then the stall warnings you are seeing are expected
> > behavior.
> > 
> > I am seeing someething like sort of like this in my rcutorture runs,
> > but only when I boot with nr_cpus quite a bit bigger than maxcpus, as in
> > something like nr_cpusC and maxcpus=8.  This causes 8 CPUs to be brought
> > online at the usual time, and the other 35 come online some time later.
> > One difference from your situation is that I see the grace-period
> > kthread in ->state=0x401 (TASK_WAKING) instead of your ->state=0x1.
> > If I send extra wakeups to the grace-period kthread (which shouldn't be
> > needed), it does make progress, but then other kthreads fall into that
> > same half-woken state.
> > 
> > So now that I ahve shared the full extent of my ignorance on this topic,
> > any ideas?  ;-)
> 
> Shoing my ignorance as well, after reading this, for some reason this
> commit below sticks out to me.  Maybe I should do a bisect and see if
> it lands on this commit.

I would be very surprised if this commit was the culprit, but then
again, I have been very surprised before.

> That would take a while as it's hard to forcibly set this thing off.

And my similar error can take awhile as well.  But maybe I should try
forcing nr_cpusC and maxcpus=8 on older versions to see what happens.

A bisection would of course be quite helpful, depending of course on
the value of "a while".  ;-)

							Thanx, Paul

> ==========
> commit f92c734f02cbf10e40569facff82059ae9b61920
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Apr 10 15:40:35 2017 -0700
> 
>     rcu: Prevent rcu_barrier() from starting needless grace periods
>     
>     Currently rcu_barrier() uses call_rcu() to enqueue new callbacks
>     on each CPU with a non-empty callback list.  This works, but means
>     that rcu_barrier() forces grace periods that are not otherwise needed.
>     The key point is that rcu_barrier() never needs to wait for a grace
>     period, but instead only for all pre-existing callbacks to be invoked.
>     This means that rcu_barrier()'s new callbacks should be placed in
>     the callback-list segment containing the last pre-existing callback.
>     
>     This commit makes this change using the new rcu_segcblist_entrain()
>     function.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>


