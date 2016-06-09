From: joe moriarty <joe.moriarty@oracle.com>
Date: Thu, 09 Jun 2016 20:52:31 +0000
Subject: Re: [PATCH 2/2] arch/sparc: SPARC-S7 IB software support
Message-Id: <7944fe3d-b24a-b21f-291d-8b01853c9e99@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <be051dde-f2bc-39ea-9460-9ad36c666723@oracle.com>
In-Reply-To: <be051dde-f2bc-39ea-9460-9ad36c666723@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam,

I know you guys are very busy.  But, I wanted to know if there is an 
update on this patch set yet.

Joe


On 5/23/2016 5:25 PM, Sam Ravnborg wrote:
> Hi Joe.
>
> On Mon, May 23, 2016 at 03:40:44PM -0400, joe moriarty wrote:
>> Modified existing code to provide support for the IB software model on
>> SPARC-S7.
> Can you please do te following:
> 1) Split this up - so there is one patch per mail.
> 2) Especially on patch 1 - elaborate a bit more why this is needed,
>     and why it does not break existing setups
>
>
>> Patch 1/2
>>  From 1c021a3c7801a044886cc8efad15e4777fb68ad8 Mon Sep 17 00:00:00 2001
>> From: Joe Moriarty <joe.moriarty@oracle.com>
>> Date: Mon, 23 May 2016 13:40:24 -0400
>> Subject: [PATCH 4.7 1/2] arch/sparc:  SPARC-S7 piggyback support
>>
>> Needed for SPARC-S7 IB software support
>>
>> Orabug: 23055807
>> Signed-off-by: Joe Moriarty <joe.moriarty@oracle.com>
>> Acked-by: Karl Volz <karl.volz@oracle.com>
>> ---
>>   arch/sparc/boot/piggyback.c |   17 +++++++++--------
>>   1 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/sparc/boot/piggyback.c b/arch/sparc/boot/piggyback.c
>> index bb7c951..85e5816 100644
>> --- a/arch/sparc/boot/piggyback.c
>> +++ b/arch/sparc/boot/piggyback.c
>> @@ -103,7 +103,7 @@ static int end_line(const char *line)
>>    * f0004000 ... _start
>>    * f0379f79 ... _end
>>    * 1234567890123456
>> - * ^coloumn 1
>> + * ^column 1
>>    * There is support for 64 bit addresses too.
>>    *
>>    * Return 0 if either start or end is not found
>> @@ -216,13 +216,15 @@ int main(int argc,char **argv)
>>        * To locate these symbols search for the "HdrS" text which appear
>>        * in the image a little before the gokernel symbol.
>>        * See definition of these in init_32.S
>> +     * See definition of these in head_32.S (there is no gokernel symbol
>> +     * in head_64.S).
> The first "See definition" comments looks wrong - should it be deleted?
>
>> -    if (lseek(image, offset, 0) < 0)
>> +    if (lseek(image, offset, SEEK_SET) < 0)
> This does not look like a fix.
> If you have it in the same path - then document it in the changelog.
>
>
>>           die("lseek");
>>
>>       /*
>> @@ -234,7 +236,7 @@ int main(int argc,char **argv)
>>        */
>>       st4(buffer, 0);
>>       st4(buffer + 4, 0x01000000);
>> -    st4(buffer + 8, align(end + 32));
>> +    st4(buffer + 8, align(end));
> It is not obvious why this change is needed or is ok. Please comment somewhere.
>
>>       st4(buffer + 12, s.st_size);
>>
>>       if (write(image, buffer + 2, 14) != 14)
>> @@ -243,11 +245,10 @@ int main(int argc,char **argv)
>>       /* For sparc64 update a_text and clear a_data + a_bss */
>>       if (is64bit)
>>       {
>> -        if (lseek(image, 4, 0) < 0)
>> +        if (lseek(image, 4, SEEK_SET) < 0)
>>               die("lseek");
>>           /* a_text */
>> -        st4(buffer, align(end + 32 + 8191) - (start & ~0x3fffffUL) +
>> -                    s.st_size);
>> +        st4(buffer, align(end - start) + s.st_size);
> It is not obvious why this change is needed or is ok. Please comment somewhere.
>
>>           /* a_data */
>>           st4(buffer + 4, 0);
>>           /* a_bss */
>> @@ -256,8 +257,8 @@ int main(int argc,char **argv)
>>               die(argv[2]);
>>       }
>>
>> -    /* seek page aligned boundary in the image file and add boot image */
>> -    if (lseek(image, AOUT_TEXT_OFFSET - start + align(end + 32), 0) < 0)
>> +    /* seek page aligned boundary in the text and add boot image */
>> +    if (lseek(image, AOUT_TEXT_OFFSET + align(end - start), SEEK_SET) < 0)
>>           die("lseek");
>>       if ((tail = open(argv[4], O_RDONLY)) < 0)
>>           die(argv[4]);
>> -- 
>> 1.7.1
>>
>> Patch 2/2*
>> *From aef060fc56161ab8952f788a70db43fb3333aea7 Mon Sep 17 00:00:00 2001
>> From: Joe Moriarty <joe.moriarty@oracle.com>
>> Date: Mon, 23 May 2016 13:42:32 -0400
>> Subject: [PATCH 4.7 2/2] arch/sparc:  SPARC-S7 epsc group support
>>
>> Needed for SPARC-S7 IB software support
>>
>> Orabug: 23055865
>> Signed-off-by: Joe Moriarty <joe.moriarty@oracle.com>
>> Acked-by: Babu Moger <babu.moger@oracle.com>
>> ---
>>   arch/sparc/include/asm/hypervisor.h |    1 +
>>   arch/sparc/kernel/hvapi.c           |    1 +
>>   2 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/sparc/include/asm/hypervisor.h
>> b/arch/sparc/include/asm/hypervisor.h
>> index f5b6537..aa25da4 100644
>> --- a/arch/sparc/include/asm/hypervisor.h
>> +++ b/arch/sparc/include/asm/hypervisor.h
>> @@ -3001,6 +3001,7 @@ unsigned long sun4v_m7_set_perfreg(unsigned long
>> reg_num,
>>   #define HV_GRP_KT_CPU            0x0209
>>   #define HV_GRP_VT_CPU            0x020c
>>   #define HV_GRP_T5_CPU            0x0211
>> +#define HV_GRP_EPSC            0x0241
>>   #define HV_GRP_DIAG            0x0300
>>
>>   #ifndef __ASSEMBLY__
>> diff --git a/arch/sparc/kernel/hvapi.c b/arch/sparc/kernel/hvapi.c
>> index 662500f..9bc39a3 100644
>> --- a/arch/sparc/kernel/hvapi.c
>> +++ b/arch/sparc/kernel/hvapi.c
>> @@ -47,6 +47,7 @@ static struct api_info api_table[] = {
>>       { .group = HV_GRP_KT_CPU,                },
>>       { .group = HV_GRP_VT_CPU,                },
>>       { .group = HV_GRP_T5_CPU,                },
>> +    { .group = HV_GRP_EPSC,                    },
>>       { .group = HV_GRP_DIAG,        .flags = FLAG_PRE_API    },
>>       { .group = HV_GRP_M7_PERF,                },
> Ident looks wrong in the code snippet above.
>
> 	Sam

