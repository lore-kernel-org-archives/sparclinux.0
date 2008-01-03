From: Chris Wright <chrisw@sous-sol.org>
Date: Thu, 03 Jan 2008 19:17:36 +0000
Subject: Re: [RFC PATCH 01/11] Add basic support for gcc profiler
Message-Id: <20080103191736.GD3627@sequoia.sous-sol.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072226.776141236@goodmis.org> <20080103092104.GE10813@elte.hu> <Pine.LNX.4.58.0801030849180.1468@gandalf.stny.rr.com> <20080103181651.GC3627@sequoia.sous-sol.org> <Pine.LNX.4.58.0801031413410.5746@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0801031413410.5746@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wright <chrisw@redhat.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> On Thu, 3 Jan 2008, Chris Wright wrote:
> > Yes, paravirt ops have a well-specified calling convention (register
> > based).  There was a cleanup that Andi did that caused the problem
> > because it removed all the "fastcall" annotations since -mregparm=3
> > is now always on for i386.  Since MCOUNT disables REGPARM the calling
> > convention changes (caller pushes to stack, callee expects register)
> > chaos ensues.  I sent a patch to fix that quite some months back, but
> > it went stale and I neglected to update it.  Would you like me to dig
> > it up refresh and resend?
> 
> Chris, thanks for the refresher.
> 
> I'm going to see if we can remove the REGPARM hack and change the way
> mcount does its calls. Maybe this will fix things for us.

I don't recall why mcount disables regparm, but I think you're on the
right path to remove that dependency.

thanks,
-chris
