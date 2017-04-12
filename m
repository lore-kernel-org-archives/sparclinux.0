From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 12 Apr 2017 17:55:35 +0000
Subject: Re: [PATCH v2 0/4] Improved logging
Message-Id: <e2849e48-1167-84aa-9648-5e2c356aacf7@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1489423479-654395-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1489423479-654395-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> You really need to generalize this, so that it doesn't only just work
> with the hypervisor console, but rather with any console device we
> support whatsoever.
> 
> I bet if you did that, the hook wouldn't even be needed.
> 
> If you need to keep the hook, you have to declare it in some common
> kernel header file.  If you built with extra warnings or with sparse
> it would have warned about this (globally visible function with no
> previous declaration seen).
> 

Hi Dave,

Thank you for the review, I will fix the missing declaration.

I have thought about this new hook problem, and do not really see a 
clean way to do what plat_unregister_bootcon() is doing in the common code.

The main reason is that this function is doing very SPARC specific 
checking of where OpenBoot (boot console) is outputing, and if the 
device matches the virtual-console, only than we are waiting for ttyHV 
to replace the boot console.

We could add a new console flag, and move the logic from 
plat_unregister_bootcon() into ttyHV, but that would add unnecessary 
OpenBoot code into ttyHV driver. It is really, better to keep it in the 
sparc startup code instead.

Also, it appears, that boot to normal console switch works well for all 
other platforms, and only on sun4v sparc where we have this extra 
hypervisor console which is loaded later in boot we have this 
duplicating messages, and dead time problems.

---

Unrelated to the above problem, but related to this patchset:

As part of [v2,1/4] sparc64: initialize time early, I am also thinking 
to add timer_offset, so sched_clock() would start from 0, as it does on 
most of other platforms.

It means one extra load on every sched_clock() call, we would still be 
far better, than what x86 is doing on every sched_clock().

If you are concerned about this extra load, I could mitigate it on newer 
platforms by adding a static branch for cases where stick increments 
every nanosecond, defined in Oracle SPARC Architecture 2011.

sched_clock() would look something like this:

unsigned long long sched_clock(void)
{

         if (static_branch_likely(&__nanosec_stick)) {
		return stick_get_tick() - timer_offset;
	} else {
		unsigned long ticks = tick_ops->get_tick();

		return ((ticks * timer_ticks_per_nsec_quotient)
			>> SPARC64_NSEC_PER_CYC_SHIFT) - timer_offset;
	}
}

This would save function pointer load, multiplication, and also 
timer_ticks_per_nsec_quotient load. Initially __nanosec_stick would be 
false, so early time stamps would work, but later during clock_init() 
changed to true if freq = 1Ghz, and get_tick = stick_get_tick().

Also, should not we replace shift and multiplication with:
mul_u64_u32_shr(ticks, timer_ticks_per_nsec_quotient,
SPARC64_NSEC_PER_CYC_SHIFT); to avoid possible overflow? I could do that 
as well.

Thank you,
Pasha
