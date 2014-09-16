From: David Miller <davem@davemloft.net>
Date: Tue, 16 Sep 2014 21:02:49 +0000
Subject: Re: [PATCH V2] sparc64: sparse irq
Message-Id: <20140916.170249.1497693095648604845.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410873926-11191-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410873926-11191-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 09:25:26 -0400

> 1) provides the option to enable SPARSE_IRQ

You're converting sparc64 completely over to SPARSE_IRQ unconditionally,
so this wording doesn't make any sense.  Please adjust the rest of
the commit message as needed.

> -#define NR_IRQS    255
> +#ifdef CONFIG_SPARSE_IRQ
> +#define NR_IRQS		(2048)
> +#else
> +#define NR_IRQS		(255)
> +#endif /* CONFIG_SPARSE_IRQ */

And thus SPARSE_IRQ checks no longer make any sense in sparc64 specific
files such as irq_64.h here.

> +#ifdef CONFIG_SPARSE_IRQ
> +unsigned int irq_alloc(unsigned int dev_handle, unsigned int dev_ino);
> +void irq_free(unsigned int irq);

Likewise throughout the rest of your patch.

You're really close, please fix this up and resubmit. :-)
