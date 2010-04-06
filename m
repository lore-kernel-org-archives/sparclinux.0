From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 06 Apr 2010 18:15:58 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <1270577758.19685.15557.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100405194055.GA5265@nowhere>
	 <20100405.191555.184824968.davem@davemloft.net>
	 <1270561264.2738.8.camel@localhost.localdomain>
	 <20100406.104635.210218044.davem@davemloft.net>
In-Reply-To: <20100406.104635.210218044.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: srostedt@redhat.com, fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

On Tue, 2010-04-06 at 10:46 -0700, David Miller wrote:
> From: Steven Rostedt <srostedt@redhat.com>
> Date: Tue, 06 Apr 2010 09:41:04 -0400
> 
> > It's best to send to my rostedt@goodmis.org account, just like it is
> > best to send to your davem@davemloft.net ;-)
> 
> Ok then you should, like me, use it in your commits :-)
> 

My SoB is rostedt@goodmis.org, my commits are srostedt@redhat.com just
because I want to give credit to the one that pays me for making those
commits ;-)


> > What about removing the logic from the ring buffer and moving it to the
> > TRACE_EVENT() macros as I suggested above?
> 
> No, that makes no sense, just align the data types properly
> instead of making every single access site pay the price.

OK

> 
> Just fix the CPP test to handle 32-bit platforms with slow
> mis-alignment handling, everything else seems to be working properly
> after I fixed the NMI issues on sparc64.

A little more work will need to be done since on 32bit, the page headers
are 12 bytes, not 16, so we start off without being aligned 8bytes. But
that too is fixable.

-- Steve


