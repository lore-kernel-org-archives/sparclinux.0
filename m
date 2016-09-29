From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 29 Sep 2016 13:55:39 +0000
Subject: Re: [PATCH v3 2/2] lockdep: Limit static allocations if PROVE_LOCKING_SMALL is defined
Message-Id: <0c25611f-c78e-da10-5370-7c9af3201464@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1475004808-91920-1-git-send-email-babu.moger@oracle.com>
 <1475004808-91920-3-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1475004808-91920-3-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>

CCing Dave.

Dave, Please ack it if it looks good. Thanks.


On 9/27/2016 2:33 PM, Babu Moger wrote:
> Reduce the size of data structure for lockdep entries by half if
> PROVE_LOCKING_SMALL if defined. This is used only for sparc.
>
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> ---
>   kernel/locking/lockdep_internals.h |   20 +++++++++++++++++---
>   1 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index 51c4b24..c2b8849 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -46,6 +46,14 @@ enum {
>   		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
>   
>   /*
> + * CONFIG_PROVE_LOCKING_SMALL is defined for sparc. Sparc requires .text,
> + * .data and .bss to fit in required 32MB limit for the kernel. With
> + * PROVE_LOCKING we could go over this limit and cause system boot-up problems.
> + * So, reduce the static allocations for lockdeps related structures so that
> + * everything fits in current required size limit.
> + */
> +#ifdef CONFIG_PROVE_LOCKING_SMALL
> +/*
>    * MAX_LOCKDEP_ENTRIES is the maximum number of lock dependencies
>    * we track.
>    *
> @@ -54,18 +62,24 @@ enum {
>    * table (if it's not there yet), and we check it for lock order
>    * conflicts and deadlocks.
>    */
> +#define MAX_LOCKDEP_ENTRIES	16384UL
> +#define MAX_LOCKDEP_CHAINS_BITS	15
> +#define MAX_STACK_TRACE_ENTRIES	262144UL
> +#else
>   #define MAX_LOCKDEP_ENTRIES	32768UL
>   
>   #define MAX_LOCKDEP_CHAINS_BITS	16
> -#define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
> -
> -#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
>   
>   /*
>    * Stack-trace: tightly packed array of stack backtrace
>    * addresses. Protected by the hash_lock.
>    */
>   #define MAX_STACK_TRACE_ENTRIES	524288UL
> +#endif
> +
> +#define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
> +
> +#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
>   
>   extern struct list_head all_lock_classes;
>   extern struct lock_chain lock_chains[];

