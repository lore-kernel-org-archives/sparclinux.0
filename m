Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94028352C2B;
	Thu,  4 Jun 2026 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551872; cv=none; b=lb39x/xgTANtvtvPCP5YkWI45uek8/QP1ZAlurv+az0ReD0nT5DesZvkYwJLG8EnDv4bIxgvvQ8X5PEzTfhXtXYcycORHblQ1Srr72Y/Dm7bz/B+grSrYYgtUdbzBU56uiwcrT1W+f8mSF+MZYkDb8Zj43nwBWV4tR2mKfibENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551872; c=relaxed/simple;
	bh=mcTCxxOX9qnxOD3RbX1q1ypIFdLNwAoDyZX/Ca0KeWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqiOJjXAlob0O+IY5gJRtI64HWsnd9bLrFVE6R8vR32FVQlnUydt6azX8R3wjGLS3TfWb2o737Ih+TM0c3grD7IhtOEQrfVOxceuNIJP4pkKCf8SBZHktz+/1HTVjlUVJm21O4HCw0aIOupKj/c3qjZhsUdylh1jbeRS693RSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtPfhMok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtPfhMok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C211F00893;
	Thu,  4 Jun 2026 05:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780551868;
	bh=i9U2E5wM9GwBXet0D5NfI+XdIVHV58zoDfgA5pHkk0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FtPfhMok/Sq6q/EWpl0HkfZHEXB93SkrfDQ1avxGAUV0U6pC/V8iyBvjtTtkts5gq
	 d6vlMQSw4o8T3gbCW4X22yPx9/vz5b82hMCVFd1HYtcPdQyIciO3mIbCIcZc1wrmma
	 pN6gbeazjyTVMZPMXWpbMHaC0tgciwvZA+RdwFPtQuPcaS9v/lin5GSukXB4rXlAfq
	 Uah0e5RmyQV53tamwmMAV28lqbVKPQuwSxe2uLqoeZP0IEvSMZkbvjcrX0X8P4nvW/
	 aAohKKtprbmaxyiWh6xqDjRdNXm2yaFDtq2Q0KVYJ34jueUE/x8hwlvBWu738nzBWy
	 g1UVQim2kTCQg==
Date: Thu, 4 Jun 2026 08:44:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memblock: Introduce memblock_alloc_node_or_panic()
 helper
Message-ID: <aiEQscLI2LkNSj2v@kernel.org>
References: <20260604034139.2827148-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604034139.2827148-1-zhen.ni@easystack.cn>

On Thu, Jun 04, 2026 at 11:41:39AM +0800, Zhen Ni wrote:
> During early boot, several subsystems allocate memory from specific
> NUMA nodes using memblock_alloc_node(). When allocation fails, the
> typical requirement is to panic immediately.
> 
> Introduce memblock_alloc_node_or_panic() to automatically panic on
> allocation failure. This reduces repetitive error checking, improves code
> consistency across subsystems, and enhances code readability.

memblock_alloc_or_panic() made sense because it's the most used memblock
API.

Adding panic() versions for a handful of uses is unnecessary churn.

A better patch would be to update panic() messages to convey more useful
information.
 
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  arch/sh/mm/numa.c            | 10 ++++------
>  arch/sparc/kernel/setup_64.c | 16 ++++++----------
>  arch/x86/coco/sev/core.c     |  5 ++---
>  include/linux/memblock.h     |  6 ++++++
>  mm/memblock.c                | 22 ++++++++++++++++++++++
>  mm/mm_init.c                 | 11 ++++-------
>  mm/sparse.c                  | 13 +++++--------
>  7 files changed, 49 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
> index 9bc212b5e762..32b01697b27f 100644
> --- a/arch/sh/mm/numa.c
> +++ b/arch/sh/mm/numa.c
> @@ -38,12 +38,10 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
>  	__add_active_range(nid, start_pfn, end_pfn);
>  
>  	/* Node-local pgdat */
> -	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
> -					     SMP_CACHE_BYTES, nid);
> -	if (!NODE_DATA(nid))
> -		panic("%s: Failed to allocate %zu bytes align=0x%x nid=%d\n",
> -		      __func__, sizeof(struct pglist_data), SMP_CACHE_BYTES,
> -		      nid);
> +	NODE_DATA(nid) = memblock_alloc_node_or_panic(
> +				sizeof(struct pglist_data),
> +				SMP_CACHE_BYTES,
> +				nid);

Please don't touch this, the entire file is going away after rc1.

>  
>  	NODE_DATA(nid)->node_start_pfn = start_pfn;
>  	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;

-- 
Sincerely yours,
Mike.
