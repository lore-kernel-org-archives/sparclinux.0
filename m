From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 21 Oct 2016 03:25:27 +0000
Subject: Re: [PATCH v2 1/2] watchdog: Introduce arch_watchdog_nmi_enable and arch_watchdog_nmi_disable
Message-Id: <20161020202527.b01839356c6d34ed0cba3569@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1476391082-77928-1-git-send-email-babu.moger@oracle.com>
        <1476391082-77928-2-git-send-email-babu.moger@oracle.com>
        <20161019170012.6006d06d9326e62a8059fd08@linux-foundation.org>
        <20161020161414.GE35881@redhat.com>
In-Reply-To: <20161020161414.GE35881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Don Zickus <dzickus@redhat.com>
Cc: Babu Moger <babu.moger@oracle.com>, mingo@kernel.org, ak@linux.intel.com, jkosina@suse.cz, baiyaowei@cmss.chinamobile.com, atomlin@redhat.com, uobergfe@redhat.com, tj@kernel.org, hidehiro.kawai.ez@hitachi.com, johunt@akamai.com, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

On Thu, 20 Oct 2016 12:14:14 -0400 Don Zickus <dzickus@redhat.com> wrote:

> > > -static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
> > > -static void watchdog_nmi_disable(unsigned int cpu) { return; }
> > > +/*
> > > + * These two functions are mostly architecture specific
> > > + * defining them as weak here.
> > > + */
> > > +int __weak arch_watchdog_nmi_enable(unsigned int cpu) { return 0; }
> > > +void __weak arch_watchdog_nmi_disable(unsigned int cpu) { return; }
> > > +
> > >  #endif /* CONFIG_HARDLOCKUP_DETECTOR */
> > 
> > This is a strange way of using __weak.
> > 
> > Take a look at (one of many examples) kernel/module.c:module_alloc(). 
> > We simply provide a default implementation and some other compilation
> > unit can override (actually replace) that at link time.  No strange
> > ifdeffing needed.
> 
> Yeah, this is mostly because of how we enable the hardlockup detector.
> 
> Some arches use the perf hw and enable CONFIG_HARDLOCKUP_DETECTOR.  Other
> arches just use their own variant of nmi and set CONFIG_HAVE_NMI_WATCHDOG and
> the rest of the arches do not use this.
> 
> So the thought was if CONFIG_HARDLOCKUP_DETECTOR use that implementation,
> everyone else use the __weak version.  Then the arches like sparc can override
> the weak version with their own nmi enablement.
> 
> I don't know how to represent those 3 states correctly and the above is what
> we end up with.

<head spins>

Is there a suitable site where we could capture these considerations in
a code comment?
