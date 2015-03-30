From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 30 Mar 2015 13:01:16 +0000
Subject: Re: [PATCH v7 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <20150330130116.GE26127@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
 <b9dbeef3a3ae463a5198b6d34eb446ae50966a66.1427295804.git.sowmini.varadhan@oracle.com>
 <1427685844.20500.66.camel@kernel.crashing.org>
 <20150330103824.GA26127@oracle.com>
 <1427712943.20500.77.camel@kernel.crashing.org>
In-Reply-To: <1427712943.20500.77.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On (03/30/15 21:55), Benjamin Herrenschmidt wrote:
> 
> No that's not my point. The lock is only taken for a short time but
> might still collide, the bouncing in that case will probably (at least
> that's my feeling) hurt more than help.
> 
> However, I have another concern with your construct. Essentially you
> spin looking for an unlocked pool without a cpu_relax. Now it's unlikely
> but you *can* end up eating cycles, which on a high SMT like POWER8
> might mean slowing down the actual owner of the pool lock. 

So I tried looking at the code, and perhaps there is some arch-specific
subtlety here that I am missing, but where does spin_lock itself
do the cpu_relax? afaict, LOCK_CONTENDED() itself does not have this.


> What is iperf ? What does that mean "there was lock contention" ? IE,
> was the overall performance improved or not ? Removing contention by
> trading it for cache line bouncing will not necessarily help. I'm not
> saying this is a bad optimisation but it makes the code messy and I
> think deserves some solid numbers demonstrating its worth.

iperf is a network perf benchmark. I'll try to regenerate some 
numbers today and get some instrumentation of cache-line bounces
vs trylock misses.
   
> There was also an actual bug in the case where you hop'ed to a new pool
> and forgot the flush.

yes, thanks for catching that, I'll fix that too, of course.

--Sowmini
