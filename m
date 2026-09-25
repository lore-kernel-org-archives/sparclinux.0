Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9048D872;
	Fri, 25 Sep 2026 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331526; cv=none; b=NvALpFefPZBnVLDhBNBtHefcDY5FkY5/kIDiQBtIxfKoeek6SoaDEAFJjoa/jFk6W03WVoKQoR0jxtlZK0sZS/616fRGqoyvg1+6X2GsxDJo8dJGucu3AAzDiVKbKsHxcQmZLXCIW2eCGOMNVFVTfXCF+tct9eEiDcHpdPaWVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331526; c=relaxed/simple;
	bh=CpmxRU9+iKFpg5bvhhGZQGyt3vfrqBdpwbEgHOrLymI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEwfZ2tiMjnJ4db5kkuzbhx5n3jm1vtzn8SXAJoTZ1P3itXSMh3w/TYrzqc7VXISJOfqfmSXpb1ddWUU7AKgptady+Ac8BbWTHYAmeeQrlTGI93bu9htsKrSknXBFHFjdb6eeqE0V/IKOv/zsixdn1hfU0VwPNUAzO/NiNdFXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LgQww5oP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LgQww5oP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7A316F8;
	Fri, 25 Sep 2026 03:18:39 -0700 (PDT)
Received: from [10.164.19.30] (unknown [10.164.19.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9179B3F86F;
	Fri, 25 Sep 2026 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790331523; bh=CpmxRU9+iKFpg5bvhhGZQGyt3vfrqBdpwbEgHOrLymI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LgQww5oPUbWf6eN1nsr5Vqe8WzyaweKdK4VVcKTQhvjT69wK5zHR+5KHcLt7XF12r
	 TsVecaMJUffvIsSdeTElshKH4e47IB00ch8tZtuwNdRiZcHmvoP+F7hw21x7TMJkp0
	 HtumcBkNgo5CX6e1gbxob2bHp/O9wGSpLN5CjmrQ=
Message-ID: <638cdbef-016a-41f1-986f-7ed6e65e80c4@arm.com>
Date: Fri, 25 Sep 2026 15:48:32 +0530
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] mm: move anon-exclusive batch helper to rmap.h
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 hughd@google.com, chrisl@kernel.org, kasong@tencent.com,
 davem@davemloft.net, andreas@gaisler.com, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, baolin.wang@linux.alibaba.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev,
 youngjun.park@lge.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, pfalcato@suse.de,
 jgg@ziepe.ca, thuth@redhat.com, sparclinux@vger.kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com
References: <20260924131106.1730494-1-dev.jain@arm.com>
 <20260924131106.1730494-4-dev.jain@arm.com>
 <CAGsJ_4yVhXF+-gOrOB+JOK6nZt19SA=LT+gXpmaMpErg6Ra5NQ@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAGsJ_4yVhXF+-gOrOB+JOK6nZt19SA=LT+gXpmaMpErg6Ra5NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/09/26 2:32 am, Barry Song wrote:
> On Thu, Sep 24, 2026 at 9:11 PM Dev Jain <dev.jain@arm.com> wrote:
>>
>> In preparation for optimizing large folio unmapping, we need to reuse
>> the page_anon_exclusive_batch helper in rmap.c and rmap.h and obey the
>> existing use in mprotect.c .
>>
>> Therefore, move it from mprotect.c to rmap.h.
>>
>> While at it, change return type, start_idx and max_len to unsigned long
>> type for future proofing against THP support at >= PUD level. Also
>> shorten expected_anon_exclusive -> anon_exclusive.
> 
> I really think the `expected` prefix makes the semantics clearer, so I
> don't think it's necessary to remove it.
> 
> If you really find it too long, maybe just use
> `expected_exclusive`, since we're already in the anon context and
> know that it is definitely anon.
> 
> Another option might be to make `*exclusive` an output parameter.
> Then we wouldn't need to call
> `expected_anon_exclusive = PageAnonExclusive(first_page + batch_idx);`
> in the caller.

Ah nice! This looks much cleaner, thanks.


> 
>  static __always_inline unsigned long
> page_anon_exclusive_batch(unsigned long start_idx,
>                 unsigned long max_len, struct page *first_page, bool *exclusive)
> 
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> 
> Otherwise, the patch looks good to me.
> 
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks.

> 
>> ---
>>  include/linux/rmap.h | 17 +++++++++++++++++
>>  mm/mprotect.c        | 18 +-----------------
>>  2 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 74cca0e3c7264..62ef511a6175a 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -106,6 +106,23 @@ enum ttu_flags {
>>
>>  #ifdef CONFIG_MMU
>>
>> +/*
>> + * Get max length of consecutive PTEs pointing to PageAnonExclusive() pages or
>> + * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
>> + * that the PTEs point to consecutive pages of the same anon large folio.
>> + */
>> +static __always_inline unsigned long page_anon_exclusive_batch(unsigned long start_idx,
>> +               unsigned long max_len, struct page *first_page, bool anon_exclusive)
>> +{
>> +       unsigned long idx;
>> +
>> +       for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
>> +               if (anon_exclusive != PageAnonExclusive(first_page + idx))
>> +                       break;
>> +       }
>> +       return idx - start_idx;
>> +}
>> +
> 
> Thanks
> Barry

