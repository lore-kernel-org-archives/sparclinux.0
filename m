Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF07C4332F
	for <sparclinux@archiver.kernel.org>; Fri,  8 Apr 2022 11:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiDHLVQ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiDHLVP (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 8 Apr 2022 07:21:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 146DA255C1F;
        Fri,  8 Apr 2022 04:19:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF61911FB;
        Fri,  8 Apr 2022 04:19:12 -0700 (PDT)
Received: from [10.163.33.132] (unknown [10.163.33.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2237A3F73B;
        Fri,  8 Apr 2022 04:19:06 -0700 (PDT)
Message-ID: <dcd6ffe0-9ee2-a862-4ed7-5d04505e6144@arm.com>
Date:   Fri, 8 Apr 2022 16:49:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4 3/7] arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
 <20220407103251.1209606-4-anshuman.khandual@arm.com>
 <YlAOO2H/Ay/y9HOv@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YlAOO2H/Ay/y9HOv@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org



On 4/8/22 15:58, Catalin Marinas wrote:
> On Thu, Apr 07, 2022 at 04:02:47PM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
>> index 77ada00280d9..307534fcec00 100644
>> --- a/arch/arm64/mm/mmap.c
>> +++ b/arch/arm64/mm/mmap.c
>> @@ -55,3 +55,36 @@ static int __init adjust_protection_map(void)
>>  	return 0;
>>  }
>>  arch_initcall(adjust_protection_map);
>> +
>> +static pgprot_t arm64_arch_vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	pteval_t prot = 0;
>> +
>> +	if (vm_flags & VM_ARM64_BTI)
>> +		prot |= PTE_GP;
>> +
>> +	/*
>> +	 * There are two conditions required for returning a Normal Tagged
>> +	 * memory type: (1) the user requested it via PROT_MTE passed to
>> +	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
>> +	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
>> +	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
>> +	 * mmap() call since mprotect() does not accept MAP_* flags.
>> +	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
>> +	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
>> +	 */
>> +	if (vm_flags & VM_MTE)
>> +		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
>> +
>> +	return __pgprot(prot);
>> +}
>> +
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
>> +				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>> +				pgprot_val(arm64_arch_vm_get_page_prot(vm_flags)));
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(vm_get_page_prot);
> 
> Could you write all this in a single function? I think I mentioned it in
> a previous series (untested):

Right, missed that.

> 
> pgprot_t vm_get_page_prot(unsigned long vm_flags)
> {
> 	pteval_t prot = pgprot_val(protection_map[vm_flags &
> 				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> 
> 	if (vm_flags & VM_ARM64_BTI)
> 		prot |= PTE_GP;
> 
> 	/*
> 	 * There are two conditions required for returning a Normal Tagged
> 	 * memory type: (1) the user requested it via PROT_MTE passed to
> 	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
> 	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
> 	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
> 	 * mmap() call since mprotect() does not accept MAP_* flags.
> 	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
> 	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
> 	 */
> 	if (vm_flags & VM_MTE)
> 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
> 
> 	return __pgprot(prot);
> }
> EXPORT_SYMBOL(vm_get_page_prot);
> 
> With that:

Sure, will change them into a single function.

> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
