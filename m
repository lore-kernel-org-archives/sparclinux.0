From: David Miller <davem@davemloft.net>
Date: Wed, 02 Oct 2013 20:17:00 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131002.161700.447115901830751131.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Tue, 01 Oct 2013 18:20:07 -0700

> On 09/30/2013 04:07 PM, David Miller wrote:
>> From: Gurudas Pai <gurudas.pai@oracle.com>
>> Date: Mon, 30 Sep 2013 13:14:01 -0700
>>
>>> And I think we need to increase NR_CPUS.
>> Just set the config option to the appropriate value when you build, I
>> set it to 128 for my T4-2.
> Sure, also it is running out of NR_IRQ. I agree this is not related to
> 47-bit bit patches.
> 
> IRQ: Out of virtual IRQs.
> IRQ: Out of virtual IRQs.
> IRQ: Out of virtual IRQs.
> IRQ: Out of virtual IRQs.

Can you send me the output of "/usr/sbin/prtconf -pv" and a machine
description dump from this machine?

You can get the raw binary machine description blob under linux into a
file by simply doing a large enough read() on /dev/mdesc.  The read()
system call will return -EMSGSIZE until you pass in a large enough
sized buffer.

Thanks.
