From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2018 04:19:53 +0000
Subject: [PATCH WIP 2/2] rseq: Add sparc support to rseq selftests.
Message-Id: <20181010.211953.685683151560128440.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

    
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index eec2663261f2..b2c7bf48b759 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -206,6 +206,32 @@ unsigned int yield_mod_cnt, nr_abort;
 	"bnez " INJECT_ASM_REG ", 222b\n\t" \
 	"333:\n\t"
 
+#elif defined(__sparc__)
+
+#define RSEQ_INJECT_INPUT \
+	, [loop_cnt_1]"m"(loop_cnt[1]) \
+	, [loop_cnt_2]"m"(loop_cnt[2]) \
+	, [loop_cnt_3]"m"(loop_cnt[3]) \
+	, [loop_cnt_4]"m"(loop_cnt[4]) \
+	, [loop_cnt_5]"m"(loop_cnt[5]) \
+	, [loop_cnt_6]"m"(loop_cnt[6])
+
+#define INJECT_ASM_REG	"g2"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
+
+#define RSEQ_INJECT_ASM(n) \
+	"ld %[loop_cnt_" #n "], %%" INJECT_ASM_REG "\n\t" \
+	"cmp %%" INJECT_ASM_REG ", 0\n\t" \
+	"be 333f\n\t" \
+	" nop\n\t" \
+	"222:\n\t" \
+	"subcc %%" INJECT_ASM_REG ", 1, %%" INJECT_ASM_REG "\n\t" \
+	"bne 222b\n\t"\
+	" nop\n\t" \
+	"333:\n\t"
+
 #else
 #error unsupported target
 #endif
diff --git a/tools/testing/selftests/rseq/rseq-sparc.h b/tools/testing/selftests/rseq/rseq-sparc.h
new file mode 100644
index 000000000000..c6bae8748efd
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-sparc.h
@@ -0,0 +1,472 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#define RSEQ_SIG	0x53053053
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("membar #StoreLoad" ::: "memory")
+#define rseq_smp_rmb()	rseq_smp_mb()
+#define rseq_smp_wmb()	rseq_smp_mb()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_barrier();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_barrier();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#define __RSEQ_ASM_SETUP_TABLE(label, rseq_cs, version, flags,		\
+				start_ip, post_commit_offset, abort_ip)	\
+		"94: call 95f\n\t"					\
+		" nop\n\t"						\
+		".balign 32\n\t"					\
+		"96:\n\t"						\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".xword " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		"95: add %%o7, (96b - 94b), %%o7\n\t"			\
+		RSEQ_INJECT_ASM(1)					\
+		"stx %%o7, %[" __rseq_str(rseq_cs) "]\n\t"		\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_SETUP_TABLE(label, rseq_cs, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_SETUP_TABLE(label, rseq_cs, 0x0, 0x0, start_ip,	\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)	\
+		RSEQ_INJECT_ASM(1)				\
+		"stx %%o7, %[" __rseq_str(rseq_cs) "]\n\t"	\
+		__rseq_str(label) ":\n\t"
+
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
+		"ld %[" __rseq_str(current_cpu_id) "], %%g1\n\t"	\
+		"cmp %%g1, %[" __rseq_str(cpu_id) "]\n\t"		\
+		"bne " __rseq_str(label) "\n\t"				\
+		" nop\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		".word " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"ba %l[" __rseq_str(abort_label) "]\n\t"		\
+		" nop\n\t"						\
+		".popsection\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_SETUP_TABLE(1, rseq_cs, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldx %[v], %%g1\n\t"
+		"cmp %[expect], %%g1\n\t"
+		"bne,pn %%xcc, %l[cmpfail]\n\t"
+		" nop\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldx %[v], %%g1\n\t"
+		"cmp %[expect], %%g1\n\t"
+		"bne,pn %%xcc, %l[error2]\n\t"
+		" nop\n\t"
+#endif
+		/* final store */
+		"stx %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "g1", "o7"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_SETUP_TABLE(1, rseq_cs, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldx %[v], %%g1\n\t"
+		"cmp %[expectnot], %%g1\n\t"
+		"be,pn %%xcc, %l[cmpfail]\n\t"
+		" nop\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldx %[v], %%g1\n\t"
+		"cmp %[expectnot], %%g1\n\t"
+		"be,pn %%xcc, %l[error2]\n\t"
+		" nop\n\t"
+#endif
+		"stx %%g1, %[load]\n\t"
+		"add %%g1, %[voffp], %%g1\n\t"
+		"ldx [%%g1], %%g1\n\t"
+		/* final store */
+		"stx %%g1, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"r" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "g1", "o7"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_SETUP_TABLE(1, rseq_cs, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		"ldx %[v], %%g1\n\t"
+		"add %%g1, %[count], %%g1\n\t"
+		/* final store */
+		"stx %%g1, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "g1", "o7"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_SETUP_TABLE(1, rseq_cs, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldx %[v], %%g1\n\t"
+		"cmp %%g1, %[expect]\n\t"
+		"bne,pn %%xcc, %l[cmpfail]\n\t"
+		" nop\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldx %[v], %%g1\n\t"
+		"cmp %%g1, %[expect]\n\t"
+		"bne,pn %%xcc, %l[error2]\n\t"
+		" nop\n\t"
+#endif
+		/* try store */
+		"stx %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"stx %[newv], %[v]\n\t"
+
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "g1", "o7"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* sparc is effectively TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2, newv, cpu);
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_SETUP_TABLE(1, rseq_cs, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldx %[v], %%g1\n\t"
+		"cmp %%g1, %[expect]\n\t"
+		"bne,pn %%xcc, %[cmpfail]\n\t"
+		" nop\n\t"
+		RSEQ_INJECT_ASM(4)
+		"ldx %[v2], %%g1\n\t"
+		"cmp %%g1, %[expect2]\n\t"
+		"bne,pn %%xcc, %l[cmpfail]\n\t"
+		" nop\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldx %[v], %%g1\n\t"
+		"cmp %%g1, %[expect]\n\t"
+		"bne,pn %%xcc, %[error2]\n\t"
+		" nop\n\t"
+		"ldx %[v2], %%g1\n\t"
+		"cmp %%g1, %[expect2]\n\t"
+		"bne,pn %%xcc, %l[error3]\n\t"
+		" nop\n\t"
+#endif
+		/* final store */
+		"stx %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "g1", "o7"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_SETUP_TABLE(1, rseq_cs, 1f, 2f, 4f) /* start, commit, abort */
+		/* setup for memcpy */
+		"mov %[dst], %%o0\n\t"
+		"mov %[src], %%o1\n\t"
+		"mov %[len], %%o2\n\t"
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldx %[v], %%g1\n\t"
+		"cmp %%g1, %[expect]\n\t"
+		"bne,pn %%xcc, %[cmpfail]\n\t"
+		" nop\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldx %[v], %%g1\n\t"
+		"cmp %%g1, %[expect]\n\t"
+		"bne,pn %%xcc, %[error2]\n\t"
+		" nop\n\t"
+#endif
+		/* try memcpy */
+		"cmp %%o2, 0\n\t"
+		"be,pn %%xcc, 333f\n\t"
+		" nop\n\t"
+		"222:\n\t"
+		"ldub [%%o1], %%g1\n\t"
+		"stb %%g1, [%%o0]\n\t"
+		"add %%o1, 1, %%o1\n\t"
+		"add %%o0, 1, %%o0\n\t"
+		"subcc %%o2, 1, %%o2\n\t"
+		"bne,pt %%xcc, 222b\n\t"
+		" nop\n\t"
+		"333:\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"stx %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "g1", "o0", "o1", "o2", "o7"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* s390 is effectively TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
+					    newv, cpu);
+}
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70f9b52..5af7a0c733dc 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -79,6 +79,8 @@ extern __thread volatile struct rseq __rseq_abi;
 #include <rseq-mips.h>
 #elif defined(__s390__)
 #include <rseq-s390.h>
+#elif defined(__sparc__)
+#include <rseq-sparc.h>
 #else
 #error unsupported target
 #endif
