From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 15 Jul 2016 11:05:33 +0000
Subject: [patch] sparc32: off by ones in BUG_ON()
Message-Id: <20160715110533.GA9258@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Smatch complains that these tests are off by one, which is true but not
life threatening.

	arch/sparc/kernel/irq_32.c:169 irq_link()
	error: buffer overflow 'irq_map' 384 <= 384

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index a979e99..cac4a55 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -165,7 +165,7 @@ void irq_link(unsigned int irq)
 
 	p = &irq_table[irq];
 	pil = p->pil;
-	BUG_ON(pil > SUN4D_MAX_IRQ);
+	BUG_ON(pil >= SUN4D_MAX_IRQ);
 	p->next = irq_map[pil];
 	irq_map[pil] = p;
 
@@ -182,7 +182,7 @@ void irq_unlink(unsigned int irq)
 	spin_lock_irqsave(&irq_map_lock, flags);
 
 	p = &irq_table[irq];
-	BUG_ON(p->pil > SUN4D_MAX_IRQ);
+	BUG_ON(p->pil >= SUN4D_MAX_IRQ);
 	pnext = &irq_map[p->pil];
 	while (*pnext != p)
 		pnext = &(*pnext)->next;
