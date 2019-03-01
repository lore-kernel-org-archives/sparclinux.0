From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 01 Mar 2019 01:17:13 +0000
Subject: Re: [RFC PATCH v2 09/14] watchdog/hardlockup: Make arch_touch_nmi_watchdog() to hpet-based implement
Message-Id: <20190301011713.GA8058@ranerica-svr.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1551283518-18922-10-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20190227161758.GE4072@linux.ibm.com>
In-Reply-To: <20190227161758.GE4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Christoffer Dall <cdall@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Ashok Raj <ashok.raj@intel.com>, x86@kernel.org, David Rientjes <rientjes@google.com>, Andi Kleen <andi.kleen@intel.com>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Ricardo Neri <ricardo.neri@intel.com>, Byungchul Park <byungchul.park@lge.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Colin Ian King <colin.king@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 27, 2019 at 08:17:58AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 27, 2019 at 08:05:13AM -0800, Ricardo Neri wrote:
> > CPU architectures that have an NMI watchdog use arch_touch_nmi_watchdog()
> > to briefly ignore the hardlockup detector. If the architecture does not
> > have an NMI watchdog, one can be constructed using a source of non-
> > maskable interrupts. In this case, arch_touch_nmi_watchdog() is common
> > to any underlying hardware resource used to drive the detector and needs
> > to be available to other kernel subsystems if hardware different from perf
> > drives the detector.
> > 
> > There exists perf-based and HPET-based implementations. Make it available
> > to the latter.
> > 
> > For clarity, wrap this function in a separate preprocessor conditional
> > from functions which are truly specific to the perf-based implementation.
> > 
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Andi Kleen <andi.kleen@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Don Zickus <dzickus@redhat.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Babu Moger <babu.moger@oracle.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Colin Ian King <colin.king@canonical.com>
> > Cc: Byungchul Park <byungchul.park@lge.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Christoffer Dall <cdall@linaro.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: x86@kernel.org
> > Cc: sparclinux@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  include/linux/nmi.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > index 5a8b19749769..bf5ebcfdd590 100644
> > --- a/include/linux/nmi.h
> > +++ b/include/linux/nmi.h
> > @@ -94,8 +94,16 @@ static inline void hardlockup_detector_disable(void) {}
> >  # define NMI_WATCHDOG_SYSCTL_PERM	0444
> >  #endif
> > 
> > -#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > +#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF) || \
> > +    defined(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET)
> 
> Why not instead make CONFIG_X86_HARDLOCKUP_DETECTOR_HPET select
> CONFIG_HARDLOCKUP_DETECTOR_PERF?  Keep the arch-specific details
> in the arch-specific files and all that.

Thanks for your feedback, Paul! The HPET implementation does not use
perf. Thus, in my opinion is not correct for the HPET HLD to select
the perf implementation. Patch 8 of this series splits the perf-specific
code and the generic hardlockup detector code. Does this make sense?

Thanks and BR,
Ricardo
