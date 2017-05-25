From: David Miller <davem@davemloft.net>
Date: Thu, 25 May 2017 19:22:49 +0000
Subject: Re: [PATCH v3 1/5] sparc64: expand LDC interface
Message-Id: <20170525.152249.1866948233503251468.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e270afc62a8eed77cd8377561ee60d0145c9c367.1495721691.git.jag.raman@oracle.com>
In-Reply-To: <e270afc62a8eed77cd8377561ee60d0145c9c367.1495721691.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 25 May 2017 10:25:54 -0400

> +void ldc_print(struct ldc_channel *lp)
> +{
> +	pr_info("%s: id=0x%lx flags=0x%x state=%s cstate=0x%lx hsstate=0x%x\n"
> +		"\trx_h=0x%lx rx_t=0x%lx rx_n=%ld\n"
> +		"\ttx_h=0x%lx tx_t=0x%lx tx_n=%ld\n"
> +		"\trcv_nxt=%u snd_nxt=%u\n",
> +	__func__, lp->id, lp->flags, state_to_str(lp->state),

These arguments are indented improperly, they need to line up with
the first column after the openning parenthesis of the pr_info() call.

Also, __func__ makes no sense here.  It will always be "ldc_print".
