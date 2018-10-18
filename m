From: David Miller <davem@davemloft.net>
Date: Thu, 18 Oct 2018 18:32:50 +0000
Subject: [PATCH] sparc: Fix syscall fallback bugs in VDSO.
Message-Id: <20181018.113250.518901581103673055.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


First, the trap number for 32-bit syscalls is 0x10.

Also, only negate the return value when syscall error is indicated by
the carry bit being set.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/vdso/vclock_gettime.c | 12 +++++++++++-
 tools/perf/util/event.c          |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 3feb3d960ca5..75dca9aab737 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -33,9 +33,19 @@
 #define	TICK_PRIV_BIT	(1ULL << 63)
 #endif
 
+#ifdef	CONFIG_SPARC64
 #define SYSCALL_STRING							\
 	"ta	0x6d;"							\
-	"sub	%%g0, %%o0, %%o0;"					\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#else
+#define SYSCALL_STRING							\
+	"ta	0x10;"							\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#endif
 
 #define SYSCALL_CLOBBERS						\
 	"f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",			\
