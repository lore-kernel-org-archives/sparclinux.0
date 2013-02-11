From: Len Brown <lenb@kernel.org>
Date: Mon, 11 Feb 2013 23:23:55 +0000
Subject: Re: linux-next: build failure after merge of the final tree (acpi tree related)
Message-Id: <51197D8B.6010407@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20130211183409.7519b73ca320baeac5ec886f@canb.auug.org.au>
In-Reply-To: <20130211183409.7519b73ca320baeac5ec886f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On 02/11/2013 02:34 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (sparc64 defconfig)
> failed like this:
> 
> arch/sparc/include/asm/processor.h: Assembler messages:
> arch/sparc/include/asm/processor.h:10: Error: Unknown opcode: `extern'
> 
> Caused by commit 3a242f58a5f4 ("sparc idle: rename pm_idle to
> sparc_idle") from the acpi tree.
> 
> I have applied this patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 11 Feb 2013 18:30:19 +1100
> Subject: [PATCH] sparc idle: protect variable declarations against the assembler
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/sparc/include/asm/processor.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/processor.h b/arch/sparc/include/asm/processor.h
> index 34baa35..622cfa5 100644
> --- a/arch/sparc/include/asm/processor.h
> +++ b/arch/sparc/include/asm/processor.h
> @@ -7,6 +7,8 @@
>  #endif
>  
>  #define nop() 		__asm__ __volatile__ ("nop")
> +#ifndef __ASSEMBLY__
>  extern void (*sparc_idle)(void);
> +#endif
>  
>  #endif
> 

Thank you Stephen!

The last time I compiled a sparc kernel was in 1993:-)

I've added your fix and Dave's Ack to this patch,
and updated it in my next branch.

Len Brown, Intel Open Source Technology Center


