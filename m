From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 09 Jan 2004 06:54:14 +0000
Subject: [SPARC32] Minor srmmu fixes
Message-Id: <20040109065414.GA22008@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here are a few small srmmu bits that didn't get into the last patch.
Also, this removes the needless declaration Pete noticed.  Dave,
please apply.

Note to users: This should now eliminate the last of the oopses/BUGs
caused by srmmu issues.  It does not yet correct the out-of-nocache
problem.

=== arch/sparc/mm/fault.c 1.15 vs edited ==--- 1.15/arch/sparc/mm/fault.c	Wed Jan  7 23:34:45 2004
+++ edited/arch/sparc/mm/fault.c	Wed Jan  7 23:39:56 2004
@@ -36,7 +36,6 @@
 
 #define ELEMENTS(arr) (sizeof (arr)/sizeof (arr[0]))
 
-extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 extern int prom_node_root;
 
 /* At boot time we determine these two values necessary for setting
=== arch/sparc/mm/srmmu.c 1.38 vs edited ==--- 1.38/arch/sparc/mm/srmmu.c	Wed Jan  7 23:34:45 2004
+++ edited/arch/sparc/mm/srmmu.c	Thu Jan  8 18:36:33 2004
@@ -349,7 +349,7 @@
 		    vaddr, (unsigned long)SRMMU_NOCACHE_VADDR);
 		BUG();
 	}
-	if (vaddr+size >= srmmu_nocache_end) {
+	if (vaddr+size > srmmu_nocache_end) {
 		printk("Vaddr %lx is bigger than nocache end 0x%lx\n",
 		    vaddr, srmmu_nocache_end);
 		BUG();
@@ -1071,7 +1071,7 @@
 		}
 		if (start > (0xffffffffUL - SRMMU_PMD_SIZE_SOFT))
 			break;
-		start = (start + SRMMU_PMD_SIZE) & SRMMU_PMD_MASK;
+		start = (start + SRMMU_PMD_SIZE_SOFT) & SRMMU_PMD_MASK_SOFT;
 	}
 }
 
@@ -1101,7 +1101,7 @@
 		}
 		if (start > (0xffffffffUL - SRMMU_PMD_SIZE_SOFT))
 			break;
-		start = (start + SRMMU_PMD_SIZE) & SRMMU_PMD_MASK;
+		start = (start + SRMMU_PMD_SIZE_SOFT) & SRMMU_PMD_MASK_SOFT;
 	}
 }
 


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
