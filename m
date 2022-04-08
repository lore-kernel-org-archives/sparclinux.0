Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DF0C433EF
	for <sparclinux@archiver.kernel.org>; Fri,  8 Apr 2022 10:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiDHKaY (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiDHKaX (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 8 Apr 2022 06:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F919319A1C;
        Fri,  8 Apr 2022 03:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D68CB82A1E;
        Fri,  8 Apr 2022 10:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA71C385A1;
        Fri,  8 Apr 2022 10:28:14 +0000 (UTC)
Date:   Fri, 8 Apr 2022 11:28:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH V4 3/7] arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <YlAOO2H/Ay/y9HOv@arm.com>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
 <20220407103251.1209606-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407103251.1209606-4-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Apr 07, 2022 at 04:02:47PM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 77ada00280d9..307534fcec00 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -55,3 +55,36 @@ static int __init adjust_protection_map(void)
>  	return 0;
>  }
>  arch_initcall(adjust_protection_map);
> +
> +static pgprot_t arm64_arch_vm_get_page_prot(unsigned long vm_flags)
> +{
> +	pteval_t prot = 0;
> +
> +	if (vm_flags & VM_ARM64_BTI)
> +		prot |= PTE_GP;
> +
> +	/*
> +	 * There are two conditions required for returning a Normal Tagged
> +	 * memory type: (1) the user requested it via PROT_MTE passed to
> +	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
> +	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
> +	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
> +	 * mmap() call since mprotect() does not accept MAP_* flags.
> +	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
> +	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
> +	 */
> +	if (vm_flags & VM_MTE)
> +		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
> +
> +	return __pgprot(prot);
> +}
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
> +				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
> +				pgprot_val(arm64_arch_vm_get_page_prot(vm_flags)));
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);

Could you write all this in a single function? I think I mentioned it in
a previous series (untested):

pgprot_t vm_get_page_prot(unsigned long vm_flags)
{
	pteval_t prot = pgprot_val(protection_map[vm_flags &
				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);

	if (vm_flags & VM_ARM64_BTI)
		prot |= PTE_GP;

	/*
	 * There are two conditions required for returning a Normal Tagged
	 * memory type: (1) the user requested it via PROT_MTE passed to
	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
	 * mmap() call since mprotect() does not accept MAP_* flags.
	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
	 */
	if (vm_flags & VM_MTE)
		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);

	return __pgprot(prot);
}
EXPORT_SYMBOL(vm_get_page_prot);

With that:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
