From: David Miller <davem@davemloft.net>
Date: Sun, 18 Dec 2016 03:07:00 +0000
Subject: Re: [RFC PATCH 03/14] sparc64: routines for basic mmu shared context structure management
Message-Id: <20161217.220700.50846773009762926.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
	<1481913337-9331-4-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1481913337-9331-4-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mike.kravetz@oracle.com
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@oracle.com, nitin.m.gupta@oracle.com, vijay.ac.kumar@oracle.com, julian.calaby@gmail.com, adam.buchbinder@gmail.com, kirill.shutemov@linux.intel.com, mhocko@suse.com, akpm@linux-foundation.org

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 16 Dec 2016 10:35:26 -0800

> +void smp_flush_shared_tlb_mm(struct mm_struct *mm)
> +{
> +	u32 ctx = SHARED_CTX_HWBITS(mm->context);
> +
> +	(void)get_cpu();		/* prevent preemption */

preempt_disable();

> +
> +	smp_cross_call(&xcall_flush_tlb_mm, ctx, 0, 0);
> +	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
> +
> +	put_cpu();

preempt_enable();
