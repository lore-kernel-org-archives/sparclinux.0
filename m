From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 12 May 2009 19:46:32 +0000
Subject: Re: [PATCH] sparc64: fix and optimize irq distribution
Message-Id: <20090512194632.GA11335@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
In-Reply-To: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Hong.

On Tue, May 12, 2009 at 03:29:49PM -0400, Hong H. Pham wrote:
> irq_choose_cpu() should compare the affinity mask against cpu_online_map
> rather than CPU_MASK_ALL, since irq_select_affinity() sets the interrupt's
> affinity mask to cpu_online_map "and" CPU_MASK_ALL (which ends up being
> just cpu_online_map).  The mask comparison in irq_choose_cpu() will always
> fail since the two masks are not the same.  So the CPU chosen is the first CPU
> in the intersection of cpu_online_map and CPU_MASK_ALL, which is always CPU0.
> That means all interrupts are reassigned to CPU0...
> 
> Distributing interrupts to CPUs in a linearly increasing round robin fashion
> is not optimal for the UltraSPARC T1/T2.  Also, the irq_rover in
> irq_choose_cpu() causes an interrupt to be assigned to a different
> processor each time the interrupt is allocated and released.  This may lead
> to an unbalanced distribution over time.
> 
> A static mapping of interrupts to processors is done to optimize and balance
> interrupt distribution.  For the T1/T2, interrupts are spread to different
> cores first, and then to strands within a core.
> 

Please include the nice benchmark numbers in the changelog.
It is good to know the effect of a patch and how to measure it.


> Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
> ---
>  arch/sparc/kernel/Makefile |    1 +
>  arch/sparc/kernel/cpumap.c |  113 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/cpumap.h |   15 ++++++
>  arch/sparc/kernel/irq_64.c |   29 ++----------
>  arch/sparc/kernel/smp_64.c |    2 +
>  5 files changed, 135 insertions(+), 25 deletions(-)
>  create mode 100644 arch/sparc/kernel/cpumap.c
>  create mode 100644 arch/sparc/kernel/cpumap.h
> 
> diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
> index 54742e5..4e217a4 100644
> --- a/arch/sparc/kernel/Makefile
> +++ b/arch/sparc/kernel/Makefile
> @@ -53,8 +53,9 @@ obj-$(CONFIG_SPARC64)   += hvapi.o
>  obj-$(CONFIG_SPARC64)   += sstate.o
>  obj-$(CONFIG_SPARC64)   += mdesc.o
>  obj-$(CONFIG_SPARC64)	+= pcr.o
>  obj-$(CONFIG_SPARC64)	+= nmi.o
> +obj-$(CONFIG_SPARC64)	+= cpumap.o
If you use:
obj-$(CONFIG_SPARC64_SMP)   += cpumap.o
then


>  
>  # sparc32 do not use GENERIC_HARDIRQS but uses the generic devres implementation
>  obj-$(CONFIG_SPARC32)     += devres.o
>  devres-y                  := ../../../kernel/irq/devres.o
> diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
> new file mode 100644
> index 0000000..d539f2f
> --- /dev/null
> +++ b/arch/sparc/kernel/cpumap.c
> @@ -0,0 +1,113 @@
> +/* cpumap.c: used for optimizing CPU assignment
> + *
> + * Copyright (C) 2009 Hong H. Pham <hong.pham@windriver.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/cpumask.h>
> +#include <linux/spinlock.h>
> +#include "cpumap.h"
> +
> +
> +#ifdef CONFIG_SMP

you can drop this ifdef.

	Sam
