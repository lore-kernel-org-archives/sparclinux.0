Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622CC2DA756
	for <sparclinux@vger.kernel.org>; Sat,  4 Apr 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775288240; cv=none; b=uN5U93ZUPH2mt0ZVjfA59KLAV/p+cRGAnlDbtSEkG0/ubxmfYSQf9JctfJGfUfSqIbLsmS0IdwunwFkHD09bqGFqW3IqZmmwQw4uB2qiyhKUgrqFuKq/wFeQGs9q3ZPlIRK7m6VkhfcIARUjKY0RtRCxq9UWOBoCuOMSoMIrVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775288240; c=relaxed/simple;
	bh=YjFLpQgBnF3HAvIxqtDDMQxGJDJnkaYb5atAFDTsFuA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u/9lD7bjJvdnszsp5n4p4vDBYDDpwtjBkOzwsLiCcoSdE+EjmTBLMA6VvtQ4x3OgqNJjfIbDEOYUc5Fm1VY3wB4SxcFSfB92CFDv3lgGaRvu38Mct2hd6/N54pLV7MuaoJFrVH8wUaXyl+L6uqPLSSTvGSS2efBVOJAqD99Jz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J33Tenz/; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J33Tenz/"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775288226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nWmxlFNX2J4GFdZGRIfE23zfRXOguYRhAS78blu2KA=;
	b=J33Tenz/ujh68w+9y9GSofFFuNbYRuCJy01kusKKlEkABY5ljUk6uvJbKYDHMmHBIJOXFT
	UXtt8AucZB5bfd/OfHI0wkfWil+HoheGoWkV+iMawWx8h6mRgQdLXNbMYzhRG4ENO3ICHP
	3j2bY5ABGkDxRJU5fjDVh4NEdUHMPd4=
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 0/5] mm/sparse-vmemmap: provide generic vmemmap_set_pmd()
 and vmemmap_check_pmd()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260404071720.3577290-1-songmuchun@bytedance.com>
Date: Sat, 4 Apr 2026 15:35:52 +0800
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Petr Tesarik <ptesarik@suse.com>,
 Austin Kim <austin.kim@lge.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alex Shi <alexs@kernel.org>,
 Chengkaitao <chengkaitao@kylinos.cn>,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org,
 sparclinux@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CFBEBBC-5273-48E9-9E5F-1F4599194050@linux.dev>
References: <20260404071720.3577290-1-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

  =20
> On Apr 4, 2026, at 15:17, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> The two weak functions vmemmap_set_pmd() and vmemmap_check_pmd() are
> currently no-ops on every architecture, forcing each platform that =
needs
> them to duplicate the same handful of lines. Provide a generic =
implementation:
>=20
> - vmemmap_set_pmd() simply sets a huge PMD with PAGE_KERNEL =
protection.
>=20
> - vmemmap_check_pmd() verifies that the PMD is present and leaf,
>  then calls the existing vmemmap_verify() helper.
>=20
> Architectures that need special handling can continue to override the
> weak symbols; everyone else gets the standard version for free.
>=20
> This series drops the custom implementations in arm64, riscv, =
loongarch,
> and sparc, replacing them with the generic implementation introduced
> in the first patch.
>=20
> Muchun Song (5):
>  mm/sparse-vmemmap: provide generic vmemmap_set_pmd() and
>    vmemmap_check_pmd()
>  arm64/mm: drop vmemmap_pmd helpers and use generic code
>  riscv/mm: drop vmemmap_pmd helpers and use generic code
>  loongarch/mm: drop vmemmap_check_pmd helper and use generic code
>  sparc/mm: drop vmemmap_check_pmd helper and use generic code

Hi all,

Please accept my sincere apologies for the mailing list noise.

Due to an error in my local scripts (failing to clean up the patch
output directory before regenerating the series with an updated commit
range), multiple duplicate and conflicting patches were accidentally
sent to the list simultaneously (10 patches in total instead of the
intended 5).

Sorry again for the inconvenience.

Thanks,
Muchun=20

>=20
> arch/arm64/mm/mmu.c      | 14 --------------
> arch/loongarch/mm/init.c | 11 -----------
> arch/riscv/mm/init.c     | 13 -------------
> arch/sparc/mm/init_64.c  | 11 -----------
> mm/sparse-vmemmap.c      |  7 ++++++-
> 5 files changed, 6 insertions(+), 50 deletions(-)
>=20
> --=20
> 2.20.1
>=20

