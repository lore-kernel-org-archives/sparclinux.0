From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 25 May 2004 00:52:51 +0000
Subject: Re: PMD_SIZE and compile errors in 2.6.7-rc1
Message-Id: <20040525005251.GR1833@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040525003820.GK2632@artsapartment.org>
In-Reply-To: <20040525003820.GK2632@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 24, 2004 at 07:38:20PM -0500, Art Haas wrote:
> My attempts to build the 2.6.7-rc1 kernel on my SS20 fail when compiling
> the mm/rmap.c file. The problem is on line 541:
> 540	#define CLUSTER_SIZE    (32 * PAGE_SIZE)
> 541	#if     CLUSTER_SIZE  > PMD_SIZE
> 542	#undef  CLUSTER_SIZE
> 543	#define CLUSTER_SIZE    PMD_SIZE
> 544	#endif
> 545	#define CLUSTER_MASK    (~(CLUSTER_SIZE - 1))
> On 32-bit sparc, the PMD_SIZE macro expands to a function call, unlike
> 64-bit sparc where it is a plain macro expanding out to a compile-time
> derviable value. So, the pre-processor gets stuck and compiling the file
> fails.
> The following patch changes the PMD_SIZE to macros the preprocessor can
> handle, but I'm not sure about the removal of the BTFIXUP_SETHI()
> wrapper and what consequences may result. The kernel is rebuilding as I
> write this so the patch below is untested. Comments?

Hmm, preprocessor logic on the thing is probably ungood. How about this?


-- wli

Index: sparc32-2.6.7-rc1/mm/rmap.c
=================================--- sparc32-2.6.7-rc1.orig/mm/rmap.c	2004-05-24 08:50:32.354217000 -0700
+++ sparc32-2.6.7-rc1/mm/rmap.c	2004-05-24 17:50:11.082902000 -0700
@@ -537,11 +537,7 @@
  * there there won't be many ptes located within the scan cluster.  In this case
  * maybe we could scan further - to the end of the pte page, perhaps.
  */
-#define CLUSTER_SIZE	(32 * PAGE_SIZE)
-#if     CLUSTER_SIZE  >	PMD_SIZE
-#undef  CLUSTER_SIZE
-#define CLUSTER_SIZE	PMD_SIZE
-#endif
+#define CLUSTER_SIZE	min(32*PAGE_SIZE, PMD_SIZE)
 #define CLUSTER_MASK	(~(CLUSTER_SIZE - 1))
 
 static int try_to_unmap_cluster(unsigned long cursor,
