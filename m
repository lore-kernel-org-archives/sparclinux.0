From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 06:32:47 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110118.223247.241909079.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110118201323.GA14930@Krystal>
	<1295382144.12215.123.camel@gandalf.stny.rr.com>
	<20110119050844.GA8776@Krystal>
In-Reply-To: <20110119050844.GA8776@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 19 Jan 2011 00:08:45 -0500

> - No aligned() type attribute nor variable attribute. I get a crash on x86_64
>   (NULL pointer exception when executing __trace_add_event_call, the 5th call).
>   __alignof__(struct ftrace_event_call) is worth 8.

I think I figured it out.

It's the static vs. non-static thing, or some other crazyness wrt.
how x86-64 implements it's alignment rules.

GCC on x86-64 uses a completely different policy for aligning local
(ie. "static") data objects vs. globally visible ones, for one thing.
It also has different alignment policies for objects that are part
of an array vs. those which are not.

On both counts, we're lying to the compiler, so maybe it's sort of our
fault.

As far as GCC can see, the object is static and also not part of an
array or any other C construct for which things like this could matter
as long as the alignment it chooses meets the minimum alignment
requirements of the ABI.

So it doesn't let us do this trick where we put the individual event
markers into a special section, yet mark it __used and static, then
later access them as if they were part of a globally visible array.

If you look these static objects, they are emitted with a leading
".align 32" directive.  This is what screws everything up.

When the linker sees this, it aligns the start of every individual
"_ftrace_events" section, and that's where the "gaps" come from and
the crashes.

