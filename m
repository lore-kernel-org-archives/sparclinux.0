Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5C3009DA;
	Tue,  3 Feb 2026 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113845; cv=none; b=n5UJjUNIo8c0uOyLmxVXSSX1Yhu4objhvSZzQRdPl+NhWWDj5O7+y3ifuiGEmHuiVH/oxGXN51jMSWjWMwT8DcCgJ6v+6UPo23ZgGc+s1EdywEFHw61Q8iAVKaZYEDqr1XCs5yz77Yfr/Z6QtYcUkU36g+iou70qj98P59gi/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113845; c=relaxed/simple;
	bh=Vc2QbSixSsb2ON81jWvWOUH8cSKvDtILixarN96mqWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ckz2v1Qn+/FePy03CaPGxS922AvzU61+mJDsPgXrlBE0XXuVNa2Er2htQ4xvdSHt4K+J5GdRU1t95zWcApvnai+l9ukNcnS+aIv8fWZPcxdIn4Ndx462ZZRhMVNmCd2niR869h6QCGONgRTuqp/Q5P5lw99ZK4FJaEvrOhPfSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=lUAE2uVq reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="lUAE2uVq"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f4ztc2TZXz1DDMV;
	Tue,  3 Feb 2026 11:17:12 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f4ztY1CK4z1DHbc;
	Tue,  3 Feb 2026 11:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770113832;
	bh=bIz4RVwkv6KARy4MwQOhUdd22JeZFr0fFrNF7J4bRPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lUAE2uVqAzYhZ1sm97fYuqy+vlFYURoO/ESgRDOLYwoPcj+AJLYcKftxzXr+4y/HX
	 2YOyDda3zoXt+26+AX8pMM7QHh5T+XJuM4W03HRzJukix5g8rdsb/fjilKm09oxzSx
	 tBwy+nern6bg1a50/KfLMYddppMeG7txUbC4/AmsAXT1tuu3+smPwBXiUUqokjSpVv
	 UUsrhLX04O7HNQNLLVmIA6iNk0y72m91fWDt4UXVjn71WutyJfQfTM3K8uFvvtoUBz
	 jIXUHdgIYTlrZQBjHS4KV4lgMsEWYt8Uw9Kgk+K14XLmF28umAniXCSL8090kqia/S
	 lC0jknJm/j/RQ==
Message-ID: <ec965a79-dad8-4358-a8e9-ebc9f330b67b@gaisler.com>
Date: Tue, 3 Feb 2026 11:17:08 +0100
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
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <aXj_x5CyUeys7ONM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-27 19:11, Mike Rapoport wrote:
> On Tue, Jan 27, 2026 at 05:02:39PM +0100, Andreas Larsson wrote:
>> On 2026-01-24 10:56, Mike Rapoport wrote:
>>
>>> Every architecture defines empty_zero_page that way or another, but for the
>>> most of them it is always a page aligned page in BSS and most definitions
>>> of ZERO_PAGE do virt_to_page(empty_zero_page).
>>
>> Running this in an LDOM on an UltraSparc T4 sparc64, the entire LDOM
>> hangs after a while during boot.
>>
>>> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
>>> index c2d19c9a9244..2bd99944176d 100644
>>> --- a/arch/sparc/mm/init_64.c
>>> +++ b/arch/sparc/mm/init_64.c
>>> @@ -177,9 +177,6 @@ extern unsigned long sparc_ramdisk_image64;
>>>  extern unsigned int sparc_ramdisk_image;
>>>  extern unsigned int sparc_ramdisk_size;
>>>  
>>> -struct page *mem_map_zero __read_mostly;
>>> -EXPORT_SYMBOL(mem_map_zero);
>>> -
>>>  unsigned int sparc64_highest_unlocked_tlb_ent __read_mostly;
>>>  
>>>  unsigned long sparc64_kern_pri_context __read_mostly;
>>> @@ -2506,18 +2503,6 @@ void __init mem_init(void)
>>>  	 */
>>>  	register_page_bootmem_info();
>>>  
>>> -	/*
>>> -	 * Set up the zero page, mark it reserved, so that page count
>>> -	 * is not manipulated when freeing the page from user ptes.
>>> -	 */
>>> -	mem_map_zero = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
>>> -	if (mem_map_zero == NULL) {
>>> -		prom_printf("paging_init: Cannot alloc zero page.\n");
>>> -		prom_halt();
>>> -	}
>>> -	mark_page_reserved(mem_map_zero);
>>> -
>>> -
>>>  	if (tlb_type == cheetah || tlb_type == cheetah_plus)
>>>  		cheetah_ecache_flush_init();
>>>  }
>>
>> This just removes the mark_page_reserved(mem_map_zero) without 
>> replacing it with something corresponding to that. Perhaps part
>> of the problem?
> 
> I don't think so, empty_zero_page is in BSS now an it's reserved as a part
> of the kernel image.
> 
> I suspect that virt_to_page() does not work BSS symbols on sparc64. Can you
> please try with this patch:
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 74ede706fb32..0578c5172d4e 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -22,6 +22,7 @@
>  #include <asm/adi.h>
>  #include <asm/page.h>
>  #include <asm/processor.h>
> +#include <asm/vaddrs.h>
>  
>  /* The kernel image occupies 0x4000000 to 0x6000000 (4MB --> 96MB).
>   * The page copy blockops can use 0x6000000 to 0x8000000.
> @@ -210,6 +211,11 @@ extern unsigned long _PAGE_CACHE;
>  extern unsigned long pg_iobits;
>  extern unsigned long _PAGE_ALL_SZ_BITS;
>  
> +extern unsigned long kern_base;
> +#define ZERO_PAGE(vaddr)						   \
> +	(virt_to_page(empty_zero_page + ((unsigned long)__va(kern_base)) - \
> +		      ((unsigned long)KERNBASE)))
> +
>  /* PFNs are real physical page numbers.  However, mem_map only begins to record
>   * per-page information starting at pfn_base.  This is to handle systems where
>   * the first physical page in the machine is at some huge physical address,
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 2bd99944176d..d2d724ba4f83 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -170,6 +170,8 @@ static void __init read_obp_memory(const char *property,
>  
>  /* Kernel physical address base and size in bytes.  */
>  unsigned long kern_base __read_mostly;
> +EXPORT_SYMBOL(kern_base);
> +
>  unsigned long kern_size __read_mostly;
>  
>  /* Initial ramdisk setup */
Hi,

Unfortunately, that does not help. The LDOM goes down in the same fashion.

In QEMU, with or without this extra patch, I get this:

[    3.310674] BUG: Bad page map in process mount  pte:ffffc800016436b0
[    3.310778] pgd:027dc000 p4d:027dc000 pud:027d8000 pmd:0269a000
[    3.311686] addr:000001000020a000 vm_flags:00100077 anon_vma:fffff80002688548 mapping:0000000000000000 index:8000105
[    3.312449] file:(null) fault:0x0 mmap:0x0 mmap_prepare: 0x0 read_folio:0x0
[    3.313622] CPU: 0 UID: 0 PID: 46 Comm: mount Not tainted 6.19.0-rc5-00269-g28acabacf9b0 #22 VOLUNTARY 
[    3.314056] Call Trace:
[    3.314182] [<00000000005e822c>] print_bad_page_map+0x10c/0x260
[    3.314375] [<00000000005e9f30>] vm_normal_page+0x70/0x80
[    3.314400] [<00000000005ea5a8>] unmap_page_range+0x4e8/0x13c0
[    3.314421] [<00000000005eb54c>] unmap_vmas+0x2c/0x120
[    3.314440] [<00000000005f781c>] exit_mmap+0xdc/0x440
[    3.314457] [<000000000047193c>] mmput+0x3c/0x100
[    3.314477] [<0000000000479e94>] do_exit+0x1f4/0xa00
[    3.314494] [<000000000047a83c>] do_group_exit+0x1c/0xa0
[    3.314511] [<0000000000489b28>] get_signal+0x8a8/0x8e0
[    3.314529] [<000000000043be24>] do_notify_resume+0xa4/0x5a0
[    3.314549] [<0000000000404b48>] __handle_signal+0xc/0x30
[    3.314687] Disabling lock debugging due to kernel taint

Cheers,
Andreas

