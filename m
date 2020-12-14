From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 14 Dec 2020 16:31:23 +0000
Subject: Re: [sparc64] ftrace: kernel startup-tests unaligned access
Message-Id: <20201214113123.0b44e35e@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com>
        <20201214111512.415717ac@gandalf.local.home>
        <20201214162804.GA27786@Jessicas-MacBook.local>
In-Reply-To: <20201214162804.GA27786@Jessicas-MacBook.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Anatoly Pugachev <matorola@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>

On Mon, 14 Dec 2020 16:28:04 +0000
Jessica Clarke <jrtc27@jrtc27.com> wrote:

> On Mon, Dec 14, 2020 at 11:15:12AM -0500, Steven Rostedt wrote:
> > On Mon, 14 Dec 2020 18:59:02 +0300
> > Anatoly Pugachev <matorola@gmail.com> wrote:
> >   
> > > Hello!
> > > 
> > > Enabled ftrace startup tests on a sparc64 test VM/LDOM:
> > > 
> > > $ diff -u <(gzip -dc ~/dmesg/config-5.10.0.gz) <(gzip -dc /proc/config.gz)
> > > --- /dev/fd/63  2020-12-14 16:19:38.239372599 +0300
> > > +++ /dev/fd/62  2020-12-14 16:19:38.235372433 +0300
> > > @@ -2842,7 +2842,10 @@
> > >  # CONFIG_TRACEPOINT_BENCHMARK is not set
> > >  # CONFIG_RING_BUFFER_BENCHMARK is not set
> > >  # CONFIG_TRACE_EVAL_MAP_FILE is not set
> > > -# CONFIG_FTRACE_STARTUP_TEST is not set
> > > +CONFIG_FTRACE_SELFTEST=y
> > > +CONFIG_FTRACE_STARTUP_TEST=y
> > > +CONFIG_EVENT_TRACE_STARTUP_TEST=y
> > > +# CONFIG_EVENT_TRACE_TEST_SYSCALLS is not set
> > >  # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> > >  # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > >  # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> > > 
> > > 
> > > Got the following results with kernel boot logs:
> > > 
> > > Dec 14 13:48:15 kernel: clocksource: jiffies: mask: 0xffffffff
> > > max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> > > Dec 14 13:48:15 kernel: futex hash table entries: 65536 (order: 9,
> > > 4194304 bytes, linear)
> > > Dec 14 13:48:15 kernel: Running postponed tracer tests:
> > > Dec 14 13:48:15 kernel: Testing tracer function:
> > > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
> > > trace_function+0x40/0x140
> > > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
> > > trace_function+0x44/0x140
> > > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
> > > trace_function+0x40/0x140
> > > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a24]
> > > trace_function+0x44/0x140
> > > Dec 14 13:48:15 kernel: Kernel unaligned access at TPC[552a20]
> > > trace_function+0x40/0x140  
> > 
> > Does sparc64 require 8 byte alignment for 8 byte words?  
> 
> Yes, SPARC requires natural alignment for all primitive types (and that
> even includes 8-byte alignment for 8-byte types on 32-bit SPARC as it
> has load/store pair instructions the compiler is free to use).
> 
> 

OK, that means I was misinformed about reverting the patch that forced
alignment (and the patch I posted in reply to my email, is the revert of
the revert).

If the patch I just posted works, then I'll get it ready for mainline and
stable.

Thanks!

-- Steve
