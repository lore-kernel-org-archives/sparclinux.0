From: David Miller <davem@davemloft.net>
Date: Thu, 17 Feb 2011 21:13:22 +0000
Subject: Re: How do we allocate virtual floppy irq on sparc64
Message-Id: <20110217.131322.189706454.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110217205747.GA25027@merkur.ravnborg.org>
In-Reply-To: <20110217205747.GA25027@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 17 Feb 2011 13:05:03 -0800 (PST)

> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 17 Feb 2011 21:57:48 +0100
> 
>> I'm trying to understand how we deal with floppy irq on sparc64.
>> 
>> In arch/sparc/include/asm/floppy_64.h we have:
>> 
>>                error = request_irq(FLOPPY_IRQ, sparc_floppy_irq,
>>                                     IRQF_DISABLED, "floppy", NULL);
>> 
>> FLOPPY_IRQ is set equal op->archdata.irqs[0] in sun_floppy_init().
>> So FLOPPY_IRQ is the platform irq - and not a virtual irq.
> 
> The archdata IRQ is actually the computed virtual IRQ.
> 
> This is the same as how we fetch the IRQ to use in other "OF" platform
> drivers.
> 
> Look at drivers/net/sunhme.c's OF platform driver probing, it uses
> of->archdata.irqs[0] as the IRQ.

BTW, if you're looking for where this is computed, look in
arch/sparc/kernel/of_device_64.c:scan_one_device() and
build_one_device_irq().
