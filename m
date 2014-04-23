From: Don Zickus <dzickus@redhat.com>
Date: Wed, 23 Apr 2014 20:44:11 +0000
Subject: Re: [PATCH 0/4 V3] Print traces on softlockup
Message-Id: <20140423204411.GB8488@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1398179848-197479-1-git-send-email-dzickus@redhat.com>
 <20140422112828.ea511cefa17affb99d9aa97f@linux-foundation.org>
 <20140423192228.GY8488@redhat.com>
 <20140423123550.1818553bcdff3ef058efd3f7@linux-foundation.org>
In-Reply-To: <20140423123550.1818553bcdff3ef058efd3f7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, mguzik@redhat.com

On Wed, Apr 23, 2014 at 12:35:50PM -0700, Andrew Morton wrote:
> On Wed, 23 Apr 2014 15:22:28 -0400 Don Zickus <dzickus@redhat.com> wrote:
> 
> > On Tue, Apr 22, 2014 at 11:28:28AM -0700, Andrew Morton wrote:
> > > On Tue, 22 Apr 2014 11:17:24 -0400 Don Zickus <dzickus@redhat.com> wrote:
> > > 
> > > > Added more patches to handle the 'uniprocessor' panic case by sending NMIs
> > > > to every cpu but self.  Only affects x86, sparc.
> > > > 
> > > 
> > > Looks OK to me.  A couple of things:
> > > 
> > > - Patches 1-3 should be combined so we don't create bisection holes
> > >   due to x86 and sparc build errors.
> > > 
> > > - Patch 4 adds stuff which is unusable on uniprocessor, especially
> > >   the presence of /proc/sys/kernel/softlockup_all_cpu_backtrace.  We
> > >   already have #ifdef CONFIG_SMP in kern_table, so do more of that?
> > 
> > Are you suggesting just add CONFIG_SMP to kern_table entry or all the
> > pieces in kernel/watchdog.c too?  I wasn't sure how messy I should make
> > this patch.
> 
> Well, don't go nuts and be tasteful. 
> 
> /proc/sys/kernel/softlockup_all_cpu_backtrace should disappear.
> 
> Look around for existing #ifdef CONFIG_SMP blocks to use.
> 
> Making sysctl_softlockup_all_cpu_backtrace evaluate to literal zero
> will cause the compiler to remove unused code without ifdefs.  This
> might require that watchdog_timer_fn:softlockup_all_cpu_backtrace (why
> does this local exist btw) be declared const - check the compiler

The local exists because it was pointed out in a private review that there
could be a race in which the sysctl value might change in the middle of
the execution of a softlockup.  This would result in a permanently disable
softlockup_all_cpu_backtrace because the flag would never be cleared.

Hence the snapshot of the local copy to prevent that race.

I posted an update of the patchset.

Cheers,
Don
