From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 17 Aug 2017 13:55:51 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <877ey2b8ns.fsf@concordia.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20170728182053.000072aa@huawei.com>
 <20170728190349.GM3730@linux.vnet.ibm.com>
 <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
 <20170816125617.GY7017@linux.vnet.ibm.com>
 <20170816162731.GA22978@linux.vnet.ibm.com>
In-Reply-To: <20170816162731.GA22978@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

> On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
>> On Wed, Aug 16, 2017 at 10:43:52PM +1000, Michael Ellerman wrote:
>> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
>> > ...
>> > >
>> > > commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
>> > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > > Date:   Mon Aug 14 08:54:39 2017 -0700
>> > >
>> > >     EXP: Trace tick return from tick_nohz_stop_sched_tick
>> > >    =20
>> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > >
>> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> > > index c7a899c5ce64..7358a5073dfb 100644
>> > > --- a/kernel/time/tick-sched.c
>> > > +++ b/kernel/time/tick-sched.c
>> > > @@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct =
tick_sched *ts,
>> > >  	 * (not only the tick).
>> > >  	 */
>> > >  	ts->sleep_length =3D ktime_sub(dev->next_event, now);
>> > > +	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_ge=
t()) / 1000);
>> > >  	return tick;
>> > >  }
>> >=20
>> > Should I be seeing negative values? A small sample:
>>=20
>> Maybe due to hypervisor preemption delays, but I confess that I am
>> surprised to see them this large.  1,602,250,019 microseconds is somethi=
ng
>> like a half hour, which could result in stall warnings all by itself.

Hmm. This is a bare metal machine. So no hypervisor.

>> I will take a look!
>
> And from your ps output, PID 9 is rcu_sched, which is the RCU grace-period
> kthread that stalled.  This kthread was starved, based on this from your
> dmesg:
>
> [ 1602.067008] rcu_sched kthread starved for 2603 jiffies! g7275 c7274 f0=
x0 RCU_GP_WAIT_FQS(3) ->state=3D0x1
>
> The RCU_GP_WAIT_FQS says that this kthread is periodically scanning for
> idle-CPU and offline-CPU quiescent states, which means that its waits
> will be accompanied by short timeouts.  The "starved for 2603 jiffies"
> says that it has not run for one good long time.  The ->state is its
> task_struct ->state field.
>
> The immediately preceding dmesg line is as follows:
>
> [ 1602.063851]  (detected by 53, t&03 jiffies, gr75, cr74, q`8)
>
> In other words, the rcu_sched grace-period kthread has been starved
> for the entire duration of the current grace period, as shown by the
> t&03.
>
> Lets turn now to the trace output, looking for the last bit of the
> rcu_sched task's activity:
>
>        rcu_sched-9     [054] d...  1576.030096: timer_start: timer=C00000=
07fae1bc20 function=3Dprocess_timeout expiresB95094922 [timeout=3D1] cpuT i=
dx=3D0 flags>     ksoftirqd/53-276   [053] ..s.  1576.030097: rcu_invoke_ca=
llback: rcu_sched rhp=C000000fcf8c4eb0 func=3D__d_free
>        rcu_sched-9     [054] d...  1576.030097: rcu_utilization: Start co=
ntext switch
>     ksoftirqd/53-276   [053] ..s.  1576.030098: rcu_invoke_callback: rcu_=
sched rhp=C000000fcff74ee0 func=3Dproc_i_callback
>        rcu_sched-9     [054] d...  1576.030098: rcu_grace_period: rcu_sch=
ed 7275 cpuqs
>        rcu_sched-9     [054] d...  1576.030099: rcu_utilization: End cont=
ext switch
>
> So this task set up a timer ("timer_start:") for one jiffy ("[timeout=3D1=
]",
> but what is with "expiresB95094922"?)

That's a good one.

I have HZ=100, and therefore:

INITIAL_JIFFIES =3D (1 << 32) - (300 * 100) =3D 4294937296

So the expires value of 4295094922 is:

4295094922 - 4294937296 =3D 157626

Jiffies since boot.

Or 1576,260,000,000 ns =3D 1576.26 s.

> Of course, the timer will have expired in the context of some other task,
> but a search for "c0000007fae1bc20" (see the "timer=3D" in the first trace
> line above) shows nothing (to be painfully accurate, the search wraps back
> to earlier uses of this timer by rcu_sched).  So the timer never did fire.

Or it just wasn't in the trace ?

I'll try and get it to trace a bit longer and see if that is helpful.

cheers
