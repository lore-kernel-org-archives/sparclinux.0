Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAFA3019AA;
	Tue,  2 Jun 2026 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375375; cv=none; b=eM70vKS9HZDjS19mBJg1PMb26/rH/7zjwqhLdZTYEl+dH/rW8HLC9CxXqj0Mx0K6tJZKWbcgzA2R1215GJQ0pT2bVkB3qyNE8EhkeomN4cKZHBvY7sseEPdQ9uY+v7K77WZodfSH5g9l1aeOKe0Y7p14IbCL5Wf+/7n+9C9y/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375375; c=relaxed/simple;
	bh=hubMJBtHOwU2kRhjEMqSgX9f43WvKsKeehylf2FEI7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHKG3bKWTJEfIZJu6cX/DZE25vA5wDITEoxqYTmcM2VVqNpkesVIe0QiqKbCvOjhOZE+XmI87dl0cjYM0ONA4BL8IdG3vJlM3i8bSDxzau/cTEp1xPQz4G7l/Q7wU7NuqAizBlDXPu3enHCwNyjI0U6HQs8h9Sk64NoJ6xnUtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX7UIQaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX7UIQaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758F31F00893;
	Tue,  2 Jun 2026 04:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780375374;
	bh=q5LjwyqHv+cuF7cox7QKxMaKT1u+xe8DMZ1+K1paDkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NX7UIQafey5Ppn3S4T1W8ulKWcx4GVHL15p4QQacar67iFhuJ0SNvibBo7j5gjswm
	 JcsAqP7zzZJzRnXqBdU6QzcN+4R7VKIeX8Xdykkre0iNXgb6t953myJbsK50zpg649
	 HE0ZA2rzhJDVPZNjRWV9WaDh9YH2eHkyATGegZvIUvbXG5v8xMKnkL74KMQNC/kNlZ
	 KmgKKRYH1J5c1mXc7/VgzS/aLHeNKUEj83ZfX+Ne/KdABkR9otndfuDAiJoe5YDyPi
	 XDsF7iWnVbPKMaoX/HaJJ0jS+/fBdjlRU2RNdW2K5dYPOAPsoYmXIasV6MVTYSvymN
	 PNjrjnre0i6Pw==
Date: Tue, 2 Jun 2026 06:42:45 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>, WANG Xuerui <kernel@xen0n.name>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 2/5] arm64/mm: drop vmemmap_pmd helpers and use
 generic code
Message-ID: <ah5fRXPvpOSmKoxl@localhost.localdomain>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
 <20260601084845.3792171-3-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601084845.3792171-3-songmuchun@bytedance.com>

On Mon, Jun 01, 2026 at 04:48:41PM +0800, Muchun Song wrote:
> The generic implementations now suffice; remove the arm64 copies.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Will Deacon <will@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

> ---
> v2->v3:
> - Collect Acked-by from Will Deacon
> ---
>  arch/arm64/mm/mmu.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 24388e5c727d..ea10b0ebecd7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1776,20 +1776,6 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
>  }
>  #endif
>  
> -void __meminit vmemmap_set_pmd(pmd_t *pmdp, void *p, int node,
> -			       unsigned long addr, unsigned long next)
> -{
> -	pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
> -}
> -
> -int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
> -				unsigned long addr, unsigned long next)
> -{
> -	vmemmap_verify((pte_t *)pmdp, node, addr, next);
> -
> -	return pmd_leaf(READ_ONCE(*pmdp));
> -}
> -
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		struct vmem_altmap *altmap)
>  {
> -- 
> 2.54.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
