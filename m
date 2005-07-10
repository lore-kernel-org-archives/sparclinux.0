From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 10 Jul 2005 00:11:04 +0000
Subject: Re: Compilation issue on 2.6.13-rc2
Message-Id: <20050709.171104.95504199.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050709090126.0e8096ed@enterprise.weeve.org>
In-Reply-To: <20050709090126.0e8096ed@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sat, 9 Jul 2005 09:01:26 -0600

> In trying to build 2.6.13-rc2 on an SMP Blade 1000, I get the following
> error;
> 
>   CC      arch/sparc64/kernel/irq.o
> arch/sparc64/kernel/irq.c: In function `irq_affinity_read_proc':
> arch/sparc64/kernel/irq.c:920: warning: initialization from incompatible
> pointer type make[1]: *** [arch/sparc64/kernel/irq.o] Error 1
> make: *** [arch/sparc64/kernel] Error 2
> 
> One thing to note is that this only manifests itself in an SMP enabled
> kernel config, single processor does not throw it.

It's fixed in Linu's GIT tree as of two days ago, as follows.

12cf649f417c68b6bdd2a3b4ed97113159c6029e
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -917,7 +917,8 @@ static int irq_affinity_read_proc (char 
 			int count, int *eof, void *data)
 {
 	struct ino_bucket *bp = ivector_table + (long)data;
-	struct irqaction *ap = bp->irq_info;
+	struct irq_desc *desc = bp->irq_info;
+	struct irqaction *ap = desc->action;
 	cpumask_t mask;
 	int len;
 
@@ -935,11 +936,13 @@ static int irq_affinity_read_proc (char 
 static inline void set_intr_affinity(int irq, cpumask_t hw_aff)
 {
 	struct ino_bucket *bp = ivector_table + irq;
+	struct irq_desc *desc = bp->irq_info;
+	struct irqaction *ap = desc->action;
 
 	/* Users specify affinity in terms of hw cpu ids.
 	 * As soon as we do this, handler_irq() might see and take action.
 	 */
-	put_smpaff_in_irqaction((struct irqaction *)bp->irq_info, hw_aff);
+	put_smpaff_in_irqaction(ap, hw_aff);
 
 	/* Migration is simply done by the next cpu to service this
 	 * interrupt.
