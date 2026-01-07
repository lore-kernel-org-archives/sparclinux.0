Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8ED2FE567
	for <sparclinux@vger.kernel.org>; Wed,  7 Jan 2026 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778606; cv=none; b=l/BYpDjMyGp2uVgBLqFxbKZX1HYE6f9tZXbWiErkk/zS7kd4EblhBP2jyunvdePVAD7/ruAd90ICmr91NsP7/DbUg5UfCorQZUyv4qieGz7XtK9cY5lIxIc8EiHLdDHNo7rsgqqbc5p2I4BhKlQII6uyvW8ud/HMi6E/LXphl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778606; c=relaxed/simple;
	bh=R6/xhrgJJ3oX+5iARNEnDZiG+Wov1lIuHZPFQPBEmQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSGa3voFV+nykE9FT4Hioh+Ou7nlUOflrqa5onx42gP9+XO6PKVHW1h2V73hYBHzhQUwSXAaG1rViGrkP7EQTYo2R51PTMcI36y6NaQkpxiI9VsYsaIaao+A9ZyGNxfs1qNX1+ioxeT3P5U2niTnZ38WjwRi1qc/BinCdQsxOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUdkVevH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUdkVevH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f335681so1277770a91.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jan 2026 01:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767778604; x=1768383404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saF+Xq+vAMpqfDLHpz1T4Supgb9jI0Y3Hn9GOIowRKE=;
        b=FUdkVevH+6gU8vtMXT5PgKoeCLziw/2uVJ0NpWC5B5YboTbJA7kUYwTdB9B9Qaauq/
         3DEY6DiO5EVn7+N83sTMmKuBLsOz0r2mfXB3UyaLOO1oP8J1jcXGGVEk/Xwu2tLcRyjn
         fzGX5J54pexsYTd7DGH01K6KOO/J+X7KgHLX9aNsHc7yxvdtZZlaw4toFQcXXb5E5IMh
         AVgIHv3Qs1GrAbhvsEo1wd5wiv44Zw5z3pgZUW//KD4ctqdVLLuet0jzIb1WqOo2WBb1
         IPKX4+iiKN7zs6ae5w8mON+3/0A7Tei6PMNhPR7Czdr2wyKqfnTLyHv/LdTUC7YzSx1u
         Gm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778604; x=1768383404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saF+Xq+vAMpqfDLHpz1T4Supgb9jI0Y3Hn9GOIowRKE=;
        b=qj19SIFNr0dTv8zOr2xTJUUt8tvtr6aN0PAVqV49oTWDgmZYgbtHaKb6WrsMSQLSYI
         CYfzc20TchGHVvfZ79gav0HkDyL5h0q7z/1dYmCeqSS1sAJv3gJpbB0Pws2qZ/0RrmN4
         Jg1vMMpX+K6DGCmRNbXSxwpGoHTp6ltl6vOa3nTps+3uwRrXB74VUwFSl2i7f7WT3JPy
         5nXK1YLU4xyVCFGkj+mT3LAeHJEWKzJBFO/rUgJhUibTDkHox6NikjKqO36jqfMyEvx6
         FW6hx90ZmqdEMAKmQRRt9mlDqD+4HIqjmi2agKq3Bk+Yi7spJv+mK10hNdqZbKyAsF9K
         ulvg==
X-Forwarded-Encrypted: i=1; AJvYcCXgBTXChksvpC5C1YU8GR9qqjBrdkL1OCY76tjo0jpKMQmb+OVPFVA/EhofrDCrDqtbQi0oUUzDtDjt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyj7kjESYXLPmOE/SxU01a0olEYIECj1TtFWY8IAIonFWkUAAE
	erFUNyOjiXr2CET/rNuTk6paLCUYfL6ZZ4riuK+hgq09P+5SGe267obi
X-Gm-Gg: AY/fxX5qLD8ywPD62qLDLW9x9hlavFNIKSMKUyXtthsmQhHI5fR+tzbaj6DgJXOKjXH
	I1w4sBM5lu8r5KcO4JO9MI9zHSAAADHEF1VqqOENoKTset3aX6g0cA8W0IdygvGedazaRQFL9YZ
	6NDkjKp0s/aJHigDAql6HvMRCYt04yr7TCuVNJXwnuqmjc2d+gwZEnI6pkblc8kNi2p/w9E0FOU
	T9lVjUzFA3XdvuWuKFtyjUvAK3J2PiCkuZ/LWq2qxQLg0/Q2Ju66Cy12X+FQjGUgbidGdMXHrhv
	H3JYTmjBqiyfqZu4IXlTbYrSNYacRmpDUjs4aGBT15NFuf6nTa74NTEhuV4HY0T72JEWot3ZpfE
	CFpxPkN0DE+lbfAtrXiSV/K2S+to4EyvMts46rpGoRQoGxDg7dfmrsBXGsEW62Iy+7rnqug54pO
	OPEOxqXaXC
X-Google-Smtp-Source: AGHT+IE6+mGUJLskbJB93jcnqfvEZxbDGnpoRrvZg0WRBMLoJk0jMmN0Khvz7StflELVz/vjodpc2g==
X-Received: by 2002:a17:90b:1c87:b0:34c:635f:f855 with SMTP id 98e67ed59e1d1-34f68c33ab8mr1891629a91.7.1767778603927;
        Wed, 07 Jan 2026 01:36:43 -0800 (PST)
Received: from [192.168.2.226] ([114.92.45.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb9a45dsm4610004a91.17.2026.01.07.01.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:36:43 -0800 (PST)
Message-ID: <753883ca-5c30-4169-9548-cac76a2de00a@gmail.com>
Date: Wed, 7 Jan 2026 17:36:34 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/sparc: fix unused vaiable warning error
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 alexs@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Zi Yan <ziy@nvidia.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260107064209.15461-1-alexs@kernel.org>
 <072b8188e07208b995eaf5d499c51cd12a25954d.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <072b8188e07208b995eaf5d499c51cd12a25954d.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/7 16:42, John Paul Adrian Glaubitz wrote:
> Hi Alex,
> 
> On Wed, 2026-01-07 at 14:42 +0800,alexs@kernel.org wrote:
>> From: Alex Shi<alexs@kernel.org>
>>
>>     arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
>>     arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set but not used [-Wunused-but-set-variable]
>>       361 |         unsigned short hv_pgsz_idx;
>>           |                        ^~~~~~~~~~~
>>
>> Reported-by: kernel test robot<lkp@intel.com>
>> Signed-off-by: Alex Shi<alexs@kernel.org>
>> Cc:sparclinux@vger.kernel.org
>> Cc: Matthew Wilcox<willy@infradead.org>
>> Cc: Lorenzo Stoakes<lorenzo.stoakes@oracle.com>
>> Cc: Qi Zheng<zhengqi.arch@bytedance.com>
>> Cc: Dave Hansen<dave.hansen@linux.intel.com>
>> Cc: Zi Yan<ziy@nvidia.com>
>> Cc: Kevin Brodsky<kevin.brodsky@arm.com>
>> Cc: Mike Rapoport<rppt@kernel.org>
>> Cc: Andrew Morton<akpm@linux-foundation.org>
>> Cc: Andreas Larsson<andreas@gaisler.com>
>> Cc: David S. Miller<davem@davemloft.net>
>> ---
>>   arch/sparc/mm/init_64.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
>> index df9f7c444c39..ba19d23d4040 100644
>> --- a/arch/sparc/mm/init_64.c
>> +++ b/arch/sparc/mm/init_64.c
>> @@ -358,30 +358,24 @@ static void __init pud_huge_patch(void)
>>   bool __init arch_hugetlb_valid_size(unsigned long size)
>>   {
>>   	unsigned int hugepage_shift = ilog2(size);
>> -	unsigned short hv_pgsz_idx;
>>   	unsigned int hv_pgsz_mask;
>>   
>>   	switch (hugepage_shift) {
>>   	case HPAGE_16GB_SHIFT:
>>   		hv_pgsz_mask = HV_PGSZ_MASK_16GB;
>> -		hv_pgsz_idx = HV_PGSZ_IDX_16GB;
>>   		pud_huge_patch();
>>   		break;
>>   	case HPAGE_2GB_SHIFT:
>>   		hv_pgsz_mask = HV_PGSZ_MASK_2GB;
>> -		hv_pgsz_idx = HV_PGSZ_IDX_2GB;
>>   		break;
>>   	case HPAGE_256MB_SHIFT:
>>   		hv_pgsz_mask = HV_PGSZ_MASK_256MB;
>> -		hv_pgsz_idx = HV_PGSZ_IDX_256MB;
>>   		break;
>>   	case HPAGE_SHIFT:
>>   		hv_pgsz_mask = HV_PGSZ_MASK_4MB;
>> -		hv_pgsz_idx = HV_PGSZ_IDX_4MB;
>>   		break;
>>   	case HPAGE_64K_SHIFT:
>>   		hv_pgsz_mask = HV_PGSZ_MASK_64K;
>> -		hv_pgsz_idx = HV_PGSZ_IDX_64K;
>>   		break;
>>   	default:
>>   		hv_pgsz_mask = 0;
> Thanks for the patch! Could you fix the typo in the subject?

Thanks  a lot. I will update the subject and resend for v2.

Thanks
Alex

> 
> Thanks,
> Adrian
> 
> -- .''`. John Paul Adrian Glaubitz : :' : Debian Developer `. `' 
> Physicist `- GPG: 62FF 8A75 84E0 2956 9546 0006 7426 3B37 F5B5 F913
> 
