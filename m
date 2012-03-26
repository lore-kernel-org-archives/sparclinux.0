From: David Miller <davem@davemloft.net>
Date: Mon, 26 Mar 2012 20:09:23 +0000
Subject: Re: [PATCH 19/20 v3] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <20120326.160923.1071907261787727015.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
In-Reply-To: <1332775946-2162-1-git-send-email-consul.kautuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: consul.kautuk@gmail.com
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 11:32:26 -0400

> +	unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
> +						  (write ? FAULT_FLAG_WRITE : 0));

Indentation is still wrong.  The "(write ..." on the second line must
line up with the column of the first "F" in "(FAULT_FLAG..." on the
first line.

+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
+						  1, regs, address);

+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
+						  1, regs, address);

These are still wrong too, for the same reason.

You didn't fix anything.

