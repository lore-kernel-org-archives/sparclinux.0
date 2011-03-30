From: David Miller <davem@davemloft.net>
Date: Wed, 30 Mar 2011 10:34:11 +0000
Subject: Re: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ
Message-Id: <20110330.033411.232894240.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 30 Mar 2011 12:00:53 +0200

> Yes, I agree with you that this is the best solution. However, the
> hardware simply does not support that. That would require the
> bootloader to have one driver per core and that the bootloader must be
> modified each time a user of LEON or gaisler adds a new core.
> 
> I have made another patch that creates all 0..15 IRQs on startup
> instead in leon_kernel.c. It will ensure linearity within that range,
> and patching of irq_32.c is not needed. Perhaps that is more
> acceptable?

I am not asking you to modify the boot loader or whatever creates
the firmware device tree on LEON.

I'm telling you to modify the kernel to create device node objects
which have an array of multiple IRQ entries when such devices are
found during the import of the device tree.
