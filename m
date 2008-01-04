From: fche@redhat.com (Frank Ch. Eigler)
Date: Fri, 04 Jan 2008 06:42:32 +0000
Subject: Re: [RFC PATCH 00/11] mcount tracing utility
Message-Id: <y0mbq82um5j.fsf@ton.toronto.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org>
In-Reply-To: <20080103071609.478486470@goodmis.org> (Steven Rostedt's message of "Thu, 03 Jan 2008 02:16:09 -0500")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>

Steven Rostedt <rostedt@goodmis.org> writes:

> The following patch series brings to vanilla Linux a bit of the RT kernel
> trace facility. This incorporates the "-pg" profiling option of gcc
> that will call the "mcount" function for all functions called in
> the kernel.
> [...]
> [Future:] SystemTap:
> ----------
> One thing that Arnaldo and I discussed last year was using systemtap to
> add hooks into the kernel to start and stop tracing.  

Sure.  The dual of this makes sense too: letting systemtap scripts
hook up to the mcount callback itself, for purposes beyond just
tracing the function calls.

> kprobes is too heavy to do on all funtion calls, but it would be
> perfect to add to non hot paths to start the tracer and stop the
> tracer.

(Note that kprobes are not the only event sources systemtap can use:
markers, timers, procfs control files, and some others.  Any
combination of these can be used in a script to express start/stop
decisions.)


- FChE
