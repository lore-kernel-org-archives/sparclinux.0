From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Jun 2010 05:03:47 +0000
Subject: Re: [PATCH 1/4] kernel: local_irq_{save,restore}_nmi()
Message-Id: <20100604050347.GE31868@linux-sh.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20100409.160135.35854399.davem@davemloft.net>
In-Reply-To: <20100409.160135.35854399.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Apr 09, 2010 at 04:01:35PM -0700, David Miller wrote:
> 
> Provide local_irq_{save,restore}_nmi() which will allow us to help
> architectures that implement NMIs using IRQ priorities like SPARC64
> does.
> 
> Sparc uses IRQ prio 15 for NMIs and implements local_irq_disable() as
> disable <= 14. However if you do that while inside an NMI you re-
> enable the NMI priority again, causing all kinds of fun.
> 
> A more solid implementation would first check the disable level and
> never lower it, however that is more costly and would slow down the
> rest of the kernel for no particular reason.
> 
> Therefore introduce local_irq_save_nmi() which can implement this
> slower but more solid scheme and dis-allow local_irq_save() from NMI
> context.
> 
> Suggested-by: David Miller <davem@davemloft.net>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Are there any updates for this patch series? I would like to make use of
this on SH as well, but it seems these haven't hit upstream yet.
