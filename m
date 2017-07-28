From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Fri, 28 Jul 2017 17:27:05 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170728182053.000072aa@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170726231505.GG3730@linux.vnet.ibm.com>
 <20170726.162200.1904949371593276937.davem@davemloft.net>
 <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728142403.0000122b@huawei.com>
 <20170728165529.GF3730@linux.vnet.ibm.com>
In-Reply-To: <20170728165529.GF3730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, 28 Jul 2017 09:55:29 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Fri, Jul 28, 2017 at 02:24:03PM +0100, Jonathan Cameron wrote:
> > On Fri, 28 Jul 2017 08:44:11 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote: =20
>=20
> [ . . . ]
>=20
> > Ok.  Some info.  I disabled a few driver (usb and SAS) in the interest =
of having
> > fewer timer events.  Issue became much easier to trigger (on some runs =
before
> > I could get tracing up and running)
> >e
> > So logs are large enough that pastebin doesn't like them - please shoet=
 if =20
> >>e another timer period is of interest. =20
> >=20
> > https://pastebin.com/iUZDfQGM for the timer trace.
> > https://pastebin.com/3w1F7amH for dmesg. =20
> >=20
> > The relevant timeout on the RCU stall detector was 8 seconds.  Event is
> > detected around 835.
> >=20
> > It's a lot of logs, so I haven't identified a smoking gun yet but there
> > may well be one in there. =20
>=20
> The dmesg says:
>=20
> rcu_preempt kthread starved for 2508 jiffies! g112 c111 f0x0 RCU_GP_WAIT_=
FQS(3) ->state=3D0x1
>=20
> So I look for "rcu_preempt" timer events and find these:
>=20
> rcu_preempt-9     [019] ....   827.579114: timer_init: timer=FFff8017d5fc=
7da0
> rcu_preempt-9     [019] d..1   827.579115: timer_start: timer=FFff8017d5f=
c7da0 function=3Dprocess_timeout=20
>=20
> Next look for "ffff8017d5fc7da0" and I don't find anything else.
It does show up off the bottom of what would fit in pastebin...

     rcu_preempt-9     [001] d..1   837.681077: timer_cancel: timer=FFff801=
7d5fc7da0
     rcu_preempt-9     [001] ....   837.681086: timer_init: timer=FFff8017d=
5fc7da0
     rcu_preempt-9     [001] d..1   837.681087: timer_start: timer=FFff8017=
d5fc7da0 function=3Dprocess_timeout expiresB95101298 [timeout=3D1] cpu=3D1 =
idx=3D0 flags
> The timeout was one jiffy, and more than a second later, no expiration.
> Is it possible that this event was lost?  I am not seeing any sign of
> this is the trace.
>=20
> I don't see any sign of CPU hotplug (and I test with lots of that in
> any case).
>=20
> The last time we saw something like this it was a timer HW/driver problem,
> but it is a bit hard to imagine such a problem affecting both ARM64
> and SPARC.  ;-)
Could be different issues, both of which were hidden by that lockup detecto=
r.

There is an errata work around for the timers on this particular board.
I'm only vaguely aware of it, so may be unconnected.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/clocksource/arm_arch_timer.c?h=3Dv4.13-rc2&id=BB42ca47401010fc02901b=
5e8f79e40a26f208cb

Seems unlikely though! + we've not yet seen it on the other chips that
errata effects (not that that means much).

Jonathan

>=20
> Thomas, any debugging suggestions?
>=20
> 							Thanx, Paul
>=20

