Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2734D3B9;
	Mon, 29 Jun 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755039; cv=none; b=FAA0t3YGfMyD9C/XgHCTEDfljLDmTmczPoBL/4CCfdRd0HhkObZECYIwlUfEg4w9vJjNbFN3al2mi5NgQurT/qXwZ6IALXyroUrX2+asruwMAtDKflBKZQLmArXTf/+7iElqgkWozolbL28vCKiOA1TKYUlLPc+ckz96cNgteVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755039; c=relaxed/simple;
	bh=8L9FGavC4ul9iL2IyJlhwaB8NzuFv78Rma1Bq2wVC4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CK4yNNHehvytNvozuTLha/y01p7710WPGDQR22mbk/aIc6rkLDpDaAASN7E0zAhrpheRmqcSSWOLV0/Ym6OuhogllAmPbiPdL2kIO1TBbKNgfREoBZ6oHGYTO/ZZJAJDZirEOmHslDN+KTnct3ClZOTA4GP6ety3dCiCcM+ksCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMBCmM6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMBCmM6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A651F000E9;
	Mon, 29 Jun 2026 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782755038;
	bh=sNPWUj0b3dpxJFm9DmiWQoTjCiuvhdzLK8xC9ADnE8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FMBCmM6uX9VREwWikdZd8AjqjhA0cn8zckZezxCiaDRwpSVAuFWVUsl7qw03ZO1Hq
	 O40u+9Ah0zciqqs3VgdDdNVUFsHXteukIHLzAm0/rSDQzzzAJ1EfJEalXtLOZYDTe4
	 TsRC/hFucqYfARZ4BGTVaoMkXlPVDT3WIBdsq4bB8ecDMYMcBFzPHuUS7vSTgQyV82
	 e3e7QmolFwS1AZUMzBVQjbX4C+K4Mgv3wroJoKMpxvEfE1BUXOBzzl5w0F4vcXxE8Q
	 GDdkUQxFMLe1h1Pl3KtE1y3UtvsCeWMliEQrBJxAzME36Iz+vio0+BTH5F0NwWOZh9
	 ZaTbQWxQjPVdA==
Message-ID: <fd1b4199-ebbc-420b-afe4-3bea4b9149fc@kernel.org>
Date: Mon, 29 Jun 2026 19:43:53 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: drop pte_clear_not_present_full()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Oscar Salvador (SUSE)" <osalvador@kernel.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260629-clear_not_present_full_ptes-v2-0-96089871a1e7@kernel.org>
 <20260629-clear_not_present_full_ptes-v2-2-96089871a1e7@kernel.org>
 <20260629102215.09605f0e9ef66c5f58fe0932@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260629102215.09605f0e9ef66c5f58fe0932@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 19:22, Andrew Morton wrote:
> On Mon, 29 Jun 2026 15:49:48 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
>> In general, there is no good reason to do anything special when clearing
>> non-present PTEs.
>>
>> In theory, HW that does have to invalidate TLBs for non-present PTEs could
>> benefit from a "full" parameter, but fortunately
>> pte_clear_not_present_full() is not wired up anymore ... and there would
>> have to be something very convincing for us to care about that to re-add
>> it.
>>
>> So, let's just use pte_clear() directly now. To avoid the compiler
>> complaining on some configs about unused "addr" parameter, silence that
>> here.
> 
> Wait, which configs do that?
> 
>> @@ -1022,8 +1007,10 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>>  static inline void clear_not_present_full_ptes(struct mm_struct *mm,
>>  		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>>  {
>> +	(void)addr;
>> +
> 
> We heavily rely on this warning not happening.
> 
> eg, one of thousands:
> 
> static inline bool page_range_contiguous(const struct page *page,
> 		unsigned long nr_pages)
> {
> 	return true;
> }
> 
> So... what's happening here?

"nr_pages" are not modified in the function, so the compile does not complain.
See below.


A private build bot barked at me after v1 for

	arm-linux-gnueabi-gcc
	openrisc-allnoconfig
	um-allmodconfig

For example:

https://lore.kernel.org/all/202606121420.Wke8Ipgx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kasan.h:38,
                    from include/linux/slab.h:264,
                    from lib/test_bitops.c:12:
   include/linux/pgtable.h: In function 'clear_not_present_full_ptes':
>> include/linux/pgtable.h:974:31: error: parameter 'addr' set but not used
[-Werror=unused-but-set-parameter=]
     974 |                 unsigned long addr, pte_t *ptep, unsigned int nr, int
full)
         |                 ~~~~~~~~~~~~~~^~~~
   cc1: all warnings being treated as errors


The problem is that addr is updated (written) in the function but never read.
This becomes visible once pte_clear() is a macro instead of a function.

	arch/arm/include/asm/pgtable.h:#define pte_clear(mm,addr,ptep)
set_pte_ext(ptep, __pte(0), 0)


"(void) addr" silences bots. An alternative would be to find all such macros and
convert them into (assuming inline function is non-trivial)

#define pte_clear(mm,addr,ptep)  ((void)addr, set_pte_ext(ptep, __pte(0), 0))

Something I wanted to avoid for this simple patch here that just removes one
function indirection.

-- 
Cheers,

David
