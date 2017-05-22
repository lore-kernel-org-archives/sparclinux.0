From: David Miller <davem@davemloft.net>
Date: Mon, 22 May 2017 19:09:26 +0000
Subject: Re: [PATCH v2 1/5] sparc64: expand LDC interface
Message-Id: <20170522.150926.2055036314183378142.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <eab89ee967ae1d94dff180eb30cc07e5a9cc1345.1494551284.git.jag.raman@oracle.com>
In-Reply-To: <eab89ee967ae1d94dff180eb30cc07e5a9cc1345.1494551284.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 11 May 2017 21:30:49 -0400

> @@ -782,6 +772,37 @@ static int process_data_ack(struct ldc_channel *lp,
>  	return 0;
>  }
>  
> +void ldc_enable_hv_intr(struct ldc_channel *lp)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&lp->lock, flags);
> +
> +	ldcdbg(RX, "%s: channel id=%lu\n", __func__, lp->id);
> +
> +	enable_irq(lp->cfg.rx_irq);
> +
> +	spin_unlock_irqrestore(&lp->lock, flags);
> +
> +}
> +EXPORT_SYMBOL(ldc_enable_hv_intr);

I explicitly asked that these interfaces be removed:

	http://marc.info/?l=linux-sparc&m9382227618761&w=2

I want the drivers themselves to call {enable,disable}_irq() directly
just like any other standard Linux driver.  I don't want to see
arbitrary wrappers like this, they are not needed and make the
code harder rather than easier to understand.

Furthermore, there is no reason to take the LP lock.

If such synchronization is necessary, there is a high order much
larger problem that needs to be solved.  The IRQ value should be
obtained at LDC channel creation time, and never change ever
again afterwards.

So there is abolutely no gain by adding synchronization across
only the {enable,disable}_irq() call.

So once again, remove these helpers completely and just call
enable_irq() and disable_irq() directly from the drivers just like any
other standard Linux driver does.

If you ignore this feedback one more time, I will probably stop
reviewing this patch series.  I am giving you fair warning.

Thank you.
