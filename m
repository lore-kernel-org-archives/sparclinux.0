From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 19 Jan 2011 22:00:23 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295474423.12215.1612.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110118.223247.241909079.davem@davemloft.net>
	 <20110118.232045.58440904.davem@davemloft.net>
	 <20110119153326.GC11022@Krystal>
	 <20110119.134047.232915743.davem@davemloft.net>
In-Reply-To: <20110119.134047.232915743.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mathieu.desnoyers@efficios.com, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

On Wed, 2011-01-19 at 13:40 -0800, David Miller wrote:

> My concern is that if there is ever a u64 or similarly "long long"
> typed member in these tracing structures, it will not be aligned
> sufficiently to avoid unaligned access traps on 32-bit systems.

The structure that gets placed in this section is the ftrace_event_call.
It consists only of pointers, a struct list_head, a couple of "int", and
a struct trace_event, which consists of: a struct hlist_node, a struct
list_head, an int, and a pointer.

None of these are more than "long" and I don't foresee them needing a
long long type. I think assuming that a long is the largest item should
due.

We can add a comment next to these structures specifying this
dependency, and hopefully it would be updated if we ever do include a
long long in them.

-- Steve


