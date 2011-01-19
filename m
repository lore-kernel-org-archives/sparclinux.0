From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 19 Jan 2011 15:46:00 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295451961.12215.1291.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1295382144.12215.123.camel@gandalf.stny.rr.com>
	 <20110119050844.GA8776@Krystal>
	 <20110118.223247.241909079.davem@davemloft.net>
	 <20110118.232045.58440904.davem@davemloft.net>
In-Reply-To: <20110118.232045.58440904.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mathieu.desnoyers@efficios.com, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

After applying David's "remove align" patch, I got it to boot on x86_64
with the following two patches. I thought just adding the "align" to the
structure declaration would work, but it still failed on the syscall for
init_module. By removing the double "declaration" of event_exit_##sname,
removed this problem.

I'll test this on x86 32bit and PPC 64. If it works there, I'll push all
of them out for 38. Should these go to 37 stable too?

-- Steve

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cacc27a..0e3bce6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -142,8 +142,6 @@ extern struct trace_event_functions exit_syscall_print_funcs;
 #define SYSCALL_TRACE_EXIT_EVENT(sname)					\
 	static struct syscall_metadata					\
 	__attribute__((__aligned__(4))) __syscall_meta_##sname;		\
-	static struct ftrace_event_call					\
-	__attribute__((__aligned__(4))) event_exit_##sname;		\
 	static struct ftrace_event_call __used				\
 	  __attribute__((__aligned__(4)))				\
 	  __attribute__((section("_ftrace_events")))			\


Index: linux-trace.git/include/linux/ftrace_event.h
=================================--- linux-trace.git.orig/include/linux/ftrace_event.h
+++ linux-trace.git/include/linux/ftrace_event.h
@@ -194,7 +194,7 @@ struct ftrace_event_call {
 	int				perf_refcount;
 	struct hlist_head __percpu	*perf_events;
 #endif
-};
+} __attribute__((__aligned__(32)));
 
 #define PERF_MAX_TRACE_SIZE	2048
 


