Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AB3D333B
	for <sparclinux@vger.kernel.org>; Wed, 25 Feb 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041321; cv=none; b=WuXaCW7b029J60D86XZX7kRg2ylserpDeugeSd4PeC/9+L8QfPch3DiE8NVXjdzRGU4w8py8FdwyHWuIo4JMbtVOS4ETT037e1NGeA5osV5f/L9mCL5dUZKpLo6iB86lapRBYItkhWSikopjulQje5lqOOp3K2nhThyP9xVZyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041321; c=relaxed/simple;
	bh=jOatpcXoBL6KLZUfPVa5YPNNuKV2Y/R+E7YOi+QvXiQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=XDarCjWz1e4FJ6hQuu2yXfyrHOQBLtANm/WbOUEU+MmaDZ5oC9mehkTfCXGEJBKZx9L0jXmCAvRfxSaDBZoweoF2RTyuYseGMUMShBU0VosN8WsCs4GRPGUmJ4IRs8aw4dFnH/Vo3tQlVNFpVfYHAcU7fKah+86MjGRSxd4zlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaQIE8Rb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaQIE8Rb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824a829f9bbso30075b3a.0
        for <sparclinux@vger.kernel.org>; Wed, 25 Feb 2026 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772041318; x=1772646118; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMnEPXSeAknTUn6pBGQAEqhzdOlacieP4zL+mwxArg0=;
        b=CaQIE8RbUyOkoSmCFKRJbZFjSrsqh7x5RlwDFyyFM18qmlqolP18GUAVZ+nv7t1Sqh
         vvWPA6H0Mf3pi4ZiJ7bNTkD4+Eurf4Zic+DGsXTM4pDTnd+Tsyo0aYU218udYhfFIKyU
         y90NmHECCwix96rOl+KiN/9KZ7fbxIenwLU0a9VlWNYJnt9GtMZi2hv+JSZSmHNsCfR8
         45o3xwEnksJFn5XKsblVX/wJP9HObSM0yTg5ZE1OQ2UQTUOI0AsZAaqxUAqV7n+0f1v1
         tte6sRIph189lX7Fazv2FXMqbFTl0s5jH8a63L8aZcclp3Uv4Uf3tKmjvZz8WyPkQGvt
         f08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772041318; x=1772646118;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMnEPXSeAknTUn6pBGQAEqhzdOlacieP4zL+mwxArg0=;
        b=BlfX7Ko17HLL7lBaT+CQ0G7MymhhbB5wITPulRGC7kerXaf0EVaNVYGu2hSb5K0gRA
         7Rqk93XHVx7503PxupSVag7pS151MU/yuEabJYdjGsxG8M+XAoHyR1lSmIKM2EmcO6tN
         djAtrJswOrZ/a8mnYQDkOl9ZVNPvgg3H7tyvqaa6MWRBw6dAz1PU6qSsSQU4BL4eE3YA
         ChWL2mBtZPLztVVBoA44jZmzBxFIsqziP3daz+pxLLJKVP0YgwCNCPVs9oT/pLYTLAyK
         Sj2yY1STMt3zZJr9EsiYS9i6W5WL4pVrHDPSAJr2TOaZ2PcSpyuhcpQOGhoaYIv3s4R+
         nFHA==
X-Forwarded-Encrypted: i=1; AJvYcCW6hITPRoXySm3pepOrGqDW4DQiVY3Yod/7+CUgxnRi5QSyFZQK6sgz/Ef67jK0I9vdLrW9rhKWM+0Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyG610XOtOeLArLxyqDPZGITfXQKLcYLJxBWRZ1OnwIBLZELHwK
	2nWl71v4KcCA+iB5uOZHpZ3x5DF+4XRELCZgPq2CPH+s01YL1+BXJcbuppTvRJ1+
X-Gm-Gg: ATEYQzzq15E6z36V0seX8mWULRtkotpRMqYaHmXMC9Vn4WiCpWvaijgHvsWB5TxutHY
	o0R0g2GV7+XtrOvY345H+DqO9cAArfq9myHeTeWE64a+ORV1OlfXfI1iyaigIDNEIT9B+E6U5h5
	+Y7LqEVFARFYGs4YmIUmtqwxuarmyExBqSEHX3lTRoiQ25GHw03q5PghQkYmYfb+nngbwatzTRG
	U1Au+PeWJYd7xoZIpgQqflHkFzqWddDRuSyWFyUNkg/0ihKrbEfCAaPTkZpiqt0CWjGp2uMhKOU
	UDHEnO2HqZ6jp6clGcRMhmEPQqLSajMLbDwVvcsyXTiZTIopQ+ieSY/Kb6PrnY4mjrWp82YW7/x
	42l23yUl+Tpv1GFaZBDgJAIxKLQ2osCVUB3dsP6yEnD6yFsy8ibaHuv4qVcg4iY+de2TIc+G3rL
	IkhCmpQU6wEulQwIA9fA==
X-Received: by 2002:a05:6a21:3290:b0:38d:edd4:2fbe with SMTP id adf61e73a8af0-39545ed058emr15020115637.31.1772041317482;
        Wed, 25 Feb 2026 09:41:57 -0800 (PST)
Received: from dw-tp ([203.81.243.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8fdb81sm14825760b3a.64.2026.02.25.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:41:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 24/29] arch, mm: consolidate initialization of SPARSE memory model
In-Reply-To: <aZ8idANginXzhf0_@kernel.org>
Date: Wed, 25 Feb 2026 23:08:38 +0530
Message-ID: <87seaohgf5.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-25-rppt@kernel.org> <87tsv5h544.ritesh.list@gmail.com> <aZ8idANginXzhf0_@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> Hello Ritesh,
>
> On Wed, Feb 25, 2026 at 09:00:35AM +0530, Ritesh Harjani wrote:
>> Mike Rapoport <rppt@kernel.org> writes:
>> 
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > Every architecture calls sparse_init() during setup_arch() although the
>> > data structures created by sparse_init() are not used until the
>> > initialization of the core MM.
>> >
>> > Beside the code duplication, calling sparse_init() from architecture
>> > specific code causes ordering differences of vmemmap and HVO initialization
>> > on different architectures.
>> >
>> > Move the call to sparse_init() from architecture specific code to
>> > free_area_init() to ensure that vmemmap and HVO initialization order is
>> > always the same.
>> >
>> 
>> Hello Mike,
>> 
>> [    0.000000][    T0] ------------[ cut here ]------------
>> [    0.000000][    T0] WARNING: arch/powerpc/include/asm/io.h:879 at virt_to_phys+0x44/0x1b8, CPU#0: swapper/0
>> [    0.000000][    T0] Modules linked in:
>> [    0.000000][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.19.0-12139-gc57b1c00145a #31 PREEMPT
>> [    0.000000][    T0] Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected) 0x801200 0xf000006 of:SLOF,git-ee03ae pSeries
>> [    0.000000][    T0] NIP:  c000000000601584 LR: c000000004075de4 CTR: c000000000601548
>> [    0.000000][    T0] REGS: c000000004d1f870 TRAP: 0700   Not tainted  (6.19.0-12139-gc57b1c00145a)
>> [    0.000000][    T0] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 48022448  XER: 20040000
>> [    0.000000][    T0] CFAR: c0000000006016c4 IRQMASK: 1
>> [    0.000000][    T0] GPR00: c000000004075dd4 c000000004d1fb10 c00000000304bb00 c000000180000000
>> [    0.000000][    T0] GPR04: 0000000000000009 0000000000000009 c000000004ec94a0 0000000000000000
>> [    0.000000][    T0] GPR08: 0000000000018000 0000000000000001 c000000004921280 0000000048022448
>> [    0.000000][    T0] GPR12: c000000000601548 c000000004fe0000 0000000000000004 0000000000000004
>> [    0.000000][    T0] GPR16: 000000000287fb08 0000000000000060 0000000000000002 0000000002831750
>> [    0.000000][    T0] GPR20: 0000000002831778 fffffffffffffffd c000000004d78050 00000000051cbb00
>> [    0.000000][    T0] GPR24: 0000000005a40008 c000000000000000 c000000000400000 0000000000000100
>> [    0.000000][    T0] GPR28: c000000004d78050 0000000000000000 c000000004ecd4a8 0000000000000001
>> [    0.000000][    T0] NIP [c000000000601584] virt_to_phys+0x44/0x1b8
>> [    0.000000][    T0] LR [c000000004075de4] alloc_bootmem+0x144/0x1a8
>> [    0.000000][    T0] Call Trace:
>> [    0.000000][    T0] [c000000004d1fb50] [c000000004075dd4] alloc_bootmem+0x134/0x1a8
>> [    0.000000][    T0] [c000000004d1fba0] [c000000004075fac] __alloc_bootmem_huge_page+0x164/0x230
>> [    0.000000][    T0] [c000000004d1fbe0] [c000000004030bc4] alloc_bootmem_huge_page+0x44/0x138
>> [    0.000000][    T0] [c000000004d1fc10] [c000000004076e48] hugetlb_hstate_alloc_pages+0x350/0x5ac
>> [    0.000000][    T0] [c000000004d1fd30] [c0000000040782f0] hugetlb_bootmem_alloc+0x15c/0x19c
>> [    0.000000][    T0] [c000000004d1fd70] [c00000000406d7b4] mm_core_init_early+0x7c/0xdf4
>> [    0.000000][    T0] [c000000004d1ff30] [c000000004011d84] start_kernel+0xac/0xc58
>> [    0.000000][    T0] [c000000004d1ffe0] [c00000000000e99c] start_here_common+0x1c/0x20
>> [    0.000000][    T0] Code: 6129ffff 792907c6 6529ffff 6129ffff 7c234840 40810018 3d2201e8 3929a7a8 e9290000 7c291840 41810044 3be00001 <0b1f0000> 3d20bfff 6129ffff 792907c6
>> 
>> 
>> I think this is happening because, now in mm_core_early_init(), the
>> order of initialization between hugetlb_bootmem_alloc() and
>> free_area_init() is reversed. Since free_area_init() -> sparse_init()
>> is responsible for setting SECTIONS and vmemmap area. 
>> 
>> Then in alloc_bootmem() (from hugetlb_bootmem_alloc() path), it uses virt_to_phys(m)...
>> 
>> 			/*
>> 			 * For pre-HVO to work correctly, pages need to be on
>> 			 * the list for the node they were actually allocated
>> 			 * from. That node may be different in the case of
>> 			 * fallback by memblock_alloc_try_nid_raw. So,
>> 			 * extract the actual node first.
>> 			 */
>> 			if (m)
>> 				listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
>> 
>> 
>> ... virt_to_phys on powerpc uses:
>> 
>> static inline unsigned long virt_to_phys(const volatile void * address)
>> {
>> 	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
>> 
>> 	return __pa((unsigned long)address);
>> }
>> 
>> #define virt_addr_valid(vaddr)	({					\
>> 	unsigned long _addr = (unsigned long)vaddr;			\
>> 	_addr >= PAGE_OFFSET && _addr < (unsigned long)high_memory &&	\
>> 	pfn_valid(virt_to_pfn((void *)_addr));				\
>> })
>> 
>> 
>> I think the above warning in dmesg gets printed from above WARN_ON, i.e.
>> because pfn_valid() is false, since we haven't done sparse_init() yet.
>
> Yes, I agree.
>  
>> So, what I wanted to check was - do you think instead of virt_to_phys(), we
>> could directly use __pa() here() in mm/hugetlb.c, since these are
>> memblock alloc addresses? i.e.: 
>> 
>> // alloc_bootmem():
>> -   listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
>> +   listnode = early_pfn_to_nid(PHYS_PFN(__pa(m)));
>> 
>> // __alloc_bootmem_huge_page():
>> -   memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
>> +   memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),
>
> It surely will work for powerpc :)
> I checked the definitions of __pa() on other architectures and it seems the
> safest and the easiest way to fix this.
>  
> Would you send a formal patch?
>

Thanks Mike for taking a look at above and confirming. Sure, let me
prepare the patch and send it by tomorrow. 

-ritesh
