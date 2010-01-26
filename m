From: Meelis Roos <mroos@linux.ee>
Date: Tue, 26 Jan 2010 10:59:43 +0000
Subject: irq_64.c compiler error in todays 2.6.33-rc5+git
Message-Id: <alpine.SOC.1.00.1001261258400.10773@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

  CC      arch/sparc/kernel/irq_64.o
arch/sparc/kernel/irq_64.c: In function 'sun4u_irq_enable':
arch/sparc/kernel/irq_64.c:286: error: 'struct irq_desc' has no member named 'affinity'
arch/sparc/kernel/irq_64.c: In function 'sun4v_irq_enable':
arch/sparc/kernel/irq_64.c:362: error: 'struct irq_desc' has no member named 'affinity'
arch/sparc/kernel/irq_64.c: In function 'sun4v_virq_enable':
arch/sparc/kernel/irq_64.c:425: error: 'struct irq_desc' has no member named 'affinity'

-- 
Meelis Roos (mroos@linux.ee)
