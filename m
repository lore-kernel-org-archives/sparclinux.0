Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A430BBBB;
	Tue, 27 Jan 2026 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529771; cv=none; b=svvOIWfjoq1G/BZlYHTp788+MJDuVmE0MkwB4I01VnIzp4yXaAaqZdwcW0khrtQmTYyxEgnv7bMV2Y6UpTgAey4e+nf1wEXmmqBMnXkrhj8hTiRlPPJGBXr286aTDyGFM8DceBWTeusz77e58PB5bmT/rVSMFLSWohmbz0thvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529771; c=relaxed/simple;
	bh=ryzKYRbfcu3WHWMX8djpR6uvSuJDdabV/Aq6Tc+9sTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrEXAPFIT5JNqKI1cJXXmoLxCD8+660YaxvHgG76JNqvnF1o36BsIu1WsXtaE+LC0NukXIMRmYMZlauKzebjPn4IKB6y2KT6zHbZGCQBsOlPcX03lTAcKsWP6wVTayCB99sz31ffdyj7r2faV2ZxnG+mgULLm3JbndSa6sP4slI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=nF1rwIiB reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="nF1rwIiB"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0qtT3772z1DDT6;
	Tue, 27 Jan 2026 17:02:41 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0qtS1KPDz1DPkR;
	Tue, 27 Jan 2026 17:02:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769529761;
	bh=XjNhgAV5Uc7zjxVMNfRjSJ4NulgkiTn1O8FFUA42SJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nF1rwIiBmdMccnC6GLsJ+1cTxVIoLNBWUK2hRgllWz+vqzG3zn6qSGadd3ql/fc/j
	 wftmmd9opEasAb176XRKPUE8StMbl/6p+SplfVp5nf9nN1Js2h0Lp8VSMmtcQE30aH
	 Bl1zEaQxtIRA2e3e+l06MPu18XvsS1MAwBqoUlTwwd2s8vpthHuAcTJvSs6AHdaqC9
	 IvGbmsJblv3nhY89l91lTlG8IritYfepiywoeUokkcFJYOBd8jK3YPlU2kPdjCdp4y
	 HkLZ042uE8RsQsy76g2JHghhGJKUQuKXN/sEzVbuaQAH2qMCw8MbIO603QZ3+XYxw6
	 58WjXFSREqUIw==
Message-ID: <2157220c-0394-40fa-9918-a8514171bd10@gaisler.com>
Date: Tue, 27 Jan 2026 17:02:39 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
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
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260124095628.668870-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-24 10:56, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
> 
> Every architecture defines empty_zero_page that way or another, but for the
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
> 
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to the
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
> 
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
> 
> For the most part the change is mechanical, with these being noteworthy:
> 
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boot
>   parameters. Switching to a generic empty_zero_page removes the aliasing
>   and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>   ZERO_PAGE() is kept intact.
> * m68k/parisc/sparc64/um: allocated empty_zero_page from memblock,
>   although they do not support zero page coloring and having it in BSS
>   will work fine.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>   Rename the parameters page to boot_params_page and let sh use the generic
>   empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
> 
> 	/* A handy thing to have if one has the RAM. Declared in head.S */
> 
>   that unfortunately had to go :)
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

Running this in an LDOM on an UltraSparc T4 sparc64, the entire LDOM
hangs after a while during boot.


> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index c2d19c9a9244..2bd99944176d 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -177,9 +177,6 @@ extern unsigned long sparc_ramdisk_image64;
>  extern unsigned int sparc_ramdisk_image;
>  extern unsigned int sparc_ramdisk_size;
>  
> -struct page *mem_map_zero __read_mostly;
> -EXPORT_SYMBOL(mem_map_zero);
> -
>  unsigned int sparc64_highest_unlocked_tlb_ent __read_mostly;
>  
>  unsigned long sparc64_kern_pri_context __read_mostly;
> @@ -2506,18 +2503,6 @@ void __init mem_init(void)
>  	 */
>  	register_page_bootmem_info();
>  
> -	/*
> -	 * Set up the zero page, mark it reserved, so that page count
> -	 * is not manipulated when freeing the page from user ptes.
> -	 */
> -	mem_map_zero = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
> -	if (mem_map_zero == NULL) {
> -		prom_printf("paging_init: Cannot alloc zero page.\n");
> -		prom_halt();
> -	}
> -	mark_page_reserved(mem_map_zero);
> -
> -
>  	if (tlb_type == cheetah || tlb_type == cheetah_plus)
>  		cheetah_ecache_flush_init();
>  }

This just removes the mark_page_reserved(mem_map_zero) without 
replacing it with something corresponding to that. Perhaps part
of the problem?

Cheers,
Andreas

