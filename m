From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 03 Sep 2008 00:42:11 +0000
Subject: Re: [PATCH] prevent sparc64 from invoking irq handlers on offline
Message-Id: <20080903004211.GD6748@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080831173349.GA15393@linux.vnet.ibm.com> <20080902.171630.193505044.davem@davemloft.net>
In-Reply-To: <20080902.171630.193505044.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org, manfred@colorfullife.com, akpm@linux-foundation.org

On Tue, Sep 02, 2008 at 05:16:30PM -0700, David Miller wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Date: Sun, 31 Aug 2008 10:33:49 -0700
> 
> > Make sparc64 refrain from clearing a given to-be-offlined CPU's bit in the
> > cpu_online_mask until it has processed pending irqs.  This change
> > prevents other CPUs from being blindsided by an apparently offline CPU
> > nevertheless changing globally visible state.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> I wonder what the 'call_lock' thing protects :-)

I didn't look till now.  ;-)

> That lock is a cobweb from the sparc64 code before I switched it over
> to use the generic smp_call_function() code in kernel/smp.c
> 
> So this lock doesn't protect anything any more.

It is a static defined in arch/sparc64/kernel/smp.c, and is used only
when setting and clearing bits in cpu_online_mask.

> kernel/smp.c has a call_function_lock, which isn't marked static
> but isn't declared in any header file.

It is exported via ipi_call_lock(), ipi_call_unlock(), and friends.
A few architectures use it to exclude some of the IPI code while
setting (but not clearing) bits in cpu_online_map.  These particular
architectures have a phase during CPU offlining where they drain
pending interrupts, so perhaps that is why they only worry about
onlining?

> My instinct is that the intention is that I could use this lock
> for the synchronization previously provided by sparc64's local
> "call_lock", and it even seems the author of kernel/smp.c intended
> this kind of usage.
> 
> Anyways, if this code is still using the worthless call_lock, it
> isn't protecting against anything.

Agreed.

> So I'd like to hold off on this patch until this locking issue is
> resolved.

OK, it is your architecture.  But in the meantime, sparc64 can take
interrupts on CPUs whose cpu_online_map bits have been cleared.

							Thanx, Paul
