From: David Miller <davem@davemloft.net>
Date: Mon, 31 Jan 2011 20:49:22 +0000
Subject: Re: [PATCH 1/2] SPARC32: implement SMP IPIs using the generic
Message-Id: <20110131.124922.71119103.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 31 Jan 2011 18:00:21 +0100

> For now I have changed the code to use a spinlock around the
> "work->msk=1 and IRQ generation" and the clearing of the "work->msk"
> in the interrupt handler.
> 
> But I disagree for the moment.. I used three IRQs to implement it the
> very first time because all other architectures does so and I also
> suspected races at first, however I think using memory barriers this
> way is enough. Since the clearing of the work->msk flag is always done
> after it has been checked and will will result in a call to the
> generic handler, so if a write to it was lost due to race does not
> really matter since it will reach the generic handler anyway (that was
> why it cleared it).

Ok, I tried to construct a case where it will fail, but I could not.
Part of the key is also that we clear the interrupt status in the
receiver before testing the mask value.

So feel free to stay with your version without spinlocks.

> Note that events will be lost when using 3 separate IRQs as well, when
> two CPUs are writing the soft-IRQ generate register when the target
> CPU is already is in an interrupt context only one IRQ will be
> generated. But I don't think it is the number of events that is the
> important thing here, rather one must make sure to enter the generic
> IPI-handler as long as there is something in the generic IPI-queue.

Yes, and this race is unique to how sparc32 remote IRQ sending works.
On sparc64, for example, we send IRQs to remote cpus by writing only
to local CPU registers.  So events cannot be lost and there are no
chip register programming races.

The key here is visibility.

>>I think we need 3, plus IRQ 15 for the cache/tlb flush IPIs.
>>
>>I tried to figure out if we have enough on LEON, but because the
>>per-cpu timer is variable, I can't figure that out.  Does that per-cpu
>>timer use IRQ 14?
>>  
> This varies slightly from design/chip to design unfortunatly. I will
> probably need to make this configurable from the GUI.
> 
> There are no per-cpu timers on the LEON, however there are multiple
> "global general purpose timers" which can generate IRQ that the IRQ
> controller can broadcast to all CPUs and/or individual CPUs by a
> mask-setting. That is why I can use only one timer for system clock
> and cpu profiling.

Please no more hacked settings in the kernel Kconfig for LEON, I already
think the U-Boot stuff is unreasonable but I let it in anyways.

Put device and misc config values where they belong, in the device
tree.

And make it so that U-Boot can be used without having to tweak the
kernel config in special ways.  The kernel really should not care where
it is loaded, and should be able to remap itself from any location
during the head.S startup sequence.
