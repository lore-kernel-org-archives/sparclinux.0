From: Mukesh Ojha <mojha@codeaurora.org>
Date: Thu, 28 Mar 2019 06:47:51 +0000
Subject: Re: [PATCH] arch:sparc:kernel/uprobes.c : Remove duplicate header
Message-Id: <636ab5b9-d0ba-d3df-3c1c-75f4b045c922@codeaurora.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
In-Reply-To: <1553722125-38957-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jagdsh.linux@gmail.com, davem@davemloft.net, paul.burton@mips.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


On 3/28/2019 2:58 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Looks good to me. but did you tested at least the compilation with these 
patches ?

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


> ---
>   arch/sparc/kernel/uprobes.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
> index d852ae5..c44bf5b 100644
> --- a/arch/sparc/kernel/uprobes.c
> +++ b/arch/sparc/kernel/uprobes.c
> @@ -29,7 +29,6 @@
>   #include <linux/kdebug.h>
>   
>   #include <asm/cacheflush.h>
> -#include <linux/uaccess.h>
>   
>   /* Compute the address of the breakpoint instruction and return it.
>    *
