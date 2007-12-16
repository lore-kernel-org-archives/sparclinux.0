From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Sun, 16 Dec 2007 19:10:10 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <200712162010.11028.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20071213024050.7d6e5f3e.akpm@linux-foundation.org> <20071216182720.GZ19691@waste.org> <200712161948.42656.m.kozlowski@tuxland.pl>
In-Reply-To: <200712161948.42656.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

Witam, 

> > > >         cat /proc/kpageflags on sparc64 causes the box to lock.
> > > > I can not write on any terminal - but I can issue sysrqs and switch
> > > > between consoles.
> > > > 
> > > > cat process hangs in read(3, ...
> > > 
> > > cat /proc/kpagecount produces similar symptoms. box is locked - sysrq-w sshd trace:
> > > 
> > > __down
> > > __down_interruptible
> > > kobject_get
> > > lock_kernel
> > > chrdev_open
> > > __dentry_open
> > > nameidata_to_filp
> > > open_pathname
> > > do_sys_open
> > > sparc32_open
> > > linux_sparc_syscall32
> > 
> > Perhaps this is related to sparsemem.
> > 
> > Can you change line 710 of fs/proc/proc_misc.c to:
> > 
> > 	ppage = NULL;
> 
> Sure.
> 
> > ..and see if it still breaks?
> 
> Yes it does - the same way as eariler. Box is locked, processes stuck in D state
> and after a while "BUG: soft lockup - CPU#0 stuck for 11s!".

My mistake. I run cat /proc/kpageflags in the first place - so how could anything change :)

cat /proc/kpagecount on the other hand - with the change in line 710 - locks the box.
Sysrq works, changing consoles works, but there is no "BUG: soft lockup ..." message.
After a while the box becomes totaly unresponsive - even caps lock doesn't work, no
responses to ping.
