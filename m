From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 04 Mar 2014 21:26:23 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <531644FF.30800@yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <259041392800232@web13m.yandex.ru>	<530475A8.3060602@oracle.com>	<359241392801938@web24j.yandex.ru> <20140304.150338.542737888922892447.davem@davemloft.net>
In-Reply-To: <20140304.150338.542737888922892447.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: allen.pais@oracle.com, linux-rt-users@vger.kernel.org, sparclinux@vger.kernel.org, bigeasy@linutronix.de

On 05.03.2014 00:03, David Miller wrote:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Wed, 19 Feb 2014 13:25:38 +0400
> 
>> It seems for me it's better to decide the problem not changing protector of tsb like in patch above.
>> You may get good stack without sun4v_data_access_exception error, which was in the first or second
>> message.
> 
> My suspicion is that what happens when we get the data access error is
> that we sample the tlb batch count as non-zero, preempt, then come
> back from preemption seeing the tlb batch in a completely different state.
> 
> And that's what leads to the crash, in the one trace I saw the TSB address
> passed to tsb_flush() (register %o0) was some garbage like 0x103.
> 

I suggested to set tb_active to zero just for experiment. This way

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index b12cb5e..e1d1fd6 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -54,7 +54,7 @@ void arch_enter_lazy_mmu_mode(void)
 {
 	struct tlb_batch *tb = &__get_cpu_var(tlb_batch);

-	tb->active = 1;
+	tb->active = 0;
 }

 void arch_leave_lazy_mmu_mode(void)

Last Allen's stack (from 26 feb. 11:52) still contains
flush_tlb_pending(). Strange, why this is so, maybe
bad initialized per-cpu tlb_batch, and something bad is with BSS...
