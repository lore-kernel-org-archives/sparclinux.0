From: David Miller <davem@davemloft.net>
Date: Mon, 26 Mar 2012 21:36:06 +0000
Subject: Re: [PATCH 19/20 v4] sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault
Message-Id: <20120326.173606.1348576857155624658.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332780474-2881-1-git-send-email-consul.kautuk@gmail.com>
In-Reply-To: <1332780474-2881-1-git-send-email-consul.kautuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: consul.kautuk@gmail.com
Cc: paul.gortmaker@windriver.com, mingo@elte.hu, joe@perches.com, a.p.zijlstra@chello.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kautuk Consul <consul.kautuk@gmail.com>
Date: Mon, 26 Mar 2012 12:47:54 -0400

> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
> (mm: retry page fault when blocking on disk transfer) and
> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
> (x86,mm: make pagefault killable)
> 
> The above commits introduced changes into the x86 pagefault handler
> for making the page fault handler retryable as well as killable.
> 
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
> 
> Port these changes to 32-bit sparc.
> 
> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
