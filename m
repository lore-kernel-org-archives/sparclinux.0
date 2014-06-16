From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 16 Jun 2014 09:29:24 +0000
Subject: Re: [PATCH 00/21] add and use devm_irq_of_parse_and_map()
Message-Id: <539EB8F4.20104@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <53997AF6.1040003@gaisler.com> <5399AE1B.1080301@gaisler.com> <5399F92B.50406@dev.rtsoft.ru> <539EA986.1090501@gaisler.com> <539EAC92.1040606@dev.rtsoft.ru>
In-Reply-To: <539EAC92.1040606@dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Cc: lugovskoy@dev.rtsoft.ru, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

On 2014-06-16 10:36, Nikita Yushchenko wrote:
>>>> SPARC does not use OF_IRQ and has a different implementation of
>>>> irq_of_parse_and_map than the one in drivers/of/irq.c. All code
>>>> converted from irq_of_parse_and_map to devm_irq_of_parse_and_map in this
>>>> patch set will be unlinkable for SPARC. This includes SPI in general and
>>>> many drivers that are used for SPARC (of which several are currently
>>>> only used on SPARC platforms).
>>>
>>> Can this be fixed by adding a copy of devm_irq_of_parse_and_map() to
>>> arch/sparc/kernel/of_device_common.c ?
>>
>> Not a copy of the version in irq.c no. On SPARC, IRQ_DOMAIN is not
>> selected in general.
>>
>> However, there is no technical problem that I can see with having a
>> SPARC version of devm_irq_of_parse_and_map that just calls
>> irq_of_parse_and_map as there are no mappings that needs to be disposed
>> of. (The empty dummy for irq_dispose_mapping is used if any
>> irq_dispose_mapping calls are made from drivers).
>
> Ok, I will post an updated patchset that adds sparc
> devm_irq_of_parse_and_map() that just calls irq_of_parse_and_map(), and
> devm_irq_dispose_mapping() that does nothing.

You have already added the needed empty devm_irq_dispose_mapping in 
include/linux/irqdomain.h.

Note that the IRQ_DOMAIN *can* be used under SPARC (GPIO_GRGPIO is one 
example that selects it), but it is not used at the top level so to 
speak. There should not be a SPARC specific empty version of 
devm_irq_dispose_mapping - CONF_IRQ_DOMAIN or not takes care of that.


> Also, you mentioned that some drivers that my original patchset touches
> are sparc-only?  Then, maybe better not convert these to devm_? Could
> you please give a list of such drivers?

The drivers that I know of off hand is not necessarily SPARC only. Some 
are currently only found in SPARC environments, but that could change in 
the future. I personally don't see a problem with using 
devm_of_parse_and_map solution as long as there is a SPARC-specific one 
as discussed above.

Best regards,
Andreas Larsson
