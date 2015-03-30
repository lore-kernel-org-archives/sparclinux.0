From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 30 Mar 2015 21:28:57 +0000
Subject: Re: [PATCH v7 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <1427750937.20500.99.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427295804.git.sowmini.varadhan@oracle.com>
 <b9dbeef3a3ae463a5198b6d34eb446ae50966a66.1427295804.git.sowmini.varadhan@oracle.com>
 <1427685844.20500.66.camel@kernel.crashing.org>
 <20150330103824.GA26127@oracle.com>
 <1427712943.20500.77.camel@kernel.crashing.org>
 <20150330130116.GE26127@oracle.com> <20150330211525.GM26127@oracle.com>
In-Reply-To: <20150330211525.GM26127@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Mon, 2015-03-30 at 17:15 -0400, Sowmini Varadhan wrote:
> On (03/30/15 09:01), Sowmini Varadhan wrote:
> > 
> > So I tried looking at the code, and perhaps there is some arch-specific
> > subtlety here that I am missing, but where does spin_lock itself
> > do the cpu_relax? afaict, LOCK_CONTENDED() itself does not have this.
> 
> To answer my question:
> I'd missed the CONFIG_LOCK_STAT (which David Ahern pointed out to me).
> the above is only true for the LOCK_STAT case.

powerpc:

static inline void arch_spin_lock(arch_spinlock_t *lock)
{
	CLEAR_IO_SYNC;
	while (1) {
		if (likely(__arch_spin_trylock(lock) = 0))
			break;
		do {
			HMT_low();
			if (SHARED_PROCESSOR)
				__spin_yield(lock);
		} while (unlikely(lock->slock != 0));
		HMT_medium();
	}
}

The HMT_* statements are what reduces the thread prio. Additionally,
the yield thingy is something that allows us to relinguish out time
slice to the partition owning the lock if it's not currently scheduled
by the hypervisor.

> In any case, I ran some experiments today: I was running 
> iperf [http://en.wikipedia.org/wiki/Iperf] over ixgbe, which
> is where I'd noticed the original perf issues for sparc. I was
> running iperf2 (which is more aggressively threaded than iperf3) with
> 8, 10, 16, 20 threads, and with TSO turned off. In each case, I was
> making sure that I was able to reach 9.X Gbps (this is a 10Gbps link)
> 
> I dont see any significant difference in the perf profile between the
> spin_trylock and the spin_lock version (other than, of course, the change
> to the lock-contention for the trylock version). I looked at the
> perf profiled cache-misses (works out to about 1400M for 10 threads,
> with or without the trylock).
> 
> I'm still waiting for some of the IB folks to try out the spin_lock
> version (they had also seen some significant perf improvements from
> breaking down the monolithic lock into multiple pools, so their workload
> is also sensitive to this)
> 
> But as such, it looks like it doesnt matter much, whether you use
> the trylock to find the first available pool, or block on the spin_lock.
> I'll let folks on this list vote on this one (assuming the IB tests also 
> come out without a significant variation between the 2 locking choices).

Provided that the IB test doesn't come up with a significant difference,
I definitely vote for the simpler version of doing a normal spin_lock.

Cheers,
Ben.


