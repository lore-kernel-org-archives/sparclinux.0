From: Nicolai Stange <nicstange@gmail.com>
Date: Thu, 30 Mar 2017 19:56:47 +0000
Subject: [PATCH] sparc/time: set ->min_delta_ticks and ->max_delta_ticks
Message-Id: <20170330195647.7668-1-nicstange@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170326134403.16226-1-nicstange@gmail.com>
In-Reply-To: <20170326134403.16226-1-nicstange@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, sparclinux@vger.kernel.org

In preparation for making the clockevents core NTP correction aware,
all clockevent device drivers must set ->min_delta_ticks and
->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
clockevent device's rate is going to change dynamically and thus, the
ratio of ns to ticks ceases to stay invariant.

Make the sparc arch's clockevent drivers initialize these fields properly.

This patch alone doesn't introduce any change in functionality as the
clockevents core still looks exclusively at the (untouched) ->min_delta_ns
and ->max_delta_ns. As soon as this has changed, a followup patch will
purge the initialization of ->min_delta_ns and ->max_delta_ns from these
drivers.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---

Notes:
    This prerequisite patch is part of a larger effort to feed NTP
    corrections into the clockevent devices' frequencies and thus
    avoiding their notion of time to diverge from the system's
    one. If you're interested, the current state of the whole series
    can be found at [1].
    
    If you haven't got any objections and these prerequisites get
    merged by 4.12 everywhere, I'll proceed with the remainder of
    this series in 4.13.
    
    Applicable to next-20170324 as well as to John' Stultz tree [2].
    
    [1]
      git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
      https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
    
    [2]
      https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time

 arch/sparc/kernel/time_32.c | 2 ++
 arch/sparc/kernel/time_64.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 244062bdaa56..9f575dfc2e41 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -228,7 +228,9 @@ void register_percpu_ce(int cpu)
 	ce->mult           = div_sc(sparc_config.clock_rate, NSEC_PER_SEC,
 	                            ce->shift);
 	ce->max_delta_ns   = clockevent_delta2ns(sparc_config.clock_rate, ce);
+	ce->max_delta_ticks = (unsigned long)sparc_config.clock_rate;
 	ce->min_delta_ns   = clockevent_delta2ns(100, ce);
+	ce->min_delta_ticks = 100;
 
 	clockevents_register_device(ce);
 }
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 12a6d3555cb8..98d05de8da66 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -796,8 +796,10 @@ void __init time_init(void)
 
 	sparc64_clockevent.max_delta_ns  		clockevent_delta2ns(0x7fffffffffffffffUL, &sparc64_clockevent);
+	sparc64_clockevent.max_delta_ticks = 0x7fffffffffffffffUL;
 	sparc64_clockevent.min_delta_ns  		clockevent_delta2ns(0xF, &sparc64_clockevent);
+	sparc64_clockevent.min_delta_ticks = 0xF;
 
 	printk("clockevent: mult[%x] shift[%d]\n",
 	       sparc64_clockevent.mult, sparc64_clockevent.shift);
-- 
2.12.0

