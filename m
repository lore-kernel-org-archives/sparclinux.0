From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 16 Aug 2017 12:56:17 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170816125617.GY7017@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170728165529.GF3730@linux.vnet.ibm.com>
 <20170728182053.000072aa@huawei.com>
 <20170728190349.GM3730@linux.vnet.ibm.com>
 <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
In-Reply-To: <87wp63smwn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 16, 2017 at 10:43:52PM +1000, Michael Ellerman wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> ...
> >
> > commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Mon Aug 14 08:54:39 2017 -0700
> >
> >     EXP: Trace tick return from tick_nohz_stop_sched_tick
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index c7a899c5ce64..7358a5073dfb 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
> >  	 * (not only the tick).
> >  	 */
> >  	ts->sleep_length = ktime_sub(dev->next_event, now);
> > +	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_get()) / 1000);
> >  	return tick;
> >  }
> 
> Should I be seeing negative values? A small sample:

Maybe due to hypervisor preemption delays, but I confess that I am
surprised to see them this large.  1,602,250,019 microseconds is something
like a half hour, which could result in stall warnings all by itself.

>           <idle>-0     [015] d...  1602.039695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250019
>           <idle>-0     [009] d...  1602.039701: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250025
>           <idle>-0     [007] d...  1602.039702: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250025
>           <idle>-0     [048] d...  1602.039703: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: 9973
>           <idle>-0     [006] d...  1602.039704: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250027
>           <idle>-0     [001] d...  1602.039730: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250053
>           <idle>-0     [008] d...  1602.039732: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250055
>           <idle>-0     [006] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
>           <idle>-0     [009] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
>           <idle>-0     [001] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
> 
> 
> I have a full trace, I'll send it to you off-list.

I will take a look!

							Thanx, Paul

