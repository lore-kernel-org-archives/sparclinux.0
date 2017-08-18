From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Fri, 18 Aug 2017 19:25:31 +0000
Subject: Re: [PATCH] sparc64: speed up etrap/rtrap on NG2 and later processors
Message-Id: <5A1BE2F0-18CD-449E-A869-7C8348CBDD0D@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1503017943-23575-1-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1503017943-23575-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> On Aug 17, 2017, at 5:59 PM, Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
> 
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -300,6 +300,20 @@ static void __init sun4v_patch(void)
> 		break;
> 	}
> 
> +	switch (sun4v_chip_type) {
> +	case SUN4V_CHIP_NIAGARA2:
> +	case SUN4V_CHIP_NIAGARA3:
> +	case SUN4V_CHIP_NIAGARA4:
> +	case SUN4V_CHIP_NIAGARA5:
> +	case SUN4V_CHIP_SPARC_M6:
> +	case SUN4V_CHIP_SPARC_M7:
> +	case SUN4V_CHIP_SPARC_M8:
> +	case SUN4V_CHIP_SPARC64X:
> +	case SUN4V_CHIP_SPARC_SN:
> +		sun4v_patch_1insn_range(&__fast_win_ctrl_1insn_patch,
> +					&__fast_win_ctrl_1insn_patch_end);
> +	}

It was pointed out off-list that this is not future-proof.  The only
sun4v chip that does not support allclean, normalw, and otherw is
Niagara1, and any future sun4v-compliant chip must support the
instructions.  Rather than require a code change for new processors,
just skip hot patching for Niagara1.  I'll send out a v2 patch shortly.

Anthony