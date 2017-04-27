From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 27 Apr 2017 16:14:58 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170427121458.2be577cc@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
In-Reply-To: <20170420131154.GL3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 20 Apr 2017 15:11:54 +0200
Petr Mladek <pmladek@suse.com> wrote:



> 
> >From c530d9dee91c74db5e6a198479e2e63b24cb84a2 Mon Sep 17 00:00:00 2001  
> From: Petr Mladek <pmladek@suse.com>
> Date: Thu, 20 Apr 2017 10:52:31 +0200
> Subject: [PATCH] printk: Use the main logbuf in NMI when logbuf_lock is
>  available

I tried this patch. It's better because I get the end of the trace, but
I do lose the beginning of it:

** 196358 printk messages dropped ** [  102.321182]     perf-5981    0.... 12983650us : d_path <-seq_path

The way I tested it was by adding this:

Index: linux-trace.git/kernel/trace/trace_functions.c
=================================--- linux-trace.git.orig/kernel/trace/trace_functions.c
+++ linux-trace.git/kernel/trace/trace_functions.c
@@ -469,8 +469,11 @@ ftrace_cpudump_probe(unsigned long ip, u
 		     struct trace_array *tr, struct ftrace_probe_ops *ops,
 		     void *data)
 {
-	if (update_count(ops, ip, data))
-		ftrace_dump(DUMP_ORIG);
+	char *killer = NULL;
+
+	panic_on_oops = 1;	/* force panic */
+	wmb();
+	*killer = 1;
 }
 
 static int


Then doing the following:

# echo 1 > /proc/sys/kernel/ftrace_dump_on_oops 
# trace-cmd start -p function
# echo nmi_handle:cpudump > /debug/tracing/set_ftrace_filter
# perf record -c 100 -a sleep 1

And that triggers the crash.

-- Steve
