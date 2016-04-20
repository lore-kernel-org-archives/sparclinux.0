From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 20 Apr 2016 16:02:04 +0000
Subject: Re: [PATCH] sparc64: recognize and support Sonoma CPU type
Message-Id: <5717A7FC.3000109@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1461085974-13534-1-git-send-email-khalid.aziz@oracle.com>
 <CACOOicafDVo6OYWYDCKTJBXGgR-HaAyv6DvrS-ZEG+2mKxTVKw@mail.gmail.com>
 <5717A63E.9000802@oracle.com>
In-Reply-To: <5717A63E.9000802@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Allen Pais <allen.pais@oracle.com>
Cc: Rob Gardner <rob.gardner@oracle.com>, David Miller <davem@davemloft.net>, David Aldridge <david.j.aldridge@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, khalid@gonehiking.org, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Nitin Gupta <nitin.m.gupta@oracle.com>

On 04/20/2016 09:54 AM, Allen Pais wrote:
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com <mailto:khalid.aziz@oracle.com>>
>> ---
>>   arch/sparc/include/asm/spitfire.h | 1 +
>>   arch/sparc/kernel/cpu.c           | 6 ++++++
>>   arch/sparc/kernel/cpumap.c        | 1 +
>>   arch/sparc/kernel/head_64.S       | 8 ++++++++
>>   arch/sparc/kernel/setup_64.c      | 7 ++++++-
>>   arch/sparc/mm/init_64.c           | 3 +++
>>   6 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
>> index 56f9338..1d8321c 100644
>> --- a/arch/sparc/include/asm/spitfire.h
>> +++ b/arch/sparc/include/asm/spitfire.h
>> @@ -48,6 +48,7 @@
>>   #define SUN4V_CHIP_SPARC_M6    0x06
>>   #define SUN4V_CHIP_SPARC_M7    0x07
>>   #define SUN4V_CHIP_SPARC64X    0x8a
>> +#define SUN4V_CHIP_SPARC_SN    0x8b
>>   #define SUN4V_CHIP_UNKNOWN     0xff
>
> Looks good to me. Do you think adding these also this patch makes sense or
> it could be a separate patch.
>
>          }
> -       if (!strcmp(sparc_pmu_type, "sparc-m7")) {
> +       if (!strcmp(sparc_pmu_type, "sparc-m7") ||
> +           !strcmp(sparc_pmu_type, "sparc-sn")) {
>                  sparc_pmu = &sparc_m7_pmu;
>                  return true;
>
> Acked-by: Allen Pais <allen.pais@oracle.com>
>
> - Allen
>

I would recommend that to be a separate patch. My goal with this patch 
is to address the core capabilities of sonoma and enable kernel to get 
optimized performance from the processor. Monitoring the performance can 
be a separate patch.

--
Khalid
