From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 18:04:59 +0000
Subject: Re: [PATCH] sparc64: Setup a scheduling domain for highest level cache.
Message-Id: <20161024.140459.1263760552719699072.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1476923609-11125-1-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1476923609-11125-1-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Atish Patra <atish.patra@oracle.com>
Date: Wed, 19 Oct 2016 18:33:29 -0600

> Individual scheduler domain should consist different hierarchy
> consisting of cores sharing similar property. Currently, no
> scheduler domain is defined separately for the cores that shares
> the last level cache. As a result, the scheduler fails to take
> advantage of cache locality while migrating tasks during load
> balancing.
> 
> Here are the cpu masks currently present for sparc that are/can
> be used in scheduler domain construction.
> cpu_core_map : set based on the cores that shares l1 cache.
> core_core_sib_map : is set based on the socket id.
> The prior SPARC notion of socket was defined as highest level of
> shared cache. However, the MD record on T7 platforms now describes
> the CPUs that share the physical socket and this is no longer tied
> to shared cache.
> 
> That's why a separate cpu mask needs to be created that truly
> represent highest level of shared cache for all platforms.
> 
> Signed-off-by: Atish Patra <atish.patra@oracle.com>
> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>

Applied, thank you.
