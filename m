From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 07 Oct 2020 20:14:09 +0000
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock and with length
Message-Id: <d5332a7b-c300-6d28-18b9-4b7d4110ef86@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
In-Reply-To: <20201007073932.865218-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Anthony Yznaga <anthony.yznaga@oracle.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On 10/7/20 1:39 AM, Jann Horn wrote:
> arch_validate_prot() is a hook that can validate whether a given set of
> protection flags is valid in an mprotect() operation. It is given the set
> of protection flags and the address being modified.
> 
> However, the address being modified can currently not actually be used in
> a meaningful way because:
> 
> 1. Only the address is given, but not the length, and the operation can
>    span multiple VMAs. Therefore, the callee can't actually tell which
>    virtual address range, or which VMAs, are being targeted.
> 2. The mmap_lock is not held, meaning that if the callee were to check
>    the VMA at @addr, that VMA would be unrelated to the one the
>    operation is performed on.
> 
> Currently, custom arch_validate_prot() handlers are defined by
> arm64, powerpc and sparc.
> arm64 and powerpc don't care about the address range, they just check the
> flags against CPU support masks.
> sparc's arch_validate_prot() attempts to look at the VMA, but doesn't take
> the mmap_lock.
> 
> Change the function signature to also take a length, and move the
> arch_validate_prot() call in mm/mprotect.c down into the locked region.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9035cf9a97e4 ("mm: Add address parameter to arch_validate_prot()")
> Suggested-by: Khalid Aziz <khalid.aziz@oracle.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/arm64/include/asm/mman.h   | 4 ++--
>  arch/powerpc/include/asm/mman.h | 3 ++-
>  arch/powerpc/kernel/syscalls.c  | 2 +-
>  arch/sparc/include/asm/mman.h   | 6 ++++--
>  include/linux/mman.h            | 3 ++-
>  mm/mprotect.c                   | 6 ++++--
>  6 files changed, 15 insertions(+), 9 deletions(-)


This looks good to me.

As Chris pointed out, the call to arch_validate_prot() from do_mmap2()
is made without holding mmap_lock. Lock is not acquired until
vm_mmap_pgoff(). This variance is uncomfortable but I am more
uncomfortable forcing all implementations of validate_prot to require
mmap_lock be held when non-sparc implementations do not have such need
yet. Since do_mmap2() is in powerpc specific code, for now this patch
solves a current problem. That leaves open the question of should
generic mmap call arch_validate_prot and return EINVAL for invalid
combination of protection bits, but that is better addressed in a
separate patch.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

> 
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 081ec8de9ea6..0876a87986dc 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -23,7 +23,7 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
>  #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
>  
>  static inline bool arch_validate_prot(unsigned long prot,
> -	unsigned long addr __always_unused)
> +	unsigned long addr __always_unused, unsigned long len __always_unused)
>  {
>  	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
>  
> @@ -32,6 +32,6 @@ static inline bool arch_validate_prot(unsigned long prot,
>  
>  	return (prot & ~supported) == 0;
>  }
> -#define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
> +#define arch_validate_prot(prot, addr, len) arch_validate_prot(prot, addr, len)
>  
>  #endif /* ! __ASM_MMAN_H__ */
> diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
> index 7cb6d18f5cd6..65dd9b594985 100644
> --- a/arch/powerpc/include/asm/mman.h
> +++ b/arch/powerpc/include/asm/mman.h
> @@ -36,7 +36,8 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
>  }
>  #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
>  
> -static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
> +static inline bool arch_validate_prot(unsigned long prot, unsigned long addr,
> +				      unsigned long len)
>  {
>  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
>  		return false;
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 078608ec2e92..b1fabb97d138 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -43,7 +43,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
>  {
>  	long ret = -EINVAL;
>  
> -	if (!arch_validate_prot(prot, addr))
> +	if (!arch_validate_prot(prot, addr, len))
>  		goto out;
>  
>  	if (shift) {
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
> index f94532f25db1..e85222c76585 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -52,9 +52,11 @@ static inline pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
>  	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
>  }
>  
> -#define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
> -static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
> +#define arch_validate_prot(prot, addr, len) sparc_validate_prot(prot, addr, len)
> +static inline int sparc_validate_prot(unsigned long prot, unsigned long addr,
> +				      unsigned long len)
>  {
> +	mmap_assert_write_locked(current->mm);
>  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
>  		return 0;
>  	if (prot & PROT_ADI) {
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 6f34c33075f9..5b4d554d3189 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -96,7 +96,8 @@ static inline void vm_unacct_memory(long pages)
>   *
>   * Returns true if the prot flags are valid
>   */
> -static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
> +static inline bool arch_validate_prot(unsigned long prot, unsigned long addr,
> +				      unsigned long len)
>  {
>  	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) == 0;
>  }
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ce8b8a5eacbb..e2d6b51acbf8 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -533,14 +533,16 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  	end = start + len;
>  	if (end <= start)
>  		return -ENOMEM;
> -	if (!arch_validate_prot(prot, start))
> -		return -EINVAL;
>  
>  	reqprot = prot;
>  
>  	if (mmap_write_lock_killable(current->mm))
>  		return -EINTR;
>  
> +	error = -EINVAL;
> +	if (!arch_validate_prot(prot, start, len))
> +		goto out;
> +
>  	/*
>  	 * If userspace did not allocate the pkey, do not let
>  	 * them use it here.
> 
> base-commit: c85fb28b6f999db9928b841f63f1beeb3074eeca
> 
