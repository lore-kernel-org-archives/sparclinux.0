From: Matt Mackall <mpm@selenic.com>
Date: Sun, 16 Dec 2007 18:27:20 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071216182720.GZ19691@waste.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20071213024050.7d6e5f3e.akpm@linux-foundation.org> <200712161114.39437.m.kozlowski@tuxland.pl> <200712161141.50012.m.kozlowski@tuxland.pl> <200712161240.54594.m.kozlowski@tuxland.pl>
In-Reply-To: <200712161240.54594.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Sun, Dec 16, 2007 at 12:40:53PM +0100, Mariusz Kozlowski wrote:
> >         cat /proc/kpageflags on sparc64 causes the box to lock.
> > I can not write on any terminal - but I can issue sysrqs and switch
> > between consoles.
> > 
> > cat process hangs in read(3, ...
> 
> cat /proc/kpagecount produces similar symptoms. box is locked - sysrq-w sshd trace:
> 
> __down
> __down_interruptible
> kobject_get
> lock_kernel
> chrdev_open
> __dentry_open
> nameidata_to_filp
> open_pathname
> do_sys_open
> sparc32_open
> linux_sparc_syscall32

Perhaps this is related to sparsemem.

Can you change line 710 of fs/proc/proc_misc.c to:

	ppage = NULL;

..and see if it still breaks?

-- 
Mathematics is the supreme nostalgia of our time.
