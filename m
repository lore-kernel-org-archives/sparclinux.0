From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 07:20:45 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110118.232045.58440904.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1295382144.12215.123.camel@gandalf.stny.rr.com>
	<20110119050844.GA8776@Krystal>
	<20110118.223247.241909079.davem@davemloft.net>
In-Reply-To: <20110118.223247.241909079.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jan 2011 22:32:47 -0800 (PST)

> As far as GCC can see, the object is static and also not part of an
> array or any other C construct for which things like this could matter
> as long as the alignment it chooses meets the minimum alignment
> requirements of the ABI.
> 
> So it doesn't let us do this trick where we put the individual event
> markers into a special section, yet mark it __used and static, then
> later access them as if they were part of a globally visible array.
> 
> If you look these static objects, they are emitted with a leading
> ".align 32" directive.  This is what screws everything up.
> 
> When the linker sees this, it aligns the start of every individual
> "_ftrace_events" section, and that's where the "gaps" come from and
> the crashes.

I've come up with one possible way to deal with this.

Put pointers to the trace objects into the special section, and
interate over those instead.

I was wondering why this x86-64 weird alignment behavior doesn't bite
us for our init funcs.  And the reason is that all of these weird
alignment cases only trigger for aggregates (ie. structs and unions).

So we could do:

	static struct ftace_event_call foo_event = { ... };
	static struct ftrace_event_call * __used
		__attribute__((section("_ftrace_event_ptrs")))
		foo_event_ptr = &foo_event;

and

	extern struct ftrace_event_call *__start_ftrace_event_ptrs[];
	extern struct ftrace_event_call *__end_ftrace_event_ptrs[];

	struct ftrace_event_call **p = __start_ftrace_event_ptrs;
	while (p < &__end_ftrace_event_ptrs[0]) {
		struct ftrace_event_call *event = *p++;

		__trace_add_event_call(event, ...);
	}

you get the idea.

And we could mark this entire point section as "initdata" and thus
free'able after bootup and post module load.
