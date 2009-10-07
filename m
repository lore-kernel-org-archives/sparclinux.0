From: Michal Simek <monstr@monstr.eu>
Date: Wed, 07 Oct 2009 14:07:39 +0000
Subject: Re: [microblaze-uclinux] Re: [RFC PATCH 05/12] of: add common header
Message-Id: <4ACCA0AB.80407@monstr.eu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
	<20091007155717.8df62c4d.sfr@canb.auug.org.au>
	<4ACC861A.7020506@monstr.eu>
	<fa686aa40910070638v16c1b811w4e5ecb61a9afd836@mail.gmail.com>
In-Reply-To: <fa686aa40910070638v16c1b811w4e5ecb61a9afd836@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: microblaze-uclinux@itee.uq.edu.au
Cc: sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net



Grant Likely wrote:
> On Wed, Oct 7, 2009 at 6:14 AM, Michal Simek <monstr@monstr.eu> wrote:
>>
>> Stephen Rothwell wrote:
>>> Hi Grant,
>>>
>>> Just first obvious thing:
>>>
>>> On Tue, 06 Oct 2009 22:30:59 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
>>>> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
>>>> index 64e8b3a..5f461f0 100644
>>>> --- a/arch/microblaze/include/asm/prom.h
>>>> +++ b/arch/microblaze/include/asm/prom.h
>>>> @@ -17,20 +17,10 @@
>>>>  #ifndef _ASM_MICROBLAZE_PROM_H
>>>>  #define _ASM_MICROBLAZE_PROM_H
>>>>  #ifdef __KERNEL__
>>>> -
>>>> -/* Definitions used by the flattened device tree */
>>>> -#define OF_DT_HEADER                0xd00dfeed /* marker */
>>> This is used in arch/microblaze/kernel/head.S, but you move its
>>> definition inside "#ifndef __ASSEMBLY__" below.  You should probably
>>> replace the include of asm/prom.h in arch/microblaze/kernel/head.S with
>>> linux/of_fdt.h (assuming that the comment in there is correct).
>> yes, Stephen is right here. I created one patch (in attachment) which fixed it. I tested your
>> patches on Microblaze (noMMU and MMU) and I have no problem with compilation and simple boot-up
>> works for both versions too.
>>
>> With that my patch: Acked-by: Michal Simek <monstr@monstr.eu>
> 
> Thanks.  I'll merge your change with my patch so that bisect isn't broken.

if is possible to do it, please do it.

Thanks,
Michal

> 
> g.
> 

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
