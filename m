From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 15 Sep 2020 03:24:07 +0000
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
Message-Id: <1600139445.qwycwjuwdq.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
        <20200914.125942.5644261129883859.davem@davemloft.net>
In-Reply-To: <20200914.125942.5644261129883859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com, axboe@kernel.dk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, sparclinux@vger.kernel.org

Excerpts from David Miller's message of September 15, 2020 5:59 am:
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Mon, 14 Sep 2020 14:52:18 +1000
> 
>  ...
>> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
>> optimisation could be effectively restored by sending IPIs to mm_cpumask
>> members and having them remove themselves from mm_cpumask. This is more
>> tricky so I leave it as an exercise for someone with a sparc64 SMP.
>> powerpc has a (currently similarly broken) example.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Sad to see this optimization go away, but what can I do:
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> 

Thanks Dave, any objection if we merge this via the powerpc tree
to keep the commits together?

Thanks,
Nick
