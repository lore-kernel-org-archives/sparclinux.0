Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7D3876DE;
	Fri, 25 Sep 2026 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334561; cv=none; b=o1l1SskHyAQy5yF1p46fcvZCXaw0dXQe4rSjNrVHNWN+LBMg2JjIh9IIERByrYnREvgaqAt+O37uyP11Nm4HinbYN0y6DgbKY1Xorf/4MoIDsxD+xfUxJ5wXut6Aat159UcS1yfapoT9NcgovkoPX/QW02VOrnJXBtKP6+G3oIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334561; c=relaxed/simple;
	bh=X+08JXGHDhZk6jkgj/t3kmX/ETkf/ZmKY7HfCywvC/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftPQZPZKffzHbA5pOCuUrFUgN4TTTLD+YngIL6U9E7kdafY8b0d+5H228kdu41MybE+D+n+YfZKraQz8QJF5X7D9KKBZCCPTYesa9EVaGFNt/xS3s2WkwRftBDLuv5tXz4K6qaUTQWnADfMqrByQ7pxdGkuoFwAXH6W+LlEHgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KWg+bRtM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KWg+bRtM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15A71169C;
	Fri, 25 Sep 2026 04:09:15 -0700 (PDT)
Received: from [10.164.19.30] (unknown [10.164.19.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE76F3F86F;
	Fri, 25 Sep 2026 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790334558; bh=X+08JXGHDhZk6jkgj/t3kmX/ETkf/ZmKY7HfCywvC/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KWg+bRtMjGqLoIq2HtiOXrjfQHC2zQacDtIxI3KeL3iVK4BJfstn2lrr+cgLf3Eag
	 QKYCwFFsClUn/oHUOipJJ62RqgGefgj89gJsmuewjX+MGFk89ybtuUOe2321sPOsnz
	 veaCdNDDEw0exuXjycAPli/iYr5NC3odwAerIO+E=
Message-ID: <9c00b28a-8b76-48c9-9318-cf1f4abaf944@arm.com>
Date: Fri, 25 Sep 2026 16:39:08 +0530
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm/rmap: Add batched version of
 folio_try_share_anon_rmap_pte
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
 <20260924131106.1730494-5-dev.jain@arm.com>
 <CAGsJ_4yDZypOxjwmAY_usM+v_OJahShz-_uRSAiUZUAzv14VRA@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAGsJ_4yDZypOxjwmAY_usM+v_OJahShz-_uRSAiUZUAzv14VRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/09/26 11:00 am, Barry Song wrote:
> On Thu, Sep 24, 2026 at 9:11 PM Dev Jain <dev.jain@arm.com> wrote:
>>
>> To enable batched unmapping of anonymous folios, we need to handle the
>> sharing of exclusive pages. Hence, a batched version of
>> folio_try_share_anon_rmap_pte is required.
>>
>> Currently, the sole purpose of nr_pages in __folio_try_share_anon_rmap is
>> to do some rmap sanity checks. Now, clear the PageAnonExclusive bit on a
>> batch of nr_pages. Refactor the function such that the clearing of the bit
>> can be done at one place without duplication.
>>
>> Note that __folio_try_share_anon_rmap can receive nr_pages == HPAGE_PMD_NR
>> from the PMD path, but currently we only clear the bit on the head page.
>> Retain this behaviour by setting nr_pages = 1 in case the caller is
>> folio_try_share_anon_rmap_pmd.
>>
>> While at it, convert nr_pages to unsigned long to future-proof from
>> overflow in case P4D-huge mappings etc get supported down the road.
>> I haven't made such a change in each function receiving nr_pages in
>> try_to_unmap_one - perhaps this can be done incrementally.
>>
>> Add two WARN's: check that the batch is entirely exclusive (for PMD
>> callers, need to check only head page), and that there are only
>> PTE/PMD paths converging into __folio_try_share_anon_rmap.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> 
> The patch looks correct to me, but it seems a bit hard to follow
> because of the `pinnable` handling.
> 
>> ---
>>  include/linux/rmap.h | 56 ++++++++++++++++++++++++++++++--------------
>>  1 file changed, 39 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 62ef511a6175a..91b5763ef466f 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -723,17 +723,23 @@ static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
>>  }
>>
>>  static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
>> -               struct page *page, int nr_pages, enum pgtable_level level)
>> +               struct page *page, unsigned long nr_pages, enum pgtable_level level)
>>  {
>> +       /* device private folios cannot get pinned via GUP. */
>> +       const bool pinnable = !folio_is_device_private(folio);
>> +
> 
> If we make a helper that does:
> 
> for (;;) {
>      ClearPageAnonExclusive(page);
>      if (--nr_pages == 0)
>                break;
>      page++;
> }
> 
> wouldn't that allow us to avoid this ugly `pinnable` variant?
> 
> Then we can make a much smaller modification, which should
> also be much easier to follow? No?

David had suggested here:

https://lore.kernel.org/all/95b8224d-3ed4-4fe3-9954-d5ba0aa373f8@kernel.org/

The argument was that the helper would have no context of the pages we are
operating on. Although you are correct that this makes the function harder
to follow.

Maybe, revert to the original function, and have this helper
folio_clear_pages_anon_exclusive, which will take the folio and do
the page_anon_exclusive_batch = nr_pages sanity check, and add
kerneldoc to it which says pages should be within folio?

The kerneldoc can be saved by calling __folio_rmap_sanity_checks in
folio_clear_pages_anon_exclusive - that will cause duplication, but
then it's all a VM_WARN_ON function so maybe we don't care?


> 
> Best Regards
> Barry

