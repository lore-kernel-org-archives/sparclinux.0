From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Sun, 12 Aug 2007 14:54:55 +0000
Subject: [patch 21/23] Add cmpxchg_local to sparc64
Message-Id: <20070812145843.393209640@polymtl.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20070812145434.520271946@polymtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, sparclinux@vger.kernel.org, wli@holomorphy.com

Use cmpxchg_u32 and cmpxchg_u64 for cmpxchg_local and cmpxchg64_local. For other
type sizes, use the new generic cmpxchg_local (disables interrupt).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: clameter@sgi.com
CC: sparclinux@vger.kernel.org
CC: wli@holomorphy.com
---
 include/asm-sparc64/system.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: linux-2.6-lttng/include/asm-sparc64/system.h
=================================--- linux-2.6-lttng.orig/include/asm-sparc64/system.h	2007-08-07 14:31:51.000000000 -0400
+++ linux-2.6-lttng/include/asm-sparc64/system.h	2007-08-07 15:13:05.000000000 -0400
@@ -314,6 +314,32 @@ __cmpxchg(volatile void *ptr, unsigned l
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+#include <asm-generic/cmpxchg-local.h>
+
+/*
+ * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
+ * them available.
+ */
+
+static inline unsigned long __cmpxchg_local(volatile void *ptr,
+				      unsigned long old,
+				      unsigned long new, int size)
+{
+	switch (size) {
+	case 4:
+	case 8:	return __cmpxchg(ptr, old, new, size);
+	default:
+		return __cmpxchg_local_generic(ptr, old, new, size);
+	}
+
+	return old;
+}
+
+#define cmpxchg_local(ptr,o,n)					  	\
+	(__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),	\
+			   	 (unsigned long)(n), sizeof(*(ptr)))
+#define cmpxchg64_local(ptr,o,n) cmpxchg_local((ptr), (o), (n))
+
 #endif /* !(__ASSEMBLY__) */
 
 #define arch_align_stack(x) (x)

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
