From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 04 Jun 2019 09:21:50 +0000
Subject: [PATCH] mm/mmap: Move common defines to mman-common.h
Message-Id: <20190604090950.31417-1-aneesh.kumar@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

Two architecture that use arch specific MMAP flags are powerpc and sparc.
We still have few flag values common across them and other architectures.
Consolidate this in mman-common.h.

Also update the comment to indicate where to find HugeTLB specific reserved
values

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/mman.h   | 6 +-----
 arch/sparc/include/uapi/asm/mman.h     | 6 ------
 include/uapi/asm-generic/mman-common.h | 6 +++++-
 include/uapi/asm-generic/mman.h        | 9 ++++-----
 4 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index 65065ce32814..c0c737215b00 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -21,15 +21,11 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
+
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 #define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
 
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
 /* Override any generic PKEY permission defines */
 #define PKEY_DISABLE_EXECUTE   0x4
 #undef PKEY_ACCESS_MASK
diff --git a/arch/sparc/include/uapi/asm/mman.h b/arch/sparc/include/uapi/asm/mman.h
index f6f99ec65bb3..cec9f4109687 100644
--- a/arch/sparc/include/uapi/asm/mman.h
+++ b/arch/sparc/include/uapi/asm/mman.h
@@ -22,10 +22,4 @@
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 #define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
 
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-
 #endif /* _UAPI__SPARC_MMAN_H__ */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index bea0278f65ab..ef4623f03156 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -25,7 +25,11 @@
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
 #endif
 
-/* 0x0100 - 0x40000 flags are defined in asm-generic/mman.h */
+/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 2dffcbf705b3..57e8195d0b53 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -9,12 +9,11 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
 
-/* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
+/*
+ * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
+ * for MAP_HUGETLB usage
+ */
 
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
-- 
2.21.0
