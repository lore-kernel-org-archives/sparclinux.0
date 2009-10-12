From: David Miller <davem@davemloft.net>
Date: Mon, 12 Oct 2009 10:26:57 +0000
Subject: Re: Linux guest domain with two vnets bound to the same vswitch
Message-Id: <20091012.032657.24181291.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091009.150829.218507309.davem@davemloft.net>
	<20091009.162120.164441279.davem@davemloft.net>
	<505766fa0910120123l51b57b8aja30a5d0fd1225c0d@mail.gmail.com>
In-Reply-To: <505766fa0910120123l51b57b8aja30a5d0fd1225c0d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: heyongli@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: hyl <heyongli@gmail.com>
Date: Mon, 12 Oct 2009 16:23:47 +0800

> look the console output, system seems hang on a live lock:
> tl0_irq5 triggered just after the irq been re-enable in the handler
> of irq5: the ldc_rx.
> 
> i have no idea about the t10_irq5, just guess that: the special
> configuration lead to t10_irq5 been triggered continuously, and
> the trigger condition can not been cleared.

Yes, it seems that stack is exhausted.  Ho hum...

I guess the following patch works too?  Please make sure you've
removed your changes when testing this.

Thanks.

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index adf5f27..cb3c72c 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1242,13 +1242,13 @@ int ldc_bind(struct ldc_channel *lp, const char *name)
 	snprintf(lp->tx_irq_name, LDC_IRQ_NAME_MAX, "%s TX", name);
 
 	err = request_irq(lp->cfg.rx_irq, ldc_rx,
-			  IRQF_SAMPLE_RANDOM | IRQF_SHARED,
+			  IRQF_SAMPLE_RANDOM | IRQF_DISABLED | IRQF_SHARED,
 			  lp->rx_irq_name, lp);
 	if (err)
 		return err;
 
 	err = request_irq(lp->cfg.tx_irq, ldc_tx,
-			  IRQF_SAMPLE_RANDOM | IRQF_SHARED,
+			  IRQF_SAMPLE_RANDOM | IRQF_DISABLED | IRQF_SHARED,
 			  lp->tx_irq_name, lp);
 	if (err) {
 		free_irq(lp->cfg.rx_irq, lp);
