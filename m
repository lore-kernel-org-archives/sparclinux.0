From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 03 Jan 2008 09:21:04 +0000
Subject: Re: [RFC PATCH 01/11] Add basic support for gcc profiler
Message-Id: <20080103092104.GE10813@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072226.776141236@goodmis.org>
In-Reply-To: <20080103072226.776141236@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> +# function tracing might turn this off:
> +config REGPARM
> +	bool
> +	depends on !MCOUNT
> +	default y

are you sure -pg really needs this? I just carried this along the years 
and went the path of least resistence, but we should not be 
reintroducing the !REGPARM build mode for the kernel. I'd not be 
surprised if there were a few issues with REGPARM + mcount, but we have 
to figure it out before merging ...

	Ingo
