From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 24 Jun 2008 06:06:47 +0000
Subject: [PATCH] limit irq nesting
Message-Id: <Pine.LNX.4.64.0806240203550.27784@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: davem@davemloft.net

Another potential problem (found during code review) that could cause 
stack overflow is indefinite irq nesting. Linux doesn't have any limit on 
number of nested irq handlers, so there may be as many handlers on a stack 
as there are registered hardware interrupts --- enough to cause a crash.

This patch limits interrupt nesting to at most 2 levels.

--

IRQs without IRQF_DISABLED could nest to arbitrary level.

At worst this would mean having as many IRQ handlers stack frames, as there
are interrupts registered --- enough to cause a stack overflow.

This patch makes a limit to have at most two handlers on the stack.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6.26-rc7-devel/include/linux/interrupt.h
=================================--- linux-2.6.26-rc7-devel.orig/include/linux/interrupt.h	2008-06-23 17:47:16.000000000 +0200
+++ linux-2.6.26-rc7-devel/include/linux/interrupt.h	2008-06-23 18:02:40.000000000 +0200
@@ -16,6 +16,11 @@
  #include <asm/system.h>

  /*
+ * Max number of interrupt handlers on a stack. To prevent stack overflow.
+ */
+#define MAX_NESTED_INTERRUPTS	2
+
+/*
   * These correspond to the IORESOURCE_IRQ_* defines in
   * linux/ioport.h to select the interrupt line behaviour.  When
   * requesting an interrupt without specifying a IRQF_TRIGGER, the
@@ -95,7 +100,7 @@
  #ifdef CONFIG_LOCKDEP
  # define local_irq_enable_in_hardirq()	do { } while (0)
  #else
-# define local_irq_enable_in_hardirq()	local_irq_enable()
+# define local_irq_enable_in_hardirq()	do { if (hardirq_count() < (MAX_NESTED_INTERRUPTS << HARDIRQ_SHIFT)) local_irq_enable(); } while (0)
  #endif

  extern void disable_irq_nosync(unsigned int irq);
