From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 Sep 2009 22:19:32 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925151932.3bcd5363.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 25 Sep 2009 14:59:47 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Fri, 25 Sep 2009 14:56:18 -0700
> 
> > Dave, could you please send along the config which broke Christoph's
> > patch?  It works OK with allnoconfig and defconfig for me.
> 
> arch/sparc/configs/sparc32_defconfig


OK.

In file included from include/asm-generic/hardirq.h:6,
                 from /usr/src/devel/arch/sparc/include/asm/hardirq_32.h:11,
                 from /usr/src/devel/arch/sparc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:10,
                 from include/linux/interrupt.h:12,
                 from /usr/src/devel/arch/sparc/include/asm/irq_32.h:9,
                 from /usr/src/devel/arch/sparc/include/asm/irq.h:6,
                 from include/linux/nmi.h:8,
                 from kernel/sched.c:31:

How's this fix look?

 arch/sparc/include/asm/irq_32.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/sparc/include/asm/irq_32.h~a arch/sparc/include/asm/irq_32.h
--- a/arch/sparc/include/asm/irq_32.h~a
+++ a/arch/sparc/include/asm/irq_32.h
@@ -6,10 +6,10 @@
 #ifndef _SPARC_IRQ_H
 #define _SPARC_IRQ_H
 
-#include <linux/interrupt.h>
-
 #define NR_IRQS    16
 
+#include <linux/interrupt.h>
+
 #define irq_canonicalize(irq)	(irq)
 
 extern void __init init_IRQ(void);
_
 
