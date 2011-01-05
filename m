From: David Miller <davem@davemloft.net>
Date: Wed, 05 Jan 2011 21:27:20 +0000
Subject: Re: LEON SMP
Message-Id: <20110105.132720.246519356.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4CC714EC.2050001@gaisler.com>
In-Reply-To: <4CC714EC.2050001@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 05 Jan 2011 11:20:19 +0100

> I tried looking a sun4d and sun4m to get an example of how to
> implement this in a better way, however they seem to implement the
> per-cpu ticker using hardcoded IRQ number 14 and a custom trap handler
> for the per-cpu timer ticker (see bottom of kernel/sun4m_irq.c:
> sun4m_init_timers()). The system clock is implemented using the
> time-tick at IRQ10. I'm not sure why the time-tick timer is used at
> all, unless the hardware requires it (the per-cpu timer perhaps can
> not get the time or limits HZ).

sun4c, sun4d, and sun4m have two timer sources that deliver interrupts
on level 10 and level 14 and these mappings are not changable.

The level 10 one is a global interrupt which can target one cpu,
whereas the level 14 one can be used in a per-cpu manner and is
usually referred to as the profiling timer.

Therefore there is one count/limit register pair for the level 10
timer, and NR_CPUS pairs of count/limit registers for level 14.

The best thing to do is the use only the level 14 timer, and register
is as a clockevent with the generic code.

Then you won't have to deal with any details like which cpu to invoke
the scheduler tick on, etc.  It'll all be taken care of for you.

Something like:

static struct clock_event_device sparc32_clockevent = {
	.features	= CLOCK_EVT_FEAT_ONESHOT,
	.set_mode	= sparc32_timer_setup,
	.set_next_event	= sparc32_next_event,
	.rating		= 100,
	.shift		= 30,
	.irq		= -1,
};
static DEFINE_PER_CPU(struct clock_event_device, sparc32_events);

You implement sparc32_timer_setup, which will look something like:

static void sparc32_timer_setup(enum clock_event_mode mode,
				struct clock_event_device *evt)
{
	switch (mode) {
	case CLOCK_EVT_MODE_ONESHOT:
	case CLOCK_EVT_MODE_RESUME:
		break;

	case CLOCK_EVT_MODE_SHUTDOWN:
		disable_level14_timer();
		break;

	case CLOCK_EVT_MODE_PERIODIC:
	case CLOCK_EVT_MODE_UNUSED:
		WARN_ON(1);
		break;
	};
}


and sparc32_next_event, which advances the limit register to the
next interrupt count.

static int sparc64_next_event(unsigned long delta,
			      struct clock_event_device *evt)
{
	unsigned long orig_count, new_count, new_limit;

	orig_count = sparc32_read_level14_count();
	new_limit = orig_count + delta;

	sparc32_write_level14_limit(new_limit);

	new_count = sparc32_read_level14_count();

	/* If the new limit has been passed already, let the caller
	 * know.
	 */
	if (((long)(new_count - (orig_count + delta))) > 0L)
		return -ETIME;

	return 0;
}

The level 14 timer interrupt should go:

	int cpu = smp_processor_id();
	struct clock_event_device *evt = &per_cpu(sparc32_events, cpu);
 ...
	if (unlikely(!evt->event_handler)) {
		printk(KERN_WARNING
		       "Spurious SPARC32 timer interrupt on cpu %d\n", cpu);
	} else
		evt->event_handler(evt);
 ...


Finally, on bootup and on each cpu, initialize (but do not start) the
level 14 timer and then go:

	struct clock_event_device *sevt;
	sevt = &__get_cpu_var(sparc32_events);

	memcpy(sevt, &sparc32_clockevent, sizeof(*sevt));
	sevt->cpumask = cpumask_of(smp_processor_id());

	clockevents_register_device(sevt);

The clockevents system will make ->next_event() calls on this
clockevents device to start the timers firing.

