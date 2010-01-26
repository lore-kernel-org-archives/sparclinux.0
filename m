From: David Miller <davem@davemloft.net>
Date: Tue, 26 Jan 2010 12:14:39 +0000
Subject: Re: irq_64.c compiler error in todays 2.6.33-rc5+git
Message-Id: <20100126.041439.228284704.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1001261258400.10773@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1001261258400.10773@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 26 Jan 2010 12:59:43 +0200 (EET)

>   CC      arch/sparc/kernel/irq_64.o
> arch/sparc/kernel/irq_64.c: In function 'sun4u_irq_enable':
> arch/sparc/kernel/irq_64.c:286: error: 'struct irq_desc' has no member named 'affinity'
> arch/sparc/kernel/irq_64.c: In function 'sun4v_irq_enable':
> arch/sparc/kernel/irq_64.c:362: error: 'struct irq_desc' has no member named 'affinity'
> arch/sparc/kernel/irq_64.c: In function 'sun4v_virq_enable':
> arch/sparc/kernel/irq_64.c:425: error: 'struct irq_desc' has no member named 'affinity'

See my other reply to a similar build failure report:

sparc64: Fix UP build.

Can't reference irq_desc[].affinity when !SMP.

Reported-by: Alexander Beregalov <a.beregalov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index f2179cc..e1cbdb9 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -268,10 +268,8 @@ static int irq_choose_cpu(unsigned int virt_irq, const struct cpumask *affinity)
 	return cpuid;
 }
 #else
-static int irq_choose_cpu(unsigned int virt_irq, const struct cpumask *affinity)
-{
-	return real_hard_smp_processor_id();
-}
+#define irq_choose_cpu(virt_irq, affinity)	\
+	real_hard_smp_processor_id()
 #endif
 
 static void sun4u_irq_enable(unsigned int virt_irq)
