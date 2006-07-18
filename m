From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2006 00:42:47 +0000
Subject: Re: sparc32 git tree
Message-Id: <20060717.174247.77055828.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Mon, 17 Jul 2006 10:45:16 -0500

> I think I've found the core problem with the prom properties, and a
> potential problem with the zilog initialization.  Could you try the
> attached patch and let me know if it works for you?

The property fix looks good, applied.  Thanks Bob.

The sunzilog change, hmmm... :)

This code works on my SBUS sparc64 machines using zilog serial,
so I wonder what's going wrong.

The sunzilog_alloc_tables() sets up the global list
sunzilog_irq_chain.

All the zilogs hang off of a single interrupt, and therefore
we need that interrupt to process all zilogs in the system.
That's why we pass sunzilog_irq_chain to request_irq().

I double checked the prtconf for a typical SS20 machine,
and both zilog devices have an identical IRQ specification.

This is identical to the behavior of the driver before I made
any changes, for example in 2.6.17.

What could be happening is that the interrupt hits before the
start of the UART struct and device are fully setup.  Perhaps
more of the uart_sunzilog_port initialization should be moved
into sunzilog_alloc_tables(), but there are critical things
we cannot initialize there because we don't have the of_device
object handy yet.

Ok, I think I see what's happening.  We register sunzilog_interrupt
before things like up->port.membase are fully setup.  We init
the first port, by calling sunzilog_init_hw() and that makes
the chip interrupt, I guess.  If that happens, the interrupt
handler will try to read the channel registers of the other
port as well, the pointer to which is still NULL.

Bob, can you confirm this is what is happening by putting some
NULL checks in sunzilog_interrupt or similar?

Thanks.
