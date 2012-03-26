From: David Miller <davem@davemloft.net>
Date: Mon, 26 Mar 2012 20:11:05 +0000
Subject: Re: [PATCH 20/20 v3] sparc/mm/fault_64.c: Port OOM changes to do_sparc64_fault
Message-Id: <20120326.161105.1592652605352070253.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332775997-2197-1-git-send-email-consul.kautuk@gmail.com>
In-Reply-To: <1332775997-2197-1-git-send-email-consul.kautuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: consul.kautuk@gmail.com
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 11:33:17 -0400

> +	fault = handle_mm_fault(mm, vma, address,
> +							flags | ((fault_code & FAULT_CODE_WRITE) ?
> +									 FAULT_FLAG_WRITE : 0);

This is so shockingly gross I'm at a loss for words.  Why are you
tabbing this crap all the way into outer-space?

Make the "flags | ..." line up with the first column after the
openning parenthesis of "handle_mm_fault(".

> +			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
> +						  1, regs, address);

Same problem.

> +			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
> +						  1, regs, address);

Same problem.

You're making the coding style worse each iteration, not better.
