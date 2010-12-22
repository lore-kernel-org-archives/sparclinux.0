From: David Miller <davem@davemloft.net>
Date: Wed, 22 Dec 2010 22:28:41 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <20101222.142841.59678110.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 22 Dec 2010 14:23:27 +0100

> I will try to create a patch for the atomic layer for SMP LEON systems
> since they have the CASA instruction.

But see my other posting, you still have to fix the irq15 problem.

Merely switching to CASA doesn't mean you don't still have a problem
because spin_lock_irqsave() and other similar pieces of code expect
they will not be interrupted by smp_call_function() calls.
