From: David Miller <davem@davemloft.net>
Date: Fri, 04 Jul 2014 04:18:20 +0000
Subject: Re: [RFA][PATCH 18/27] sparc64,ftrace: Remove check of obsolete variable function_trace_stop
Message-Id: <20140703.211820.1674895115102216877.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140626165221.736847419@goodmis.org>
	<20140626165852.160038235@goodmis.org>
	<20140703124146.3a93668f@gandalf.local.home>
In-Reply-To: <20140703124146.3a93668f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de, masami.hiramatsu.pt@hitachi.com, hpa@zytor.com, linux-arch@vger.kernel.org, rjw@rjwysocki.net, jkosina@suse.cz, notifications@github.com, sparclinux@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 3 Jul 2014 12:41:46 -0400

> Do you have any problem with this patch going through my tree? It
> compiles, but I do not have any hardware to test it. If you can verify
> that this patch works and ack it, it would be much appreciated.
> 
> This code is at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> 
> branch: rfc/remove-function-trace-stop

I can look at this next week at the earliest.  But frankly I have no problem
if you just merge it as-is now, we can sort out any fallout later.

Thanks.
