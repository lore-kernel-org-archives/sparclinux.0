From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 18 Jan 2011 18:26:18 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295375178.12215.33.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1295273486.16479.15.camel@gandalf.stny.rr.com>
	 <20110117.213448.226787087.davem@davemloft.net>
	 <20110117.220039.71097651.davem@davemloft.net>
	 <20110117.220857.104046847.davem@davemloft.net>
	 <20110118164633.GA12872@Krystal>
	 <1295372019.12215.30.camel@gandalf.stny.rr.com>
	 <1295374595.12215.32.camel@gandalf.stny.rr.com>
In-Reply-To: <1295374595.12215.32.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Miller <davem@davemloft.net>, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

On Tue, 2011-01-18 at 13:16 -0500, Steven Rostedt wrote:
> On Tue, 2011-01-18 at 12:33 -0500, Steven Rostedt wrote:
> > On Tue, 2011-01-18 at 11:46 -0500, Mathieu Desnoyers wrote:
> 
> > > Also align TRACE_PRINTKS on 8 bytes to make sure the beginning of the section is
> > > aligned on pointer size.
> > 
> > If I can make it crash without the alignments and this fixes the issue,
> > I'll apply both patches.
> 
> After applying David's patch, I do indeed get a crash. I'll now apply
> yours and see if it fixes the issue.

Your patch doesn't seem to fix it either. I'll investigate this further.

-- Steve


