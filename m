From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 14 Dec 2020 15:59:02 +0000
Subject: [sparc64] ftrace: kernel startup-tests unaligned access
Message-Id: <CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel list <linux-kernel@vger.kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>

Hello!

Enabled ftrace startup tests on a sparc64 test VM/LDOM:

$ diff -u <(gzip -dc ~/dmesg/config-5.10.0.gz) <(gzip -dc /proc/config.gz)
--- /dev/fd/63  2020-12-14 16:19:38.239372599 +0300
+++ /dev/fd/62  2020-12-14 16:19:38.235372433 +0300
@@ -2842,7 +2842,10 @@
 # CONFIG_TRACEPOINT_BENCHMARK is not set
 # CONFIG_RING_BUFFER_BENCHMARK is not set
 # CONFIG_TRACE_EVAL_MAP_FILE is not set
-# CONFIG_FTRACE_STARTUP_TEST is not set
+CONFIG_FTRACE_SELFTEST=y
+CONFIG_FTRACE_STARTUP_TEST=y
+CONFIG_EVENT_TRACE_STARTUP_TEST=y
+# CONFIG_EVENT_TRACE_TEST_SYSCALLS is not set
 # CONFIG_RING_BUFFER_STARTUP_TEST is not set
 # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
 # CONFIG_KPROBE_EVENT_GEN_TEST is not set


Got the following results with kernel boot logs:

Dec 14 13:48:15 kernel: clocksource: jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Dec 14 13:48:15 kernel: futex hash table entries: 65536 (order: 9,
4194304 bytes, linear)
Dec 14 13:48:15 kernel: Running postponed tracer tests:
Dec 14 13:48:15 kernel: Testing tracer function:
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
trace_function+0x40/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
trace_function+0x44/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
trace_function+0x40/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
trace_function+0x44/0x140
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
trace_function+0x40/0x140
Dec 14 13:48:15 kernel: PASSED
Dec 14 13:48:15 kernel: Testing dynamic ftrace: PASSED
...
Dec 14 13:48:15 kernel: Testing event workqueue_execute_end:
Dec 14 13:48:15 kernel: log_unaligned: 194175 callbacks suppressed
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47faa4]
trace_event_raw_event_workqueue_execute_end+0x44/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47fab0]
trace_event_raw_event_workqueue_execute_end+0x50/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47faa4]
trace_event_raw_event_workqueue_execute_end+0x44/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47fab0]
trace_event_raw_event_workqueue_execute_end+0x50/0xa0
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[47faa4]
trace_event_raw_event_workqueue_execute_end+0x44/0xa0
Dec 14 13:48:15 kernel: OK
...
Dec 14 13:48:15 kernel: Testing event sched_waking: OK
Dec 14 13:48:15 kernel: Testing event sched_kthread_stop_ret:
Dec 14 13:48:15 kernel: log_unaligned: 401755 callbacks suppressed
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c538]
function_test_events_call+0x84/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c53c]
function_test_events_call+0x88/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c538]
function_test_events_call+0x84/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c53c]
function_test_events_call+0x88/0x188
Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[f4c538]
function_test_events_call+0x84/0x188
Dec 14 13:48:15 kernel: OK
Dec 14 13:48:15 kernel: Testing event sched_kthread_stop: OK
...

full log is at  https://gist.github.com/mator/a44eb39d5103aaaea2f1b2f3856c391d

Looking at the most encountered function list in dmesg (journalctl -b
-k) output:

$ zgrep 'Kernel unaligned access at TPC' kernel-ftrace.log.gz | awk
'{print $NF}' | cut -f1 -d'+' | sort  | uniq -c
    313 function_test_events_call
      4 trace_event_raw_event_kmem_alloc
      4 trace_event_raw_event_kmem_free
      1 trace_event_raw_event_mm_page
      1 trace_event_raw_event_mm_page_alloc
      2 trace_event_raw_event_rcu_utilization
      5 trace_event_raw_event_sched_switch
      3 trace_event_raw_event_timer_class
      2 trace_event_raw_event_timer_expire_entry
      8 trace_event_raw_event_workqueue_execute_end
      2 trace_event_raw_event_workqueue_execute_start
      5 trace_function

Can someone look for unaligned access at least in
function_test_events_call() to fix it?

Thanks.
