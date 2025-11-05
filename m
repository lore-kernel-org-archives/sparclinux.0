Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC625DB1C
	for <sparclinux@vger.kernel.org>; Wed,  5 Nov 2025 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314119; cv=none; b=X4bp3CAKBvUsBn7TkwayHx+WR1o1F38zlx+j3lZurWXigWQsLo2H9WvmL8QdNdBUDtJQA52Zek/xgj0WN/fTRl8N68STMYVaSkNKhd/nISvVegm7R2Z7lMz9E1iGo5y/E2ekUVJoHWne6k8rfjKCYEUnQCw5Yia2rE9LZPG7y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314119; c=relaxed/simple;
	bh=A7T7h1LobUivdMEwPvmLCL0uHKn/vDln9L++QIr/1v8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=owFGZNPr1MohVTPQN0EJr/eqe6EONKG7+sdPDHKKpqSI4mth76JlwthcVt+8dWwehvk80lSKJqV8wnn3ky4IWqS4cNCliRh+uJNC3kAECRZ7B7ZnJykqwrwHyw+Uw5aj8lmzqCuBGMsJtx9oqVgtFwXuF2i2SwJVQrmJSu3DFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZi7d2sU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZi7d2sU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2951a817541so70502735ad.2
        for <sparclinux@vger.kernel.org>; Tue, 04 Nov 2025 19:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762314117; x=1762918917; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PpcYW9rXkka09Jy11m9xJQRt/n8jdZMdqOTeKYVeZk=;
        b=VZi7d2sUgMaFcZboFmJzXN6+BycKSs/it+WL0w1wuJbbtKEkYvFP1k6V/6dERNrJdp
         TqmP/eRybHARHG1kDdqHRYKJmHV8TjTt49/FkRpt85rTK2+sSEiQWRXEJ6zo58dgNzqd
         FwgwPtJV/BLJTl6aL2Psc2L1Te0M4nVyvoxJAttGB464xD3/5yQl3xouyCx4NrjcHIlq
         X/LYJEREmMC2yZ5egAY0Ez964tCXaqRstPPkg7x4I/2B9EaofJCiXQvSvErS1q3fMlFa
         1NKQSBdorRwBVVsU+aByxRbl4YsyTcG+fbuXOaWmoPRDKth1qsXVB41eU9ZI1FOYZOxa
         zwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762314117; x=1762918917;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PpcYW9rXkka09Jy11m9xJQRt/n8jdZMdqOTeKYVeZk=;
        b=gvWQrpBBTd1LaPXDGU+v/oL7fH0Mhe4KkBX2V1Mij0ipgk9g9hZow3vE6L9jeiadoD
         YrE8JZo3QeoT2zI3vGp4srGP90ma9Waky066Ld75Tx7O4CuBh2iCFLbGMOmS4XaVHviU
         fjWLkaKfSV6vrwgKu0bX1sHVIolB6s+/MB5CDkcTOn1CCDc53Af0y7ZzET/AIE/SPIXn
         sPAwuZBEzv+oT32E4pqDgdOH2mDxsYucPAJLJDUHwd/gxJq367JjqqnWChwX15Z6GRvt
         bpqzvCnsbtcndVj80yOxHx0w7TUDXhEW5AFsfnNnNByiAwkbJd7Vmek0LUxgXo3ij+Z/
         BdpA==
X-Forwarded-Encrypted: i=1; AJvYcCXu0HLfsz/oDmja+IJX+wPpdB+A1jubZBAYNs64ZMwChbwS6xxhzPOuO3xm2vCsD+p0ltd62QGBbrgU@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGO6l8QLWWunyYXZ4UfRjkav8m/9dWl6bcGa6e9UJidG44mW0
	cYewUxToToYGz+ZmDMNGkzO9pX7Akhq1pBPwpuSBDfuOcHaVsHqW2AC0
X-Gm-Gg: ASbGnctnke0xAW4LzhT2atIvI/qVmfAZ/fH6dBm619YaBJM7bF00xRehWqlO9d9DmeT
	5d0gOSHLfvx4YuGJaGTxNw6rynn+FMl5/KeId0TJO3vNsycKF+7M7H90Ea3e5R7o38yCPt/EhTF
	48zFcqhlgmK1vXH1bkxW8KFFd6dLWc0vFpuYOOmdxB6yPzqz9/bjmNgsfNHrhKOKrDK2trmwOnV
	L/iYpcIsFZjzXxkV4/z9ZbQJta5FsmLZznSsN+28xqv/vM7wFYj+lolTFmaaIEsXZ5N4UKhOpSQ
	jwlohwh37NqgGaeHFm0G9HEj+6fg6Rd/mgEtPpsFeVQLxuGsM6XCPI8GUhqzfpnRa3hfMP71xJr
	hVIhsVWA4WyjKoIfD1Whv+opDE3IJ4a42Uq5VTEo6ObIpD1G8aN7E8HtLquvoQ4bFchq/Dg==
X-Google-Smtp-Source: AGHT+IHU+u4c4m70sp/Km2qphWV2GETQaiqBJlBLQ9oH8KuDbSRxjLHzXNgoB+GOOUcEEs7QOw2HMQ==
X-Received: by 2002:a17:903:944:b0:295:7f1d:b02d with SMTP id d9443c01a7336-2962ad3340fmr26429125ad.22.1762314116721;
        Tue, 04 Nov 2025 19:41:56 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a61418sm43663725ad.96.2025.11.04.19.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 19:41:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v4 03/12] powerpc/mm: implement arch_flush_lazy_mmu_mode()
In-Reply-To: <20251029100909.3381140-4-kevin.brodsky@arm.com>
Date: Wed, 05 Nov 2025 08:45:06 +0530
Message-ID: <87pl9x41c5.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-4-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> Upcoming changes to the lazy_mmu API will cause
> arch_flush_lazy_mmu_mode() to be called when leaving a nested
> lazy_mmu section.
>
> Move the relevant logic from arch_leave_lazy_mmu_mode() to
> arch_flush_lazy_mmu_mode() and have the former call the latter.
>
> Note: the additional this_cpu_ptr() on the
> arch_leave_lazy_mmu_mode() path will be removed in a subsequent
> patch.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  .../powerpc/include/asm/book3s/64/tlbflush-hash.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> index 146287d9580f..7704dbe8e88d 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
> @@ -41,6 +41,16 @@ static inline void arch_enter_lazy_mmu_mode(void)
>  	batch->active = 1;
>  }
>  
> +static inline void arch_flush_lazy_mmu_mode(void)
> +{
> +	struct ppc64_tlb_batch *batch;
> +
> +	batch = this_cpu_ptr(&ppc64_tlb_batch);
> +
> +	if (batch->index)
> +		__flush_tlb_pending(batch);
> +}
> +

This looks a bit scary since arch_flush_lazy_mmu_mode() is getting
called from several of the places in later patches(). 

Although I think arch_flush_lazy_mmu_mode() will only always be called
in nested lazy mmu case right?

Do you think we can add a VM_BUG_ON(radix_enabled()); in above to make
sure the above never gets called in radix_enabled() case. 

I am still going over the patch series, but while reviewing this I
wanted to take your opinion.

Ohh wait.. There is no way of knowing the return value from
arch_enter_lazy_mmu_mode().. I think you might need a similar check to
return from arch_flush_lazy_mmu_mode() too, if radix_enabled() is true.


-ritesh


>  static inline void arch_leave_lazy_mmu_mode(void)
>  {
>  	struct ppc64_tlb_batch *batch;
> @@ -49,14 +59,11 @@ static inline void arch_leave_lazy_mmu_mode(void)
>  		return;
>  	batch = this_cpu_ptr(&ppc64_tlb_batch);
>  
> -	if (batch->index)
> -		__flush_tlb_pending(batch);
> +	arch_flush_lazy_mmu_mode();
>  	batch->active = 0;
>  	preempt_enable();
>  }
>  
> -#define arch_flush_lazy_mmu_mode()      do {} while (0)
> -
>  extern void hash__tlbiel_all(unsigned int action);
>  
>  extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
> -- 
> 2.47.0
