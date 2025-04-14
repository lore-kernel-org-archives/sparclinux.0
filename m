Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B323D289;
	Mon, 14 Apr 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636981; cv=none; b=aMP3pMC8RkzBu3mmYup57qr/A1lhb2pW2SkZKl1X/dEBJcV/dw0TQ4JaLnITQDRsu5uGDstxS0jvTrl5KX3beHIaVPUFWzXU6C+UZa3QmeEtwzTwGkJdhKSJWguzMwo6a3NXp9LudocvWn643ujHHP5qDhbIDM6M4sTAa0Xea1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636981; c=relaxed/simple;
	bh=iHBajgRQ/g0p3qwCjlhcDaR+5+wzf8+g3EzD9RVfVP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrYKlsdIJW2RIu+UkUxDAngKUnh18OeT9I9hAnBiodhLLFoxWtVQUexfREfRj3MoXDf3en4qcYmrbENieXCdRR4Wu5Kqn7QNsYHOC22sw4gE9zVzDUgrW6AIcjsKHEryMooOsqUFyrqwgCfjCzhuxGjIuQ+UL7k/zjKXj0IKbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE831007;
	Mon, 14 Apr 2025 06:22:56 -0700 (PDT)
Received: from [10.57.86.225] (unknown [10.57.86.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 093363F66E;
	Mon, 14 Apr 2025 06:22:54 -0700 (PDT)
Message-ID: <5b0609c9-95ee-4e48-bb6d-98f57c5d2c31@arm.com>
Date: Mon, 14 Apr 2025 14:22:53 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Fix lazy mmu mode
Content-Language: en-GB
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
References: <20250303141542.3371656-1-ryan.roberts@arm.com>
 <912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2025 17:07, Alexander Gordeev wrote:
> On Mon, Mar 03, 2025 at 02:15:34PM +0000, Ryan Roberts wrote:
> 
> Hi Ryan,
> 
>> I'm planning to implement lazy mmu mode for arm64 to optimize vmalloc. As part
>> of that, I will extend lazy mmu mode to cover kernel mappings in vmalloc table
>> walkers. While lazy mmu mode is already used for kernel mappings in a few
>> places, this will extend it's use significantly.
>>
>> Having reviewed the existing lazy mmu implementations in powerpc, sparc and x86,
>> it looks like there are a bunch of bugs, some of which may be more likely to
>> trigger once I extend the use of lazy mmu.
> 
> Do you have any idea about generic code issues as result of not adhering to
> the originally stated requirement:
> 
>   /*
>    ...
>    * the PTE updates which happen during this window.  Note that using this
>    * interface requires that read hazards be removed from the code.  A read
>    * hazard could result in the direct mode hypervisor case, since the actual
>    * write to the page tables may not yet have taken place, so reads though
>    * a raw PTE pointer after it has been modified are not guaranteed to be
>    * up to date.
>    ...
>    */
> 
> I tried to follow few code paths and at least this one does not look so good:
> 
> copy_pte_range(..., src_pte, ...)
> 	ret = copy_nonpresent_pte(..., src_pte, ...)
> 		try_restore_exclusive_pte(..., src_pte, ...)	// is_device_exclusive_entry(entry)
> 			restore_exclusive_pte(..., ptep, ...)
> 				set_pte_at(..., ptep, ...)
> 					set_pte(ptep, pte);	// save in lazy mmu mode
> 
> 	// ret == -ENOENT
> 
> 	ptent = ptep_get(src_pte);				// lazy mmu save is not observed
> 	ret = copy_present_ptes(..., ptent, ...);		// wrong ptent used
> 
> I am not aware whether the effort to "read hazards be removed from the code"
> has ever been made and the generic code is safe in this regard.
> 
> What is your take on this?

Hmm, that looks like a bug to me, at least based on the stated requirements.
Although this is not a "read through a raw PTE *pointer*", it is a ptep_get().
The arch code can override that so I guess it has an opportunity to flush. But I
don't think any arches are currently doing that.

Probably the simplest fix is to add arch_flush_lazy_mmu_mode() before the
ptep_get()?

It won't be a problem in practice for arm64, since the pgtables are always
updated immediately. I just want to use these hooks to defer/batch barriers in
certain cases.

And this is a pre-existing issue for the arches that use lazy mmu with
device-exclusive mappings, which my extending lazy mmu into vmalloc won't
exacerbate.

Would you be willing/able to submit a fix?

Thanks,
Ryan


> 
> Thanks!

