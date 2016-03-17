From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 17 Mar 2016 19:35:27 +0000
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <20160317123527.6346bce3284509849d061eaa@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <201511271919.aEZuZKNe%fengguang.wu@intel.com>
 <20151127153804.GC2648@pathway.suse.cz>
 <alpine.LNX.2.00.1512020022460.32500@pobox.suse.cz>
 <20151204165744.GD20935@pathway.suse.cz>
In-Reply-To: <20151204165744.GD20935@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 4 Dec 2015 17:57:44 +0100 Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2015-12-02 00:24:49, Jiri Kosina wrote:
> > On Fri, 27 Nov 2015, Petr Mladek wrote:
> > 
> > > MN10300 has its own implementation for entering and exiting NMI 
> > > handlers. It does not call nmi_enter() and nmi_exit(). Please, find 
> > > below an updated patch that adds printk_nmi_enter() and 
> > > printk_nmi_exit() to the custom entry points. Then we could add HAVE_NMI 
> > > to arch/mn10300/Kconfig and avoid the above warning.
> > 
> > Hmm, so what exactly would go wrong if MN10300 (whatever that architecture 
> > is) would call nmi_enter() and nmi_exit() at the places where it's 
> > starting and finishing NMI handler?
> > 
> > >From a cursory look, it seems like most (if not all) of the things called 
> > from nmi_{enter,exit}() would be nops there anyway.
> 
> Good point. Max mentioned in the other main that the NMI handler
> should follow the NMI ruler. I do not why it could not work.
> In fact, it might improve things, e.g. nmi_enter() blocks
> recursive NMIs.
> 
> I think that it will move it into a separate patch, thought.
> 

I've sort of lost the plot on this patchset.

I know Daniel had concerns (resolved?).  Sergey lost the ability to
perform backtraces and has a proposed fix ("printk/nmi: restore
printk_func in nmi_panic") but that wasn't fully resolved and I didn't
merge anything.  I'm not sure what Jan's thinking is on it all.

So... I'll retain 

printk-nmi-generic-solution-for-safe-printk-in-nmi.patch
printk-nmi-use-irq-work-only-when-ready.patch
printk-nmi-warn-when-some-message-has-been-lost-in-nmi-context.patch
printk-nmi-increase-the-size-of-nmi-buffer-and-make-it-configurable.patch

in -mm for now.  Perhaps I should drop them all and we start again
after -rc1?

