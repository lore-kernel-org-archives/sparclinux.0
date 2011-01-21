From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Fri, 21 Jan 2011 20:36:33 +0000
Subject: [patch 3/3] tracepoints: use __u64_aligned/U64_ALIGN()
Message-Id: <20110121203643.046218322@efficios.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110121203630.725922272@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, Richard Mortimer <richm@oldelvet.org.uk>, ben@decadent.org.uk, sparclinux@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 7e066fb870fcd1025ec3ba7bbde5d541094f4ce1 added the aligned(32) type and
variable attribute to the tracepoint structures to deal with gcc happily
aligning statically defined structures on 32-byte multiples.

Working on issues within Ftrace, we came up with __64_aligned, which deals with
this issue more elegantly by forcing an 8-byte alignment to both the type
declaration and variable definition.

This therefore saves space, bringing down the size of struct tracepoint from 64
bytes to 38 on 64-bit architectures.

Updating:
- The type attribute (for iteration over the struct tracepoint array)
- Added the variable attribute to the extern definition (needed to force gcc to
  consider this alignment for the following definition)
- The definition variable attribute (to force gcc to this specific alignment for
  the static definitions)
- The linker script (8-byte alignment can now replace the previous 32-byte
  alignment for the custom tracepoint section)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: David Miller <davem@davemloft.net>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Frederic Weisbecker <fweisbec@gmail.com>
CC: Ingo Molnar <mingo@elte.hu>
---
 include/asm-generic/vmlinux.lds.h |    2 +-
 include/linux/tracepoint.h        |   12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

Index: linux-2.6-lttng/include/asm-generic/vmlinux.lds.h
=================================--- linux-2.6-lttng.orig/include/asm-generic/vmlinux.lds.h
+++ linux-2.6-lttng/include/asm-generic/vmlinux.lds.h
@@ -168,7 +168,7 @@
 	CPU_KEEP(exit.data)						\
 	MEM_KEEP(init.data)						\
 	MEM_KEEP(exit.data)						\
-	. = ALIGN(32);							\
+	U64_ALIGN();							\
 	VMLINUX_SYMBOL(__start___tracepoints) = .;			\
 	*(__tracepoints)						\
 	VMLINUX_SYMBOL(__stop___tracepoints) = .;			\
Index: linux-2.6-lttng/include/linux/tracepoint.h
=================================--- linux-2.6-lttng.orig/include/linux/tracepoint.h
+++ linux-2.6-lttng/include/linux/tracepoint.h
@@ -33,12 +33,7 @@ struct tracepoint {
 	void (*regfunc)(void);
 	void (*unregfunc)(void);
 	struct tracepoint_func *funcs;
-} __attribute__((aligned(32)));		/*
-					 * Aligned on 32 bytes because it is
-					 * globally visible and gcc happily
-					 * align these on the structure size.
-					 * Keep in sync with vmlinux.lds.h.
-					 */
+} __u64_aligned;
 
 /*
  * Connect a probe to a tracepoint.
@@ -143,7 +138,7 @@ static inline void tracepoint_update_pro
  * structure. Force alignment to the same alignment as the section start.
  */
 #define __DECLARE_TRACE(name, proto, args, data_proto, data_args)	\
-	extern struct tracepoint __tracepoint_##name;			\
+	extern struct tracepoint __u64_aligned __tracepoint_##name;	\
 	static inline void trace_##name(proto)				\
 	{								\
 		JUMP_LABEL(&__tracepoint_##name.state, do_trace);	\
@@ -174,7 +169,8 @@ do_trace:								\
 	static const char __tpstrtab_##name[]				\
 	__attribute__((section("__tracepoints_strings"))) = #name;	\
 	struct tracepoint __tracepoint_##name				\
-	__attribute__((section("__tracepoints"), aligned(32))) =	\
+	__u64_aligned							\
+	__attribute__((section("__tracepoints"))) =			\
 		{ __tpstrtab_##name, 0, reg, unreg, NULL }
 
 #define DEFINE_TRACE(name)						\

