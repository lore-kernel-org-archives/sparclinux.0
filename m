From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2011 20:06:13 +0000
Subject: Re: [PATCH 0/3] sparc32: SMP IPI patches
Message-Id: <20110516.160613.390283690621436672.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB817B3.5050205@gaisler.com>
In-Reply-To: <4DB817B3.5050205@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2011 13:04:28 -0700 (PDT)

> From: Daniel Hellstrom <daniel@gaisler.com>
> Date: Wed, 27 Apr 2011 15:18:43 +0200
> 
>> I have made a new set of IPI patches, this time it includes a patch
>> for SUN4M but still missing SUN4D however.
>> 
>> I have tried to use BTFIXUPs and extract some code from the LEON to
>> the common smp_32.c as you suggested. I have left the non-spinlock
>> LEON code around per-cpu work data as we discussed, I think the same
>> argumentation works for sun4m to avoid races when clearing the pending
>> register in the interrupt trap handler.
>> 
>> This time I added some IPI IRQ statistics to the genirq
>> arch_show_interrupts(),
>> so the patches must be applied to sparc-next containing genirq
>> patches.
> 
> All 3 patches applied.

Oops, I see now there was a 4-patch "v2" series, will look that
over instead. :-)
