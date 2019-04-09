From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 09 Apr 2019 02:05:30 +0000
Subject: Re: [RFC PATCH v2 09/14] watchdog/hardlockup: Make arch_touch_nmi_watchdog() to hpet-based implement
Message-Id: <20190409020530.GA7197@ranerica-svr.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20190227161758.GE4072@linux.ibm.com>
 <20190301011713.GA8058@ranerica-svr.sc.intel.com>
 <alpine.DEB.2.21.1903262219100.1789@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903262219100.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>, x86@kernel.org, David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>, Byungchul Park <byungchul.park@lge.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Tue, Mar 26, 2019 at 10:20:41PM +0100, Thomas Gleixner wrote:
> On Thu, 28 Feb 2019, Ricardo Neri wrote:
> > > > 
> > > > -#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > > > +#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF) || \
> > > > +    defined(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET)
> > > 
> > > Why not instead make CONFIG_X86_HARDLOCKUP_DETECTOR_HPET select
> > > CONFIG_HARDLOCKUP_DETECTOR_PERF?  Keep the arch-specific details
> > > in the arch-specific files and all that.
> > 
> > Thanks for your feedback, Paul! The HPET implementation does not use
> > perf. Thus, in my opinion is not correct for the HPET HLD to select
> > the perf implementation. Patch 8 of this series splits the perf-specific
> > code and the generic hardlockup detector code. Does this make sense?
> 
> That's what intermediate config symbols are for.
> 
> config HARDLOCKUP_DETECTOR_CORE
>        bool
> 
> And make both PERF and HPET select it.

I'll implement it in this manner.

Thanks and BR,
Ricardo
