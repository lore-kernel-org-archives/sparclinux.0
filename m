From: David Miller <davem@davemloft.net>
Date: Tue, 25 Jul 2017 21:10:29 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170725.141029.676882447882600000.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170725224245.00004e7e@huawei.com>
 <20170725151245.GO3730@linux.vnet.ibm.com>
 <20170725175207.000001cb@huawei.com>
In-Reply-To: <20170725175207.000001cb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 26 Jul 2017 00:52:07 +0800

> On Tue, 25 Jul 2017 08:12:45 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
>> On Tue, Jul 25, 2017 at 10:42:45PM +0800, Jonathan Cameron wrote:
>> > On Tue, 25 Jul 2017 06:46:26 -0700
>> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>> >   
>> > > On Tue, Jul 25, 2017 at 10:26:54PM +1000, Nicholas Piggin wrote:  
>> > > > On Tue, 25 Jul 2017 19:32:10 +0800
>> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>> > > >     
>> > > > > Hi All,
>> > > > > 
>> > > > > We observed a regression on our d05 boards (but curiously not
>> > > > > the fairly similar but single socket / smaller core count
>> > > > > d03), initially seen with linux-next prior to the merge window
>> > > > > and still present in v4.13-rc2.
>> > > > > 
>> > > > > The symptom is:    
>> > > 
>> > > Adding Dave Miller and the sparclinux@vger.kernel.org email on CC, as
>> > > they have been seeing something similar, and you might well have saved
>> > > them the trouble of bisecting.
>> > > 
>> > > [ . . . ]
>> > >   
>> > > > > [ 1984.628602] rcu_preempt kthread starved for 5663 jiffies! g1566 c1565 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1    
>> > > 
>> > > This is the cause from an RCU perspective.  You had a lot of idle CPUs,
>> > > and RCU is not permitted to disturb them -- the battery-powered embedded
>> > > guys get very annoyed by that sort of thing.  What happens instead is
>> > > that each CPU updates a per-CPU state variable when entering or exiting
>> > > idle, and the grace-period kthread ("rcu_preempt kthread" in the above
>> > > message) checks these state variables, and if when sees an idle CPU,
>> > > it reports a quiescent state on that CPU's behalf.
>> > > 
>> > > But the grace-period kthread can only do this work if it gets a chance
>> > > to run.  And the message above says that this kthread hasn't had a chance
>> > > to run for a full 5,663 jiffies.  For completeness, the "g1566 c1565"
>> > > says that grace period #1566 is in progress, the "f0x0" says that no one
>> > > is needing another grace period #1567.  The "RCU_GP_WAIT_FQS(3)" says
>> > > that the grace-period kthread has fully initialized the current grace
>> > > period and is sleeping for a few jiffies waiting to scan for idle tasks.
>> > > Finally, the "->state=0x1" says that the grace-period kthread is in
>> > > TASK_INTERRUPTIBLE state, in other words, still sleeping.  
>> > 
>> > Thanks for the explanation!  
>> > > 
>> > > So my first question is "What did commit 05a4a9527 (kernel/watchdog:
>> > > split up config options) do to prevent the grace-period kthread from
>> > > getting a chance to run?"   
>> > 
>> > As far as we can tell it was a side effect of that patch.
>> > 
>> > The real cause is that patch changed the result of defconfigs to stop running
>> > the softlockup detector - now CONFIG_SOFTLOCKUP_DETECTOR
>> > 
>> > Enabling that on 4.13-rc2 (and presumably everything in between)
>> > means we don't see the problem any more.
>> >   
>> > > I must confess that I don't see anything
>> > > obvious in that commit, so my second question is "Are we sure that
>> > > reverting this commit makes the problem go away?"  
>> > 
>> > Simply enabling CONFIG_SOFTLOCKUP_DETECTOR seems to make it go away.
>> > That detector fires up a thread on every cpu, which may be relevant.  
>> 
>> Interesting...  Why should it be necessary to fire up a thread on every
>> CPU in order to make sure that RCU's grace-period kthreads get some
>> CPU time?  Especially give how many idle CPUs you had on your system.
>> 
>> So I have to ask if there is some other bug that the softlockup detector
>> is masking.
> I am thinking the same.  We can try going back further than 4.12 tomorrow
> (we think we can realistically go back to 4.8 and possibly 4.6
> with this board)

Just to report, turning softlockup back on fixes things for me on
sparc64 too.

The thing about softlockup is it runs an hrtimer, which seems to run
about every 4 seconds.

So I wonder if this is a NO_HZ problem.
