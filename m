From: Julien Thierry <julien.thierry@arm.com>
Date: Wed, 13 Jun 2018 09:36:56 +0000
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-Id: <344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613083419.GS12258@hirez.programming.kicks-ass.net>
 <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
 <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brg>



On 13/06/18 10:20, Thomas Gleixner wrote:
> On Wed, 13 Jun 2018, Julien Thierry wrote:
>> On 13/06/18 09:34, Peter Zijlstra wrote:
>>> On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
>>>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>>>> index 5426627..dbc5e02 100644
>>>> --- a/include/linux/interrupt.h
>>>> +++ b/include/linux/interrupt.h
>>>> @@ -61,6 +61,8 @@
>>>>     *                interrupt handler after suspending interrupts. For
>>>> system
>>>>     *                wakeup devices users need to implement wakeup
>>>> detection in
>>>>     *                their interrupt handlers.
>>>> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as
>>>> non-maskable, if
>>>> + *                supported by the chip.
>>>>     */
>>>
>>> NAK on the first 6 patches. You really _REALLY_ don't want to expose
>>> NMIs to this level.
>>>
>>
>> I've been working on something similar on arm64 side, and effectively the one
>> thing that might be common to arm64 and intel is the interface to set an
>> interrupt as NMI. So I guess it would be nice to agree on the right approach
>> for this.
>>
>> The way I did it was by introducing a new irq_state and let the irqchip driver
>> handle most of the work (if it supports that state):
>>
>> https://lkml.org/lkml/2018/5/25/181
>>
>> This has not been ACKed nor NAKed. So I am just asking whether this is a more
>> suitable approach, and if not, is there any suggestions on how to do this?
> 
> I really didn't pay attention to that as it's burried in the GIC/ARM series
> which is usually Marc's playground.
> 
> Adding NMI delivery support at low level architecture irq chip level is
> perfectly fine, but the exposure of that needs to be restricted very
> much. Adding it to the generic interrupt control interfaces is not going to
> happen. That's doomed to begin with and a complete abuse of the interface
> as the handler can not ever be used for that.
> 

Understood, however the need would be to provide a way for a driver to 
request an interrupt to be delivered as an NMI (if irqchip supports it).

But from your response this would be out of the question (in the 
interrupt/irq/irqchip definitions).

Or somehow the concerned irqchip informs the arch it supports NMI 
delivery and it is up to the interested drivers to query the arch 
whether NMI delivery is supported by the system?

Thanks,

-- 
Julien Thierry
