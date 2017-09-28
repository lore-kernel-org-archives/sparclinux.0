From: David Miller <davem@davemloft.net>
Date: Thu, 28 Sep 2017 04:52:06 +0000
Subject: Re: [PATCH] sparc64: mmu_context: Add missing include files
Message-Id: <20170927.215206.1151121167562961485.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1505076287-18401-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1505076287-18401-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 10 Sep 2017 13:44:47 -0700

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

Applied.
