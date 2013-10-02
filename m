From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Wed, 02 Oct 2013 01:20:07 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <524B74C7.7090302@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/30/2013 04:07 PM, David Miller wrote:
> From: Gurudas Pai <gurudas.pai@oracle.com>
> Date: Mon, 30 Sep 2013 13:14:01 -0700
>
>> And I think we need to increase NR_CPUS.
> Just set the config option to the appropriate value when you build, I
> set it to 128 for my T4-2.
Sure, also it is running out of NR_IRQ. I agree this is not related to 
47-bit bit patches.

IRQ: Out of virtual IRQs.
IRQ: Out of virtual IRQs.
IRQ: Out of virtual IRQs.
IRQ: Out of virtual IRQs.

Thanks,
-Guru
