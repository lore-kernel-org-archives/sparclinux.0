From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 24 Mar 2017 16:13:12 +0000
Subject: [PATCH v3 1/7] Add multibyte memset functions
Message-Id: <20170324161318.18718-2-willy@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170324161318.18718-1-willy@infradead.org>
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, Minchan Kim <minchan@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

memset16(), memset32() and memset64() are like memset(), but allow the
caller to fill the destination with a multibyte pattern.  memset_l()
and memset_p() allow the caller to use unsigned long and pointer
values respectively.  memset64() is currently only available on 64-bit
architectures.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/string.h | 30 ++++++++++++++++++++++
 lib/string.c           | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 26b6f6a66f83..b376875b650c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -99,6 +99,36 @@ extern __kernel_size_t strcspn(const char *,const char *);
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
 #endif
+
+#ifndef __HAVE_ARCH_MEMSET16
+extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET32
+extern void *memset32(uint32_t *, uint32_t, __kernel_size_t);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET64
+extern void *memset64(uint64_t *, uint64_t, __kernel_size_t);
+#endif
+
+static inline void *memset_l(unsigned long *p, unsigned long v,
+		__kernel_size_t n)
+{
+	if (BITS_PER_LONG = 32)
+		return memset32((uint32_t *)p, v, n);
+	else
+		return memset64((uint64_t *)p, v, n);
+}
+
+static inline void *memset_p(void **p, void *v, __kernel_size_t n)
+{
+	if (BITS_PER_LONG = 32)
+		return memset32((uint32_t *)p, (uintptr_t)v, n);
+	else
+		return memset64((uint64_t *)p, (uintptr_t)v, n);
+}
+
 #ifndef __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *,const void *,__kernel_size_t);
 #endif
diff --git a/lib/string.c b/lib/string.c
index ed83562a53ae..f18ba402e503 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -697,6 +697,74 @@ void memzero_explicit(void *s, size_t count)
 }
 EXPORT_SYMBOL(memzero_explicit);
 
+#ifndef __HAVE_ARCH_MEMSET16
+/**
+ * memset16() - Fill a memory area with a uint16_t
+ * @s: Pointer to the start of the area.
+ * @v: The value to fill the area with
+ * @count: The number of values to store
+ *
+ * Differs from memset() in that it fills with a uint16_t instead
+ * of a byte.  Remember that @count is the number of uint16_ts to
+ * store, not the number of bytes.
+ */
+void *memset16(uint16_t *s, uint16_t v, size_t count)
+{
+	uint16_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+EXPORT_SYMBOL(memset16);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET32
+/**
+ * memset32() - Fill a memory area with a uint32_t
+ * @s: Pointer to the start of the area.
+ * @v: The value to fill the area with
+ * @count: The number of values to store
+ *
+ * Differs from memset() in that it fills with a uint32_t instead
+ * of a byte.  Remember that @count is the number of uint32_ts to
+ * store, not the number of bytes.
+ */
+void *memset32(uint32_t *s, uint32_t v, size_t count)
+{
+	uint32_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+EXPORT_SYMBOL(memset32);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET64
+#if BITS_PER_LONG > 32
+/**
+ * memset64() - Fill a memory area with a uint64_t
+ * @s: Pointer to the start of the area.
+ * @v: The value to fill the area with
+ * @count: The number of values to store
+ *
+ * Differs from memset() in that it fills with a uint64_t instead
+ * of a byte.  Remember that @count is the number of uint64_ts to
+ * store, not the number of bytes.
+ */
+void *memset64(uint64_t *s, uint64_t v, size_t count)
+{
+	uint64_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+EXPORT_SYMBOL(memset64);
+#endif
+#endif
+
 #ifndef __HAVE_ARCH_MEMCPY
 /**
  * memcpy - Copy one area of memory to another
-- 
2.11.0

