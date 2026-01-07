Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62E25A655
	for <sparclinux@vger.kernel.org>; Wed,  7 Jan 2026 04:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767761905; cv=none; b=U00NOuK/ToPHpD/m57VYpmShNbYxvaYjNx5VofkpxN2lXPOhko7SPnvz9kkcdF+dpOMlNQdEpCOxKxJbC0SZHbi37c1s9P02MJqyGExUpnuQ363ZS3/+KGT8sJF3ckSrpGx6EIZhhj4wk7stOxH0B2WwJxB2/2bobgaacZ3rjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767761905; c=relaxed/simple;
	bh=u52IYXtkIGi8sisrJ2GXaZQiFovGjOBhfJtTiCU+FIM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=f3ClpozWFVypuJGp/HFpMLtPNkR3UXEVdB2GY9eNlddcPSqOFxI/GjuxxqiEJ8BlDa8XoUbx6MdAOLodSZ5kyvae81t8noyRxW68h8EV9WRISFbaRy39/d3dgCt460HLJ22CgQtR813LX5wYoxiJH5BTBCS6zgV9YgQjybin/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE9OHB7K; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE9OHB7K"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so1496605a91.1
        for <sparclinux@vger.kernel.org>; Tue, 06 Jan 2026 20:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767761902; x=1768366702; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nurUXHNs091EaceKYt0jtxQiBJ2IaAdTDr7CGJ+zWBU=;
        b=XE9OHB7Kl+IegOavGwsCniq7IfH569pyWSwOB3GH4IFakEzMoVU0qTAM99Htm/LTZa
         oIrdXqofABAYlYf0vbgd+n0GUNiJzVIPiyO8CScU6yhPMURk/UDM/RVMGFEztgjtLPNS
         WRPiIEJnD0Ff9/Z8WNMKc7Anw6/nMx8MAbq3s3xv9xn+5m1oNJCX1ktobB6O3+C+tCKf
         0dT43+gSNEm71HVEC9CZgI8klLsPbgoiQqrHQwigH/O6I0GQ3Ti8owh0piXgvhZN4xe2
         1m7D9Rr/nZ33sxwqrbUB/YINiEIurizt1znhUcLNHdGYLs9ErvXCDeFUGjhnGu4pVoK6
         wLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767761902; x=1768366702;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nurUXHNs091EaceKYt0jtxQiBJ2IaAdTDr7CGJ+zWBU=;
        b=IwY+kO4n+90+odCQRePR74+f962Gl2GZIOhSdNpBaQOh8fnYRqLilhjUNZefdMf9Mi
         UJq2kuMyRkpjPs3c0i3ztTtJilc/leB7mdOxtwLytWBxxY0UJzPlIFkDn0PVXS6TCZOC
         DAgIt6qvaZXRlN/dL2E0LQXkDScSRTXlvWrgUFE2G1hPvzOPyL36uDEubBYyK/i+LtcB
         an/vJNOzM9YEWJ5KwssliMtwAVnoeK+JuBiMRtMDLHqrdik0YmYQIWUUd6IGDIAKNr2d
         F00wqurwLKr1fSB9gMeyccagASYZjiDinC9ib3r7/q7YvNFUYx0Wjbu0d60waYwN3TN9
         owVw==
X-Forwarded-Encrypted: i=1; AJvYcCVBtFKNlXxAUasgJ8ZwPxzcOa2bfOKN6boogG/wBpLvqoTs9ZZZs7/flhbm3Jw+kECSHxM77M8kpDpL@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVAF28+HHOZyM2lbAjiaumDbrc08oeU4YGf/bs/d+hYQ2IEIS
	W6lgqvM1OxSP4Niba13McuTcBcDccVd79vEnXvPrfFJos3KrNgsl9qWrw6k/wVFislQ=
X-Gm-Gg: AY/fxX7kTpTH9z53Onmbt5xcR9bUMSDf1w2h+RQAPPicoOMNJsFDbenVLuXy15zz0aw
	vYklYqGweOY4FrpMamKdjSfBQCrXh6f+TSsTF1tjFVeasBu8TtScZcnMpz8OibIYC0+okocu4kH
	1zRbZMsu7iwuh673yOXXwHalVq1AfTcnEIkDxZB7Mb8f0DaXkfVYX7oeHtdsApJ79RfR1Hrb+fO
	owNZ/Poen5vowLV/4GisfyZwQu6oxuDu5RF3bmZ+X8DJJqUUGLRxcwAkoaKToTcHmQLgTlDcVXn
	Zhu3N7KeXGD54zdfXgN4YSs0OVxftwRKTEB8peQa+qpudWBhN8M18ZSHvWFu3EFEeKSoCcp94ms
	iytk3jIM7+MxHkNauVtf5p6x8i1GEVpGiYrCXiVtezjf4Hqn2MrV5ddF1q1RcAisWV9bx+ajrhn
	bXBzrqaw==
X-Google-Smtp-Source: AGHT+IE3iEJ4twso46GOnqJPDopUox2qFLaKHiDPKI95vlPPxjV/F7mxvaI/CeOE2s8GrRHRScEd6Q==
X-Received: by 2002:a17:90b:6c7:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-34f68d3b4a4mr1191743a91.33.1767761901762;
        Tue, 06 Jan 2026 20:58:21 -0800 (PST)
Received: from dw-tp ([49.207.192.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb75902sm3622895a91.16.2026.01.06.20.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 20:58:20 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 14/28] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260102070005.65328-15-rppt@kernel.org>
Date: Wed, 07 Jan 2026 09:57:34 +0530
Message-ID: <87ldia9he1.ritesh.list@gmail.com>
References: <20260102070005.65328-1-rppt@kernel.org> <20260102070005.65328-15-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 3ddbfdbfa941..32c496bfab4f 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -221,13 +221,23 @@ static int __init mark_nonram_nosave(void)
>   * anyway) will take a first dip into ZONE_NORMAL and get otherwise served by
>   * ZONE_DMA.
>   */
> -static unsigned long max_zone_pfns[MAX_NR_ZONES];
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
> +{
> +#ifdef CONFIG_ZONE_DMA
> +	max_zone_pfns[ZONE_DMA]	= min(zone_dma_limit, max_low_pfn - 1) + 1;

Hi Mike, 

This doesn't look correct. Isn't the zone_dma_limit value in bytes actually?
Shouldn't it be -

     max_zone_pfns[ZONE_DMA] = min((zone_dma_limit >> PAGE_SHIFT) + 1, max_low_pfn);


-ritesh


> +#endif
> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +#ifdef CONFIG_HIGHMEM
> +	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
> +#endif
> +}
>  
>  /*
>   * paging_init() sets up the page tables - in fact we've already done this.
>   */
>  void __init paging_init(void)
>  {
> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
>  	unsigned long long total_ram = memblock_phys_mem_size();
>  	phys_addr_t top_of_ram = memblock_end_of_DRAM();
>  	int zone_dma_bits;
> @@ -259,15 +269,7 @@ void __init paging_init(void)
>  
>  	zone_dma_limit = DMA_BIT_MASK(zone_dma_bits);
>  
> -#ifdef CONFIG_ZONE_DMA
> -	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> -				      1UL << (zone_dma_bits - PAGE_SHIFT));
> -#endif
> -	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> -#ifdef CONFIG_HIGHMEM
> -	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
> -#endif
> -
> +	arch_zone_limits_init(max_zone_pfns);
>  	free_area_init(max_zone_pfns);
>  
>  	mark_nonram_nosave();
> -- 
> 2.51.0

