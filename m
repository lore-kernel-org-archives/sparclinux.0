From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Oct 2017 02:29:14 +0000
Subject: Re: sparc64: mmu_context: Add missing include files
Message-Id: <20171026022914.GA26273@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1505076287-18401-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1505076287-18401-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Did I send this to the wrong mailing list, or did it get lost ?
Should I resend ?

Guenter

On Sun, Sep 10, 2017 at 01:44:47PM -0700, Guenter Roeck wrote:
> Fix the following build errors.
> 
> In file included from arch/sparc/include/asm/mmu_context.h:4:0,
>                  from include/linux/mmu_context.h:4,
> 		 from drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h:29,
> 		 from drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c:23:
> arch/sparc/include/asm/mmu_context_64.h:22:37: error:
> 	unknown type name 'per_cpu_secondary_mm'
> 
> arch/sparc/include/asm/mmu_context_64.h: In function 'switch_mm':
> arch/sparc/include/asm/mmu_context_64.h:79:2: error:
> 	implicit declaration of function 'smp_processor_id'
> 
> Fixes: 70539bd79500 ("drm/amd: Update MEC HQD loading code for KFD")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Oded Gabbay <oded.gabbay@gmail.com>
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
