From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 25 May 2008 16:58:13 +0000
Subject: [2.6 patch] sparc64: global_reg_snapshot is not for userspace
Message-Id: <20080525165813.GC1791@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

global_reg_snapshot shouldn't be visible in our userspace headers.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-sparc64/ptrace.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

bcd3ca7553a2f3e416db385fd976ef5b862b1370 diff --git a/include/asm-sparc64/ptrace.h b/include/asm-sparc64/ptrace.h
index d8a56cd..b163da7 100644
--- a/include/asm-sparc64/ptrace.h
+++ b/include/asm-sparc64/ptrace.h
@@ -126,6 +126,8 @@ struct sparc_trapf {
 #define TRACEREG32_SZ	sizeof(struct pt_regs32)
 #define STACKFRAME32_SZ	sizeof(struct sparc_stackf32)
 
+#ifdef __KERNEL__
+
 struct global_reg_snapshot {
 	unsigned long		tstate;
 	unsigned long		tpc;
@@ -137,8 +139,6 @@ struct global_reg_snapshot {
 	unsigned long		pad2;
 };
 
-#ifdef __KERNEL__
-
 #define __ARCH_WANT_COMPAT_SYS_PTRACE
 
 #define force_successful_syscall_return()	    \
@@ -306,6 +306,8 @@ extern void __show_regs(struct pt_regs *);
 #define SF_XARG5  0x58
 #define SF_XXARG  0x5c
 
+#ifdef __KERNEL__
+
 /* global_reg_snapshot offsets */
 #define GR_SNAP_TSTATE	0x00
 #define GR_SNAP_TPC	0x08
@@ -316,6 +318,8 @@ extern void __show_regs(struct pt_regs *);
 #define GR_SNAP_PAD1	0x30
 #define GR_SNAP_PAD2	0x38
 
+#endif  /*  __KERNEL__  */
+
 /* Stuff for the ptrace system call */
 #define PTRACE_SPARC_DETACH       11
 #define PTRACE_GETREGS            12

