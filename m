From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 21:57:19 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413.145719.08253677.davem@davemloft.net>
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

Ok, I'll try to track down the cause, thanks Steven.

'perf' works fine in this configuration so maybe that will
provide some clues.
