From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Sun, 24 Sep 2017 10:14:01 +0000
Subject: Re: [PATCH] sparc64: mmu_context: Add missing include files
Message-Id: <CAFCwf11CoVUQ5W6y9Ek3FEe0v7k6ckwhG5Cark_675sYOaFHTg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1505076287-18401-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1505076287-18401-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Sun, Sep 10, 2017 at 11:44 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Fix the following build errors.
>
> In file included from arch/sparc/include/asm/mmu_context.h:4:0,
>                  from include/linux/mmu_context.h:4,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c:23:
> arch/sparc/include/asm/mmu_context_64.h:22:37: error:
>         unknown type name 'per_cpu_secondary_mm'
>
> arch/sparc/include/asm/mmu_context_64.h: In function 'switch_mm':
> arch/sparc/include/asm/mmu_context_64.h:79:2: error:
>         implicit declaration of function 'smp_processor_id'
>
> Fixes: 70539bd79500 ("drm/amd: Update MEC HQD loading code for KFD")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> "Exposed-by:" instead of "Fixes:" might be more appropriate.
>
>  arch/sparc/include/asm/mmu_context_64.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
> index 87841d687f8d..a34315e1f0ed 100644
> --- a/arch/sparc/include/asm/mmu_context_64.h
> +++ b/arch/sparc/include/asm/mmu_context_64.h
> @@ -7,9 +7,11 @@
>
>  #include <linux/spinlock.h>
>  #include <linux/mm_types.h>
> +#include <linux/smp.h>
>
>  #include <asm/spitfire.h>
>  #include <asm-generic/mm_hooks.h>
> +#include <asm/percpu.h>
>
>  static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>  {
> --
> 2.7.4
>


This patch is:
Acked-by: Oded Gabbay <oded.gabbay@gmail.com>


HI David,
Could you please pick-up this patch for -rc3/4 ?
We constantly get kbuild error reports due to this issue.

Thanks,
Oded
