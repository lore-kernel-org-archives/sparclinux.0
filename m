From: Joe Perches <joe@perches.com>
Date: Mon, 26 Mar 2012 16:16:35 +0000
Subject: Re: [PATCH 19/20 v3] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <1332778595.6160.84.camel@joe2Laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
In-Reply-To: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kautuk Consul <consul.kautuk@gmail.com>
Cc: davem@davemloft.net, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2012-03-26 at 11:32 -0400, Kautuk Consul wrote:
[]
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 8023fd7..6da1818 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -226,6 +226,8 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
>  	unsigned long g2;
>  	int from_user = !(regs->psr & PSR_PS);
>  	int fault, code;
> +	unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
> +						  (write ? FAULT_FLAG_WRITE : 0));

David meant that the indentation should be aligned
immediately after the open parenthesis:

+	unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
+			      (write ? FAULT_FLAG_WRITE : 0));

though perhaps this is clearer as:

	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;

	if (write)
		flags |= FAULT_FLAG_WRITE;

or even separate sets.

	if (write)
		flags = foo;
	else
		flags = bar;


