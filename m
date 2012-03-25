From: David Miller <davem@davemloft.net>
Date: Sun, 25 Mar 2012 19:04:22 +0000
Subject: Re: [PATCH 19/20 v2] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <20120325.150422.2000357641354896689.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332698315-2218-1-git-send-email-consul.kautuk@gmail.com>
In-Reply-To: <1332698315-2218-1-git-send-email-consul.kautuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: consul.kautuk@gmail.com
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Sun, 25 Mar 2012 13:58:35 -0400

> +	unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
> +					(write ? FAULT_FLAG_WRITE : 0));

Still indented wrong, it should be:

	unsigned int flags = (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE |
			      (write ? FAULT_FLAG_WRITE : 0));

The second line must have the openning parenthesis line up with
the column after the openning parenthesis on the first line.  Do
not use only tabs to indent this stuff, line it up properly.

You need to use tabs and spaces to line it up.  Use something like
emacs's C-mode to help you if you can't do it right by hand.

> +			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
> +					1, regs, address);

Still wrong, for the same exact reason.

I went out of my way to reply to your private email (which I usually
ignore, you should never email developers privately) and you didn't
even listen to the feedback I gave you.
