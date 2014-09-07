From: Bob Picco <bpicco@meloft.net>
Date: Sun, 07 Sep 2014 15:52:27 +0000
Subject: [PATCH] sparc64: mem boot option correction
Message-Id: <1410105147-23085-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

The "mem" boot option can result in many unexpected consequences. This patch
attempts to prevent boot hangs which have been experienced on T4-4 and T5-8.
Basically the boot loader allocates vmlinuz and initrd higher in available
OBP physical memory. For example, on a 2Tb T5-8 it isn't possible to boot
with mem G.

The patch utilizes memblock to avoid reserved regions and trim memory which
is only free. Other improvements are possible for a multi-node machine.

This is a snippet of the boot log with mem G on T5-8 with the patch applied:
MEMBLOCK configuration:	<- before memory reduction
 memory size = 0x1ffad6ce000 reserved size = 0xa1adf44
 memory.cnt  = 0xb
 memory[0x0]    [0x00000030400000-0x00003fdde47fff], 0x3fada48000 bytes
 memory[0x1]    [0x00003fdde4e000-0x00003fdde4ffff], 0x2000 bytes
 memory[0x2]    [0x00080000000000-0x00083fffffffff], 0x4000000000 bytes
 memory[0x3]    [0x00100000000000-0x00103fffffffff], 0x4000000000 bytes
 memory[0x4]    [0x00180000000000-0x00183fffffffff], 0x4000000000 bytes
 memory[0x5]    [0x00200000000000-0x00203fffffffff], 0x4000000000 bytes
 memory[0x6]    [0x00280000000000-0x00283fffffffff], 0x4000000000 bytes
 memory[0x7]    [0x00300000000000-0x00303fffffffff], 0x4000000000 bytes
 memory[0x8]    [0x00380000000000-0x00383fffc71fff], 0x3fffc72000 bytes
 memory[0x9]    [0x00383fffc92000-0x00383fffca1fff], 0x10000 bytes
 memory[0xa]    [0x00383fffcb4000-0x00383fffcb5fff], 0x2000 bytes
 reserved.cnt  = 0x2
 reserved[0x0]  [0x00380000000000-0x0038000117e7f8], 0x117e7f9 bytes
 reserved[0x1]  [0x00380004000000-0x0038000d02f74a], 0x902f74b bytes
...
MEMBLOCK configuration:	<- after reduction of memory
 memory size = 0x50a1adf44 reserved size = 0xa1adf44
 memory.cnt  = 0x4
 memory[0x0]    [0x00380000000000-0x0038000117e7f8], 0x117e7f9 bytes
 memory[0x1]    [0x00380004000000-0x0038050d01d74a], 0x50901d74b bytes
 memory[0x2]    [0x00383fffc92000-0x00383fffca1fff], 0x10000 bytes
 memory[0x3]    [0x00383fffcb4000-0x00383fffcb5fff], 0x2000 bytes
 reserved.cnt  = 0x2
 reserved[0x0]  [0x00380000000000-0x0038000117e7f8], 0x117e7f9 bytes
 reserved[0x1]  [0x00380004000000-0x0038000d02f74a], 0x902f74b bytes
...
Early memory node ranges
  node   7: [mem 0x380000000000-0x38000117dfff]
  node   7: [mem 0x380004000000-0x380f0d01bfff]
  node   7: [mem 0x383fffc92000-0x383fffca1fff]
  node   7: [mem 0x383fffcb4000-0x383fffcb5fff]
Could not find start_pfn for node 0
Could not find start_pfn for node 1
Could not find start_pfn for node 2
Could not find start_pfn for node 3
Could not find start_pfn for node 4
Could not find start_pfn for node 5
Could not find start_pfn for node 6
.

The patch was tested on T4-1, T5-8 and Jalap?no.

Cc: sparclinux@vger.kernel.org
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/kernel/setup_64.c |   18 ++------------
 arch/sparc/mm/init_64.c      |   53 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 3fdb455..7d3c539 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -141,21 +141,9 @@ static void __init boot_flags_init(char *commands)
 				process_switch(*commands++);
 			continue;
 		}
-		if (!strncmp(commands, "mem=", 4)) {
-			/*
-			 * "mem=XXX[kKmM]" overrides the PROM-reported
-			 * memory size.
-			 */
-			cmdline_memory_size = simple_strtoul(commands + 4,
-							     &commands, 0);
-			if (*commands = 'K' || *commands = 'k') {
-				cmdline_memory_size <<= 10;
-				commands++;
-			} else if (*commands='M' || *commands='m') {
-				cmdline_memory_size <<= 20;
-				commands++;
-			}
-		}
+		if (!strncmp(commands, "mem=", 4))
+			cmdline_memory_size = memparse(commands + 4, &commands);
+
 		while (*commands && *commands != ' ')
 			commands++;
 	}
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0e25cb7..b2b720f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1888,6 +1888,56 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD];
 static void sun4u_pgprot_init(void);
 static void sun4v_pgprot_init(void);
 
+static phys_addr_t __init available_memory(void)
+{
+	phys_addr_t available = 0ULL;
+	phys_addr_t pa_start, pa_end;
+	int any_nid = NUMA_NO_NODE;
+	int nid;
+	u64 i;
+
+	for_each_free_mem_range(i, any_nid, &pa_start, &pa_end, &nid) {
+		available = available + (pa_end  - pa_start);
+	}
+	return available;
+}
+
+/* We need to exclude reserved regions. This exclusion will include
+ * vmlinux and initrd. To be more precise the initrd size could be used to
+ * compute a new lower limit because it is freed later during initialization.
+ */
+static void __init reduce_memory(phys_addr_t limit_ram)
+{
+	phys_addr_t avail_ram = available_memory();
+	phys_addr_t pa_start, pa_end;
+	int any_nid = NUMA_NO_NODE;
+	int nid;
+	u64 i;
+
+	if (limit_ram >= avail_ram)
+		return;
+
+	for_each_free_mem_range(i, any_nid, &pa_start, &pa_end, &nid) {
+		phys_addr_t region_size = pa_end - pa_start;
+		phys_addr_t clip_start = pa_start;
+
+		avail_ram = avail_ram - region_size;
+		/* Are we consuming too much? */
+		if (avail_ram < limit_ram) {
+			phys_addr_t give_back = limit_ram - avail_ram;
+
+			region_size = region_size - give_back;
+			clip_start = clip_start + give_back;
+		}
+
+		memblock_remove(clip_start, region_size);
+
+		if (avail_ram <= limit_ram)
+			break;
+		i = 0UL;
+	}
+}
+
 void __init paging_init(void)
 {
 	unsigned long end_pfn, shift, phys_base;
@@ -1967,7 +2017,8 @@ void __init paging_init(void)
 
 	find_ramdisk(phys_base);
 
-	memblock_enforce_memory_limit(cmdline_memory_size);
+	if (cmdline_memory_size)
+		reduce_memory(cmdline_memory_size);
 
 	memblock_allow_resize();
 	memblock_dump_all();
-- 
1.7.1

