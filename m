From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 13 Feb 2008 13:12:26 +0000
Subject: Re: [GIT]: Make LMB code sharable with sparc64.
Message-Id: <D846801F-AA6B-4238-9FA4-A712EABFE800@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080213.004120.22092044.davem@davemloft.net>
In-Reply-To: <20080213.004120.22092044.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org


On Feb 13, 2008, at 2:41 AM, David Miller wrote:

>
> As I mentioned to a few ppc folks at LCA08 I plan to use
> the LMB code from powerpc as a basis for NUMA support on
> sparc64.
>
> There are two changes.
>
> 1) Move arch/powerpc/mm/lmb.c to lib/lmb.c, put the main
>   interface bits in include/linux/lmb.h, put arch-specific
>   bits in asm/lmb.h and add Kconfig machinery to build this
>   stuff on sparc64.
>
> 2) Fix a bug in lmb_alloc() wherein the size was not aligned
>   so we could easily run out of reserve blocks because
>   every aligned allocation would create a tiny hole, and
>   secondly the lmb_reserve() call there did not have it's
>   return value checked.
>
> Powerpc folks, if there are no objections please pull, thanks!
>
> The following changes since commit  
> 96b5a46e2a72dc1829370c87053e0cd558d58bc0:
>  Linus Torvalds (1):
>        WMI: initialize wmi_blocks.list even if ACPI is disabled
>
> are available in the git repository at:
>
>  master.kernel.org:/pub/scm/linux/kernel/git/davem/lmb-2.6.git master
>
> David S. Miller (2):
>      [LIB]: Make PowerPC LMB code generic so sparc64 can use it too.
>      [LMB]: Fix bug in __lmb_alloc_base().

Does sparc have the concept of a phys_addr_t?  We are in the process  
of expanding the lmb support to deal with 36-bit physical addresses on  
32-bit machines.

- k
