From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 27 Jan 2011 17:29:16 +0000
Subject: Re: [PATCH] SPARC/LEON: FPU-FSR only available when FPU present
Message-Id: <20110127172916.GA4468@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059825-22822-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059825-22822-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 27, 2011 at 12:06:27PM +0100, Daniel Hellstrom wrote:
> Sam Ravnborg wrote:
>
>> On Wed, Jan 26, 2011 at 05:37:05PM +0100, Daniel Hellstrom wrote:
>>  
>>
>>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>> ---
>>> arch/sparc/kernel/cpu.c |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
>>> index 0dc714f..7925c54 100644
>>> --- a/arch/sparc/kernel/cpu.c
>>> +++ b/arch/sparc/kernel/cpu.c
>>> @@ -324,7 +324,7 @@ void __cpuinit cpu_probe(void)
>>> 	psr = get_psr();
>>> 	put_psr(psr | PSR_EF);
>>> #ifdef CONFIG_SPARC_LEON
>>> -	fpu_vers = 7;
>>> +	fpu_vers = get_psr() & PSR_EF ? ((get_fsr() >> 17) & 0x7) : 7;
>>> #else
>>> 	fpu_vers = ((get_fsr() >> 17) & 0x7);
>>> #endif
>>>    
>>>
>>
>> This file is full of numbers.
>> But for new stuff it would be great with symbolic constants.
>>  
>>
> Please ack this patch, and see the follow up patch doing some cleaning  
> of PSR/FSR code.
I have no problem with the patch per see. I was just
looking for a possibility to get rid of an ifdef.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

Btw. my ack is not a precondition for David to merge your
patches - but it may help a little :-)

	Sam
