Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05827EC7C
	for <sparclinux@vger.kernel.org>; Thu,  8 Jan 2026 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842297; cv=none; b=heWl0ypXqH35YyhvtaevLexArt8tQrVDxbmlRdBnZzelPJafJgkv4N3jFi6NSDjlkVI0AWv39tZeFo9LT12tFY58ZuP0IVkVugfk5yFJgOflL5Gr6O2vVpewm5t5R/Wz0MdaiHFWqb5zhICBPV8+7uWe20Ekqi37EFlOKQy+q3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842297; c=relaxed/simple;
	bh=SGsW3RrCaecKqg2d4HlFgNCObq+wXvt+qhfrwhJ4ZxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUkrA4rSe1AEMIAsXxMli4cFUXp1/W5BmvuOIQSzbc93YaPRg99mEneZXwByUjkdTpfdVkp1JOdVYVzmLtwYM+OoF8XzoOfEPViuBnNSHlSsB2HmWYkj76OtMUcQ73ecYg7Ip7xX04HZwCfQu3oc6AcAGnJjCPkOqlQ++Us7y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1FJ7rKr; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1FJ7rKr"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2abe15d8a4bso7787eec.0
        for <sparclinux@vger.kernel.org>; Wed, 07 Jan 2026 19:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842295; x=1768447095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaSaOdpXMbWrSlJwcrlyjrxLNGS6q5kwuPmkpwrLbXc=;
        b=j1FJ7rKrodFYGYOaliGjlEblnBDB8+lFBFwJaYaDcLaWZ1gKHh5AMI+fYQjCRUVhjz
         HpFV8olwymSwMyWPnY+qUIwTQvEKtz0oMWwjglOcOEuYB14NYEk54NhFdzimFIE8Ncps
         v8EE9wxf3496WJSee9iF7IS5iQw/2ESIcRXHEc0JGnFOZ4Lk4R0+MO7cUXXDEzoFMRax
         smucfgxklVmjXAnv67YEHZhxItcB1ugOWQIdJvMC54Tz2sqSECb9/kwBbiQaZmQU2Ixm
         7Rk5qNg8xj3xiSO1lq5B7BX9/oqImRR+IeNtEly//wBlpsbcT8ZvmSVtU7zHGWFQkpLG
         D5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842295; x=1768447095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaSaOdpXMbWrSlJwcrlyjrxLNGS6q5kwuPmkpwrLbXc=;
        b=AJ2QCluDLRAmWiTyFU15ovqtPNo8ikQkiXlL7BYxFdAr32NGIF6zzLbnOLWB0OfSqq
         war1ZmcTJ200GGeKFcAAgvpduLFMWObTBGK2MjwcWJe7saTdwuR3Tyhsb1GzPKko9/Vs
         fPT3s2Kq1FIGJxgWsPfcYb0vkUV2itm+/ITPZ9lrUEwGOTMHt4OZDa3l0XiH4QssOxS7
         M4wjIRtk+u7C+T+UYKcfHgjgE2DEBnmcnDEOgDhLKut1DJ2vvM+5TPC+PIzrWaAiXVYk
         j7W0p451cvVAxBe1rRbjUHyNtilGUJmjc4lfT3FQP8XKfcJMZ9KYRQwaGUH5Ley63mjJ
         gDkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgR5lwQFYph32pGDkyT3oOSc9WMwV1iFuEshOFN19mBYe+nXKIY/gxgUrDvbkducat+xjUAwxjZxS1@vger.kernel.org
X-Gm-Message-State: AOJu0YyRL+tOdNKciZ8cljfFncg2ojmuCkfZ4BRJtvkbMBr4szokZdRN
	UmFOBlvZGJcUO48OTaBAQOafkeVZxQbbjwVsLtPPm6f8EI6/ZzMnaOT8
X-Gm-Gg: AY/fxX741/J0L+PdvolCh9Fw2swZT7rAYEzo69EpeG4dKaPGGX/AsgzepmCqYt9Isd4
	bOEbMFhJ5f7aP2wwZ1mN33kw1VnIQTWhfKu+kHLA60L8JeRZBx4zx8hz/O001dssotor+O1GLg4
	xuXpgns3JBjFyniNKxVr3Ytc1U6dpybEgnkIgVIdJDN771OwFG9iWCWKhAWDnFVF1s41pREM20p
	cPopECvuEWl12uiFF9S6DPE7/pKyKm8uZHyHavs3bpo19N8CnTXxXkox4IJjWsbwqETceqdE+M2
	BM+B3AZkgJ/0Uvg+FRY51rE43s3UrTOH1/cXiUqDQZfhi0/XiSz7wPN3lQYeyxobfoRjRnG3gz0
	r3jt4FTbOwInmOkcvntCX66IDFelyBaacN65AxZeM8B/WB/aQQnQWQL+IBtZooT2J7xLgaWx343
	FKs2GiHWOeOhtWY4rAjw6bzKydhJBnPe4yEketWQ==
X-Google-Smtp-Source: AGHT+IG6vHjZJF3iuCC3/lZlP5mplVCNe/UUIZCU6laystWobF3zaNSE5S04nOJRMMq5iPd0ITbh5g==
X-Received: by 2002:a05:690c:4044:b0:78d:6a71:76c5 with SMTP id 00721157ae682-790b55c0b56mr30974207b3.10.1767835599219;
        Wed, 07 Jan 2026 17:26:39 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa592cdcsm24600547b3.25.2026.01.07.17.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 17:26:38 -0800 (PST)
Message-ID: <da4e67bf-e671-46a6-8b09-19193c747c37@gmail.com>
Date: Thu, 8 Jan 2026 09:26:28 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/sparc: fix unused variable warning
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Zi Yan <ziy@nvidia.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260107104145.51416-1-alexs@kernel.org>
 <aV5xv0PfUvdc5QFE@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <aV5xv0PfUvdc5QFE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/7 22:46, Matthew Wilcox wrote:
> On Wed, Jan 07, 2026 at 06:41:44PM +0800,alexs@kernel.org wrote:
>> From: Alex Shi<alexs@kernel.org>
>>
>>     arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
>>     arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set but not used [-Wunused-but-set-variable]
>>       361 |         unsigned short hv_pgsz_idx;
>>           |                        ^~~~~~~~~~~
> Looks like it's been unused since introduction in c7d9f77d33a7 ?
> 
> As such, why cc all these people who have absolutely nothing to do with
> it?  Use your brain, not a stupid script.

Thanks for the feedback, Matthew. You're right—the script was too 
aggressive for such a localized fix.

I used 'scripts/get_maintainer.pl' without enough manual filtering. 
Besides '--nogit-fallback', are there specific parameters or workflows 
you recommend to keep the CC list lean for trivial cleanups like this?

I'll be more surgical with the CC list on the next version.

Thanks!
