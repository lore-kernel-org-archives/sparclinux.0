From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Sun, 16 Dec 2007 11:40:53 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <200712161240.54594.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20071213024050.7d6e5f3e.akpm@linux-foundation.org> <200712161114.39437.m.kozlowski@tuxland.pl> <200712161141.50012.m.kozlowski@tuxland.pl>
In-Reply-To: <200712161141.50012.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

>         cat /proc/kpageflags on sparc64 causes the box to lock.
> I can not write on any terminal - but I can issue sysrqs and switch
> between consoles.
> 
> cat process hangs in read(3, ...

cat /proc/kpagecount produces similar symptoms. box is locked - sysrq-w sshd trace:

__down
__down_interruptible
kobject_get
lock_kernel
chrdev_open
__dentry_open
nameidata_to_filp
open_pathname
do_sys_open
sparc32_open
linux_sparc_syscall32

then again:

BUG: soft lockup - CPU#0 stuck for 11s! [sshd:3242]
...
TPC: spitfire_xcall_helper+0xa0/0x100
...
RPC: spitfire_xcall_helper+0xac/0x100
...
I7: flush_dcache_page_all+0x1a4/0x1e0

or:

BUG: soft lockup - CPU#0 stuck for 11s! [sshd:3242]
...
TPC: tick_get_tick+0xc/0x20
...
RPC: __handle_softirq_continue+0x20/0x24
...
I7: __delay+0x2c/0x60

Box is unusable. Easy to reproduce - every time.

Regards,

	Mariusz
