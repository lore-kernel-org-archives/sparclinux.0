From: Christoph Hellwig <hch@lst.de>
Date: Sun, 14 Nov 2004 10:40:26 +0000
Subject: [PATCH] kill ancient comment in arch/sparc/kernel/irq.c
Message-Id: <20041114104026.GA32073@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

These days irq_exit() does all softirq processing.


--- 1.32/arch/sparc/kernel/irq.c	2004-09-08 08:32:57 +02:00
+++ edited/arch/sparc/kernel/irq.c	2004-11-14 11:38:36 +01:00
@@ -356,9 +356,6 @@ void sparc_floppy_irq(int irq, void *dev
 	floppy_interrupt(irq, dev_id, regs);
 	irq_exit();
 	enable_pil_irq(irq);
-	// XXX Eek, it's totally changed with preempt_count() and such
-	// if (softirq_pending(cpu))
-	//	do_softirq();
 }
 #endif
 
