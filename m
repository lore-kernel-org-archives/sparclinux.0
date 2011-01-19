From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 21:40:47 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119.134047.232915743.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110118.223247.241909079.davem@davemloft.net>
	<20110118.232045.58440904.davem@davemloft.net>
	<20110119153326.GC11022@Krystal>
In-Reply-To: <20110119153326.GC11022@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 19 Jan 2011 10:33:26 -0500

> I'm still unsure that __long_long_aligned is needed over __long_aligned though.
> AFAIK, the only requirement we have for, e.g. tracepoints, is to align on the
> pointer size (sizeof(long)), so RCU pointer updates are performed atomically.
> Aligning on the pointer size also allows the architecture to efficiently read
> the field content. What does aligning on sizeof(long long) bring to us ? Is it
> that you are concerned about the fact that the "aligned" type attribute, when
> applied to a structure, is only used as a lower-bound by the compiler ? In that
> case, we might want to consider using "packed" too:

My concern is that if there is ever a u64 or similarly "long long"
typed member in these tracing structures, it will not be aligned
sufficiently to avoid unaligned access traps on 32-bit systems.

If your suggestion defines the lowest possible alignment and GCC will
do the right thing and "up-align" the structure if necessary, then
fine.

If you add "packed" it is going to screw everything up and we'll
essentially be back to square one.

On RISC like sparc64, "packed" causes even 16-bit words to be read and
written a byte at a time.

Never use "packed" under any circumstances unless absolutely
unavoidable.
