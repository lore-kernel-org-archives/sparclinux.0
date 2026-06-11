Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27489357CF7;
	Thu, 11 Jun 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185780; cv=none; b=m5M65Y8zvaCcldpxePJ2ilY1qLYqedeVe1rmlzp0ht8pm+nWwMko5ydlO7f7W6KzQEQq/4U9oApu7JN/aAZVqWwKFXevVqkDUyeIOPKEwWeHNDh3CRf+qldgQAzk2VSSD6UPy0srzvRSu7F12WASD6inYyndom5dBwmCd7J0Bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185780; c=relaxed/simple;
	bh=hoHEIqyYYb0s+bx+iAuS0NcesypeIFXcTIlntHwOZvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsNSwuFEFx9Bq9tFnBfsIXOBPUXdYlj5tJ/J4UZR/ipgf/OYCUPsI+9vRZ1sMN+5zxss3SyEmVFlpiWuk7q+sKVyl9RFhbcg8qaEwM9i6Jl2CnE5Ksjdf6IqK8oKgMOBI0FegM0dYITrJAsFxBEkWSKgtVz6p4uviEiIeZGEJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkKy257r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkKy257r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C96F1F00899;
	Thu, 11 Jun 2026 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781185779;
	bh=TEvuJlQ7/byK5XxsbYYwUbRy15W0fhVCxzo1M/PBXMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IkKy257r9V3Y4dqrKhFosnHxl/O+VSLLwvZhs9NCu0ZnacHR2U0oyhquj+b8cv0Nb
	 pN963rM/ZsmLuBz25lQwn8W1cFTDW0tXfOgaHa7kzli1wOKRvnvNCTh96COOtxiXG0
	 3cHIpfTPwZCXaGVmAXBlmKSVqWZKNJ+FnGPA8/EUc7c9DTeY1SkK5Egf+aFYwJZPDS
	 Y2wsSrp1m/yOhR2z6j30HHuV4uSZ8zCMZj+zsUrE4l/i0LsP22XJYCJhreCnA3Myx9
	 jCs6fnM1yjp/CY0nf2hAOEmqV6H2FiVq6Xlj3SRfbUDZAvLQzvu4SwkSNqlp9mBl+N
	 TFFJU68m2/qxQ==
Date: Thu, 11 Jun 2026 15:49:31 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm: drop pte_clear_not_present_full()
Message-ID: <aiq86-eKAeDi-CQd@localhost.localdomain>
References: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
 <20260611-clear_not_present_full_ptes-v1-2-49865fc82629@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-clear_not_present_full_ptes-v1-2-49865fc82629@kernel.org>

On Thu, Jun 11, 2026 at 01:50:48PM +0200, David Hildenbrand (Arm) wrote:
> In general, there is no good reason to do anything special when clearing
> non-present PTEs.
> 
> In theory, HW that does have to invalidate TLBs for non-present PTEs could
> benefit from a "full" parameter, but fortunately

That would be on arches like arm64 where it can cache non-present
entries, right?
Then, we could signal a global invalidation instead of doing per page.

> pte_clear_not_present_full() is not wired up anymore ... and there would
> have to be something very convincing for us to care about that to re-add
> it.
> 
> So, let's just use pte_clear() directly now.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
