From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Thu, 03 Jan 2008 19:18:19 +0000
Subject: Re: [RFC PATCH 01/11] Add basic support for gcc profiler	instrumentation
Message-Id: <477D34FB.6070601@goop.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org>	<20080103072226.776141236@goodmis.org>	<20080103092104.GE10813@elte.hu>	<Pine.LNX.4.58.0801030849180.1468@gandalf.stny.rr.com> <20080103181651.GC3627@sequoia.sous-sol.org>
In-Reply-To: <20080103181651.GC3627@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wright <chrisw@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Gregory Haskins <ghaskins@novell.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Steven Rostedt <srostedt@redhat.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

Chris Wright wrote:
> * Steven Rostedt (rostedt@goodmis.org) wrote:
>   
>> Hmm, I know paravirt-ops had an issue with mcount in the RT tree. I can't
>> remember the exact issues, but it did have something to do with the way
>> parameters were passed in.
>>
>> Chris, do you remember what the issues were?
>>     
>
> Yes, paravirt ops have a well-specified calling convention (register
> based).  There was a cleanup that Andi did that caused the problem
> because it removed all the "fastcall" annotations since -mregparm=3
> is now always on for i386.  Since MCOUNT disables REGPARM the calling
> convention changes (caller pushes to stack, callee expects register)
> chaos ensues.  I sent a patch to fix that quite some months back, but
> it went stale and I neglected to update it.  Would you like me to dig
> it up refresh and resend?

Ingo/Andrew have been accepting patches to systematically remove all the
fastcall annotations from the kernel, so adding them back isn't going to
help.

Ingo and I discussed whether we need to reannotate paravirt.h (either
with fastcall or something else indicating a register-only calling
convention), specifically because of the -pg issue, but I think the
conclusion was that whatever problem existed no longer does, and there's
no incompatibility between -pg and regparm.

    J
