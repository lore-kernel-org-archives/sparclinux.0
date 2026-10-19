Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8C3328FD
	for <sparclinux@vger.kernel.org>; Mon, 19 Oct 2026 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377781; cv=none; b=n16+C69JcgDRLRAI8ZjEJCXP9sBJIM+mmBIae6rFDIcH/epbAWtoHB+LUzCtWIquV3hIIjbxKa8jWNzg8zFdbHeBFEhizHQIw5q0qquidvnGYfdZwRbzuCRYhcbmmbH6hXC7tO5FGL72r9r1wpOKSxy+oYPYPMxpp8Jx/GnMmKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377781; c=relaxed/simple;
	bh=odw4BQdOuCm+tCSRiqJDUIi1fwZ9LR+CAM5fTsxkt5A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hfxzgpIo3wRXDuMEFG8S6XdPMdH65U6Wvsp8KRWfQ+FYOn/eC+29A5vvmoeqNKjTQESl9uQC0dIJpN/baUwxxs9M7TLL1vQih4k8Z06S1y6rvzBiGvj3J7XX2W136zqQfrTrgAtAFT8xTf4Fwop8aGnvF3OZDER6ibpa5v/KCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+TwDqta; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+TwDqta"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-868b3248b2cso1008373b3a.1
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 19:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792377778; x=1792982578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iom84IfjPNhYdhvDKyAl2Pn6OICqSUUt1eSaXWwgyJM=;
        b=G+TwDqtaVOwZkbW0yiTM+q3YMVpyh80cYzt8E2z0UNNerArEbLRRDlR3St4kVyo/9b
         R24MfdRmR9RYHLcu/qhLCTXDV0tOpcLD1+NjZs6rU6fcSCd8hZHlk8vFPUW8+m5clHN3
         3yw3xdYvqWQVoOiRdmdMXYdiWMgvxzMl99UyBpFrxvAv0WPUdvOIClq8TeuGCEdC3P1n
         HpOmdoTtFX0SGh8zoMZr3KZSqPFKxzLTwRgKe7+NGzJpfkNZgyIQ5isQMQDQw8SgItar
         ZYBdLVWhT9jp0+wRCNOsy18oxrhaENeJsLZ9AAuJ1oL90M6VK5IwAeXXwTctRWcNprPD
         fXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792377778; x=1792982578;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iom84IfjPNhYdhvDKyAl2Pn6OICqSUUt1eSaXWwgyJM=;
        b=g4/OBukCw//uxcpaeyyQKZREiX63vHCGp1K8HOgjAeRdBrfdG6ZZcXy6ygDdKJZ4nA
         VfTNvrCgC9gMzHh4wmIwulujrjz4cwovnM16WIxqDDvZXx8/jxFIc2uRLUw3eFHKLpP5
         lj8Tgfw95E/CRc/q/MV8zE1fo151jISJ+djc80VwFL09KIRuXvA8F4boa7hu3GveEFSm
         geyQuQ+CEBN98MRbofCnK157mzvWqDlxhKpEUNCqWrbPAHhPqzlDTkfQPuVrwaWzKg07
         FJS20hMjEqz3x9cLBoeNuqVgBzuQU+cGEt0JXiV7CvOndqEoXnCOf+QYRb9FCstL5NbJ
         6fDg==
X-Gm-Message-State: AFq9FYJNAD6mYmwWQJCXIK5miKvaRkpi9lJFtbIzJ+ypjIUWpNAcrRXG
	AZaDip3SKBZ5tzOX3XQqv6l997q0vMmccQKsxlVmE6XnHG63jN6GMzZ7
X-Gm-Gg: AYBFou0jEJohhcxKCf5C357c0oSoPRG0Pc3McZKgQyqkp64KVV8ogHLX6cmnsZt3KLI
	FDzfpWC+sQFxhZTJZDleQ2831oheSdZqEBCUmoncVU9ZTH5KlKTGdZBv8rNmLLw6A3qZzGkP8Ah
	cNSUdhZvxSKHkqbUl6p3IGMUHXe7ZC5wL4yc7ktSTDYHdJRxbqk4j7qnHZ4REzNkJ78uYqIFkMp
	v+okCXaJXeEpu5kiHsvmW9LmOhWzY+Ficn8wRt1ACMnWohwAhMlTDe4j07Y6ybzzM+d6qlmOfvn
	FgdozuobLOSpZdP+MA+GmsXm5/2OXB+OHwtiOcnSYPocs/u/iwaOPi1P4hyeYIx3FxwyWVFt6wO
	4yFbINCnFJCs0XIh9zoPYpWAZbRdLC6GEUYeWlry3xGbUBpvBAZPmeepHpBHDR5QbGLaV/9PjO+
	oLuMpswwc0xexV5n/8hBUAQhlXLja0lAxxKXr2E6REnZ+kIuVbANo6euGsYQ5LU7TrKtzX1VSku
	z1FErtEj7u1Z3V24xA4qGgOopJK3LsP02A=
X-Received: by 2002:a05:6a20:438f:b0:3e2:59b5:a697 with SMTP id adf61e73a8af0-3e259b5c202mr341756637.20.1792377778041;
        Sun, 18 Oct 2026 19:42:58 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65497f8dfsm3264334a12.11.2026.10.18.19.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 19:42:57 -0700 (PDT)
Message-ID: <54413888-3f62-40c9-92fa-beda41de0ff4@gmail.com>
Date: Sun, 18 Oct 2026 19:42:56 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on sun4v
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Stian Halseth <stian@itx.no>
References: <20261018222723.43442-1-jengelh@inai.de>
 <b69a7cd6-7f9d-4c8e-80b9-701a77a6805a@gmail.com>
 <0593b88f-6151-4975-a840-ef21f3df06e8@gmail.com>
 <c7d7a96c-feb9-4676-8cc2-73529e8324ef@gmail.com>
In-Reply-To: <c7d7a96c-feb9-4676-8cc2-73529e8324ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jan,

On 10/18/26 7:29 PM, Tony Rodriguez wrote:
>
> Hi Jan,
>
>>>
>>> On 10/18/26 3:27 PM, Jan Engelhardt wrote:
>>>> The SPARC port does not publish any cache topology information. The
>>>> lscpu utility therefore falls back to assuming the published cache
>>>> sizes are for unshared caches, and as a result, reports way more
>>>> cache than there really is present in the system. On a T5240 machine:
>>>>
>>>> ```
>>>> $ lscpu
>>>> Architecture:          sparc64
>>>>    CPU op-mode(s):      32-bit, 64-bit
>>>>    Byte Order:          Big Endian
>>>> CPU(s):                128
>>>>    On-line CPU(s) list: 0-127
>>>> Model name:            UltraSparc T2 (Niagara2)
>>>>    Thread(s) per core:  4
>>>>    Core(s) per socket:  16
>>>>    Socket(s):           2
>>>>    Flags:               sun4v
>>>> Caches (sum of all):
>>>>    L1d:                 1 MiB (128 instances)
>>>>    L1i:                 2 MiB (128 instances)
>>>>    L2:                  512 MiB (128 instances)
>>>> ```
>>>>
>>>> This patch implements population of the sysfs cacheinfo structures
>>>> for sun4v (systems with mdesc). The proper amount is now reflected in
>>>> lscpu's output:
>>>>
>>>> ```
>>>> Caches (sum of all):
>>>>    L1d:                 128 KiB (16 instances)
>>>>    L1i:                 256 KiB (16 instances)
>>>>    L2:                  8 MiB (2 instances)
>>>> ```
>>>>
>>>> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
>>>> ---
>>>>   arch/sparc/include/asm/cpudata_64.h |  8 +++-
>>>>   arch/sparc/kernel/mdesc.c           | 61 
>>>> +++++++++++++++++++++++++++++
>>>>   2 files changed, 68 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/sparc/include/asm/cpudata_64.h 
>>>> b/arch/sparc/include/asm/cpudata_64.h
>>>> index 056b3c0e7ef9..e28b841ffe23 100644
>>>> --- a/arch/sparc/include/asm/cpudata_64.h
>>>> +++ b/arch/sparc/include/asm/cpudata_64.h
>>>> @@ -18,13 +18,19 @@ typedef struct {
>>>>       unsigned int    irq0_irqs;
>>>>       unsigned int    __pad2;
>>>>   -    /* Dcache line 2, rarely used */
>>>> +    /* Dcache line 2+3, rarely used */
>>>>       unsigned int    dcache_size;
>>>>       unsigned int    dcache_line_size;
>>>> +    unsigned int    dcache_assoc;
>>>> +    unsigned int    dcache_id;
>>>>       unsigned int    icache_size;
>>>>       unsigned int    icache_line_size;
>>>> +    unsigned int    icache_assoc;
>>>> +    unsigned int    icache_id;
>>>>       unsigned int    ecache_size;
>>>>       unsigned int    ecache_line_size;
>>>> +    unsigned int    ecache_assoc;
>>>> +    unsigned int    ecache_id;
>>>>       unsigned short    sock_id;    /* physical package */
>>>>       unsigned short    core_id;
>>>>       unsigned short  max_cache_id;    /* groupings of highest 
>>>> shared cache */
>>>> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
>>>> index 23b51a32e96e..029d9d812074 100644
>>>> --- a/arch/sparc/kernel/mdesc.c
>>>> +++ b/arch/sparc/kernel/mdesc.c
>>>> @@ -818,6 +818,7 @@ static void fill_in_one_cache(cpuinfo_sparc *c, 
>>>> struct mdesc_handle *hp, u64 mp)
>>>>       const u64 *level = mdesc_get_property(hp, mp, "level", NULL);
>>>>       const u64 *size = mdesc_get_property(hp, mp, "size", NULL);
>>>>       const u64 *line_size = mdesc_get_property(hp, mp, 
>>>> "line-size", NULL);
>>>> +    const u64 *assoc = mdesc_get_property(hp, mp, "associativity", 
>>>> NULL);
>>>>       const char *type;
>>>>       int type_len;
>>>>   @@ -828,15 +829,21 @@ static void fill_in_one_cache(cpuinfo_sparc 
>>>> *c, struct mdesc_handle *hp, u64 mp)
>>>>           if (of_find_in_proplist(type, "instn", type_len)) {
>>>>               c->icache_size = *size;
>>>>               c->icache_line_size = *line_size;
>>>> +            c->icache_assoc = assoc ? *assoc : 0;
>>>> +            c->icache_id = mp;
>>>>           } else if (of_find_in_proplist(type, "data", type_len)) {
>>>>               c->dcache_size = *size;
>>>>               c->dcache_line_size = *line_size;
>>>> +            c->dcache_assoc = assoc ? *assoc : 0;
>>>> +            c->dcache_id = mp;
>>>>           }
>>>>           break;
>>>>         case 2:
>>>>           c->ecache_size = *size;
>>>>           c->ecache_line_size = *line_size;
>>>> +        c->ecache_assoc = assoc ? *assoc : 0;
>>>> +        c->ecache_id = mp;
>>>>           break;
>>>>         default:
>>>> @@ -1251,6 +1258,60 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
>>>>       smp_fill_in_sib_core_maps();
>>>>   }
>>>>   +int init_cache_level(unsigned int cpu)
>>>> +{
>>>> +    struct cpu_cacheinfo *i = get_cpu_cacheinfo(cpu);
>>>> +    i->num_levels = 2;
>>>> +    i->num_leaves = 3;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int populate_cache_leaves(unsigned int cpu)
>>>> +{
>>>> +    struct cacheinfo *leaf = get_cpu_cacheinfo(cpu)->info_list;
>>>> +    cpuinfo_sparc *cs = &cpu_data(cpu);
>>>> +
>>>> +    leaf->id                    = cs->icache_id;
>>>> +    leaf->attributes            = CACHE_ID;
>>>> +    leaf->level                 = 1;
>>>> +    leaf->type                  = CACHE_TYPE_INST;
>>>> +    leaf->coherency_line_size   = cs->icache_line_size;
>>>> +    leaf->ways_of_associativity = cs->icache_assoc;
>>>> +    leaf->size                  = cs->icache_size;
>>>> +    leaf->priv                  = cs;
>>>> +    if (cs->icache_line_size > 0 && cs->icache_assoc > 0)
>>>> +        leaf->number_of_sets = cs->icache_size / 
>>>> cs->icache_line_size /
>>>> +                               cs->icache_assoc;
>>>> +    ++leaf;
>>>> +
>>>> +    leaf->id                    = cs->dcache_id;
>>>> +    leaf->attributes            = CACHE_ID;
>>>> +    leaf->level                 = 1;
>>>> +    leaf->type                  = CACHE_TYPE_DATA;
>>>> +    leaf->coherency_line_size   = cs->dcache_line_size;
>>>> +    leaf->ways_of_associativity = cs->dcache_assoc;
>>>> +    leaf->size                  = cs->dcache_size;
>>>> +    leaf->priv                  = cs;
>>>> +    if (cs->dcache_line_size > 0 && cs->dcache_assoc > 0)
>>>> +        leaf->number_of_sets = cs->dcache_size / 
>>>> cs->dcache_line_size /
>>>> +                               cs->dcache_assoc;
>>>> +    ++leaf;
>>>> +
>>>> +    leaf->id                    = cs->ecache_id;
>>>> +    leaf->attributes            = CACHE_ID;
>>>> +    leaf->level                 = 2;
>>>> +    leaf->type                  = CACHE_TYPE_UNIFIED;
>>>> +    leaf->coherency_line_size   = cs->ecache_line_size;
>>>> +    leaf->ways_of_associativity = cs->ecache_assoc;
>>>> +    leaf->size                  = cs->ecache_size;
>>>> +    leaf->priv                  = cs;
>>>> +    if (cs->ecache_line_size > 0 && cs->ecache_assoc > 0)
>>>> +        leaf->number_of_sets = cs->ecache_size / 
>>>> cs->ecache_line_size /
>>>> +                               cs->ecache_assoc;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /* mdesc_open() - Grab a reference to mdesc_handle when 
>>>> /dev/mdesc is
>>>>    * opened. Hold this reference until /dev/mdesc is closed to ensure
>>>>    * mdesc data structure is not released underneath us. Store the
>>
> I’ve applied the patch to a dual‑socket SPARC S7‑2 (16 cores total, 
> 128 threads) and wanted to share the resulting lscpu output, since it 
> clarifies what the patch fixes and what still needs work for 3‑level 
> parts.
>
> Before the patch:
>
> L1d: 2 MiB (128 instances)
> L1i: 2 MiB (128 instances)
> L2:  32 MiB (128 instances)
>
> After the patch:
>
> L1d: 256 KiB (16 instances)
> L1i: 256 KiB (16 instances)
> L2:  2 MiB (8 instances)
>
> A) The L1 reporting is now correct. Each of the 16 cores has a private 
> 16 KB L1I and 16 KB L1D, so 256 KiB in 16 instances is exactly right. 
> The per‑thread inflation is gone for L1, and the sharing/instance 
> counts are sensible. The generic leaf->id grouping is clearly doing 
> its job.
>
> * B)  L2 is only half‑reported on S7:  This may be true for S7, T7, 
> and T8 CPUs.
>
> For the L2 split (On S7):
>
>     L2D: 256 KB shared by every 2 cores -> 8 instances × 256 KB = 2 
> MiB  (matches the output)
>
>     L2I: 256 KB shared by every 4 cores ->4 instances × 256 KB = 1 
> MiB  (missing)
>
> So the total L2 on this box should  be 3 MiB across 12 instances , or 
> shown as separate L2D/L2I lines. It looks like MDESC reports the L2I 
> and L2D nodes separately, and the current case 2: overwrites one with 
> the other in ecache_*. Supporting S7 properly would need either 
> separate storage for L2I/L2D or a way to handle multiple level‑2 nodes.
>
> * C) Need "level 3" cache details for (useful for T4, T5, S7, T7, 
> T8).  Perhaps in revised patch?
>
> As expected, the S7’s 16 MB per‑socket L3 (32 MiB total, 2 instances 
> on this box) does not appear at all. init_cache_level() hardcodes 
> num_levels = 2 / num_leaves = 3, and fill_in_one_cache() has no case 
> 3:, so the MDESC level‑3 node is dropped in default.
>
> Adding an L3 leaf may need?
>
>     l3_* fields in cpuinfo_sparc,
>
>     a case 3: in fill_in_one_cache(),
>
>     num_levels = 3 / num_leaves = 4 in init_cache_level(),
>
>     a 4th leaf in populate_cache_leaves().
>
> For T7‑1/T8‑1 this would surface  their 64 MiB per‑socket L3; for S7‑2 
> it would show 32 MiB in 2 instances (16 MiB per cpu). The T5240 result 
> looks correct because that machine is 2‑level only, so the missing 
> case 3: doesn’t show up there.
>
> Summary:
>
> The patch is an improvement but needs more work. It fixes the L1 (and 
> L2D) inflation on S7‑2. To make it complete for the 3‑level SPARC 
> parts, it needs L2I handling and an L3 leaf.  It would be great to 
> have L3 cache details shown via lscpu as well.
>
>
> Tested-By: Tony Rodriguez <unixpro1970@gmail.com>
>
>
> Regards,
>
> Tony
>

Corrected typos in my summary and changed point C to be "Perhaps in a 
revised patch?"

Tony

