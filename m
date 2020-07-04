From: Valentin Schneider <valentin.schneider@arm.com>
Date: Sat, 04 Jul 2020 23:51:26 +0000
Subject: Re: [PATCH 0/2] genirq: Kill preflow handlers
Message-Id: <jhjo8oug7pd.mognet@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200703155645.29703-1-valentin.schneider@arm.com> <6d902159f1819b6f3a0af5e982d11868@kernel.org>
In-Reply-To: <6d902159f1819b6f3a0af5e982d11868@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>


Hi Marc,

On 04/07/20 10:48, Marc Zyngier wrote:
> Hi Valentin,
>
> On 2020-07-03 16:56, Valentin Schneider wrote:
>> Hi,
>>
>> while strolling around the different flow handlers, I tried to make
>> sense of
>> what preflow_handler() was about. Turns out no one uses those anymore,
>> but the
>> genirq support has remained in place.
>
> If we needed to reintroduce some form of preflow handler, we'd try and
> do it using hierarchical irqchips, if at all possible.

Right, that does sound like the most sensible approach. If I got my history
right, the preflow handlers saw the light of day before hierarchical
domains did, which I suppose is a reason why it wasn't done that way back
then.

>
>>
>> Unless we can see another user of those in the near future, this seems
>> like as
>> good a time as any for a little housecleaning.
>>
>> - Patch 1 simply deselects the (unexploited) preflow Kconfig for
>> sparc64
>> - Patch 2 is the actual cleanup
>>
>> Cheers,
>> Valentin
>>
>> Valentin Schneider (2):
>>   sparc64: Deselect IRQ_PREFLOW_FASTEOI
>>   genirq: Remove preflow handler support
>>
>>  arch/sparc/Kconfig         |  1 -
>>  include/linux/irqdesc.h    | 15 ---------------
>>  include/linux/irqhandler.h |  1 -
>>  kernel/irq/Kconfig         |  4 ----
>>  kernel/irq/chip.c          | 13 -------------
>>  5 files changed, 34 deletions(-)
>
> For the whole series, and assuming that there is no regression
> (can't imagine any for unused code):
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
>

Thanks!

> Thanks,
>
>          M.
