From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jan 2015 04:58:58 +0000
Subject: Re: [PATCH] sparc64: fatal trap should stop all cpus
Message-Id: <20150104.235858.838198074051345873.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 29 Dec 2014 17:23:10 -0600

> +	while (1) ;

Like the powerpc implementation, please correctly format this as:

	while (1)
		;

However I also have to wonder if we should be doing a hypervisor
or firmware CPU stop call in that handler.

That's what the XEN x86 implementation does.

It should logically do something like:

	if (tlb_type = hypervisor) {
		if (ldom_domaining_enabled)
			sun4v_stop_cpu(cpuid);
		else
			prom_stopcpu_cpuid(cpuid);
	} else
		smp_call_function(wrapper_around_prom_stopself, NULL, 0);
