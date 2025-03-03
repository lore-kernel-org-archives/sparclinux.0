Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229E21148A;
	Mon,  3 Mar 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009188; cv=none; b=S65dIq9u+ygmuGsCi7QHaz39Yj8h5B/qxujqvRjE9YKMpVL7fcmqyCzcCci/XMQGv1I13RIlkcV4mBbmGEqQUFU7SITyFpFjUx4sqS20drRvnzgoRNkEZ1F2XSte7BaS2NOd6O8vq0iVoaamhebKSASeKAVm4SGUwc3qqVeR4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009188; c=relaxed/simple;
	bh=o+ts1pt/FQ0CGJdP3sC0rV01GDi3wTNTC2H3kxq4b90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqS7WfwCCX5yDgwJ/MbZqayNzVCbe/WXdam9yWxPKr1N5rwC3URguhwvpZdLBSEuKNhccVBIDO7Z9iuJ4IEpwFOOIbVW1mg+bRnaPLE77ljlcdDhYW8KcdIFmCXxnBZoM/45gtSKwmDrhfKyhcm1jmdCCZDo+HLzTWHkrp+ogs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=p0KolgJx; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="p0KolgJx"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Z60Kp3w73z1FbbW;
	Mon,  3 Mar 2025 14:39:42 +0100 (CET)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Z60Kn4PqSz1Fb3J;
	Mon,  3 Mar 2025 14:39:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1741009182;
	bh=U9UNcI/nx3v8USmf6+dAWPsF1rNLmjoWXEBhsh+2uHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=p0KolgJx4p9btvk6fYlk/66A1PpkCAcDXoLwwd13tXWlLgCyaTRqeAZoowkRKGUcz
	 a93BO8cm7m7V9NR5W2AabYKC+pmXp6QfOyzdLHkjLMMme9YAVr/Jk545VauJVRJBRF
	 f0+BgLYnD++BR/MTcLl9Jh8F872XyJXNOzOZA4ck=
Message-ID: <f99125f1-e4e4-4ee8-909d-8e8d0618d54b@gaisler.com>
Date: Mon, 3 Mar 2025 14:39:40 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] sparc/mm: Avoid calling
 arch_enter/leave_lazy_mmu() in set_ptes
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
 <20250302145555.3236789-4-ryan.roberts@arm.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250302145555.3236789-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-02 15:55, Ryan Roberts wrote:
> With commit 1a10a44dfc1d ("sparc64: implement the new page table range
> API") set_ptes was added to the sparc architecture. The implementation
> included calling arch_enter/leave_lazy_mmu() calls.
> 
> The patch removes the usage of arch_enter/leave_lazy_mmu() since this
> implies nesting of lazy mmu regions which is not supported. Without this
> fix, lazy mmu mode is effectively disabled because we exit the mode
> after the first set_ptes:
> 
> remap_pte_range()
>   -> arch_enter_lazy_mmu()
>   -> set_ptes()
>       -> arch_enter_lazy_mmu()
>       -> arch_leave_lazy_mmu()
>   -> arch_leave_lazy_mmu()
> 
> Powerpc suffered the same problem and fixed it in a corresponding way
> with commit 47b8def9358c ("powerpc/mm: Avoid calling
> arch_enter/leave_lazy_mmu() in set_ptes").
> 
> Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/sparc/include/asm/pgtable_64.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 2b7f358762c1..dc28f2c4eee3 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -936,7 +936,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> -	arch_enter_lazy_mmu_mode();
>  	for (;;) {
>  		__set_pte_at(mm, addr, ptep, pte, 0);
>  		if (--nr == 0)
> @@ -945,7 +944,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte_val(pte) += PAGE_SIZE;
>  		addr += PAGE_SIZE;
>  	}
> -	arch_leave_lazy_mmu_mode();
>  }
>  #define set_ptes set_ptes

Acked-by: Andreas Larsson <andreas@gaisler.com>

Thanks,
Andreas
