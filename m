Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A327703E;
	Mon, 12 Jan 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212563; cv=none; b=j6Ed34meTD0/cLUXyNZxfdst7mWihPheOfxT7ea+3H6nzYTpjC2n2QwlvU2AASgV8V20eeHSfPHOIaWp/Q8gQwoDTedlpBbPMLafVo8QO8bOwu8k3VmOF5jgwfW4zdO3Lb7sJN8OGfVM95WSpo09TQ7sxswF8DdZUXLUMXfvFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212563; c=relaxed/simple;
	bh=zVbE2YDMvok5WZS14hV3iS5sDhPr6OqtWfoQw6P5ksU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2F4Lfhwgw+o9WwsPsaeSxpW8EaCRgQairqUcGz6TbXwHj73Zs0rrOrIasRkcEfEN2uNs3YOzXuIstRw+U+br2qE35+hSCr81MmWEmTgepTFcZYlJ7bjQt0pZn9ZlzpRfttXIuV3YyfMEW8aLANAUqxsOvW0L5vGFo/jqkD7a68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 325ED497;
	Mon, 12 Jan 2026 02:09:15 -0800 (PST)
Received: from [10.57.48.185] (unknown [10.57.48.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD67E3F5A1;
	Mon, 12 Jan 2026 02:09:20 -0800 (PST)
Message-ID: <3ae6e07c-c99e-476e-b9d8-49b999e87197@arm.com>
Date: Mon, 12 Jan 2026 11:09:18 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/mm: export symbols for lazy_mmu_mode KUnit tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "David Hildenbrand (Red Hat)" <david@kernel.org>, sparclinux@vger.kernel.org
References: <20251216201403.4647a4f9861d3122ee9e90d7@linux-foundation.org>
 <20251218100541.2667405-1-kevin.brodsky@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251218100541.2667405-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2025 11:05, Kevin Brodsky wrote:
> Upcoming KUnit tests will call lazy_mmu_mode_{enable,disable}.
> These tests may be built as a module, and because of inlining this
> means that arch_{enter,flush,leave}_lazy_mmu_mode need to be
> exported.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>
> The CI reports that sparc needs pretty much the same time treatment as
> powerpc... Here's another patch to take care of that.
>
> Andrew, could you please add it after the powerpc one? At this point it's
> probably best to remove the comment above MODULE_IMPORT_NS() in
> mm/tests/lazy_mmu_mode_kunit.c. Thank you and sorry for the noise!

Gentle ping - I think we need this patch in mm-unstable, the CI has been
complaining as well. Thanks!

- Kevin

> ---
>  arch/sparc/mm/tlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 3a852071d260..6d9dd5eb1328 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -11,6 +11,8 @@
>  #include <linux/preempt.h>
>  #include <linux/pagemap.h>
>  
> +#include <kunit/visibility.h>
> +
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
> @@ -54,6 +56,8 @@ void arch_enter_lazy_mmu_mode(void)
>  {
>  	preempt_disable();
>  }
> +/* For lazy_mmu_mode KUnit tests */
> +EXPORT_SYMBOL_IF_KUNIT(arch_enter_lazy_mmu_mode);
>  
>  void arch_flush_lazy_mmu_mode(void)
>  {
> @@ -62,12 +66,14 @@ void arch_flush_lazy_mmu_mode(void)
>  	if (tb->tlb_nr)
>  		flush_tlb_pending();
>  }
> +EXPORT_SYMBOL_IF_KUNIT(arch_flush_lazy_mmu_mode);
>  
>  void arch_leave_lazy_mmu_mode(void)
>  {
>  	arch_flush_lazy_mmu_mode();
>  	preempt_enable();
>  }
> +EXPORT_SYMBOL_IF_KUNIT(arch_leave_lazy_mmu_mode);
>  
>  static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
>  			      bool exec, unsigned int hugepage_shift)
>
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
