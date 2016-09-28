From: David Miller <davem@davemloft.net>
Date: Wed, 28 Sep 2016 15:30:34 +0000
Subject: Re: [PATCH 2/2] sparc64: Fix irq stack bootmem allocation.
Message-Id: <20160928.113034.369022817978772485.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1473972881-10671-3-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1473972881-10671-3-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Atish Patra <atish.patra@oracle.com>
Date: Thu, 15 Sep 2016 14:54:41 -0600

> Currently, irq stack bootmem is allocated for all possible cpus
> before nr_cpus value changes the list of possible cpus. As a result,
> there is unnecessary wastage of bootmemory.
> 
> Move the irq stack bootmem allocation so that it happens after
> possible cpu list is modified based on nr_cpus value.
> 
> Signed-off-by: Atish Patra <atish.patra@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>

Applied, thanks.
