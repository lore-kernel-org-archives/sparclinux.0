From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 03 Nov 2020 09:27:30 +0000
Subject: [patch V3 18/37] highmem: Get rid of kmap_types.h
Message-Id: <20201103095858.422094352@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>, Chris Mason <clm@fb.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Christoph Hellwig <hch@lst.de>, Vincent Guittot <vincent.guittot@linaro.org>, Paul McKenney <paulmck@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, David Airlie <airlied@linux.ie>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Mel Gorman <mgorman@suse.de>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, Ben Skeggs <bskeggs@redhat.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org, Roland Scheidegger <sroland@vmware.com>, Josef Bacik <josef@toxicpanda.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org, David Sterba <dsterba@suse.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, linux-mm@kvack.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, linux-btrfs@vger.kernel.org, Greentime Hu <green.hu@gmail.com>

The header is not longer used and on alpha, ia64, openrisc, parisc and um
it was completely unused anyway as these architectures have no highmem
support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 arch/alpha/include/asm/kmap_types.h  |   15 ---------------
 arch/ia64/include/asm/kmap_types.h   |   13 -------------
 arch/openrisc/mm/init.c              |    1 -
 arch/openrisc/mm/ioremap.c           |    1 -
 arch/parisc/include/asm/kmap_types.h |   13 -------------
 arch/um/include/asm/fixmap.h         |    1 -
 arch/um/include/asm/kmap_types.h     |   13 -------------
 include/asm-generic/Kbuild           |    1 -
 include/asm-generic/kmap_types.h     |   11 -----------
 include/linux/highmem.h              |    2 --
 10 files changed, 71 deletions(-)

--- a/arch/alpha/include/asm/kmap_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type. */
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
--- a/arch/ia64/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_IA64_KMAP_TYPES_H
-#define _ASM_IA64_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_IA64_KMAP_TYPES_H */
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -33,7 +33,6 @@
 #include <asm/io.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/bug.h>
 #include <linux/sched.h>
--- a/arch/parisc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
--- a/arch/um/include/asm/fixmap.h
+++ b/arch/um/include/asm/fixmap.h
@@ -3,7 +3,6 @@
 #define __UM_FIXMAP_H
 
 #include <asm/processor.h>
-#include <asm/kmap_types.h>
 #include <asm/archparam.h>
 #include <asm/page.h>
 #include <linux/threads.h>
--- a/arch/um/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- */
-
-#ifndef __UM_KMAP_TYPES_H
-#define __UM_KMAP_TYPES_H
-
-/* No more #include "asm/arch/kmap_types.h" ! */
-
-#define KM_TYPE_NR 14
-
-#endif
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -30,7 +30,6 @@ mandatory-y += irq.h
 mandatory-y += irq_regs.h
 mandatory-y += irq_work.h
 mandatory-y += kdebug.h
-mandatory-y += kmap_types.h
 mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
--- a/include/asm-generic/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_KMAP_TYPES_H
-#define _ASM_GENERIC_KMAP_TYPES_H
-
-#ifdef __WITH_KM_FENCE
-# define KM_TYPE_NR 41
-#else
-# define KM_TYPE_NR 20
-#endif
-
-#endif
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -29,8 +29,6 @@ static inline void invalidate_kernel_vma
 }
 #endif
 
-#include <asm/kmap_types.h>
-
 /*
  * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
  */
