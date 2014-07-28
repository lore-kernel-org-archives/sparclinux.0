From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jul 2014 22:54:25 +0000
Subject: Re: [PATCH] Fix BREAK handling in sunsab serial driver
Message-Id: <20140728.155425.1055511642008591127.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271519.22272.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271519.22272.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 15:19:21 +0200

> However, there seems to be another problem that causes an Oops when
> a register dump is requested by SysRq. This is caused when
> perf_event_print_debug() is called from sysrq_handle_showregs() in
> drivers/tty/sysrq.c.

Did you save the OOPS?  It should be trivial to debug with that
information.

perf_event_print_debug() doesn't do anything fancy, it disables CPU
interrupts and reads the PCR and PIC registers.

UltraSPARC-III should be using direct_pcr_ops for this, therefore:

	__asm__ __volatile__("rd %%pcr, %0" : "=r" (val));

and

	__asm__ __volatile__("rd %%pic, %0" : "=r" (val));

are the two operations it will perform.
