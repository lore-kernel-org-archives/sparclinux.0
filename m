From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 30 Mar 2011 12:41:45 +0000
Subject: Re: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ Controller
Message-Id: <4D932509.70700@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Wed, 30 Mar 2011 12:00:53 +0200
>
>  
>
>>Yes, I agree with you that this is the best solution. However, the
>>hardware simply does not support that. That would require the
>>bootloader to have one driver per core and that the bootloader must be
>>modified each time a user of LEON or gaisler adds a new core.
>>
>>I have made another patch that creates all 0..15 IRQs on startup
>>instead in leon_kernel.c. It will ensure linearity within that range,
>>and patching of irq_32.c is not needed. Perhaps that is more
>>acceptable?
>>    
>>
>
>I am not asking you to modify the boot loader or whatever creates
>the firmware device tree on LEON.
>
>I'm telling you to modify the kernel to create device node objects
>which have an array of multiple IRQ entries when such devices are
>found during the import of the device tree.
>  
>
I see, however that is almost as bad because that would also require one 
driver per core but in the LEON IRQ layer of Linux.

If I always create an array of say 8 IRQs starting from the first IRQ, 
for example for IRQ5: {5,6,7,8,9,10,11,12}, that would be a solution for 
the drivers as well. 8 IRQs should be enough per core. That would 
however require that I change the scan_one_device() (of_device_32.c) and 
add an extra call to sparc_irq_config structure, fixup_device_irqs() or 
prepare_device_irqs() or something like that. This will result in 
devices with an archdata.irqs[] containing unused IRQs that are not 
really available. Do you think this is an acceptable solution?

Daniel
