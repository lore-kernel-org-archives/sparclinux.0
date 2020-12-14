From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 14 Dec 2020 17:12:18 +0000
Subject: Re: [sparc64] ftrace: kernel startup-tests unaligned access
Message-Id: <CADxRZqwDAZK3s2jjavUKunvbE3jux=yNfPQFRwvMZRjqqS_6cw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com>
 <20201214111512.415717ac@gandalf.local.home> <20201214112629.3cf6f240@gandalf.local.home>
In-Reply-To: <20201214112629.3cf6f240@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>

On Mon, Dec 14, 2020 at 7:26 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 14 Dec 2020 11:15:12 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Does sparc64 require 8 byte alignment for 8 byte words?
> >
>
> In other words, does this patch fix anything?
>
> -- Steve
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..fa716994f77e 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -143,6 +143,22 @@ config UPROBES
>             managed by the kernel and kept transparent to the probed
>             application. )
>
> +config HAVE_64BIT_ALIGNED_ACCESS
...

Steven,

yes, this patch fully fixes ftrace sparc64 "unaligned access". Thanks!

$ journalctl -b -k --no-hostname -o short-monotonic | grep -c unaligned
0

$ diff -u <(gzip -dc ~/dmesg/config-5.10.0.gz) <(gzip -dc /proc/config.gz)
--- /dev/fd/63  2020-12-14 20:11:10.442415669 +0300
+++ /dev/fd/62  2020-12-14 20:11:10.438415619 +0300
@@ -305,6 +305,7 @@
 CONFIG_JUMP_LABEL=y
 # CONFIG_STATIC_KEYS_SELFTEST is not set
 CONFIG_UPROBES=y
+CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
 CONFIG_KRETPROBES=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
@@ -2842,7 +2843,10 @@
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
