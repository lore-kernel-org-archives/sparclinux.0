From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 27 Oct 2010 21:20:20 +0000
Subject: Re: [PATCH] jump_label: Fix unaligned traps on sparc.
Message-Id: <1288214420.18238.130.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20101023.110624.226758370.davem@davemloft.net>
In-Reply-To: <20101023.110624.226758370.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: jbaron@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sat, 2010-10-23 at 11:06 -0700, David Miller wrote:
> The vmlinux.lds.h knobs to emit the __jump_table section in the main
> kernel image takes care to align the section, but this doesn't help
> for the __jump_table section that gets emitted into modules.
> 
> Fix the resulting lack of section alignment by explicitly specifying
> it in the assembler.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Thanks! I'll pull this in tonight with the other jump label patches.

Unfortunately, it turns out that gcc has a bug that can cause crashes
when jump label is used. We need to set it to broken until gcc has a fix
and we can detect if the compiler has the bug or not.

-- Steve


> 
> diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm/jump_label.h
> index 62e66d7..d95cf44 100644
> --- a/arch/sparc/include/asm/jump_label.h
> +++ b/arch/sparc/include/asm/jump_label.h
> @@ -14,6 +14,7 @@
>  			 "nop\n\t"				\
>  			 "nop\n\t"				\
>  			 ".pushsection __jump_table,  \"a\"\n\t"\
> +			 ".align 4\n\t"				\
>  			 ".word 1b, %l[" #label "], %c0\n\t"	\
>  			 ".popsection \n\t"			\
>  			 : :  "i" (key) :  : label);\


