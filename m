From: Julien Thierry <julien.thierry@arm.com>
Date: Wed, 13 Jun 2018 09:49:05 +0000
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-Id: <f2172062-c13d-837f-fb75-31da50853cc6@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<20180613083419.GS12258@hirez.programming.kicks-ass.net>
	<26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
	<alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de>
	<344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
In-Reply-To: <344b838e-81e3-97d8-f90d-315fed7879c1-5wv7dgnIgG8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Andi Kleen <andi.kleen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Masami Hiramatsu <mhiramat-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ravi V. Shankar" <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Levin,
	Alexander (Sasha Levin)" <alexander.levin-H+0wwilmMs1BDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linuxppc-dev-uLR06cmDAlaKREJ1Ck/qmQ@public.gmane.org



On 13/06/18 10:36, Julien Thierry wrote:
> 
> 
> On 13/06/18 10:20, Thomas Gleixner wrote:
>> On Wed, 13 Jun 2018, Julien Thierry wrote:
>>> On 13/06/18 09:34, Peter Zijlstra wrote:
>>>> On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
>>>>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>>>>> index 5426627..dbc5e02 100644
>>>>> --- a/include/linux/interrupt.h
>>>>> +++ b/include/linux/interrupt.h
>>>>> @@ -61,6 +61,8 @@
>>>>>     *                interrupt handler after suspending interrupts. 
>>>>> For
>>>>> system
>>>>>     *                wakeup devices users need to implement wakeup
>>>>> detection in
>>>>>     *                their interrupt handlers.
>>>>> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as
>>>>> non-maskable, if
>>>>> + *                supported by the chip.
>>>>>     */
>>>>
>>>> NAK on the first 6 patches. You really _REALLY_ don't want to expose
>>>> NMIs to this level.
>>>>
>>>
>>> I've been working on something similar on arm64 side, and effectively 
>>> the one
>>> thing that might be common to arm64 and intel is the interface to set an
>>> interrupt as NMI. So I guess it would be nice to agree on the right 
>>> approach
>>> for this.
>>>
>>> The way I did it was by introducing a new irq_state and let the 
>>> irqchip driver
>>> handle most of the work (if it supports that state):
>>>
>>> https://lkml.org/lkml/2018/5/25/181
>>>
>>> This has not been ACKed nor NAKed. So I am just asking whether this 
>>> is a more
>>> suitable approach, and if not, is there any suggestions on how to do 
>>> this?
>>
>> I really didn't pay attention to that as it's burried in the GIC/ARM 
>> series
>> which is usually Marc's playground.
>>
>> Adding NMI delivery support at low level architecture irq chip level is
>> perfectly fine, but the exposure of that needs to be restricted very
>> much. Adding it to the generic interrupt control interfaces is not 
>> going to
>> happen. That's doomed to begin with and a complete abuse of the interface
>> as the handler can not ever be used for that.
>>
> 
> Understood, however the need would be to provide a way for a driver to 
> request an interrupt to be delivered as an NMI (if irqchip supports it).
> 
> But from your response this would be out of the question (in the 
> interrupt/irq/irqchip definitions).
> 
> Or somehow the concerned irqchip informs the arch it supports NMI 
> delivery and it is up to the interested drivers to query the arch 
> whether NMI delivery is supported by the system?

Actually scratch that last part, it is also missing a way for the driver 
to actually communicate to the irqchip that its interrupt should be 
treated as an NMI, so it wouldn't work...

-- 
Julien Thierry
