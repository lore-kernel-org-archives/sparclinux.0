From: john stultz <johnstul@us.ibm.com>
Date: Wed, 13 Jan 2010 02:00:57 +0000
Subject: Re: [patch 1/1] sparc: convert to arch_gettimeoffset()
Message-Id: <1263348057.2306.26.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <200912220028.nBM0S5uX005437@imap1.linux-foundation.org>
In-Reply-To: <200912220028.nBM0S5uX005437@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2010-01-12 at 00:42 -0800, David Miller wrote:
> From: akpm@linux-foundation.org
> Date: Mon, 21 Dec 2009 16:28:05 -0800
> 
> > +extern u32 (*do_arch_gettimeoffset)(void);
> > +
> 
> Please put this declaration into a header file that both
> pcic.c and time_32.c can include, rather than pcic.c
> 
> Otherwise sparse will complain, time_32.c's definition
> can get out of sync, etc.


Would this do it? 

thanks
-john

Move do_arch_gettimeoffset function pointer declaration to a timex_32.h

Uncompiled/Untested

Signed-off-by: John Stultz <johnstul@us.ibm.com>


diff --git a/arch/sparc/include/asm/timex_32.h b/arch/sparc/include/asm/timex_32.h
index b6ccdb0..a254750 100644
--- a/arch/sparc/include/asm/timex_32.h
+++ b/arch/sparc/include/asm/timex_32.h
@@ -12,4 +12,5 @@
 typedef unsigned long cycles_t;
 #define get_cycles()	(0)
 
+extern u32 (*do_arch_gettimeoffset)(void);
 #endif
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 8ff470c..4e2724e 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -30,6 +30,7 @@
 #include <asm/oplib.h>
 #include <asm/prom.h>
 #include <asm/pcic.h>
+#include <asm/timex.h>
 #include <asm/timer.h>
 #include <asm/uaccess.h>
 #include <asm/irq_regs.h>
@@ -714,8 +715,6 @@ static irqreturn_t pcic_timer_handler (int irq, void *h)
 #define USECS_PER_JIFFY  10000  /* We have 100HZ "standard" timer for sparc */
 #define TICK_TIMER_LIMIT ((100*1000000/4)/100)
 
-extern u32 (*do_arch_gettimeoffset)(void);
-
 u32 pci_gettimeoffset(void)
 {
 	/*
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 9b440c0..0d4c09b 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/oplib.h>
+#include <asm/timex.h>
 #include <asm/timer.h>
 #include <asm/system.h>
 #include <asm/irq.h>



