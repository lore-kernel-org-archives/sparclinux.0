From: David Miller <davem@davemloft.net>
Date: Tue, 06 Apr 2010 21:17:44 +0000
Subject: Re: Random scheduler/unaligned accesses crashes with perf lock
Message-Id: <20100406.141744.17264255.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270561264.2738.8.camel@localhost.localdomain>
	<20100406.104635.210218044.davem@davemloft.net>
	<1270577758.19685.15557.camel@gandalf.stny.rr.com>
In-Reply-To: <1270577758.19685.15557.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org
Cc: srostedt@redhat.com, fweisbec@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com, a.p.zijlstra@chello.nl, paulus@samba.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 06 Apr 2010 14:15:58 -0400

> On Tue, 2010-04-06 at 10:46 -0700, David Miller wrote:
>> Just fix the CPP test to handle 32-bit platforms with slow
>> mis-alignment handling, everything else seems to be working properly
>> after I fixed the NMI issues on sparc64.
> 
> A little more work will need to be done since on 32bit, the page headers
> are 12 bytes, not 16, so we start off without being aligned 8bytes. But
> that too is fixable.

Oh yeah the buffer_data_page, good point.
