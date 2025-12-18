Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022628134F
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067396; cv=none; b=qOq+KfAd6PRZCxsBdGM2ll5bLwwhKnVMMVWHnxeivmrXxaSLcVydHAftJjmRcIv4euFP3bPzGPfv+BfVRPckTyKDyxB5J919HFiVKhcq0qwBLIWb8sCU9SF+pJZ2+L+IYF1WRvLT+ZCYFXaq0nYOztJ8vm/I3M71DK3G7uxhBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067396; c=relaxed/simple;
	bh=X3AetqFr0Rs5Pr4ASvORkz3yAjAZv7TTnmXwVQ+MVjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A4nGAQVwTJ0z+ZAKHB/pMM/dCfH4vkLOkCMZyG0ywtdIzJFIZBztnjR+b1qCLbRPm2P+3gqSOK6HMPYbt8DYOLZdRAJYglRBb0XihZdSOBewX+G44TvtGsN1Vx2PZxWIBGcyIrGP6OEAX62r/OXwNCZQVru8fUMcDTWL/OsRcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6F7rLWi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6F7rLWi"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78e765f9997so4552377b3.1
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 06:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766067393; x=1766672193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXzxKl4n/8RvMAsuC5o0CHJyqBCSHbh1Hg5d0ZUuzDk=;
        b=J6F7rLWi6E1H9pOATmMmbgtG+g3Awq3ldDk5zgt5lBNDPX6MH9Yz1xBeb5pQj8riBK
         j5UznOUKAg6MFra7ThfGxgbN3PuyoOprEcO5Rr1khYY+k3JdH23C1mbIx4xkXeF1QT4y
         augowEqmdDxRQL3Tb5RtT50bPEZO8O9EONyVL2eO3PVDNEM6XE+FhN6ZOUHg7MDbfJG4
         A1knCUy4d4hvGDdQxZHVI4NKita3Kn9MlKHax0v9I06oCxgUbUfK1DJd/BIb/laqdOrm
         jr02RSvIiEV5r9keHZBdBb2y0vDFJ6kdWWml/9MqwBE8s5vhDJBprGze9lq3cDtFzevs
         moBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766067393; x=1766672193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXzxKl4n/8RvMAsuC5o0CHJyqBCSHbh1Hg5d0ZUuzDk=;
        b=vMddIl9WAd62BhgkS6yY5GfXIdZCydqhOwFblYyafAxMNvQ/V0slkTrAlG+GNjdFsX
         bB38yi2xhZyDU9y+PpiTUkGUsq6LyOKH5dVjbSBzlQsAi6qftScF2Pp7m/dASVXLHrew
         nLyAgPuL+PY0l9ay4BBJkFZZMjCpYizpO6Q7MQVVruzMHKU1aTehJOJukAtMFlcEnBat
         1XzdU18KLAYmnvnlpwYcHV9/KaobN+mwhaqye5Da1plaw+oYpaHIoL9wEZXjYuOIkUZY
         +kyw86OEFjM6lFcn+YGMLx13YGgDfgQ6VVPoWEZ+d9/Z+gcn6MndbV3WJ5K4DobK+WAU
         5ZjA==
X-Forwarded-Encrypted: i=1; AJvYcCVWkCG9ds9VesY07Lb/UvLOj2jGt91yOHBB45Zy0yLGIU5YE1VQ2AbL1jw+SRhprT3mYX5+xKmw+7Sb@vger.kernel.org
X-Gm-Message-State: AOJu0YwecBled72l79UwKD7sOz51hKkY64Nufw/531ojCF897x24wkHP
	by07iPVIk9/nCUQSySIj7i8ZGzfBDR5ZL/e13afKcd0FRcqyOQK+Brp6
X-Gm-Gg: AY/fxX6yVsgEZekcR1DHQIw09FdiITyzRKU7ZG7mU7PrG9gkcLxvF0aDmnzQgYzMAyz
	ipbbPiOv2zR/ld0jPUFg06Oc2Bp18A4eYriaWb2Dof2E99hcu2/NiwOYIBeLfRgcuTtse/djeTd
	vHe8z/8ahSDO5VC1/PhvGVRoB7GlEkJfT/sEa9cLdsPQ/F2Zfv1n/lhEukHCNTB53viPpFHr43x
	URXxjHM1nm/raTX9r96s4985kvtDI0ZoMAfUwk05ICn9urV1MREYp+++5Z0E40VBU3fd1S1UcSW
	GGOe76diG7CsTuKvrWhPp2Ym8QhSBNcnPYOP6GntQQ7INh6m7ydiFZQIv7s9SX9sjT9hDNYzh7/
	sPaKgUg65fFspyn1IkODijRfuhCn/Z4wD3my2yW5BBurrwnvjFedWdNih/GbQC6jE0DiTHcLR2n
	bAEqVhFbpI7jf+bWsNmsyfpEQLdEx0SUf7WEUiVg==
X-Google-Smtp-Source: AGHT+IHiyiDMA9Ch4dS+LVHDAxXzncC3LuoMgD0ZQuZ+G9ON0TWb1O0iMOdyZnWTo8KMI06Ox9pplg==
X-Received: by 2002:a05:690e:4086:b0:645:5a9f:8002 with SMTP id 956f58d0204a3-6455a9f836bmr15444591d50.6.1766067392483;
        Thu, 18 Dec 2025 06:16:32 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fa72b48efsm8363757b3.51.2025.12.18.06.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 06:16:31 -0800 (PST)
Message-ID: <4249e49a-c91a-4e9c-92c1-79c272627540@gmail.com>
Date: Thu, 18 Dec 2025 22:16:05 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm/pgtable: use ptdesc for pmd_huge_pte
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, alexs@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Thomas Huth <thuth@redhat.com>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Magnus Lindholm <linmag7@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20251214065546.156209-1-alexs@kernel.org>
 <52e2c1eb-67cf-41ee-9088-760fb6258153@gmail.com>
 <ee42b057-b2d1-4a61-a6b0-39f81f78a918@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ee42b057-b2d1-4a61-a6b0-39f81f78a918@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/18 18:01, David Hildenbrand (Red Hat) wrote:
> On 12/15/25 01:53, Alex Shi wrote:
>>
>>
>> On 2025/12/14 14:55, alexs@kernel.org wrote:
>>> From: Alex Shi<alexs@kernel.org>
>>>
>>> 'pmd_huge_pte' are pgtable variables, but used 'pgtable->lru'
>>> instead of pgtable->pt_list in pgtable_trans_huge_deposit/withdraw
>>> functions, That's a bit weird.
>>>
>>> So let's convert the pgtable_t to precise 'struct ptdesc *' for
>>> ptdesc->pmd_huge_pte, and mm->pmd_huge_pte, then convert function
>>> pgtable_trans_huge_deposit() to use correct ptdesc.
>>>
>>> This convertion works for most of arch, but failed on s390/sparc/powerpc
>>> since they use 'pte_t *' as pgtable_t. Is there any suggestion for these
>>> archs? If we could have a solution, we may remove the pgtable_t for 
>>> other
>>> archs.
>>
>> If s390/sparc/powerpc can't align pgtable_t with others, we have to keep
>> the pgtable_t to bridge different types. But we could take step to
>> change pgtable_t as 'struct ptdesc *' in other archs. That could
>> simplify and clarify related code too, isn't it?
> 
> Not sure. s390 and friends squeeze multiple actual page tables into a 
> single page and that single page has a single ptdesc.
> 
> I was rather hoping that we can make the code more consistent by making 
> everybody just point at the start of the page table? (that is, make it 
> consistent for all, not use ptdesc for some and pte_t * for others)
> 

Got it. That would be great if owners of these archs like to work on this.

Thanks
Alex
