From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 23:34:53 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413.163453.141492778.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 13 Apr 2010 17:52:21 -0400

> On Tue, 2010-04-13 at 14:34 -0700, David Miller wrote:
>> BTW, one thing that drives me nuts on this machine is that catting the
>> 'trace' file takes several seconds to start up.  Is it calling
>> stop_machine() or something else which very expensive with high cpu
>> counts?
> 
> No, in does not call stop_machine, but it stops all tracing on all cpus.
> I wonder what is happening :-/
> 
> It does allocate an "iterator" that has per cpu descriptors.
> 
> Does "trace_pipe" give you the same issues?

Indeed, "trace_pipe" does not show the stall.

And when I 'perf' the stalling case, nothing interesting shows up.

Then I went snooping around the call path for this stuff and looked at
ring_buffer_read_start()

That does a synchronize_sched(), and this function is invoked for
every cpu when we open the "trace" file.

So this likely explains the delay.

This synchronize_sched() is meant to make sure that the buffer's cpu
has finished any pending ring buffer writes, and thus will see the new
->record_disabled setting.  It is only at that point that we can
safely call rb_iter_reset() and start reading.

But synchronize_sched() waits for an RCU grace peiod considering all
cpus, so this is overkill since we only care about writes to a
particular cpu's buffer not all cpu buffers.

I think the criteria we are looking for is that "cpu X has returned
from a function" since that would guarentee that it left the tracing
code paths.  So maybe there's some clever way we can do this more
cheaply.
