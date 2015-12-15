From: Petr Mladek <pmladek@suse.com>
Date: Tue, 15 Dec 2015 14:26:21 +0000
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and make it configurable
Message-Id: <20151215142621.GE3729@pathway.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <20151211153054.48da5d4139b93dd4ed438f4c@linux-foundation.org>
In-Reply-To: <20151211153054.48da5d4139b93dd4ed438f4c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 2015-12-11 15:30:54, Andrew Morton wrote:
> On Fri, 11 Dec 2015 23:21:13 +0000 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Fri, Dec 11, 2015 at 02:57:25PM -0800, Andrew Morton wrote:
> > > This is a bit messy.  NEED_PRINTK_NMI is an added-on hack for one
> > > particular arm variant.  From the changelog:
> > > 
> > >    "One exception is arm where the deferred printing is used for
> > >     printing backtraces even without NMI.  For this purpose, we define
> > >     NEED_PRINTK_NMI Kconfig flag.  The alternative printk_func is
> > >     explicitly set when IPI_CPU_BACKTRACE is handled."
> > > 
> > > 
> > > - why does arm needs deferred printing for backtraces?
> > > 
> > > - why is this specific to CONFIG_CPU_V7M?



> > > - can this Kconfig logic be cleaned up a bit?
> > 
> > I think this comes purely from this attempt to apply another round of
> > cleanups to the nmi backtrace work I did.
> > 
> > As I explained when I did that work, the vast majority of ARM platforms
> > are unable to trigger anything like a NMI - the FIQ is something that's
> > generally a property of the secure monitor, and is not accessible to
> > Linux.  However, there are platforms where it is accessible.
> 
> OK, thanks.  So "not needed at present, might be needed in the future,
> useful for out-of-tree debug code"?

It is possible that I got it a wrong way on arm. The NMI buffer is
usable there on two locations.

First, the temporary is currently used to handle IPI_CPU_BACKTRACE.
It seems that it is not a real NMI. But it seems to be available
(compiled) on all arm system. This is why I introduced NEED_PRINTK_NMI
Kconfig flag to avoid confusion with a real NMI.

Second, there is the FIQ "NMI" handler that is called from
/arch/arm/kernel/entry-armv.S. It is compiled only if _not_
defined $(CONFIG_CPU_V7M). It calls nmi_enter() and nmi_stop().
It looks like a real NMI handler. This is why I defined HAVE_NMI
if (!CPU_V7M).

A solution would be to define HAVE_NMI on all Arm systems and get rid
of NEED_PRINTK_NMI. If you think that it would cause less confusion...


> > there's this effort to apply further cleanups - to me, the changelogs
> > don't seem to make that much sense, unless we want to start using
> > printk() extensively in NMI functions - using the generic nmi backtrace
> > code surely gets us something that works across all architectures...
> 
> Yes, I was scratching my head over that.  The patchset takes an nmi-safe
> all-cpu-backtrace and generalises that into an nmi-safe printk.  That
> *sounds* like a good thing to do but yes, some additional justification
> would be helpful.  What real-world value does this patchset really
> bring to real-world users?

The patchset brings two big advantages. First, it makes the NMI
backtraces safe on all architectures for free. Second, it makes
all NMI messages almost[*] safe on all architectures.

Note that there already are several messages printed in NMI context.
See the mail from Jiri Kosina. They are not easy to avoid.

[*] The temporary buffer is limited. We still should keep
the number of messages in NMI context at minimum.

Best Regards,
Petr
