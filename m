From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 16 Aug 2017 01:24:34 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170816022434.00006d11@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170728084411.00001ddb@huawei.com>
 <20170728142403.0000122b@huawei.com>
 <20170728165529.GF3730@linux.vnet.ibm.com>
 <20170728182053.000072aa@huawei.com>
 <20170728190349.GM3730@linux.vnet.ibm.com>
 <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
In-Reply-To: <20170815154743.GK7017@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 15 Aug 2017 08:47:43 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Aug 02, 2017 at 05:25:55PM +0100, Jonathan Cameron wrote:
> > On Tue, 1 Aug 2017 11:46:46 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >  =20
> > > On Mon, Jul 31, 2017 at 04:27:57PM +0100, Jonathan Cameron wrote: =20
> > > > On Mon, 31 Jul 2017 08:04:11 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >    =20
> > > > > On Mon, Jul 31, 2017 at 12:08:47PM +0100, Jonathan Cameron wrote:=
   =20
> > > > > > On Fri, 28 Jul 2017 12:03:50 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > >      =20
> > > > > > > On Fri, Jul 28, 2017 at 06:27:05PM +0100, Jonathan Cameron wr=
ote:     =20
> > > > > > > > On Fri, 28 Jul 2017 09:55:29 -0700
> > > > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > > > >        =20
> > > > > > > > > On Fri, Jul 28, 2017 at 02:24:03PM +0100, Jonathan Camero=
n wrote:       =20
> > > > > > > > > > On Fri, 28 Jul 2017 08:44:11 +0100
> > > > > > > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:  =
       =20
> > > > > > > > >=20
> > > > > > > > > [ . . . ]
> > > > > > > > >        =20
> > > > > > > > > > Ok.  Some info.  I disabled a few driver (usb and SAS) =
in the interest of having
> > > > > > > > > > fewer timer events.  Issue became much easier to trigge=
r (on some runs before
> > > > > > > > > > I could get tracing up and running)
> > > > > > > > > >e
> > > > > > > > > > So logs are large enough that pastebin doesn't like the=
m - please shoet if         =20
> > > > > > > > > >>e another timer period is of interest.         =20
> > > > > > > > > >=20
> > > > > > > > > > https://pastebin.com/iUZDfQGM for the timer trace.
> > > > > > > > > > https://pastebin.com/3w1F7amH for dmesg. =20
> > > > > > > > > >=20
> > > > > > > > > > The relevant timeout on the RCU stall detector was 8 se=
conds.  Event is
> > > > > > > > > > detected around 835.
> > > > > > > > > >=20
> > > > > > > > > > It's a lot of logs, so I haven't identified a smoking g=
un yet but there
> > > > > > > > > > may well be one in there.         =20
> > > > > > > > >=20
> > > > > > > > > The dmesg says:
> > > > > > > > >=20
> > > > > > > > > rcu_preempt kthread starved for 2508 jiffies! g112 c111 f=
0x0 RCU_GP_WAIT_FQS(3) ->state=3D0x1
> > > > > > > > >=20
> > > > > > > > > So I look for "rcu_preempt" timer events and find these:
> > > > > > > > >=20
> > > > > > > > > rcu_preempt-9     [019] ....   827.579114: timer_init: ti=
mer=FFff8017d5fc7da0
> > > > > > > > > rcu_preempt-9     [019] d..1   827.579115: timer_start: t=
imer=FFff8017d5fc7da0 function=3Dprocess_timeout=20
> > > > > > > > >=20
> > > > > > > > > Next look for "ffff8017d5fc7da0" and I don't find anythin=
g else.       =20
> > > > > > > > It does show up off the bottom of what would fit in pastebi=
n...
> > > > > > > >=20
> > > > > > > >      rcu_preempt-9     [001] d..1   837.681077: timer_cance=
l: timer=FFff8017d5fc7da0
> > > > > > > >      rcu_preempt-9     [001] ....   837.681086: timer_init:=
 timer=FFff8017d5fc7da0
> > > > > > > >      rcu_preempt-9     [001] d..1   837.681087: timer_start=
: timer=FFff8017d5fc7da0 function=3Dprocess_timeout expiresB95101298 [timeo=
ut=3D1] cpu=3D1 idx=3D0 flags=3D       =20
> > > > > > >=20
> > > > > > > Odd.  I would expect an expiration...  And ten seconds is way=
 longer
> > > > > > > than the requested one jiffy!
> > > > > > >      =20
> > > > > > > > > The timeout was one jiffy, and more than a second later, =
no expiration.
> > > > > > > > > Is it possible that this event was lost?  I am not seeing=
 any sign of
> > > > > > > > > this is the trace.
> > > > > > > > >=20
> > > > > > > > > I don't see any sign of CPU hotplug (and I test with lots=
 of that in
> > > > > > > > > any case).
> > > > > > > > >=20
> > > > > > > > > The last time we saw something like this it was a timer H=
W/driver problem,
> > > > > > > > > but it is a bit hard to imagine such a problem affecting =
both ARM64
> > > > > > > > > and SPARC.  ;-)       =20
> > > > > > > > Could be different issues, both of which were hidden by tha=
t lockup detector.
> > > > > > > >=20
> > > > > > > > There is an errata work around for the timers on this parti=
cular board.
> > > > > > > > I'm only vaguely aware of it, so may be unconnected.
> > > > > > > >=20
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/drivers/clocksource/arm_arch_timer.c?h=3Dv4.13-rc2&id=BB42ca=
47401010fc02901b5e8f79e40a26f208cb
> > > > > > > >=20
> > > > > > > > Seems unlikely though! + we've not yet seen it on the other=
 chips that
> > > > > > > > errata effects (not that that means much).       =20
> > > > > > >=20
> > > > > > > If you can reproduce quickly, might be worth trying anyway...
> > > > > > >=20
> > > > > > > 							Thanx, Paul     =20
> > > > > > Errata fix is running already and was for all those tests.     =
=20
> > > > >=20
> > > > > I was afraid of that...  ;-)   =20
> > > > It's a pretty rare errata it seems.  Not actually managed to catch
> > > > one yet.    =20
> > > > >    =20
> > > > > > I'll have a dig into the timers today and see where I get to.  =
   =20
> > > > >=20
> > > > > Look forward to seeing what you find!   =20
> > > > Nothing obvious turning up other than we don't seem to have issue
> > > > when we aren't running hrtimers.
> > > >=20
> > > > On a plus side I just got a report that it is effecting our d03
> > > > boards which is good on the basis I couldn't tell what the differen=
ce
> > > > could be wrt to this issue!
> > > >=20
> > > > It indeed looks like we are consistently missing a timer before
> > > > the rcu splat occurs.   =20
> > >=20
> > > And for my part, my tests with CONFIG_HZ_PERIODIC=3Dy and
> > > CONFIG_RCU_FAST_NO_HZ=3Dn showed roughly the same failure rate
> > > as other runs.
> > >=20
> > > Missing a timer can most certainly give RCU severe heartburn!  ;-)
> > > Do you have what you need to track down the missing timer?   =20
> >=20
> > Not managed to make much progress yet.  Turning on any additional traci=
ng
> > in that area seems to make the issue stop happening or at least
> > occur very infrequently. Which certainly makes it 'fun' to find.
> >=20
> > As a long shot I applied a locking fix from another reported issue that
> > was causing rcu stalls and it seemed good for much longer, but
> > eventually still occurred.
> >=20
> > (from the thread rcu_sched stall while waiting in csd_lock_wait()) =20
>=20
> On the perhaps unlikely off-chance that it helps locate something,
> here is a patch that adds a trace_printk() to check how long a CPU
> believes that it can sleep when going idle.  The thought is to check
> to see if a CPU with a timer set to expire in one jiffy thinks that
> can sleep for (say) 30 seconds.
>=20
> Didn't find anything for my problem, but I believe that yours is
> different, so...
>=20
> 							Thanx, Paul

Hi Paul,

Thanks for the suggestion.  I hadn't thought to look at the
expected time being wrong.

I have noted that adding other tracepoints (and turning them on)
in that function cause the problem to 'disappear' though so it
would seem very timing sensitive.  Fingers crossed this doesn't
have the same effect!

Our progress on this has been a bit limited partly as I have been
traveling and haven't sorted out remote hardware access.
May be the start of next week before I can try this out.

Agreed, the problems look to be different.

Interesting question is whether the other known cases fall
into one or the other category?

Thanks for the help and good luck with your variant!

Jonathan
>=20
> ------------------------------------------------------------------------
>=20
> commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Aug 14 08:54:39 2017 -0700
>=20
>     EXP: Trace tick return from tick_nohz_stop_sched_tick
>    =20
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c7a899c5ce64..7358a5073dfb 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_=
sched *ts,
>  	 * (not only the tick).
>  	 */
>  	ts->sleep_length =3D ktime_sub(dev->next_event, now);
> +	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_get()) =
/ 1000);
>  	return tick;
>  }
> =20
>=20

