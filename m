From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 09 Jan 2004 07:08:22 +0000
Subject: [SPARC32] Fix irqaction sleep-in-lock
Message-Id: <20040109070822.GB22008@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This removes cli/sti from the irqaction allocation, and also prevents
the allocation from sleeping while holding the lock.  This will only
matter once we have modules working.  Dave, please apply if this looks
ok.

This will be the last patch for a while from me as I'm out of the
country on business until the 20th.  Sparc32 hackers who want me to
look over patches should expect some additional latency.

=== arch/sparc/kernel/irq.c 1.25 vs edited ==--- 1.25/arch/sparc/kernel/irq.c	Mon Dec 29 13:37:39 2003
+++ edited/arch/sparc/kernel/irq.c	Thu Jan  8 22:53:40 2004
@@ -49,6 +49,9 @@
 #include <asm/pcic.h>
 #include <asm/cacheflush.h>
 
+/* Used to protect the IRQ action lists */
+spinlock_t irq_action_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  * Dave Redman (djhr@tadpole.co.uk)
  *
@@ -492,7 +495,7 @@
 		return -EBUSY;
 	}
 
-	save_and_cli(flags);
+	spin_lock_irqsave(&irq_action_lock, flags);
 
 	/* If this is flagged as statically allocated then we use our
 	 * private struct which is never freed.
@@ -507,10 +510,10 @@
 	
 	if (action = NULL)
 	    action = (struct irqaction *)kmalloc(sizeof(struct irqaction),
-						 GFP_KERNEL);
+						 GFP_ATOMIC);
 	
 	if (!action) { 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&irq_action_lock, flags);
 		return -ENOMEM;
 	}
 
@@ -547,7 +550,7 @@
 	*(cpu_irq + irq_action) = action;
 
 	enable_irq(irq);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irq_action_lock, flags);
 	return 0;
 }
 
@@ -586,7 +589,7 @@
 		action = NULL;		/* Or else! */
 	}
 
-	save_and_cli(flags);
+	spin_lock_irqsave(&irq_action_lock, flags);
 
 	/* If this is flagged as statically allocated then we use our
 	 * private struct which is never freed.
@@ -600,10 +603,10 @@
 	
 	if (action = NULL)
 	    action = (struct irqaction *)kmalloc(sizeof(struct irqaction),
-						 GFP_KERNEL);
+						 GFP_ATOMIC);
 	
 	if (!action) { 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&irq_action_lock, flags);
 		return -ENOMEM;
 	}
 
@@ -620,7 +623,7 @@
 		*(cpu_irq + irq_action) = action;
 
 	enable_irq(irq);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irq_action_lock, flags);
 	return 0;
 }
 


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
