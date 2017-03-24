From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 24 Mar 2017 16:13:14 +0000
Subject: [PATCH v3 3/7] x86: Implement memset16, memset32 & memset64
Message-Id: <20170324161318.18718-4-willy@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170324161318.18718-1-willy@infradead.org>
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, Minchan Kim <minchan@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

These are single instructions on x86.  There's no 64-bit instruction
for x86-32, but we don't yet have any user for memset64() on 32-bit
architectures, so don't bother to implement it.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/x86/include/asm/string_32.h | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/string_64.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 3d3e8353ee5c..84da91fe13ac 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -331,6 +331,30 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 	 : __memset((s), (c), (count)))
 #endif
 
+#define __HAVE_ARCH_MEMSET16
+static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
+{
+	int d0, d1;
+	asm volatile("rep\n\t"
+		     "stosw"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET_32
+static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
+{
+	int d0, d1;
+	asm volatile("rep\n\t"
+		     "stosl"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
 /*
  * find the first occurrence of byte 'c', or 1 past the area if none
  */
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index a164862d77e3..71c5e860c7da 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -56,6 +56,42 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
 
+#define __HAVE_ARCH_MEMSET16
+static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
+{
+	long d0, d1;
+	asm volatile("rep\n\t"
+		     "stosw"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET32
+static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
+{
+	long d0, d1;
+	asm volatile("rep\n\t"
+		     "stosl"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET64
+static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
+{
+	long d0, d1;
+	asm volatile("rep\n\t"
+		     "stosq"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void *dest, const void *src, size_t count);
 void *__memmove(void *dest, const void *src, size_t count);
-- 
2.11.0

