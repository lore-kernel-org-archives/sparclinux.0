From: David Ahern <david.ahern@oracle.com>
Date: Mon, 15 Jun 2015 20:15:45 +0000
Subject: [PATCH 3/4] sparc64: perf: Add sanity checking on addresses in user stack
Message-Id: <1434399346-21665-4-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Processes are getting killed (sigbus or segv) while walking userspace
callchains when using perf. In some instances I have seen ufp = 0x7ff
which does not seem like a proper stack address.

This patch adds a function to run validity checks against the address
before attempting the copy_from_user. The checks are copied from the
x86 version as a start point with the addition of a 4-byte alignment
check.

Signed-off-by: David Ahern <david.ahern@oracle.com>
---
 arch/sparc/include/asm/uaccess_64.h | 22 ++++++++++++++++++++++
 arch/sparc/kernel/perf_event.c      | 13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index a35194b7dba0..ea6e9a20f3ff 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -49,6 +49,28 @@ do {										\
 	__asm__ __volatile__ ("wr %%g0, %0, %%asi" : : "r" ((val).seg));	\
 } while(0)
 
+/*
+ * Test whether a block of memory is a valid user space address.
+ * Returns 0 if the range is valid, nonzero otherwise.
+ */
+static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
+{
+	if (__builtin_constant_p(size))
+		return addr > limit - size;
+
+	addr += size;
+	if (addr < size)
+		return true;
+
+	return addr > limit;
+}
+
+#define __range_not_ok(addr, size, limit)                               \
+({                                                                      \
+	__chk_user_ptr(addr);                                           \
+	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
+})
+
 static inline int __access_ok(const void __user * addr, unsigned long size)
 {
 	return 1;
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 48387be665e9..a665e3f8c6c6 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1741,6 +1741,16 @@ void perf_callchain_kernel(struct perf_callchain_entry *entry,
 	} while (entry->nr < PERF_MAX_STACK_DEPTH);
 }
 
+static inline int
+valid_user_frame(const void __user *fp, unsigned long size)
+{
+	/* addresses should be at least 4-byte aligned */
+	if (((unsigned long) fp) & 3)
+		return 0;
+
+	return (__range_not_ok(fp, size, TASK_SIZE) = 0);
+}
+
 static void perf_callchain_user_64(struct perf_callchain_entry *entry,
 				   struct pt_regs *regs)
 {
@@ -1753,6 +1763,9 @@ static void perf_callchain_user_64(struct perf_callchain_entry *entry,
 		unsigned long pc;
 
 		usf = (struct sparc_stackf __user *)ufp;
+		if (!valid_user_frame(usf, sizeof(sf)))
+			break;
+
 		if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
 			break;
 
-- 
2.3.0

