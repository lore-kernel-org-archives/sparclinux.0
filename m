From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 27 Jan 2011 18:39:47 +0000
Subject: Re: [PATCH] sparc: cleaned up FPU version probing
Message-Id: <4D41BBF3.4080506@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 27/01/2011 17:34, Sam Ravnborg wrote:
> On Thu, Jan 27, 2011 at 11:14:16AM +0000, Richard Mortimer wrote:
>>
>>
>> On 27/01/2011 11:06, Daniel Hellstrom wrote:
>>> Signed-off-by: Daniel Hellstrom<daniel@gaisler.com>
>>> ---
>>>    arch/sparc/include/asm/psr.h |   51 ++++++++++++++++++++++++++++++++++++++++++
>>>    arch/sparc/kernel/cpu.c      |   11 +++++---
>>>    2 files changed, 58 insertions(+), 4 deletions(-)
>>>
>> ...
>>
>>> diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
>>> index 7925c54..bc8d5ef 100644
>>> --- a/arch/sparc/kernel/cpu.c
>>> +++ b/arch/sparc/kernel/cpu.c
>>> @@ -318,15 +318,18 @@ void __cpuinit cpu_probe(void)
>>>    	int psr_impl, psr_vers, fpu_vers;
>>>    	int psr;
>>>
>>> -	psr_impl = ((get_psr()>>   28)&   0xf);
>>> -	psr_vers = ((get_psr()>>   24)&   0xf);
>>> +	psr_impl = ((get_psr()&   PSR_IMPL)>>   PSR_IMPL_SHIFT);
>> This is going to break. If the top bit of psr_impl is set it
>> will get sign extended when the left shift is done.
>
> That would not matter as we use the "&  PSR_IMPL" to clear
> the unused upper bits.
> So IMO the patch is correct.
>
I'm not sure. But I'm willing to be pursuaded.

Daniel changed the order of things. The shift is now done after the 
mask. Previously the mask was using 0xf and now it is using 0xf0000000.
e.g.
originally (0x8??????? >> 28)  gives 0xfffffff8 which is masked by 0xf 
to give 8

but now (0x8??????? & 0xf0000000) gives 0x80000000 which is shifted right 28
to give 0xfffffff8.

I must admit that I haven't looked at the defition of get_psr() but I 
think it returns an int and even if it returns unsigned I would be wary 
of leaving it as is because it is fragile in that particular case.

Regards

Richard
