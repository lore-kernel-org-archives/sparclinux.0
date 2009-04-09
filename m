From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2009 05:37:55 +0000
Subject: [PATCH 11/12]: sparc64: Only allocate per-cpu areas for possible
Message-Id: <20090408.223755.06231218.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This gets us real close to the generic implementation of
setup_per_cpu_areas() except:

1) We store the per-cpu offset into the trap_block[], whereas
   the generic code has it's own static array.

2) We have to initialize the %g5 register to hold the boot cpu's
   per-cpu area offset.

3) The OBP/MDESC cpu info scan is performed at the end.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/smp_64.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index af0b28e..168025f 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1373,27 +1373,17 @@ void smp_send_stop(void)
 
 void __init setup_per_cpu_areas(void)
 {
-	unsigned long base, shift, goal, size, i;
+	unsigned long size, i, nr_possible_cpus = num_possible_cpus();
 	char *ptr;
 
 	/* Copy section for each CPU (we discard the original) */
-	goal = PERCPU_ENOUGH_ROOM;
+	size = ALIGN(PERCPU_ENOUGH_ROOM, PAGE_SIZE);
+	ptr = alloc_bootmem_pages(size * nr_possible_cpus);
 
-	shift = PAGE_SHIFT;
-	for (size = PAGE_SIZE; size < goal; size <<= 1UL)
-		shift++;
-
-	ptr = __alloc_bootmem(size * NR_CPUS, PAGE_SIZE, 0);
-	if (!ptr) {
-		prom_printf("Cannot allocate per-cpu memory.\n");
-		prom_halt();
-	}
-
-	base = ptr - __per_cpu_start;
-
-	for (i = 0; i < NR_CPUS; i++, ptr += size) {
-		__per_cpu_offset(i) = base + (i * size);
+	for_each_possible_cpu(i) {
+		__per_cpu_offset(i) = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+		ptr += size;
 	}
 
 	/* Setup %g5 for the boot cpu.  */
-- 
1.6.2.2

