From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 15 Aug 2017 15:47:43 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170815154743.GK7017@linux.vnet.ibm.com>
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
In-Reply-To: <20170802172555.0000468a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 02, 2017 at 05:25:55PM +0100, Jonathan Cameron wrote:
> On Tue, 1 Aug 2017 11:46:46 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>=20
> > On Mon, Jul 31, 2017 at 04:27:57PM +0100, Jonathan Cameron wrote:
> > > On Mon, 31 Jul 2017 08:04:11 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >  =20
> > > > On Mon, Jul 31, 2017 at 12:08:47PM +0100, Jonathan Cameron wrote:  =

> > > > > On Fri, 28 Jul 2017 12:03:50 -0700
> > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > >    =20
> > > > > > On Fri, Jul 28, 2017 at 06:27:05PM +0100, Jonathan Cameron wrot=
e:   =20
> > > > > > > On Fri, 28 Jul 2017 09:55:29 -0700
> > > > > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > > > >      =20
> > > > > > > > On Fri, Jul 28, 2017 at 02:24:03PM +0100, Jonathan Cameron =
wrote:     =20
> > > > > > > > > On Fri, 28 Jul 2017 08:44:11 +0100
> > > > > > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:    =
   =20
> > > > > > > >=20
> > > > > > > > [ . . . ]
> > > > > > > >      =20
> > > > > > > > > Ok.  Some info.  I disabled a few driver (usb and SAS) in=
 the interest of having
> > > > > > > > > fewer timer events.  Issue became much easier to trigger =
(on some runs before
> > > > > > > > > I could get tracing up and running)
> > > > > > > > >e
> > > > > > > > > So logs are large enough that pastebin doesn't like them =
- please shoet if       =20
> > > > > > > > >>e another timer period is of interest.       =20
> > > > > > > > >=20
> > > > > > > > > https://pastebin.com/iUZDfQGM for the timer trace.
> > > > > > > > > https://pastebin.com/3w1F7amH for dmesg. =20
> > > > > > > > >=20
> > > > > > > > > The relevant timeout on the RCU stall detector was 8 seco=
nds.  Event is
> > > > > > > > > detected around 835.
> > > > > > > > >=20
> > > > > > > > > It's a lot of logs, so I haven't identified a smoking gun=
 yet but there
> > > > > > > > > may well be one in there.       =20
> > > > > > > >=20
> > > > > > > > The dmesg says:
> > > > > > > >=20
> > > > > > > > rcu_preempt kthread starved for 2508 jiffies! g112 c111 f0x=
0 RCU_GP_WAIT_FQS(3) ->state=3D0x1
> > > > > > > >=20
> > > > > > > > So I look for "rcu_preempt" timer events and find these:
> > > > > > > >=20
> > > > > > > > rcu_preempt-9     [019] ....   827.579114: timer_init: time=
r=FFff8017d5fc7da0
> > > > > > > > rcu_preempt-9     [019] d..1   827.579115: timer_start: tim=
er=FFff8017d5fc7da0 function=3Dprocess_timeout=20
> > > > > > > >=20
> > > > > > > > Next look for "ffff8017d5fc7da0" and I don't find anything =
else.     =20
> > > > > > > It does show up off the bottom of what would fit in pastebin.=
..
> > > > > > >=20
> > > > > > >      rcu_preempt-9     [001] d..1   837.681077: timer_cancel:=
 timer=FFff8017d5fc7da0
> > > > > > >      rcu_preempt-9     [001] ....   837.681086: timer_init: t=
imer=FFff8017d5fc7da0
> > > > > > >      rcu_preempt-9     [001] d..1   837.681087: timer_start: =
timer=FFff8017d5fc7da0 function=3Dprocess_timeout expiresB95101298 [timeout=
=3D1] cpu=3D1 idx=3D0 flags=3D     =20
> > > > > >=20
> > > > > > Odd.  I would expect an expiration...  And ten seconds is way l=
onger
> > > > > > than the requested one jiffy!
> > > > > >    =20
> > > > > > > > The timeout was one jiffy, and more than a second later, no=
 expiration.
> > > > > > > > Is it possible that this event was lost?  I am not seeing a=
ny sign of
> > > > > > > > this is the trace.
> > > > > > > >=20
> > > > > > > > I don't see any sign of CPU hotplug (and I test with lots o=
f that in
> > > > > > > > any case).
> > > > > > > >=20
> > > > > > > > The last time we saw something like this it was a timer HW/=
driver problem,
> > > > > > > > but it is a bit hard to imagine such a problem affecting bo=
th ARM64
> > > > > > > > and SPARC.  ;-)     =20
> > > > > > > Could be different issues, both of which were hidden by that =
lockup detector.
> > > > > > >=20
> > > > > > > There is an errata work around for the timers on this particu=
lar board.
> > > > > > > I'm only vaguely aware of it, so may be unconnected.
> > > > > > >=20
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/drivers/clocksource/arm_arch_timer.c?h=3Dv4.13-rc2&id=BB42ca47=
401010fc02901b5e8f79e40a26f208cb
> > > > > > >=20
> > > > > > > Seems unlikely though! + we've not yet seen it on the other c=
hips that
> > > > > > > errata effects (not that that means much).     =20
> > > > > >=20
> > > > > > If you can reproduce quickly, might be worth trying anyway...
> > > > > >=20
> > > > > > 							Thanx, Paul   =20
> > > > > Errata fix is running already and was for all those tests.   =20
> > > >=20
> > > > I was afraid of that...  ;-) =20
> > > It's a pretty rare errata it seems.  Not actually managed to catch
> > > one yet.  =20
> > > >  =20
> > > > > I'll have a dig into the timers today and see where I get to.    =

> > > >=20
> > > > Look forward to seeing what you find! =20
> > > Nothing obvious turning up other than we don't seem to have issue
> > > when we aren't running hrtimers.
> > >=20
> > > On a plus side I just got a report that it is effecting our d03
> > > boards which is good on the basis I couldn't tell what the difference
> > > could be wrt to this issue!
> > >=20
> > > It indeed looks like we are consistently missing a timer before
> > > the rcu splat occurs. =20
> >=20
> > And for my part, my tests with CONFIG_HZ_PERIODIC=3Dy and
> > CONFIG_RCU_FAST_NO_HZ=3Dn showed roughly the same failure rate
> > as other runs.
> >=20
> > Missing a timer can most certainly give RCU severe heartburn!  ;-)
> > Do you have what you need to track down the missing timer? =20
>=20
> Not managed to make much progress yet.  Turning on any additional tracing
> in that area seems to make the issue stop happening or at least
> occur very infrequently. Which certainly makes it 'fun' to find.
>=20
> As a long shot I applied a locking fix from another reported issue that
> was causing rcu stalls and it seemed good for much longer, but
> eventually still occurred.
>=20
> (from the thread rcu_sched stall while waiting in csd_lock_wait())

On the perhaps unlikely off-chance that it helps locate something,
here is a patch that adds a trace_printk() to check how long a CPU
believes that it can sleep when going idle.  The thought is to check
to see if a CPU with a timer set to expire in one jiffy thinks that
can sleep for (say) 30 seconds.

Didn't find anything for my problem, but I believe that yours is
different, so...

							Thanx, Paul

------------------------------------------------------------------------

commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Aug 14 08:54:39 2017 -0700

    EXP: Trace tick return from tick_nohz_stop_sched_tick
   =20
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c7a899c5ce64..7358a5073dfb 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sc=
hed *ts,
 	 * (not only the tick).
 	 */
 	ts->sleep_length =3D ktime_sub(dev->next_event, now);
+	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_get()) / =
1000);
 	return tick;
 }
=20

