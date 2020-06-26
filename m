From: Mike Rapoport <rppt@kernel.org>
Date: Fri, 26 Jun 2020 18:17:13 +0000
Subject: Re: [PATCH 0/2] sparc32: srmmu: improve type safety of __nocache_fix()
Message-Id: <20200626181713.GA3547368@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200524162151.3493-1-rppt@kernel.org>
In-Reply-To: <20200524162151.3493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

Any comments on this?

On Sun, May 24, 2020 at 07:21:49PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> As discussed at [1] the __nocache_fix() macro in sparc's SRMMU can be made
> type safe and so the compiler will yell anout misuse of pXd pointers for
> which the __nocache_fix() is primarily used.
> 
> The first patch is an fix of such misuse that I've discovered after adding
> type cast to __nocache_fix(), but to avoid breaking bisection I've made it
> the first commit.
> 
> --
> Sincerely yours,
> Mike.
> 
> [1] https://lkml.kernel.org/r/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com
> 
> Mike Rapoport (2):
>   sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_mappings()
>   sparc32: srmmu: improve type safety of __nocache_fix()
> 
>  arch/sparc/include/asm/pgtsrmmu.h |  2 +-
>  arch/sparc/mm/srmmu.c             | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
