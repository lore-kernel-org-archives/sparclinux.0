Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FF306483
	for <sparclinux@vger.kernel.org>; Mon, 15 Dec 2025 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765760006; cv=none; b=twbZyKC2ho9iv25Gcy3tE46xxwzhiZapMvPXzOEDN2yNNmEbsqkA55de/U2EIQCXZRubMQ6hu+pWuGAL6tTcxDVDfMlCHDDNeIlLJxTVs+2stIGw0NEChxkUqYzyQpW4+rk992GMufsTZY9tpHeCcxpzP7yRH6lTogI7r+PMaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765760006; c=relaxed/simple;
	bh=WkyKiF5z3K+l681MxAijPXdfs2UqVwfJOs959vTVdl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SbHmgZF2f/1AAmLVI0cDtUT2YduhWHpNJZP0YfmNyDYV2yZHo8GwfTEBP2oPniiRXDEWD8xTa3snDA6ci2ejaMUgg/YudUJhztF4S/Yf5wHRulNorq4LLeb/3btyXGqWRoSLTn9YECuabKlcMI8zWtuECqfEICt02bwPPpVI1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaE9BmZo; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaE9BmZo"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6446ba3d337so2139731d50.1
        for <sparclinux@vger.kernel.org>; Sun, 14 Dec 2025 16:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765760004; x=1766364804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9g3zA8+/SS364XH9Hr1y/D4AwnbgxagYZf00bypWxY=;
        b=JaE9BmZomcb8F0JmEgvmzCsyA8P7mwM9HHpNNmhWJZ6opit8xNIVn1W/ld03q2vDrV
         6kVN5fFD/XtqpiVPe3DeoXpil6NvcVwjWldzILt42YKi21fjn1T3gR8z2QobEDAyhiR4
         rfHZkEu/1Kn6EnvLh4BeDhKMSyPE3IpulzoZKSSDdlqQ2tyLhAFP8iTXBSAsLs/J4teb
         opdzurQ26JgVNxasI3izcSEGhvjILQQvvIFBQbxarUW6DCoMnITmPkCQyF1aVYnkZZcY
         P+4pCaonLNQ0Q/TqEKTR2/1bD8Sb2oHYp0iR1UtbRe//14O0RDiKDvrbTBZszov5Zaxc
         HPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765760004; x=1766364804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9g3zA8+/SS364XH9Hr1y/D4AwnbgxagYZf00bypWxY=;
        b=ejPNOzgAHV0GLR/8GjoGvwTnUAqbE3lK8dvf4wVU+t+Ze/bwKbi8d/T9YiiILB9sdD
         TZ63OY82nQR1jG10gh/3kK0MM9/yeqjCDyWkTMs7k3gLkxTo8ad0psScT77XkJKZ6BsN
         iVUKZl1rBibJ6x5tgj+1dfkBC646sWsv4LQi8BfqoP0Bf2z2JJkK8MEItyOPr4/tDfa2
         O6EeF2iGrzmMWXV+lEQ70xATaU+TiRf/3rdSWSThQ87MU9xA3VzihoxuprQlhIhJ1xmU
         nc0wfKOdNKDE/PDPyYEilb12gtOsgRBvfclb4JAOyrzSxcU6fYvIEL4r1cvsf7c8sCxx
         8Zdw==
X-Forwarded-Encrypted: i=1; AJvYcCVDPhZN+lT2OxYjdhpQ2lcbnGbV8A1mIwIbhdKzfaq6uWyfp93FoMq6L+npn/SEcH2uMF8BQaZwHif0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3b7XR9ED9ZMBS1YCWd9J/u9etitdDZElcl3qHCfW0mOmjgYb
	KkkRct1axuwD22Az6BNnUrnyYjOi4c9nwPwWh8mms5/sqU7XNgTV4FsaEA/t19QxRsJYmw==
X-Gm-Gg: AY/fxX6oHH2JiwOkUMpCWbnkL36P1NkmnlY8PpElnJUNhagd8+tlUgwEC3wuDKrXpkw
	e+LVKu5DhhJNVNI8wMe+rTSUC+m1wGAIev578//ec4DYtLwZt/qeEQOUoytF0Hrxgk0QZQVVXDs
	fhyH39VLIqKAVnu5PHy3dSFNBsVh6AzoI3jDGMuOTB91xtmB5slmPshvwV2UQZkkbbrDyyA6sTr
	mvbxlzziRqhWB0KQFehh8fqIdyD6NpjJHIX8NnT1YySTQuDnyb1yZG/GLz2T2m2D7mwVrETgAa9
	GB/cqZPXrnsv6flC7fGmemI9osyQmGHAEoaACvWBlcGC3C9dlVpZKZFiqd3VVX6/aVH0/ivWTX5
	jG84ZoYZKJoC2wcVBNzSO/Alet5otm2HqkPg1Acky0ZJQ8kq63vd1LmGdVNI4+alHXsXk36vJeV
	F06+pN8JpDgqj75663g/l1cY6srZOmIXVUNrCSew==
X-Google-Smtp-Source: AGHT+IGymE1URbEHDhw5BX1nzGOTECoWjlfm2zsVFVoPWPkTZrOWD3CnCtM5DT/uUKOVkJdBDZchkQ==
X-Received: by 2002:a05:690e:b8f:b0:641:f5bc:6950 with SMTP id 956f58d0204a3-6455567e9admr7325417d50.84.1765760003993;
        Sun, 14 Dec 2025 16:53:23 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477db6599sm5753649d50.21.2025.12.14.16.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 16:53:23 -0800 (PST)
Message-ID: <52e2c1eb-67cf-41ee-9088-760fb6258153@gmail.com>
Date: Mon, 15 Dec 2025 08:53:07 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm/pgtable: use ptdesc for pmd_huge_pte
To: alexs@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
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
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20251214065546.156209-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/14 14:55, alexs@kernel.org wrote:
> From: Alex Shi<alexs@kernel.org>
> 
> 'pmd_huge_pte' are pgtable variables, but used 'pgtable->lru'
> instead of pgtable->pt_list in pgtable_trans_huge_deposit/withdraw
> functions, That's a bit weird.
> 
> So let's convert the pgtable_t to precise 'struct ptdesc *' for
> ptdesc->pmd_huge_pte, and mm->pmd_huge_pte, then convert function
> pgtable_trans_huge_deposit() to use correct ptdesc.
> 
> This convertion works for most of arch, but failed on s390/sparc/powerpc
> since they use 'pte_t *' as pgtable_t. Is there any suggestion for these
> archs? If we could have a solution, we may remove the pgtable_t for other
> archs.

If s390/sparc/powerpc can't align pgtable_t with others, we have to keep 
the pgtable_t to bridge different types. But we could take step to 
change pgtable_t as 'struct ptdesc *' in other archs. That could 
simplify and clarify related code too, isn't it?
