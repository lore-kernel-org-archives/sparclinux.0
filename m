From: David Ahern <david.ahern@oracle.com>
Date: Mon, 15 Jun 2015 20:15:42 +0000
Subject: [PATCH 0/4] sparc64: perf fixes for userspace stacks
Message-Id: <1434399346-21665-1-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave:

Coming back to the perf userspace callchain problem. As a reminder there are
a series of problems trying to use perf to collect callchains with scheduling
tracepoints, e.g., perf sched record -g -- <cmd>.

The first patch disables pagefaults while walking the user stack. As discussed
a couple of months ago this is the right fix, but I was puzzled as to why
processes were terminating with sigbus (and sometimes sigsegv). I believe the
root of this problem is bad addresses trying to walk the frames using frame
pointers. The bad addresses lead to faults that get handled by do_sparc64_fault
and it aborts the task though I am still puzzled as to why it gets past this
check in do_sparc64_fault:

        if (in_atomic() || !mm)
                goto intr_or_no_mm;

pagefault_disable bumps the preempt_count which should make in_atomic return != 0
(building kernels with preemption set to voluntar, CONFIG_PREEMPT_VOLUNTARY=y).

While this set does not fully solve the problem it does prevent a number of
pain points with the current code, most notably able to lock up the system.

David Ahern (4):
  sparc: perf: Disable pagefaults while walking userspace stacks
  sparc64: Convert BUG_ON to warning
  sparc64: perf: Add sanity checking on addresses in user stack
  sparc64: perf: Use UREG_FP rather than UREG_I6

 arch/sparc/include/asm/uaccess_64.h | 22 ++++++++++++++++++++++
 arch/sparc/kernel/perf_event.c      | 24 +++++++++++++++++++++---
 arch/sparc/mm/fault_64.c            |  5 +++--
 3 files changed, 46 insertions(+), 5 deletions(-)

-- 
2.3.0

