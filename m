From: David Miller <davem@davemloft.net>
Date: Mon, 14 Sep 2020 19:59:42 +0000
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
Message-Id: <20200914.125942.5644261129883859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
In-Reply-To: <20200914045219.3736466-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: npiggin@gmail.com
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, axboe@kernel.dk, peterz@infradead.org

From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 14 Sep 2020 14:52:18 +1000

 ...
> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
> optimisation could be effectively restored by sending IPIs to mm_cpumask
> members and having them remove themselves from mm_cpumask. This is more
> tricky so I leave it as an exercise for someone with a sparc64 SMP.
> powerpc has a (currently similarly broken) example.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Sad to see this optimization go away, but what can I do:

Acked-by: David S. Miller <davem@davemloft.net>
