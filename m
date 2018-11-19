From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 19 Nov 2018 10:37:49 +0000
Subject: Re: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
Message-Id: <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20181117185715.25198-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/17/2018 07:57 PM, Ard Biesheuvel wrote:
> Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
> allocations") added a call to bpf_jit_uncharge_modmem() to the routine
> bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
> This function is overridden by arches, some of which do not call
> bpf_jit_binary_free() to release the memory, and so the released
> memory is not accounted for, potentially leading to spurious allocation
> failures.
> 
> So replace the direct calls to module_memfree() in the arch code with
> calls to bpf_jit_binary_free().

Sorry but this patch is completely buggy, and above description on the
accounting incorrect as well. Looks like this patch was not tested at all.

The below cBPF JITs that use module_memfree() which you replace with
bpf_jit_binary_free() are using module_alloc() internally to get the JIT
image buffer ...

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/mips/net/bpf_jit.c           | 2 +-
>  arch/powerpc/net/bpf_jit_comp.c   | 2 +-
>  arch/powerpc/net/bpf_jit_comp64.c | 5 +----
>  arch/sparc/net/bpf_jit_comp_32.c  | 2 +-
>  4 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> index 4d8cb9bb8365..1b69897274a1 100644
> --- a/arch/mips/net/bpf_jit.c
> +++ b/arch/mips/net/bpf_jit.c
> @@ -1264,7 +1264,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
>  	if (fp->jited)
> -		module_memfree(fp->bpf_func);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index d5bfe24bb3b5..a1ea1ea6b40d 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -683,7 +683,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
>  	if (fp->jited)
> -		module_memfree(fp->bpf_func);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 50b129785aee..84c8f013a6c6 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1024,11 +1024,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  /* Overriding bpf_jit_free() as we don't set images read-only. */
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
> -	unsigned long addr = (unsigned long)fp->bpf_func & PAGE_MASK;
> -	struct bpf_binary_header *bpf_hdr = (void *)addr;
> -
>  	if (fp->jited)
> -		bpf_jit_binary_free(bpf_hdr);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> index a5ff88643d5c..01bda6bc9e7f 100644
> --- a/arch/sparc/net/bpf_jit_comp_32.c
> +++ b/arch/sparc/net/bpf_jit_comp_32.c
> @@ -759,7 +759,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
>  void bpf_jit_free(struct bpf_prog *fp)
>  {
>  	if (fp->jited)
> -		module_memfree(fp->bpf_func);
> +		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
>  
>  	bpf_prog_unlock_free(fp);
>  }
> 
