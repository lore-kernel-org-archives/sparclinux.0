From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 27 Jan 2011 19:36:03 +0000
Subject: Re: [PATCH] sparc: cleaned up FPU version probing
Message-Id: <20110127193603.GA4730@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 27, 2011 at 06:39:47PM +0000, Richard Mortimer wrote:
>
>
> On 27/01/2011 17:34, Sam Ravnborg wrote:
>> On Thu, Jan 27, 2011 at 11:14:16AM +0000, Richard Mortimer wrote:
>>>
>>>
>>> On 27/01/2011 11:06, Daniel Hellstrom wrote:
>>>> Signed-off-by: Daniel Hellstrom<daniel@gaisler.com>
>>>> ---
>>>>    arch/sparc/include/asm/psr.h |   51 ++++++++++++++++++++++++++++++++++++++++++
>>>>    arch/sparc/kernel/cpu.c      |   11 +++++---
>>>>    2 files changed, 58 insertions(+), 4 deletions(-)
>>>>
>>> ...
>>>
>>>> diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
>>>> index 7925c54..bc8d5ef 100644
>>>> --- a/arch/sparc/kernel/cpu.c
>>>> +++ b/arch/sparc/kernel/cpu.c
>>>> @@ -318,15 +318,18 @@ void __cpuinit cpu_probe(void)
>>>>    	int psr_impl, psr_vers, fpu_vers;
>>>>    	int psr;
>>>>
>>>> -	psr_impl = ((get_psr()>>   28)&   0xf);
>>>> -	psr_vers = ((get_psr()>>   24)&   0xf);
>>>> +	psr_impl = ((get_psr()&   PSR_IMPL)>>   PSR_IMPL_SHIFT);
>>> This is going to break. If the top bit of psr_impl is set it
>>> will get sign extended when the left shift is done.
>>
>> That would not matter as we use the "&  PSR_IMPL" to clear
>> the unused upper bits.
>> So IMO the patch is correct.
>>
> I'm not sure. But I'm willing to be pursuaded.
>
> Daniel changed the order of things. The shift is now done after the  
> mask. Previously the mask was using 0xf and now it is using 0xf0000000.
> e.g.
> originally (0x8??????? >> 28)  gives 0xfffffff8 which is masked by 0xf  
> to give 8
>
> but now (0x8??????? & 0xf0000000) gives 0x80000000 which is shifted right 28
> to give 0xfffffff8.

You are right. I was only looking at the case where we shifted 17.

But get_psr() return an unsigned int:

   static inline unsigned int get_psr(void)

And same does get_fsr().

I checked a few drivers and it seems to be a common pattern to rely
on use of unisged variables.

If we want to be more explicit we can do:

	u32 psr;

	psr = get_psr();
	psr_impl = (psr & PSR_IMPL) >> PSR_IMPL_SHIFT;

I assume gcc will generate equal code for this.
But this looks like overkill.

The mixed use of unsigned int and int in this file also looks
like something to be cleaned up...

	Sam
