From: David Miller <davem@davemloft.net>
Date: Mon, 21 Aug 2017 20:47:35 +0000
Subject: Re: [PATCH v2] sparc64: speed up etrap/rtrap on NG2 and later processors
Message-Id: <20170821.134735.414712980112483462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1503085236-65590-1-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1503085236-65590-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 18 Aug 2017 12:40:36 -0700

> For many sun4v processor types, reading or writing a privileged register
> has a latency of 40 to 70 cycles.  Use a combination of the low-latency
> allclean, otherw, normalw, and nop instructions in etrap and rtrap to
> replace 2 rdpr and 5 wrpr instructions and improve etrap/rtrap
> performance.  allclean, otherw, and normalw are available on NG2 and
> later processors.
> 
> The average ticks to execute the flush windows trap ("ta 0x3") with and
> without this patch on select platforms:
> 
>  CPU            Not patched     Patched    % Latency Reduction
> 
>  NG2            1762            1558            -11.58
>  NG4            3619            3204            -11.47
>  M7             3015            2624            -12.97
>  SPARC64-X      829             770              -7.12
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
> v2:
> 	Simplified and future-proofed changes to sun4v_patch()
> 	by just skipping hot patching for Niagara1 processors.

I'm applying this after I review it a little more but this situation
is kinda disappointing:

> @@ -38,7 +38,11 @@ etrap_syscall:	TRAP_LOAD_THREAD_REG(%g6, %g1)
>  		or	%g1, %g3, %g1
>  		bne,pn	%xcc, 1f
>  		 sub	%sp, STACKFRAME_SZ+TRACEREG_SZ-STACK_BIAS, %g2
> -		wrpr	%g0, 7, %cleanwin
> +661:		wrpr	%g0, 7, %cleanwin
> +		.section .fast_win_ctrl_1insn_patch, "ax"
> +		.word	661b
> +		.word	0x85880000	! allclean
> +		.previous
>  
>  		sethi	%hi(TASK_REGOFF), %g2
>  		sethi	%hi(TSTATE_PEF), %g3

So the chip can't decode "wrpr %g0, 7, %cleanwin" and say "hey, this is
'allclean'" and do whatever fast path exists in the chip for that?

I realize the other cases are not so simple because they involve a
read/write sequence.

Enough complaining from me :-)

Applied, thanks.
