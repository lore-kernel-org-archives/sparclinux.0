From: Julien Thierry <julien.thierry@arm.com>
Date: Fri, 15 Jun 2018 08:01:02 +0000
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-Id: <4eb34b18-11f8-7d70-46a5-f206d127b768@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613083419.GS12258@hirez.programming.kicks-ass.net>
 <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
 <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de>
 <c000699c-7859-74ec-7944-ec484e887f60@arm.com>
 <20180615021213.GC11625@voyager>
In-Reply-To: <20180615021213.GC11625@voyager>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Doug Berger <opendmb@gmail.com>

Hi Ricardo,

On 15/06/18 03:12, Ricardo Neri wrote:
> On Wed, Jun 13, 2018 at 11:06:25AM +0100, Marc Zyngier wrote:
>> On 13/06/18 10:20, Thomas Gleixner wrote:
>>> On Wed, 13 Jun 2018, Julien Thierry wrote:
>>>> On 13/06/18 09:34, Peter Zijlstra wrote:
>>>>> On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
>>>>>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>>>>>> index 5426627..dbc5e02 100644
>>>>>> --- a/include/linux/interrupt.h
>>>>>> +++ b/include/linux/interrupt.h
>>>>>> @@ -61,6 +61,8 @@
>>>>>>     *                interrupt handler after suspending interrupts. For
>>>>>> system
>>>>>>     *                wakeup devices users need to implement wakeup
>>>>>> detection in
>>>>>>     *                their interrupt handlers.
>>>>>> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as
>>>>>> non-maskable, if
>>>>>> + *                supported by the chip.
>>>>>>     */
>>>>>
>>>>> NAK on the first 6 patches. You really _REALLY_ don't want to expose
>>>>> NMIs to this level.
>>>>>
>>>>
>>>> I've been working on something similar on arm64 side, and effectively the one
>>>> thing that might be common to arm64 and intel is the interface to set an
>>>> interrupt as NMI. So I guess it would be nice to agree on the right approach
>>>> for this.
>>>>
>>>> The way I did it was by introducing a new irq_state and let the irqchip driver
>>>> handle most of the work (if it supports that state):
>>>>
>>>> https://lkml.org/lkml/2018/5/25/181
>>>>
>>>> This has not been ACKed nor NAKed. So I am just asking whether this is a more
>>>> suitable approach, and if not, is there any suggestions on how to do this?
>>>
>>> I really didn't pay attention to that as it's burried in the GIC/ARM series
>>> which is usually Marc's playground.
>>
>> I'm working my way through it ATM now that I have some brain cycles back.
>>
>>> Adding NMI delivery support at low level architecture irq chip level is
>>> perfectly fine, but the exposure of that needs to be restricted very
>>> much. Adding it to the generic interrupt control interfaces is not going to
>>> happen. That's doomed to begin with and a complete abuse of the interface
>>> as the handler can not ever be used for that.
>>
>> I can only agree with that. Allowing random driver to use request_irq()
>> to make anything an NMI ultimately turns it into a complete mess ("hey,
>> NMI is *faster*, let's use that"), and a potential source of horrible
>> deadlocks.
>>
>> What I'd find more palatable is a way for an irqchip to be able to
>> prioritize some interrupts based on a set of architecturally-defined
>> requirements, and a separate NMI requesting/handling framework that is
>> separate from the IRQ API, as the overall requirements are likely to
>> completely different.
>>
>> It shouldn't have to be nearly as complex as the IRQ API, and require
>> much stricter requirements in terms of what you can do there (flow
>> handling should definitely be different).
> 
> Marc, Julien, do you plan to actively work on this? Would you mind keeping
> me in the loop? I also need this work for this watchdog. In the meantime,
> I will go through Julien's patches and try to adapt it to my work.

We are going to work on this and of course your input is most welcome to 
make sure we have an interface usable across different architectures.

In my patches, I'm not sure there is much to adapt to your work as most 
of it is arch specific (although I wont say no to another pair of eyes 
looking at them). From what I've seen of your patches, the point where 
we converge is that need for some code to be able to tell the irqchip "I 
want that particular interrupt line to be treated/setup as an NMI".

We'll make sure to keep you in the loop for discussions/suggestions on this.

Thanks,

-- 
Julien Thierry
