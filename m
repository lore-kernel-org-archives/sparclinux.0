Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177348;
	b=NpJLqdOGGTBBF51ajPBLeTyPnTdHhHtkZiDq4Iod3lHrGYnmn4csCcsH7lss0/yJjI11
	 wfZnZXVKNJ3wLVpy0DnEXFO/7dv+mrQu707oC72/BK6ZSHglFqMybApR1qZ1gU9vCUgfF
	 P7ZmieF6r+ISaun+BfsM/l/7s8gyrFz1eXZGgA0WKWAW10GMQUtkq67FoGrZxPRqfVojo
	 oK0kpzJec2Lwrb1M/LBKEBpt7OSAjcUpMYkvUaupdV7LTCF9u4+F/5bUW+mVNi56fTUcd
	 dcuFA/AfnSqqScGRW0N2JkzK+vjvukgY7adnuShxNEyRMgK5ETHLr0hweP+ZAjwBH9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177348;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VnV+4QS26pSX7EnMfpDaRxIt7mL09p6ZtWCC/XSNX4A=;
	b=1+e61FSFj2AjpVSf0KC2CX2T2QVKBWHAYGo2jbk8L+1u4QaQtcoTv0ygluiHl2t29RIV
	 ylXZ3Uq/CjfnlMfXz5e+b/h4pgdzn5npt40SCWUPhMn/Lfa0ptFZ8K66L+dsuTs3PNze2
	 KhS2l18760WVtYuoeWVI3nnsjltdazoBLbXLVJdkHTPxrjBC9I23DYBvainiPLu3Wxhtw
	 LtEjjAV/L9WAJyTHNuIYiT4Qcb3oUKDdgvQXOnuRc/qr/CAoX0oaQVpbkz7zd2+kvL2Nq
	 WpncxYxvOjsuzpxyxBRoMSnnSzaaQezx9rwh78g/dGtPFMqyCMuTNl4Mc9vpNRI8COA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2H+Y332;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5CE606A31A;
	Wed, 28 Oct 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2H+Y332
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E7D1F01825;
	Wed, 28 Oct 2026 08:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793177347;
	bh=VnV+4QS26pSX7EnMfpDaRxIt7mL09p6ZtWCC/XSNX4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U2H+Y332KrydKkbp+oolyWdoKHr2biLx8ESo49FzvwiLvtUntLGfGSEUAiz9HDVxO
	 95NcCz1jm9zz5AhK/BlsZ4vP3FjzZd5hTb6muzfFjy304AHG8cjf+/A8sBMit+bKZA
	 PBUj8F7W1EUjiR6KV5V9CuCT+vtCyuwd5aS2hYLIBQn7n3+hYRu/wfeq9ftms5rebO
	 YtuAhjIXHrV9cwYzkXrSaeGMcX/UntIhpBS4qo4xMMsRjCRL9/Ul0GXBn82JF8iG4w
	 Xqpbki7lLEKSz8s/u2zOVumGSCMOjhJtnwqY9/HtSHhqA54Rx/65462ez2QMvwH8+V
	 0ZGrW8R33FqqQ==
Message-ID: <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org>
Date: Wed, 28 Oct 2026 09:49:00 +0100
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
To: Imre Kaloz <kaloz@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Magnus Lindholm <linmag7@gmail.com>
References: <cover.1792609488.git.kaloz@kernel.org>
 <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
 <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
 <20261027212610.6798-1-kaloz@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261027212610.6798-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 22:26, Imre Kaloz wrote:
> Hi David,
> 
> On 10/23/26 22:53, David Hildenbrand (Arm) wrote:
>> Is there some way we can avoid this
>> helper-that-shouldn't-exist-but-someone-hacked-it-in entirely?
>> If it makes sparc64 slightly slower #dontcare.
> 
> I tried three ways of doing that on an Ultra 45 (UltraSPARC IIIi, two
> CPUs), all with move_pte() removed entirely:
> 
>  A) sparc64's flush_cache_range() flushes every present page in the
>     range from the D-cache;
>  B) sparc64's flush_cache_range() flushes the whole D-cache;
>  C) A for ranges of up to 10 pages, B above that.
> 
> All three pass a test that moves pages between cache colors with
> mremap() and checks for stale data. With no flush at all the same test
> finds about 15 million stale words per run, so it does catch the
> problem.
> 
> Medians of 20 runs over two boots per kernel, against this series'
> move_pte() as the baseline:
> 
>                             move_pte()        A          B          C
>   apt-cache gencaches           6.63 s     +0.2%      +0.3%      +0.1%
>   fork+exec                                +0.7%      +3.1%      -0.6%
>   mremap 8K, same color          14 us      20 us      43 us      20 us
>   mremap 8K, other color         21 us      20 us      43 us      20 us
>   mremap 1M, same color          30 us     524 us      60 us      59 us
>   mremap 8M, same color         209 us    4152 us     229 us     227 us
>   mremap 8M, other color       4176 us    4166 us     236 us     233 us
>   mremap 8M THP, same color      14 us    3933 us      43 us      42 us
> 
> flush_cache_range() has more callers than mremap(), mostly in rmap,
> so I also timed reclaim, migration and writeback (medians of 5):
> 
>                                   A          B          C
>   MADV_PAGEOUT to swap          +0.4%     +12.9%      -1.3%
>   reclaim under memory.max      +1.9%     +17.7%      +2.0%
>   msync of shared file mappings -4.4%      -3.4%      -0.4%
>   compaction, move_pages()      within 3% for all three
> 
> So A pays on large moves, B on reclaim, and C on neither: it costs
> the same as A on small ranges and the same as B on large ones. I'd go
> with C. It would only flush on Spitfire and Cheetah, which have the
> aliasing D-cache, so sun4v and the SPARC64 VII in Magnus's M3000
> series skip it.
> 
> If that works for you, I'd suggest dropping 4/4 and using C as its
> replacement; it's below the scissors, on top of 1/4-3/4.
But that's too complicated, requiring page table walks ....

People running museum piece hardware and complaining about performance of mremap
or memory reclaim should reconsider life choices.

So I'd say, make it as slow as you want while reducing core-MM complexity and
not adding more arch complexity.

-- 
Cheers,

David
