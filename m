From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Mon, 20 Aug 2007 23:43:54 +0000
Subject: [patch 21/23] Add cmpxchg_local to sparc64 (update)
Message-Id: <20070820234354.GA2269@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820201519.512791382@polymtl.ca> <20070820201831.178200926@polymtl.ca> <646765f40708201634u5437f307l8259456c92af5cf5@mail.gmail.com>
In-Reply-To: <646765f40708201634u5437f307l8259456c92af5cf5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, clameter@sgi.com, sparclinux@vger.kernel.org, wli@holomorphy.com

Add cmpxchg_local to sparc64

Use cmpxchg_u32 and cmpxchg_u64 for cmpxchg_local and cmpxchg64_local. For other
type sizes, use the new generic cmpxchg_local (disables interrupt).

Change:
* Julian Calaby (julian.calaby@gmail.com) wrote:
> Shouldn't #includes go at the start of the file?
> 

Since the header depends on local_irqsave/local_irqrestore, it must be
included after their declaration.

Actually, being below the
#include <linux/irqflags.h> should be enough, and on sparc64 it is
included at the beginning of system.h.

So it makes sense to move it up for sparc64.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: clameter@sgi.com
CC: sparclinux@vger.kernel.org
CC: wli@holomorphy.com
---
 include/asm-sparc64/system.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: linux-2.6-lttng/include/asm-sparc64/system.h
=================================--- linux-2.6-lttng.orig/include/asm-sparc64/system.h	2007-08-20 17:40:57.000000000 -0400
+++ linux-2.6-lttng/include/asm-sparc64/system.h	2007-08-20 19:42:32.000000000 -0400
@@ -9,6 +9,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/irqflags.h>
+#include <asm-generic/cmpxchg-local.h>
 
 /*
  * Sparc (general) CPU types
@@ -314,6 +315,30 @@ __cmpxchg(volatile void *ptr, unsigned l
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
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
