From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 25 May 2004 00:38:20 +0000
Subject: PMD_SIZE and compile errors in 2.6.7-rc1
Message-Id: <20040525003820.GK2632@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

My attempts to build the 2.6.7-rc1 kernel on my SS20 fail when compiling
the mm/rmap.c file. The problem is on line 541:

540	#define CLUSTER_SIZE    (32 * PAGE_SIZE)
541	#if     CLUSTER_SIZE  > PMD_SIZE
542	#undef  CLUSTER_SIZE
543	#define CLUSTER_SIZE    PMD_SIZE
544	#endif
545	#define CLUSTER_MASK    (~(CLUSTER_SIZE - 1))

On 32-bit sparc, the PMD_SIZE macro expands to a function call, unlike
64-bit sparc where it is a plain macro expanding out to a compile-time
derviable value. So, the pre-processor gets stuck and compiling the file
fails.

The following patch changes the PMD_SIZE to macros the preprocessor can
handle, but I'm not sure about the removal of the BTFIXUP_SETHI()
wrapper and what consequences may result. The kernel is rebuilding as I
write this so the patch below is untested. Comments?

Art Haas

=== include/asm-sparc/pgtable.h 1.21 vs edited ==--- 1.21/include/asm-sparc/pgtable.h	2004-05-22 16:56:24 -05:00
+++ edited/include/asm-sparc/pgtable.h	2004-05-24 19:26:41 -05:00
@@ -113,7 +113,13 @@
 BTFIXUPDEF_INT(page_kernel)
 
 #define PMD_SHIFT       	BTFIXUP_SIMM13(pmd_shift)
-#define PMD_SIZE        	BTFIXUP_SETHI(pmd_size)
+#ifdef CONFIG_SUN4
+#define PMD_SIZE SUN4C_PMD_SIZE
+#elif SUN4C_PMD_SIZE = SRMMU_PMD_SIZE_SOFT
+#define PMD_SIZE SUN4C_PMD_SIZE
+#else
+#error "unexpected PMD_SIZE values"
+#endif
 #define PMD_MASK        	BTFIXUP_SETHI(pmd_mask)
 #define PMD_ALIGN(addr) 	pmd_align(addr)
 #define PGDIR_SHIFT     	BTFIXUP_SIMM13(pgdir_shift)

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
