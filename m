From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 25 Jul 2017 02:44:11 +0000
Subject: Re: RCU stall warnings...
Message-Id: <20170725024411.GA27413@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170724.153248.1457902120749226419.davem@davemloft.net>
 <20170724232033.GI3730@linux.vnet.ibm.com>
 <20170724.163458.1860624258080140141.davem@davemloft.net>
 <20170724234927.GK3730@linux.vnet.ibm.com>
In-Reply-To: <20170724234927.GK3730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Jul 24, 2017 at 04:49:27PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 24, 2017 at 04:34:58PM -0700, David Miller wrote:
> > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Date: Mon, 24 Jul 2017 16:20:33 -0700

[ . . . ]
 
> > That would take a while as it's hard to forcibly set this thing off.
> 
> And my similar error can take awhile as well.  But maybe I should try
> forcing nr_cpusC and maxcpus=8 on older versions to see what happens.
> 
> A bisection would of course be quite helpful, depending of course on
> the value of "a while".  ;-)

And if "a while" is too long, one alternative is to enable event tracing
for timers, as in why didn't they wake the grace-period kthread?
For example, it is possible that that kthread set its status (which
was printed out in the "rcu_sched kthread starved" message) but for
whatever reason didn't make it to the swait_event_idle_timeout()
immediately afterwards;

			rsp->gp_state = RCU_GP_WAIT_FQS;
			ret = swait_event_idle_timeout(rsp->gp_wq,
					rcu_gp_fqs_check_wake(rsp, &gf), j);

Or that the timer-based wakeup didn't happen for whatever reason.  Or...

							Thanx, Paul

> > ==========
> > commit f92c734f02cbf10e40569facff82059ae9b61920
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Mon Apr 10 15:40:35 2017 -0700
> > 
> >     rcu: Prevent rcu_barrier() from starting needless grace periods
> >     
> >     Currently rcu_barrier() uses call_rcu() to enqueue new callbacks
> >     on each CPU with a non-empty callback list.  This works, but means
> >     that rcu_barrier() forces grace periods that are not otherwise needed.
> >     The key point is that rcu_barrier() never needs to wait for a grace
> >     period, but instead only for all pre-existing callbacks to be invoked.
> >     This means that rcu_barrier()'s new callbacks should be placed in
> >     the callback-list segment containing the last pre-existing callback.
> >     
> >     This commit makes this change using the new rcu_segcblist_entrain()
> >     function.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> 

