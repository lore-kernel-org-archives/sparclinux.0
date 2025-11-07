Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBA1CAA4;
	Fri,  7 Nov 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518711; cv=none; b=lIe9AMH8y3/DjCLKDyBGAZY8BUANhihY0pvcipeaB0d7725svUEkFEdJvV1v3RfBo9UArsgsA/R6hl9R8YxwE0SPvpt/ZkKBYi17ezPD0GX6etuGDnfIMU6SMpuhWq3ZNnEi99V2XG4h3H58faSSeGvr+om1uLqX5JW9U6UGrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518711; c=relaxed/simple;
	bh=jDhnnL1mbLxHOdUJ9Vwg0lyUo1zeA2DyfHoHkqmSSr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3//MQv/OlKDGt3B7BeB22hKhnNA1z6Ucwv5xaCnZO2L3o2enP7+JWnKLpvkiZ67D7f9kDPrp1gNRMMrrJxf+zCxPqNGlwP/brY6nwCvpT8L5kwaOjq9BsRIMbaSNT637nNp7OlSlSdNFV0oMB+9/8Kpu8jBst+5XGxAicWx3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C3C81516;
	Fri,  7 Nov 2025 04:31:41 -0800 (PST)
Received: from [10.57.86.134] (unknown [10.57.86.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412D63F66E;
	Fri,  7 Nov 2025 04:31:44 -0800 (PST)
Message-ID: <b165098a-8164-4664-aaaf-1e8c4391d797@arm.com>
Date: Fri, 7 Nov 2025 12:31:42 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] x86/xen: simplify flush_lazy_mmu()
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-3-kevin.brodsky@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251029100909.3381140-3-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 10:08, Kevin Brodsky wrote:
> arch_flush_lazy_mmu_mode() is called when outstanding batched
> pgtable operations must be completed immediately. There should
> however be no need to leave and re-enter lazy MMU completely. The
> only part of that sequence that we really need is xen_mc_flush();
> call it directly.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

This looks functionally equivalent to me, so:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

But I don't think this tidy up is strictly necessary for your series to work?
(perhaps I'll change my mind on that as I go through it).

> ---
>  arch/x86/xen/mmu_pv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 2a4a8deaf612..7a35c3393df4 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2139,10 +2139,8 @@ static void xen_flush_lazy_mmu(void)
>  {
>  	preempt_disable();
>  
> -	if (xen_get_lazy_mode() == XEN_LAZY_MMU) {
> -		arch_leave_lazy_mmu_mode();
> -		arch_enter_lazy_mmu_mode();
> -	}
> +	if (xen_get_lazy_mode() == XEN_LAZY_MMU)
> +		xen_mc_flush();
>  
>  	preempt_enable();
>  }

