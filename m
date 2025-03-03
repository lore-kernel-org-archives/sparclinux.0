Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DE211A10;
	Mon,  3 Mar 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009167; cv=none; b=KLn8li1D5hW4GwoJPXJ8YMxv2SNwvFWoC6JcZbFyDxQL57i6Pr26/olgzeuq69bmBLKs0sGw+R8+JWO1ZxJAYbQHHMrrGozjhhyJp75vayfpl5RbtJOTUQk/+lFjSCAB7m7q/dDPdEqOxcUNycVDsU9R/8wmop+yrQQJEuCKFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009167; c=relaxed/simple;
	bh=a+xzmZy+B7fCsmKmkr8eFxrN/zN1zTAx89ABihyaOnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inap1f6lcXJ1vWcihJTfQRkBrabY1czfCdXRaV09yK4eMxiIOI1U9cv4YyUad5qu7l0eeCMzVVXug/Ke81dkZEq8EeHqd5nmx0frPYL0oBYkHlj9tTWvlRcZfna92adEK7CJmJEXfjh51N3JW8zCn5Ij0E2ttvcKx27pTAcq7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=RFhGDprU; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="RFhGDprU"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Z60KQ0fWkz1FbZy;
	Mon,  3 Mar 2025 14:39:22 +0100 (CET)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Z60KP1Hk1z1DDhC;
	Mon,  3 Mar 2025 14:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1741009161;
	bh=/93h/VFBMXUYlK5HJY61WVbB5bIOZygI64XeIBe95nE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RFhGDprUngIX8B/WksXu5qCl6jvG6Ue2AZeNLU2uztLVehbOrf4Be7sdpXV7apQAV
	 L5G/0zYDuoS1MZLUHtd9Cg4ltQmBCZYtoSFItZZTzSCMQlto/+shrAINuGubsl6a9Z
	 zhVJuX2/VxHBfRJjuhyVJhRfswfIwjfgKGq1o31k=
Message-ID: <b2b03b41-8442-4c68-9c00-05e524673fe0@gaisler.com>
Date: Mon, 3 Mar 2025 14:39:20 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] sparc/mm: Disable preemption in lazy mmu mode
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-3-ryan.roberts@arm.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250302145555.3236789-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-02 15:55, Ryan Roberts wrote:
> Since commit 38e0edb15bd0 ("mm/apply_to_range: call pte function with
> lazy updates") it's been possible for arch_[enter|leave]_lazy_mmu_mode()
> to be called without holding a page table lock (for the kernel mappings
> case), and therefore it is possible that preemption may occur while in
> the lazy mmu mode. The Sparc lazy mmu implementation is not robust to
> preemption since it stores the lazy mode state in a per-cpu structure
> and does not attempt to manage that state on task switch.
> 
> Powerpc had the same issue and fixed it by explicitly disabling
> preemption in arch_enter_lazy_mmu_mode() and re-enabling in
> arch_leave_lazy_mmu_mode(). See commit b9ef323ea168 ("powerpc/64s:
> Disable preemption in hash lazy mmu mode").
> 
> Given Sparc's lazy mmu mode is based on powerpc's, let's fix it in the
> same way here.
> 
> Fixes: 38e0edb15bd0 ("mm/apply_to_range: call pte function with lazy updates")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/sparc/mm/tlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 8648a50afe88..a35ddcca5e76 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -52,8 +52,10 @@ void flush_tlb_pending(void)
>  
>  void arch_enter_lazy_mmu_mode(void)
>  {
> -	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
> +	struct tlb_batch *tb;
>  
> +	preempt_disable();
> +	tb = this_cpu_ptr(&tlb_batch);
>  	tb->active = 1;
>  }
>  
> @@ -64,6 +66,7 @@ void arch_leave_lazy_mmu_mode(void)
>  	if (tb->tlb_nr)
>  		flush_tlb_pending();
>  	tb->active = 0;
> +	preempt_enable();
>  }
>  
>  static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,

Acked-by: Andreas Larsson <andreas@gaisler.com>

Thanks,
Andreas
