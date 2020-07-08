From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 08 Jul 2020 16:56:42 +0000
Subject: Re: [PATCH v2 0/2] sparc32: srmmu: improve type safety of __nocache_fix()
Message-Id: <20200708165642.GF128651@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200627081653.25311-1-rppt@kernel.org>
In-Reply-To: <20200627081653.25311-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

Gentle ping.

On Sat, Jun 27, 2020 at 11:16:51AM +0300, Mike Rapoport wrote:
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
> v2: rebased on v5.8-rc2+
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
> base-commit: 1590a2e1c681b0991bd42c992cabfd380e0338f2
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
