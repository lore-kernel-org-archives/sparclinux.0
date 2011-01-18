From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Tue, 18 Jan 2011 16:46:33 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110118164633.GA12872@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <1295273486.16479.15.camel@gandalf.stny.rr.com> <20110117.213448.226787087.davem@davemloft.net> <20110117.220039.71097651.davem@davemloft.net> <20110117.220857.104046847.davem@davemloft.net>
In-Reply-To: <20110117.220857.104046847.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

* David Miller (davem@davemloft.net) wrote:
> From: David Miller <davem@davemloft.net>
> Date: Mon, 17 Jan 2011 22:00:39 -0800 (PST)
> 
> > ftrace: Remove unnecessary alignment tag from ftrace_event_call.
> > 
> > It's completely unnecessary and causes problems on platforms
> > where this tag down-aligns the structure's alignment.
> > 
> > Signed-off-by: David S. Miller <davem@davemloft.net>
>  ...
> 
> Ok, unless we can explain why these alignments are needed at all, we
> should kill all of them:

ftrace: linker script add missing struct align

We should add the missing "STRUCT_ALIGN();" in
include/asm-generic/vmlinux.lds.h as a preliminary step to remove the ftrace
bogus structure alignments. Moving all STRUCT_ALIGN() for FTRACE_EVENTS()
and TRACE_SYSCALLS() into the definitions, so the alignment is only done if
these infrastructures are configured in. 

Also align TRACE_PRINTKS on 8 bytes to make sure the beginning of the section is
aligned on pointer size.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/asm-generic/vmlinux.lds.h |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6-lttng/include/asm-generic/vmlinux.lds.h
=================================--- linux-2.6-lttng.orig/include/asm-generic/vmlinux.lds.h
+++ linux-2.6-lttng/include/asm-generic/vmlinux.lds.h
@@ -107,7 +107,8 @@
 #endif
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
-#define LIKELY_PROFILE()	VMLINUX_SYMBOL(__start_annotated_branch_profile) = .; \
+#define LIKELY_PROFILE()	STRUCT_ALIGN();					      \
+				VMLINUX_SYMBOL(__start_annotated_branch_profile) = .; \
 				*(_ftrace_annotated_branch)			      \
 				VMLINUX_SYMBOL(__stop_annotated_branch_profile) = .;
 #else
@@ -115,7 +116,8 @@
 #endif
 
 #ifdef CONFIG_PROFILE_ALL_BRANCHES
-#define BRANCH_PROFILE()	VMLINUX_SYMBOL(__start_branch_profile) = .;   \
+#define BRANCH_PROFILE()	STRUCT_ALIGN();				      \
+				VMLINUX_SYMBOL(__start_branch_profile) = .;   \
 				*(_ftrace_branch)			      \
 				VMLINUX_SYMBOL(__stop_branch_profile) = .;
 #else
@@ -123,7 +125,8 @@
 #endif
 
 #ifdef CONFIG_EVENT_TRACING
-#define FTRACE_EVENTS()	VMLINUX_SYMBOL(__start_ftrace_events) = .;	\
+#define FTRACE_EVENTS()	STRUCT_ALIGN();					\
+			VMLINUX_SYMBOL(__start_ftrace_events) = .;	\
 			*(_ftrace_events)				\
 			VMLINUX_SYMBOL(__stop_ftrace_events) = .;
 #else
@@ -131,7 +134,8 @@
 #endif
 
 #ifdef CONFIG_TRACING
-#define TRACE_PRINTKS() VMLINUX_SYMBOL(__start___trace_bprintk_fmt) = .;      \
+#define TRACE_PRINTKS()  . = ALIGN(8);					       \
+			 VMLINUX_SYMBOL(__start___trace_bprintk_fmt) = .;      \
 			 *(__trace_printk_fmt) /* Trace_printk fmt' pointer */ \
 			 VMLINUX_SYMBOL(__stop___trace_bprintk_fmt) = .;
 #else
@@ -139,7 +143,8 @@
 #endif
 
 #ifdef CONFIG_FTRACE_SYSCALLS
-#define TRACE_SYSCALLS() VMLINUX_SYMBOL(__start_syscalls_metadata) = .;	\
+#define TRACE_SYSCALLS() STRUCT_ALIGN();				\
+			 VMLINUX_SYMBOL(__start_syscalls_metadata) = .;	\
 			 *(__syscalls_metadata)				\
 			 VMLINUX_SYMBOL(__stop_syscalls_metadata) = .;
 #else
@@ -169,11 +174,7 @@
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
-									\
-	STRUCT_ALIGN();							\
 	FTRACE_EVENTS()							\
-									\
-	STRUCT_ALIGN();							\
 	TRACE_SYSCALLS()
 
 /*



-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
