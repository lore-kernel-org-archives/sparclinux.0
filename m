From: David Miller <davem@davemloft.net>
Date: Tue, 06 Apr 2010 17:46:35 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100406.104635.210218044.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405194055.GA5265@nowhere>
	<20100405.191555.184824968.davem@davemloft.net>
	<1270561264.2738.8.camel@localhost.localdomain>
In-Reply-To: <1270561264.2738.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: srostedt@redhat.com
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org, rostedt@goodmis.org

From: Steven Rostedt <srostedt@redhat.com>
Date: Tue, 06 Apr 2010 09:41:04 -0400

> It's best to send to my rostedt@goodmis.org account, just like it is
> best to send to your davem@davemloft.net ;-)

Ok then you should, like me, use it in your commits :-)

> OK, so the a 64 bit word still needs 64 bit alignment when storing to a
> data pointer.
> 
> I wonder if we should just have a special copy in this case for the
> events and remove this patch in the ring buffer. That is:
> 
> 	__assign_word(__entry->word, value);
> 
> And have in !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS be:
> 
> 	#define __assgin_word(dest, src)	\
> 		memcpy(&(dest), &(src), sizeof(src));
> 
> This would fix it for all.

Doesn't work, first of all, because if gcc can see the types
it will inline emit aligned loads and stores.

Secondly, the accessors who read in these entries need them to be
aligned too.

> What about removing the logic from the ring buffer and moving it to the
> TRACE_EVENT() macros as I suggested above?

No, that makes no sense, just align the data types properly
instead of making every single access site pay the price.

Just fix the CPP test to handle 32-bit platforms with slow
mis-alignment handling, everything else seems to be working properly
after I fixed the NMI issues on sparc64.
