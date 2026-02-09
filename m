Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B3318B88;
	Mon,  9 Feb 2026 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626480; cv=none; b=RvoOAdtG3QwHhSb55a5y00/ryqZqjD1ZIgYnCpKRNhPqowwMnNKvBPW8ZoBFBal0P2s4YwEZlMMJaHUo3zQuZ3SvmfaktwNZPHRzUu255Wtp32XzK9XYyT5/OxZaY7GujGgrGEfAT3+ceWXaYCfuIvSa7UgC07TIcwneqnl2PeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626480; c=relaxed/simple;
	bh=Ur8MMKMlRrHxc9ho6lhi1t4ZwOyO4jvvkEb91o2ZzHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/1DDSOKATLtUPkMZz0MHo1q+Wp7JLC3Ako9KI/BGVp78EJSKWdS8Izu9DpDKJ94oN+JoCBsl5LBexPOaIb+vKJV089rRQYqt2//SCh/hcG+Eui+VcHJIkg+NsEkfZuZgkM/VzfymajhM4PAPzL/0ma0hcUw8dNfuTtNeGhHsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=OzGhPxF4 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="OzGhPxF4"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f8dT35MpPz1DDXV;
	Mon,  9 Feb 2026 09:41:11 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f8dT110xZz1DDXf;
	Mon,  9 Feb 2026 09:41:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770626471;
	bh=RbC+RKpRL3vyZA9rhFwXc+s3LnlBOMIWZ1+a+rfNhok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OzGhPxF4b1JTlL0uvUgojBuLGl/d8Dy9MJzVSCLeT/MydG7knOZy+3rxTsSLXE0fa
	 Fe8HpYTWVqRUTnGYcY3oAZB1G1mG+IVuTFOS7+WqJBz1ilC5nvTR8TovjKYRzf+P2w
	 Ww4xwxi029qA+7zIuREjyi1oyTjnneeeu19Nl05HHLco+NvnhYBsugXIxVmZ8+yauy
	 xXkbpOW82Lh5ONVHEwDikWUcNveQWPl7uCMf/FTqxIDhDMLT/JU43EG3ChwZ3W9qcL
	 8U/FowPM9gwj9XED74iSkSmiVCadg33Ys0HHbcY4Truz0z7WWFA4WvlePWVs4XcxTs
	 tU6jXEQEdNbzw==
Message-ID: <55bef6c2-de81-4b60-b6df-5ef733b54dee@gaisler.com>
Date: Mon, 9 Feb 2026 09:41:08 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20260124095628.668870-1-rppt@kernel.org>
 <2157220c-0394-40fa-9918-a8514171bd10@gaisler.com>
 <aXj_x5CyUeys7ONM@kernel.org>
 <ec965a79-dad8-4358-a8e9-ebc9f330b67b@gaisler.com>
 <aYcVu7gs65S1CeST@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <aYcVu7gs65S1CeST@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-07 11:36, Mike Rapoport wrote:
>> Unfortunately, that does not help. The LDOM goes down in the same fashion.
> 
> Apparently something is wrong with my pointer arithmetics :/
> 
> Can you try this one instead?
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 74ede706fb32..615f460c50af 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -210,6 +210,9 @@ extern unsigned long _PAGE_CACHE;
>  extern unsigned long pg_iobits;
>  extern unsigned long _PAGE_ALL_SZ_BITS;
>  
> +extern struct page *mem_map_zero;
> +#define ZERO_PAGE(vaddr)	(mem_map_zero)
> +
>  /* PFNs are real physical page numbers.  However, mem_map only begins to record
>   * per-page information starting at pfn_base.  This is to handle systems where
>   * the first physical page in the machine is at some huge physical address,
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 2bd99944176d..aa1f9f071fb2 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -177,6 +177,9 @@ extern unsigned long sparc_ramdisk_image64;
>  extern unsigned int sparc_ramdisk_image;
>  extern unsigned int sparc_ramdisk_size;
>  
> +struct page *mem_map_zero __read_mostly;
> +EXPORT_SYMBOL(mem_map_zero);
> +
>  unsigned int sparc64_highest_unlocked_tlb_ent __read_mostly;
>  
>  unsigned long sparc64_kern_pri_context __read_mostly;
> @@ -2495,6 +2498,9 @@ static void __init register_page_bootmem_info(void)
>  }
>  void __init mem_init(void)
>  {
> +	phys_addr_t zero_page_pa = kern_base +
> +		((unsigned long)&empty_zero_page[0] - KERNBASE);
> +
>  	/*
>  	 * Must be done after boot memory is put on freelist, because here we
>  	 * might set fields in deferred struct pages that have not yet been
> @@ -2503,6 +2509,12 @@ void __init mem_init(void)
>  	 */
>  	register_page_bootmem_info();
>  
> +	/*
> +	 * Set up the zero page, mark it reserved, so that page count
> +	 * is not manipulated when freeing the page from user ptes.
> +	 */
> +	mem_map_zero = pfn_to_page(PHYS_PFN(zero_page_pa));
> +
>  	if (tlb_type == cheetah || tlb_type == cheetah_plus)
>  		cheetah_ecache_flush_init();
>  }
> 

With that one, things work fine.

Cheers,
Andreas

