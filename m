From: Bob Picco <bpicco@meloft.net>
Date: Tue, 16 Sep 2014 16:54:13 +0000
Subject: [PATCH] sparc64: max_phys_bits 49
Message-Id: <1410886453-16547-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

We should be in a position now to handle 49 bits of physical address.
The patch puts M6 in the S3Core group for 47 bits of physical address.

Below illustrates the reduction in number of locked TLB entries.

PROMLIB: Sun IEEE Boot Prom 'OBP 042914_5b6e3f9d8b48 2014/04/29 21:34'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.17.0-rc3 (root@ca-sparc30.us.oracle.com) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-4) (GCC) ) #3 SMP Tue Sep 9 15:38:48 ADT 2014
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:10:e0:56:96:4a
PAGE_OFFSET is 0xfffe000000000000 (max_phys_bits = 49)
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 1254161 bytes of memory.
MDESC: Size is 709648 bytes.

Cc: sparclinux@vger.kernel.org
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/page_64.h |    2 +-
 arch/sparc/mm/init_64.c          |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 172733f..fd8ed3e 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -127,7 +127,7 @@ extern unsigned long PAGE_OFFSET;
  * is used to size various tables used to manage kernel TLB misses and
  * also the sparsemem code.
  */
-#define MAX_PHYS_ADDRESS_BITS	47
+#define MAX_PHYS_ADDRESS_BITS	49
 
 /* This represents a subset of the physical address bits. It is used
  * to determine how the powerof2 for sparc64_valid_addr_bitmap is changed.
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 24ca110..8f83b09 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1855,9 +1855,13 @@ static void __init setup_page_offset(void)
 		case SUN4V_CHIP_NIAGARA4:
 		case SUN4V_CHIP_NIAGARA5:
 		case SUN4V_CHIP_SPARC64X:
-		default:
+		case SUN4V_CHIP_SPARC_M6:
 			max_phys_bits = 47;
 			break;
+		case SUN4V_CHIP_SPARC_M7:
+		default:
+			max_phys_bits = 49;
+			break;
 		}
 	}
 
-- 
1.7.1

