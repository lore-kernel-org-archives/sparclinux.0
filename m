From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 25 Apr 2016 18:28:07 +0000
Subject: [PATCH V3 2/3] Implement byte-by-byte memory access facilitators
Message-Id: <1461608888-5063-3-git-send-email-dave.kleikamp@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sparc64 requires type-aligned memory access. Since data buffers may not
be properly aligned, implement a safe copy from memory per data type.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 defs.h |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/defs.h b/defs.h
index e3afc58..d9d4559 100644
--- a/defs.h
+++ b/defs.h
@@ -2187,6 +2187,45 @@ struct builtin_debug_table {
  *  Facilitators for pulling correctly-sized data out of a buffer at a
  *  known address. 
  */
+
+#ifdef NEED_ALIGNED_MEM_ACCESS
+
+#define DEF_LOADER(TYPE)			\
+static inline TYPE				\
+load_##TYPE (char *addr)			\
+{						\
+	TYPE ret;				\
+	size_t i = sizeof(TYPE);		\
+	while (i--)				\
+		((char *)&ret)[i] = addr[i];	\
+	return ret;				\
+}
+
+DEF_LOADER(int);
+DEF_LOADER(uint);
+DEF_LOADER(long);
+DEF_LOADER(ulong);
+DEF_LOADER(ulonglong);
+DEF_LOADER(ushort);
+DEF_LOADER(short);
+typedef void *pointer_t;
+DEF_LOADER(pointer_t);
+
+#define LOADER(TYPE) load_##TYPE
+
+#define INT(ADDR)       LOADER(int) ((char *)(ADDR))
+#define UINT(ADDR)      LOADER(uint) ((char *)(ADDR))
+#define LONG(ADDR)      LOADER(long) ((char *)(ADDR))
+#define ULONG(ADDR)     LOADER(ulong) ((char *)(ADDR))
+#define ULONGLONG(ADDR) LOADER(ulonglong) ((char *)(ADDR))
+#define ULONG_PTR(ADDR) ((ulong *) (LOADER(pointer_t) ((char *)(ADDR))))
+#define USHORT(ADDR)    LOADER(ushort) ((char *)(ADDR))
+#define SHORT(ADDR)     LOADER(short) ((char *)(ADDR))
+#define UCHAR(ADDR)     *((unsigned char *)((char *)(ADDR)))
+#define VOID_PTR(ADDR)  ((void *) (LOADER(pointer_t) ((char *)(ADDR))))
+
+#else
+
 #define INT(ADDR)       *((int *)((char *)(ADDR)))
 #define UINT(ADDR)      *((uint *)((char *)(ADDR)))
 #define LONG(ADDR)      *((long *)((char *)(ADDR)))
@@ -2198,6 +2237,8 @@ struct builtin_debug_table {
 #define UCHAR(ADDR)     *((unsigned char *)((char *)(ADDR)))
 #define VOID_PTR(ADDR)  *((void **)((char *)(ADDR)))
 
+#endif /* NEED_ALIGNED_MEM_ACCESS */
+
 struct node_table {
 	int node_id;
 	ulong pgdat;
-- 
1.7.1

