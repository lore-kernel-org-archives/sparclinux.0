From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 07 Jan 2008 04:50:57 +0000
Subject: Re: [RFC PATCH 02/11] Add fastcall to do_IRQ for i386
Message-Id: <4781AFB1.6040807@zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072226.934978594@goodmis.org> <20080103173639.GB30582@Krystal> <Pine.LNX.4.58.0801031246220.4826@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0801031246220.4826@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>

Steven Rostedt wrote:
> 
> On Thu, 3 Jan 2008, Mathieu Desnoyers wrote:
>> I would propose to try to see how we can #ifdef two different __mcount
>> assembly functions that would prepare the stack appropriately for each
>> REGPARM cases.
> 
> I have to confess that I've been testing this mostly on x86_64, which
> doesn't have the troubles with REGPARM as i386 does. I'll need to
> investigate this a bit deeper on i386 alone.
> 

I thought we had dropped support for the non-REGPARM case, so why don't 
we just make it work for REGPARM and be done with it?

	-hpa

