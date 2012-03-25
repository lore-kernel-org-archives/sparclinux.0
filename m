From: David Miller <davem@davemloft.net>
Date: Sun, 25 Mar 2012 19:04:52 +0000
Subject: Re: [PATCH 20/20 v2] sparc/mm/fault_64.c: Port OOM changes to do_sparc64_fault
Message-Id: <20120325.150452.2130364052890102881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332698348-2253-1-git-send-email-consul.kautuk@gmail.com>
In-Reply-To: <1332698348-2253-1-git-send-email-consul.kautuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: consul.kautuk@gmail.com
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Sun, 25 Mar 2012 13:59:08 -0400

> +			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
> +					1, regs, address);

Improperly indented still.

> +			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
> +					1, regs, address);

Likewise.
