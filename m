From: David Miller <davem@davemloft.net>
Date: Wed, 03 May 2017 14:37:44 +0000
Subject: Re: [PATCH 1/5] sparc64: expand LDC interface
Message-Id: <20170503.103744.1191619276146392297.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Wed, 29 Mar 2017 17:51:42 -0400

> @@ -24,6 +24,9 @@ struct ldc_channel_config {
>  	u32			mtu;
>  	unsigned int		rx_irq;
>  	unsigned int		tx_irq;
> +	u64			rx_ino;
> +	u64			tx_ino;
> +	u64			dev_handle;
>  	u8			mode;
>  #define LDC_MODE_RAW		0x00
>  #define LDC_MODE_UNRELIABLE	0x01
 ...
> +void ldc_enable_hv_intr(struct ldc_channel *lp)
 ...
> +void ldc_disable_hv_intr(struct ldc_channel *lp)

You should use enable_irq() and disable_irq() for this.

The whole idea is that the entire kernel should only operate on
32-bit abstract IRQ cookies, and not have to have any knowledge
about interrupt numbering details such as INOs.
