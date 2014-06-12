From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Date: Thu, 12 Jun 2014 19:02:03 +0000
Subject: Re: [PATCH 00/21] add and use devm_irq_of_parse_and_map()
Message-Id: <5399F92B.50406@dev.rtsoft.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <53997AF6.1040003@gaisler.com> <5399AE1B.1080301@gaisler.com>
In-Reply-To: <5399AE1B.1080301@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Larsson <andreas@gaisler.com>
Cc: lugovskoy@dev.rtsoft.ru, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

>> Currently many device tree aware drivers use irq_of_parse_and_map() to
>> get
>> IRQ number and then devm_request_irq() to set up IRQ handler.
>>
>> This causes a problem for exit path and for error paths: undo action for
>> irq_of_parse_and_map() is irq_dispose_mapping() that must not be called
>> while IRQ handler is defined, but devres moves free_irq() out of driver
>> so driver does not have safe place to call irq_dispose_mapping().
>>
>> So many drivers do not call irq_dispose_mapping() at all, others call it
>> while IRQ handler is defined (which is incorrect and causes error
>> messages
>> in logs), even others refuse to use devres for managing IRQ handlers.
>>
>> This patchset adds devres version of irq_of_parse_and_map(), and updates
>> in-tree users of both devres and irq_of_parse_and_map() to use
>> devm_irq_of_parse_and_map() instead.
> 
> 
> SPARC does not use OF_IRQ and has a different implementation of
> irq_of_parse_and_map than the one in drivers/of/irq.c. All code
> converted from irq_of_parse_and_map to devm_irq_of_parse_and_map in this
> patch set will be unlinkable for SPARC. This includes SPI in general and
> many drivers that are used for SPARC (of which several are currently
> only used on SPARC platforms).

Can this be fixed by adding a copy of devm_irq_of_parse_and_map() to
arch/sparc/kernel/of_device_common.c ?

Or there are some deep reasons why irq_of_parse_and_map() can't be
devm'd for sparc at all?

Nikita

