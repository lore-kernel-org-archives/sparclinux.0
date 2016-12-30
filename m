From: Dmitry Safonov <dsafonov@virtuozzo.com>
Date: Fri, 30 Dec 2016 15:56:30 +0000
Subject: [RFC 0/4] x86: keep TASK_SIZE in sync with mm->task_size
Message-Id: <20161230155634.8692-1-dsafonov@virtuozzo.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

At this moment, we have following task_size-related things:
- TASK_SIZE_OF() macro, which is unused;
- current->mm->task_size which is used in half and TASK_SIZE() macro
  which is used in the other half of code
- TIF_ADDR32, which is used to detect 32-bit address space and is
  x86-specific, where some other arches misused TIF_32BIT
- personality ADDR_LIMIT_32BIT, which is used on arm/alpha
- ADDR_LIMIT_3GB, which is x86-specific and can be used to change
  running task's TASK_SIZE 3GB <-> 4GB

This patches set removes unused definition of TASK_SIZE_OF (1),
defines TASK_SIZE macro as current->mm->task_size (3).
I would suggest define TASK_SIZE this way in generic version,
but currently I test it only on x86.
It also frees thread info flag (2) and adds arch_prctl()
on x86_64 to get/set current virtual address space size - as
it's needed by now only for CRIU, hide it under CHECKPOINT_RESTORE
config.
Hope those patches will help to clean task_size-related code
at least a bit (and helps me to restore vaddr limits).

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org

Dmitry Safonov (4):
  mm: remove unused TASK_SIZE_OF()
  x86/thread_info: kill TIF_ADDR32 in favour of ADDR_LIMIT_32BIT
  x86/mm: define TASK_SIZE as current->mm->task_size
  x86/arch_prctl: add ARCH_{GET,SET}_TASK_SIZE

 arch/arm64/include/asm/memory.h       |  2 --
 arch/mips/include/asm/processor.h     |  3 ---
 arch/parisc/include/asm/processor.h   |  3 +--
 arch/powerpc/include/asm/processor.h  |  3 +--
 arch/s390/include/asm/processor.h     |  3 +--
 arch/sparc/include/asm/processor_64.h |  3 ---
 arch/x86/include/asm/elf.h            |  7 +++++--
 arch/x86/include/asm/processor.h      | 19 +++++++++----------
 arch/x86/include/asm/thread_info.h    |  4 +---
 arch/x86/include/uapi/asm/prctl.h     |  3 +++
 arch/x86/kernel/process_64.c          | 17 +++++++++++++++--
 arch/x86/kernel/sys_x86_64.c          |  4 ++--
 arch/x86/um/asm/segment.h             |  2 +-
 arch/x86/xen/mmu.c                    |  4 ++--
 fs/exec.c                             | 17 +++++++++++------
 include/linux/sched.h                 |  4 ----
 16 files changed, 52 insertions(+), 46 deletions(-)

-- 
2.11.0

