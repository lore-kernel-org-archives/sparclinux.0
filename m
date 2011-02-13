From: David Miller <davem@davemloft.net>
Date: Sun, 13 Feb 2011 20:54:01 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213.125401.45889744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110213192952.GD25069@merkur.ravnborg.org>
In-Reply-To: <20110213192952.GD25069@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 20:29:52 +0100

> +unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
> +{
> +	unsigned int i;
 ...
> +	for (i = 1; i < NR_IRQS; i++) {
> +		if (irq_table[i].irq = real_irq && irq_table[i].irq = pil)
> +			return i;
> +	}
 ...
> +	irq_table[i].irq = i;
> +	irq_table[i].pil = pil;
> +
> +	return i;
> +}

Well, what is it?  Are we storing "real_irq" in irq_table[].irq or
"i"?  I think it's supposed to be "real_irq" and that's one of the
reasons your implementation isn't working :-)
