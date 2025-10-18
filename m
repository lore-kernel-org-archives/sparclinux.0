Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DF1DFF0;
	Sat, 18 Oct 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781191; cv=none; b=upzu3Upx4gxPbKVFCAPV4LPE7O6sTHXX9q/enz5VbXVYc+OZ8Dd4jXDSVtVghThqSRrTdODC7XUvZiCn4UB/aG2G6GBscGvDS2dxe/lvA4UbYJsvnjf8u1YzZZ6+PNm0UajLILkNgBQk7dleUJ7uZV+/RJpipxStOaHCHEqZjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781191; c=relaxed/simple;
	bh=bOSmYzha9caq7PhodKTKcCoPiLt+2LlIcLfZyClR6tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik1bGNWYUbHQW7Go/ew1g5GruNzVTSt3RM+pafF12dGkVDgZCgA7v+jFcobUfBAapEaPffXulzIPAzk0abbvCX45BUjFhMn41ZP+VfIktjSs0ghEr22EAueunjC3Y1OeF/PqLh1Y62o3SX91Z9E/qLSWOsGMWZpmChPWb2NN0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVM7dGcE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVM7dGcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A979DC113D0;
	Sat, 18 Oct 2025 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760781190;
	bh=bOSmYzha9caq7PhodKTKcCoPiLt+2LlIcLfZyClR6tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVM7dGcEYXCuz8kq+FQlif5GkokSxvCHTzAFAGwTnR8/6weD/vKEUQASmePsYFC3h
	 +euqjGf0PMyAFk0ZJUt5YM7wZxnuKR0UvscN4IWjm71nso3T24TfhImRIqQfyI4ss6
	 cv+7XmuLUObCGPTep6i88M7y6u+ifbhyfVbe1BHS4zD5ALzPNDk/kx15zhKRwL0t27
	 dMmFhLM5KTioGdUJieNshqGCPzeMSFbHvJviFEJxzNeYiuG1A5BFkxDb8ilKL2vLrA
	 8jv3n05kf1if0vj2NPnC/QhhCj3HuD1WtyN73Zhx+EyOOZxPqW3faoSHxWvYSohg6r
	 KlyEFQZJR/qhA==
Date: Sat, 18 Oct 2025 12:52:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
	x86@kernel.org
Subject: Re: [PATCH v3 05/13] mm: introduce CONFIG_ARCH_LAZY_MMU
Message-ID: <aPNjd2dg3YN-TZKH@kernel.org>
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-6-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015082727.2395128-6-kevin.brodsky@arm.com>

On Wed, Oct 15, 2025 at 09:27:19AM +0100, Kevin Brodsky wrote:
> Architectures currently opt in for implementing lazy_mmu helpers by
> defining __HAVE_ARCH_ENTER_LAZY_MMU_MODE.
> 
> In preparation for introducing a generic lazy_mmu layer that will
> require storage in task_struct, let's switch to a cleaner approach:
> instead of defining a macro, select a CONFIG option.
> 
> This patch introduces CONFIG_ARCH_LAZY_MMU and has each arch select
> it when it implements lazy_mmu helpers.
> __HAVE_ARCH_ENTER_LAZY_MMU_MODE is removed and <linux/pgtable.h>
> relies on the new CONFIG instead.
> 
> On x86, lazy_mmu helpers are only implemented if PARAVIRT_XXL is
> selected. This creates some complications in arch/x86/boot/, because
> a few files manually undefine PARAVIRT* options. As a result
> <asm/paravirt.h> does not define the lazy_mmu helpers, but this
> breaks the build as <linux/pgtable.h> only defines them if
> !CONFIG_ARCH_LAZY_MMU. There does not seem to be a clean way out of
> this - let's just undefine that new CONFIG too.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

...

> @@ -231,7 +231,7 @@ static inline int pmd_dirty(pmd_t pmd)
>   * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
>   * and the mode cannot be used in interrupt context.
>   */
> -#ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
> +#ifndef CONFIG_ARCH_LAZY_MMU
>  static inline void arch_enter_lazy_mmu_mode(void) {}
>  static inline void arch_leave_lazy_mmu_mode(void) {}
>  static inline void arch_flush_lazy_mmu_mode(void) {}
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0e26f4fc8717..2fdcb42ca1a1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1372,6 +1372,9 @@ config PT_RECLAIM
>  config FIND_NORMAL_PAGE
>  	def_bool n
>  
> +config ARCH_LAZY_MMU
> +	bool
> +

I think a better name would be ARCH_HAS_LAZY_MMU and the config option fits
better to arch/Kconfig.

>  source "mm/damon/Kconfig"
>  
>  endmenu
> -- 
> 2.47.0
> 

-- 
Sincerely yours,
Mike.
