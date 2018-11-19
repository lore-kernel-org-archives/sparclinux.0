From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 19 Nov 2018 11:26:46 +0000
Subject: Re: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling from VLAN_TCI
Message-Id: <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org

On 11/10/2018 07:58 PM, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Why you have empty commit messages for non-trivial changes like this in
4 out of 6 of your patches ...

How was it tested on the JITs you were changing? Did you test on both,
big and little endian machines?

> ---
>  net/core/filter.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e521c5ebc7d1..c151b906df53 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -296,22 +296,21 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
>  		break;
>  
>  	case SKF_AD_VLAN_TAG:
> -	case SKF_AD_VLAN_TAG_PRESENT:
>  		BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
> -		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
>  
>  		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
>  		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
>  				      offsetof(struct sk_buff, vlan_tci));
> -		if (skb_field = SKF_AD_VLAN_TAG) {
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg,
> -						~VLAN_TAG_PRESENT);
> -		} else {
> -			/* dst_reg >>= 12 */
> -			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, 12);
> -			/* dst_reg &= 1 */
> +#ifdef VLAN_TAG_PRESENT
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, ~VLAN_TAG_PRESENT);
> +#endif
> +		break;
> +	case SKF_AD_VLAN_TAG_PRESENT:
> +		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
> +		if (PKT_VLAN_PRESENT_BIT)
> +			*insn++ = BPF_ALU32_IMM(BPF_RSH, dst_reg, PKT_VLAN_PRESENT_BIT);
> +		if (PKT_VLAN_PRESENT_BIT < 7)
>  			*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, 1);
> -		}
>  		break;
>  	}
>  
> @@ -6140,19 +6139,22 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  		break;
>  
>  	case offsetof(struct __sk_buff, vlan_present):
> +		*target_size = 1;
> +		*insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
> +				      PKT_VLAN_PRESENT_OFFSET());
> +		if (PKT_VLAN_PRESENT_BIT)
> +			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, PKT_VLAN_PRESENT_BIT);
> +		if (PKT_VLAN_PRESENT_BIT < 7)
> +			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
> +		break;
> +
>  	case offsetof(struct __sk_buff, vlan_tci):
> -		BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
> -
>  		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
>  				      bpf_target_off(struct sk_buff, vlan_tci, 2,
>  						     target_size));
> -		if (si->off = offsetof(struct __sk_buff, vlan_tci)) {
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg,
> -						~VLAN_TAG_PRESENT);
> -		} else {
> -			*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, 12);
> -			*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 1);
> -		}
> +#ifdef VLAN_TAG_PRESENT
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, ~VLAN_TAG_PRESENT);
> +#endif
>  		break;
>  
>  	case offsetof(struct __sk_buff, cb[0]) ...
> 
