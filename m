Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DF13D2B2;
	Thu, 18 Dec 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058565; cv=none; b=YaE6Jn0sPuitP5+hcHRohfbfLSf+7t+kjXavYSXcZyUF+khJrQSzgs0EaoOdpT6M9c3xyxejqDWPjX0LA11KrYD8RHJJiEtuD2pfq4naq0Pb2GgIYkGYHG7ZuwPslCFvQFtL8Z5VTxY/DLWsGPEr12kvD70NQm5wOcHyyRQpDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058565; c=relaxed/simple;
	bh=gM97SVLiy9VJPrcCvd10t4/kGkIwU1lgSn+lqj1MNrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPV9ErzTrxK1HeN51N2opW266SldDnLe8HobnO2CD/bckAlPnRbM1UkHJdjW+rimSVj/bLUb25vhFiPv+xC8BsWiRLWbLyuqxh6hzuyBHk6lyOY7ttYo6xaSo/17H0Z+lwZVQlIj9iD+IRGUd7Z+El7oAGfDXhzcL4jUwZOz0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyhtvcbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyhtvcbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7B4C4CEFB;
	Thu, 18 Dec 2025 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766058564;
	bh=gM97SVLiy9VJPrcCvd10t4/kGkIwU1lgSn+lqj1MNrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YyhtvcbEpQ3dx0joR9Z84m74P1AJNxNm5ONNsJnIGdfoA6X59qp1wgOjkZldkGYOd
	 Lm1vova5Z6bcgbsyD7lrCsMUtdNhRo3bteUBlzqJFibthUXHJkLqVFX539iuUSMeKO
	 RQwiay1O5vobunnyWgmgLfU6EfhYYuOOjIChI956no22qzMHFrQ8vEYArCuGDo+5Cu
	 UFrAum8TaRD88pwmrnCeMWrmHCMW01FApulnS4qCPs1NbV5JZiJWtPLFdj3xYfMwQ8
	 8L87Lt0ucjEgfrMO5TUwhl87d1CKQhcHwOeoyOCKu0yFwTP53yrJcsDxiuNgZV09YI
	 EumNBapvE5wgw==
Message-ID: <d2aa6eb6-cf67-4b89-a9d4-306c720fad55@kernel.org>
Date: Thu, 18 Dec 2025 12:49:19 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
To: Tao pilgrim <pilgrimtao@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, kevin.brodsky@arm.com,
 dave.hansen@linux.intel.com, ziy@nvidia.com, chengkaitao@kylinos.cn,
 willy@infradead.org, zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251217120858.18713-1-pilgrimtao@gmail.com>
 <d373f7b0-f822-4c31-990c-41a6cdc76db3@kernel.org>
 <CAAWJmAYJdEJyybVgD7erzZgvwufZ8gSmP_FCohmZLYozbhbb3g@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CAAWJmAYJdEJyybVgD7erzZgvwufZ8gSmP_FCohmZLYozbhbb3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 12:02, Tao pilgrim wrote:
> On Thu, Dec 18, 2025 at 4:44 PM David Hildenbrand (Red Hat)
> <david@kernel.org> wrote:
>>
>> On 12/17/25 13:08, chengkaitao wrote:
>>> From: Chengkaitao <chengkaitao@kylinos.cn>

^ this is the author

And you reply from a completely different address with a completely 
different name.

To whom am I talking here? The patch author?


[...]

>>>
>>
>> Bunch of unrelated changes that should not go in here.
> 
> This indeed contains some unrelated code changes and removal of
> extra whitespace. These could be split into a separate patch,
> but the new patch might be somewhat redundant, lol. If you'd
> like me to proceed this way, please reply confirming.

We usually don't do random other stuff as part of one patch. It's a 
different story if you touch the surrounding code, but that doesn't look 
like that here?

> 
>>> @@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
>>>    EXPORT_SYMBOL(_PAGE_CACHE);
>>>
>>>    #ifdef CONFIG_SPARSEMEM_VMEMMAP
>>> -int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>>> -                            int node, struct vmem_altmap *altmap)
>>> +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
>>> +                            unsigned long addr, unsigned long next)
>>>    {
>>>        unsigned long pte_base;
>>>
>>> @@ -2595,39 +2595,25 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>>>
>>>        pte_base |= _PAGE_PMD_HUGE;
>>>
>>> -     vstart = vstart & PMD_MASK;
>>> -     vend = ALIGN(vend, PMD_SIZE);
>>> -     for (; vstart < vend; vstart += PMD_SIZE) {
>>> -             pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
>>> -             unsigned long pte;
>>> -             p4d_t *p4d;
>>> -             pud_t *pud;
>>> -             pmd_t *pmd;
>>> -
>>> -             if (!pgd)
>>> -                     return -ENOMEM;
>>> -
>>> -             p4d = vmemmap_p4d_populate(pgd, vstart, node);
>>> -             if (!p4d)
>>> -                     return -ENOMEM;
>>> -
>>> -             pud = vmemmap_pud_populate(p4d, vstart, node);
>>> -             if (!pud)
>>> -                     return -ENOMEM;
>>> -
>>> -             pmd = pmd_offset(pud, vstart);
>>> -             pte = pmd_val(*pmd);
>>> -             if (!(pte & _PAGE_VALID)) {
>>> -                     void *block = vmemmap_alloc_block(PMD_SIZE, node);
>>> +     pmd_val(*pmd) = pte_base | __pa(p);
>>> +}
>>>
>>> -                     if (!block)
>>> -                             return -ENOMEM;
>>> +bool __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
>>> +{
>>> +     return true;
>>> +}
>>>
>>> -                     pmd_val(*pmd) = pte_base | __pa(block);
>>> -             }
>>> -     }
>>> +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>>> +                             unsigned long addr, unsigned long next)
>>> +{
>>> +     vmemmap_verify((pte_t *)pmdp, node, addr, next);
>>> +     return 1;
>>> +}
>>>
>>> -     return 0;
>>> +int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>>> +                            int node, struct vmem_altmap *altmap)
>>> +{
>>> +     return vmemmap_populate_hugepages(vstart, vend, node, altmap);
>>>    }
>>>    #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 15076261d0c2..5e005b0f947d 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -4248,6 +4248,7 @@ void *vmemmap_alloc_block_buf(unsigned long size, int node,
>>>    void vmemmap_verify(pte_t *, int, unsigned long, unsigned long);
>>>    void vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
>>>                     unsigned long addr, unsigned long next);
>>> +bool vmemmap_false_pmd(pmd_t *pmd, int node);
>>>    int vmemmap_check_pmd(pmd_t *pmd, int node,
>>>                      unsigned long addr, unsigned long next);
>>>    int vmemmap_populate_basepages(unsigned long start, unsigned long end,
>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>> index 37522d6cb398..bd54b8c6f56e 100644
>>> --- a/mm/sparse-vmemmap.c
>>> +++ b/mm/sparse-vmemmap.c
>>> @@ -407,6 +407,11 @@ void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
>>>    {
>>>    }
>>>
>>> +bool __weak __meminit vmemmap_false_pmd(pmd_t *pmd, int node)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>
>> Reading that function I have absolutely no clue what this is supposed to
>> do. :)
>>
>> Also, why are you passing pmd+node when sparc ignores them completely
>> and statically returns "true" ?
> 
> The pmd+node is indeed unnecessary. My original intention was
> to provide convenience for future architecture extensions, but
> upon reflection, this appears to be a case of over-engineering.

Jup.

> 
>> If you can tell me what the semantics of that function should be, maybe
>> we can come up with a more descriptive name.
> 
> In the SPARC architecture, the original vmemmap_populate
> function does not retry with vmemmap_populate_basepages
> after vmemmap_alloc_block fails. I suspect SPARC doesn't
> support basepages, which is why we need to modify
> vmemmap_populate_hugepages to provide an interface that
> skips basepages handling.

So, something like vmemmap_pte_fallback_allowed() ?

-- 
Cheers

David
