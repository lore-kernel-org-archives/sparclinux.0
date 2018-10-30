From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 30 Oct 2018 13:10:55 +0000
Subject: Re: [PATCH] sparc64: Remvoe set_fs() from perf_callchain_user().
Message-Id: <8dbbaada-1251-4800-388a-e1b54634ca22@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181029.221740.672151756701978853.davem@davemloft.net>
In-Reply-To: <20181029.221740.672151756701978853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Acked-by: Rob Gardner <rob.gardner@oracle.com>

On 10/29/2018 11:17 PM, David Miller wrote:
> Ever since commit 88b0193d9418 ("perf/callchain: Force USER_DS when
> invoking perf_callchain_user()") the caller does this for us.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>   arch/sparc/kernel/perf_event.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
> index 67b3e6b..47c8713 100644
> --- a/arch/sparc/kernel/perf_event.c
> +++ b/arch/sparc/kernel/perf_event.c
> @@ -1849,16 +1849,12 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
>   {
>   	u64 saved_fault_address = current_thread_info()->fault_address;
>   	u8 saved_fault_code = get_thread_fault_code();
> -	mm_segment_t old_fs;
>   
>   	perf_callchain_store(entry, regs->tpc);
>   
>   	if (!current->mm)
>   		return;
>   
> -	old_fs = get_fs();
> -	set_fs(USER_DS);
> -
>   	flushw_user();
>   
>   	pagefault_disable();
> @@ -1870,7 +1866,6 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
>   
>   	pagefault_enable();
>   
> -	set_fs(old_fs);
>   	set_thread_fault_code(saved_fault_code);
>   	current_thread_info()->fault_address = saved_fault_address;
>   }
