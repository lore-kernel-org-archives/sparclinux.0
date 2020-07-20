From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 20 Jul 2020 00:38:15 +0000
Subject: io_uring kthread_use_mm / mmget_not_zero possible abuse
Message-Id: <1595203632.x8vplwce1a.astroid@bobo.none>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>, "David S. Miller" <davem@davemloft.net>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

When I last looked at this (predating io_uring), as far as I remember it was 
not permitted to actually switch to (use_mm) an mm user context that was 
pinned with mmget_not_zero. Those pins were only allowed to look at page 
tables, vmas, etc., but not actually run the CPU in that mm context.

sparc/kernel/smp_64.c depends heavily on this, e.g.,

void smp_flush_tlb_mm(struct mm_struct *mm)
{
        u32 ctx = CTX_HWBITS(mm->context);
        int cpu = get_cpu();

        if (atomic_read(&mm->mm_users) == 1) {
                cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
                goto local_flush_and_out;
        }

        smp_cross_call_masked(&xcall_flush_tlb_mm,
                              ctx, 0, 0,
                              mm_cpumask(mm));

local_flush_and_out:
        __flush_tlb_mm(ctx, SECONDARY_CONTEXT);

        put_cpu();
}

If a kthread comes in concurrently between the mm_users test and the 
mm_cpumask reset, and does mmget_not_zero(); kthread_use_mm() then we have 
another CPU switched to mm context but not in the mm_cpumask. It's then 
possible for our thread to schedule on that CPU and not go through a 
switch_mm (because kthread_unuse_mm will make it lazy, then we can switch 
back to our user thread and un-lazy it).

powerpc has something similar.

I don't think this is documented anywhere and certainly isn't checked for 
unfortunately, so I don't really blame io_uring.

The simplest fix is for io_uring to carry mm_users references. If that can't 
be done or we decide to lift the limitation on mmget_not_zero references, we 
can come up with a way to synchronize things.

On powerpc for example, we IPI all targets in mm_cpumask before clearing 
them, so we could disable interrupts while kthread_use_mm does the mm switch 
sequence, and have the IPI handler check that current->mm hasn't been set to 
mm, for example.

sparc is a bit harder because it doesn't IPI targets if it thinks it can 
avoid it. But powerpc found that just doing one IPI isn't a big burden here 
so maybe we change sparc to do that too. I would be inclined to fix this 
mmget_not_zero quirk if we can, unless someone has a very good way to test 
and enforce it, it'll just happen again.

Comments?

Thanks,
Nick
