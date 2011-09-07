From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 07 Sep 2011 17:57:21 +0000
Subject: Re: [PATCH 20/62] sparc: irq: Remove IRQF_DISABLED
Message-Id: <alpine.LFD.2.02.1109071954200.2723@ionos>
List-Id: <sparclinux.vger.kernel.org>
References: <20110907.131217.2301665763990232637.davem@davemloft.net> <alpine.LFD.2.02.1109071924510.2723@ionos> <alpine.LFD.2.02.1109071933080.2723@ionos> <20110907.135110.2069876782156753239.davem@davemloft.net>
In-Reply-To: <20110907.135110.2069876782156753239.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: yong.zhang0@gmail.com, linux-kernel@vger.kernel.org, mingo@elte.hu, joe@perches.com, sparclinux@vger.kernel.org

On Wed, 7 Sep 2011, David Miller wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 7 Sep 2011 19:33:52 +0200 (CEST)
> 
> We had big problems when openning thousands of virtual network
> devices, each with their own unique IRQ, and pointed all at the same
> cpu, and we'd get IRQ stack overflows.
> 
> See commit c58543c869606532c2382f027d6466f4672ea756
> 
> So this change to make IRQF_DISABLED a nop has reintroduced this bug.

See commit e58aa3d2d0cc01ad8d6f7f640a0670433f794922

We run ALL interrupt handlers with interrupts disabled for that reason
and we even check and yell when an interrupt handler returns with
interrupts enabled. That's why IRQF_DISABLED became meaningless.

Thanks,

	tglx

