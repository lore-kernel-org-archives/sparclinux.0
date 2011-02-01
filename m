From: David Miller <davem@davemloft.net>
Date: Tue, 01 Feb 2011 20:34:51 +0000
Subject: Re: [PATCH 1/2] SPARC32: implement SMP IPIs using the generic
Message-Id: <20110201.123451.226779819.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 01 Feb 2011 08:41:51 +0100

> David Miller wrote:
> 
>>Yes, and this race is unique to how sparc32 remote IRQ sending works.
>>On sparc64, for example, we send IRQs to remote cpus by writing only
>>to local CPU registers.  So events cannot be lost and there are no
>>chip register programming races.
>>  
> But if the same CPU sends a IPI to the same receiver CPU twice when
> the receiver has interrupts of, shouldn't that also lead to a missed
> IPI? Perhaps the sparc64 has a FIFO of IPIs.

Inter-cpu interrupts have an at least 2 entry deep queue in each
cpu's incoming interrupt vector unit.

And if you overflow (which rarely happens except under extreme
load), the cpu sends a NACK packet back, which the sender sees
which lets the sender know it needs to resend.

These vectored interrupts are processed very fast, all they do for
the IPI case is either a cache/TLB flush or reschedule to a normal
PIL based IRQ with a local cpu register write.

Vectored interrupts on sparc64 are completely seperate from normal PIL
level based interrupts.  When we do local_irq_disable() on sparc64,
vectored interrupts still can arrive and be processed.

They are therefore very low latency, and therefore must either perform
some very quick task, or reschedule to a local PIL interrupt for
more involved processing.

> This is already true, it can be located on any 256 Mbyte boundary. The
> Kconfig options are only used to create the u-boot image, they do not
> change the arch/sparc/boot/image in any way, just a matter of
> convenience when creating the uImage similar to other architectures
> which support u-boot.

Ok, this is the part I didn't understand.
