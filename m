From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 18 Jan 2011 20:22:24 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295382144.12215.123.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1295273486.16479.15.camel@gandalf.stny.rr.com>
	 <20110117.213448.226787087.davem@davemloft.net>
	 <20110117.220039.71097651.davem@davemloft.net>
	 <20110117.220857.104046847.davem@davemloft.net>
	 <20110118164633.GA12872@Krystal>
	 <1295372019.12215.30.camel@gandalf.stny.rr.com>
	 <1295374595.12215.32.camel@gandalf.stny.rr.com>
	 <1295375178.12215.33.camel@gandalf.stny.rr.com>
	 <20110118201323.GA14930@Krystal>
In-Reply-To: <20110118201323.GA14930@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Miller <davem@davemloft.net>, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

On Tue, 2011-01-18 at 15:13 -0500, Mathieu Desnoyers wrote:
> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > On Tue, 2011-01-18 at 13:16 -0500, Steven Rostedt wrote:
> > > On Tue, 2011-01-18 at 12:33 -0500, Steven Rostedt wrote:
> > > > On Tue, 2011-01-18 at 11:46 -0500, Mathieu Desnoyers wrote:
> > > 
> > > > > Also align TRACE_PRINTKS on 8 bytes to make sure the beginning of the section is
> > > > > aligned on pointer size.
> > > > 
> > > > If I can make it crash without the alignments and this fixes the issue,
> > > > I'll apply both patches.
> > > 
> > > After applying David's patch, I do indeed get a crash. I'll now apply
> > > yours and see if it fixes the issue.
> > 
> > Your patch doesn't seem to fix it either. I'll investigate this further.
> 
> I think David's patch missed kernel/trace/trace_export.c
> 
> struct ftrace_event_call __used                                         \
> __attribute__((__aligned__(4)))                                         \
> __attribute__((section("_ftrace_events"))) event_##call = {             \
> 
> and kernel/trace/trace.h:
> 
> #define FTRACE_ENTRY(call, struct_name, id, tstruct, print)             \
>         extern struct ftrace_event_call                                 \
>         __attribute__((__aligned__(4))) event_##call;
> 
> does it help if you remove these ?

I doubt it, but I'll try it anyway.

-- Steve



