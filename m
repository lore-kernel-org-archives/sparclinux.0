From: Andi Kleen <andi@firstfloor.org>
Date: Thu, 03 Jan 2008 18:05:42 +0000
Subject: Re: [RFC PATCH 00/11] mcount tracing utility
Message-Id: <p73wsqqg4y1.fsf@bingen.suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org>
In-Reply-To: <20080103071609.478486470@goodmis.org> (Steven Rostedt's message of "Thu\, 03 Jan 2008 02\:16\:09 -0500")
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

My personal feeling regarding this code was that it would be much simpler/cleaner
to implement a driver for the "jump tracer"s implemented in various CPUs.
Basically the CPU will write all jumps into a buffer by itself. That
allows you to do many traces (although not latency traces) too.

-Andi
