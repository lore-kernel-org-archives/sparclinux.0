From: Ingo Molnar <mingo@elte.hu>
Date: Sun, 06 Jan 2008 15:37:58 +0000
Subject: Re: [RFC PATCH 10/11] mcount tracer show task comm and pid
Message-Id: <20080106153758.GA27863@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072228.212967487@goodmis.org> <20080103175650.GE30582@Krystal>
In-Reply-To: <20080103175650.GE30582@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> > @@ -34,6 +34,7 @@ mctracer_add_trace_entry(struct mctracer
> >  {
> >  	unsigned long idx, idx_next;
> >  	struct mctracer_entry *entry;
> > +	struct task_struct *tsk = current;
> 
> Aren't there situations, like in the middle of a context switch, where 
> current is not valid ? Is also poses a problem for early boot, and NMI 
> tracing.

no such problems on x86.

	Ingo
