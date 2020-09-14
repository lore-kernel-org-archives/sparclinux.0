From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 14 Sep 2020 04:52:16 +0000
Subject: [PATCH v2 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
Message-Id: <20200914045219.3736466-2-npiggin@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
In-Reply-To: <20200914045219.3736466-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-mm @ kvack . org" <linux-mm@kvack.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, "David S . Miller" <davem@davemloft.net>

Reading and modifying current->mm and current->active_mm and switching
mm should be done with irqs off, to prevent races seeing an intermediate
state.

This is similar to commit 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB
invalidate"). At exec-time when the new mm is activated, the old one
should usually be single-threaded and no longer used, unless something
else is holding an mm_users reference (which may be possible).

Absent other mm_users, there is also a race with preemption and lazy tlb
switching. Consider the kernel_execve case where the current thread is
using a lazy tlb active mm:

  call_usermodehelper()
    kernel_execve()
      old_mm = current->mm;
      active_mm = current->active_mm;
      *** preempt *** -------------------->  schedule()
                                               prev->active_mm = NULL;
                                               mmdrop(prev active_mm);
                                             ...
                      <--------------------  schedule()
      current->mm = mm;
      current->active_mm = mm;
      if (!old_mm)
          mmdrop(active_mm);

If we switch back to the kernel thread from a different mm, there is a
double free of the old active_mm, and a missing free of the new one.

Closing this race only requires interrupts to be disabled while ->mm
and ->active_mm are being switched, but the TLB problem requires also
holding interrupts off over activate_mm. Unfortunately not all archs
can do that yet, e.g., arm defers the switch if irqs are disabled and
expects finish_arch_post_lock_switch() to be called to complete the
flush; um takes a blocking lock in activate_mm().

So as a first step, disable interrupts across the mm/active_mm updates
to close the lazy tlb preempt race, and provide an arch option to
extend that to activate_mm which allows architectures doing IPI based
TLB shootdowns to close the second race.

This is a bit ugly, but in the interest of fixing the bug and backporting
before all architectures are converted this is a compromise.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig |  7 +++++++
 fs/exec.c    | 17 +++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..94821e3f94d1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -414,6 +414,13 @@ config MMU_GATHER_NO_GATHER
 	bool
 	depends on MMU_GATHER_TABLE_FREE
 
+config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
+	bool
+	help
+	  Temporary select until all architectures can be converted to have
+	  irqs disabled over activate_mm. Architectures that do IPI based TLB
+	  shootdowns should enable this.
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..d4fb18baf1fb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1130,11 +1130,24 @@ static int exec_mmap(struct mm_struct *mm)
 	}
 
 	task_lock(tsk);
-	active_mm = tsk->active_mm;
 	membarrier_exec_mmap(mm);
-	tsk->mm = mm;
+
+	local_irq_disable();
+	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
+	tsk->mm = mm;
+	/*
+	 * This prevents preemption while active_mm is being loaded and
+	 * it and mm are being updated, which could cause problems for
+	 * lazy tlb mm refcounting when these are updated by context
+	 * switches. Not all architectures can handle irqs off over
+	 * activate_mm yet.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+		local_irq_enable();
 	activate_mm(active_mm, mm);
+	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+		local_irq_enable();
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
-- 
2.23.0
