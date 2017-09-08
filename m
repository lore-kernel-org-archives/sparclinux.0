From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 08 Sep 2017 15:03:56 +0000
Subject: Re: [PATCH] sparc64: Handle additional cases of no fault loads
Message-Id: <20170908150356.GA27966@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1504827559-109802-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504827559-109802-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Rob.

> diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
> index ad31af1..c49949c 100644
> --- a/arch/sparc/kernel/traps_64.c
> +++ b/arch/sparc/kernel/traps_64.c
> @@ -265,6 +265,34 @@ void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, u
>  	sun4v_insn_access_exception(regs, addr, type_ctx);
>  }
>  
> +bool is_no_fault_exception(struct pt_regs *regs)
> +{
> +	unsigned char asi;
> +	u32 insn;
> +
> +	if (get_user(insn, (u32 __user *)regs->tpc) = -EFAULT)
> +		return false;
> +
> +	if ((insn & 0xc0800000) = 0xc0800000) {
> +		if (insn & 0x2000)
> +			asi = (regs->tstate >> 24);
> +		else
> +			asi = (insn >> 5);

The constants used in the above code is pure magic
for peopel without any initimate knowledge of sparc.
Could at a abre minimum add a few comments that explains
what is going on.


> +		if ((asi & 0xf2) = ASI_PNF) {
> +			if (insn & 0x1000000) {
> +				handle_ldf_stq(insn, regs);
> +				return true;
> +			} else if (insn & 0x200000) {
> +				/* store instruction, do not handle */
> +				return false;
> +			}
Likewise

> +			handle_ld_nf(insn, regs);
> +			return true;
> +		}
> +	}
> +	return false;
> +}

	Sam
