From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 13 Apr 2010 21:52:21 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <1271195542.7962.92.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2010-04-13 at 14:34 -0700, David Miller wrote:
> From: Rostedt <rostedt@goodmis.org>

> Neener, neener:
> 

:-p

>  101)               |          run_local_timers() {
>  115) + 24.063 us   |            raise_softirq();
>   69)               |          run_local_timers() {
>   85) + 23.623 us   |            hrtimer_run_queues();
>  103)               |          run_local_timers() {
>   66) + 71.749 us   |          }
>   91)               |          run_local_timers() {
>  106) + 23.184 us   |            raise_softirq();
>   65) + 29.117 us   |            raise_softirq();
>   68) + 23.843 us   |            hrtimer_run_queues();
>  112) + 23.623 us   |            hrtimer_run_queues();
>  105) + 24.063 us   |            hrtimer_run_queues();
>   17) + 25.161 us   |            raise_softirq();
>   82) + 24.282 us   |            hrtimer_run_queues();
>  100) + 72.628 us   |          }
> 
> BTW, one thing that drives me nuts on this machine is that catting the
> 'trace' file takes several seconds to start up.  Is it calling
> stop_machine() or something else which very expensive with high cpu
> counts?

No, in does not call stop_machine, but it stops all tracing on all cpus.
I wonder what is happening :-/

It does allocate an "iterator" that has per cpu descriptors.

Does "trace_pipe" give you the same issues?

-- Steve


