From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 27 Jan 2011 11:21:03 +0000
Subject: Re: [PATCH] sparc: cleaned up FPU version probing
Message-Id: <4D41551F.8070805@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296126392-7536-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 27/01/2011 11:14, Richard Mortimer wrote:
>
>
> On 27/01/2011 11:06, Daniel Hellstrom wrote:
>> Signed-off-by: Daniel Hellstrom<daniel@gaisler.com>
>> ---
>> arch/sparc/include/asm/psr.h | 51
>> ++++++++++++++++++++++++++++++++++++++++++
>> arch/sparc/kernel/cpu.c | 11 +++++---
>> 2 files changed, 58 insertions(+), 4 deletions(-)
>>
> ...
>
>> diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
>> index 7925c54..bc8d5ef 100644
>> --- a/arch/sparc/kernel/cpu.c
>> +++ b/arch/sparc/kernel/cpu.c
>> @@ -318,15 +318,18 @@ void __cpuinit cpu_probe(void)
>> int psr_impl, psr_vers, fpu_vers;
>> int psr;
>>
>> - psr_impl = ((get_psr()>> 28)& 0xf);
>> - psr_vers = ((get_psr()>> 24)& 0xf);
>> + psr_impl = ((get_psr()& PSR_IMPL)>> PSR_IMPL_SHIFT);
> This is going to break. If the top bit of psr_impl is set it
> will get sign extended when the left shift is done.
Of course I meant right shift :-)

>
>> + psr_vers = ((get_psr()& PSR_VERS)>> PSR_VERS_SHIFT);
>>
>> psr = get_psr();
>> put_psr(psr | PSR_EF);
>> #ifdef CONFIG_SPARC_LEON
>> - fpu_vers = get_psr()& PSR_EF ? ((get_fsr()>> 17)& 0x7) : 7;
>> + if (get_psr()& PSR_EF)
>> + fpu_vers = (get_fsr()& FSR_VER)>> FSR_VER_SHIFT;
>> + else
>> + fpu_vers = FSR_VER_NOFPU;
>> #else
>> - fpu_vers = ((get_fsr()>> 17)& 0x7);
>> + fpu_vers = ((get_fsr()& FSR_VER)>> FSR_VER_SHIFT);
>> #endif
>>
>> put_psr(psr);
