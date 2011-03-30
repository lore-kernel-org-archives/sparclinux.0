From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 30 Mar 2011 10:00:53 +0000
Subject: Re: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ Controller
Message-Id: <4D92FF55.3030007@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Wed, 16 Mar 2011 16:54:24 +0100
>
>  
>
>>The AMBA Plug&Play information supports only 1 IRQ per AMBA device,
>>a device node in linux is an AMBA core which consists of 3 devices
>>(AHB Master, AHB Slave and APB Slave in any combination). The IRQ
>>information is really the first IRQ of a device, the Plug&Play does
>>not tell how many IRQs are actually present on a device so the
>>interrupt property of a device can impossibly tell how many IRQs
>>each device has, it must be up to the driver to probe the hardware
>>in a device-specific way simply know how many IRQs are present.
>>
>>Using Virtual IRQs does not work for such devices, because VIRQ+1
>>is not REAL_IRQ+1. Thus, the LEON architecture needs real IRQs or
>>map virtual IRQs 1:1 to real IRQs.
>>
>>This patch changes the VIRQ allocation to try the real IRQ if not
>>already taken.
>>
>>LEON IRQ Controller is edge triggered, not masking or acking is
>>needed in the normal case, handle_simple_irq handler can be used
>>for that.
>>
>>Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>    
>>
>
>As I stated in another email I am absolutely and completely against
>this change.
>
>Just because you only store one interrupt in the firmware device node,
>it does not mean that you cannot store multiple interrupts in the
>internal device node structure we build.  And then have the drivers
>use that.
>  
>
Yes, I agree with you that this is the best solution. However, the 
hardware simply does not support that. That would require the bootloader 
to have one driver per core and that the bootloader must be modified 
each time a user of LEON or gaisler adds a new core.

I have made another patch that creates all 0..15 IRQs on startup instead 
in leon_kernel.c. It will ensure linearity within that range, and 
patching of irq_32.c is not needed. Perhaps that is more acceptable?

Regards,
Daniel
