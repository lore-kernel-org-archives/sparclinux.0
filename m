From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jan 2011 06:36:58 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110117.223658.39164511.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110116.113944.48514452.davem@davemloft.net>
	<1295273486.16479.15.camel@gandalf.stny.rr.com>
	<20110117193525.GD16154@Krystal>
In-Reply-To: <20110117193525.GD16154@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Mon, 17 Jan 2011 14:35:25 -0500

> Steven, what were you trying to fix in the first place when you added the
> aligned(4) to the definition ? It might have just been that the _ftrace_events
> section needed to be aligned on at least 8 bytes in the linker scripts, but was
> only aligned on 4-bytes. Forcing the definition alignment down to 4 possibly
> fixed the problem you experienced on x86_64, but seems to be causing other
> problems.
> 
> I would recommend to:
> 
> - Keep the linker script _ftrace_events alignment as it is now (aligned on 32
>   bytes).
> - Remove the aligned(4) attributes from all struct ftrace_event_call
>   definitions.

Completely agreed.
