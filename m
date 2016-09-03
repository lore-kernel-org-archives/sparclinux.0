From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 03 Sep 2016 16:52:44 +0000
Subject: Re: [PATCH 4/4] sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <57CAFFDC.4030606@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net> <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net> <054ff9e1-2b84-904b-5f92-55746292916e@users.sourceforge.net>
In-Reply-To: <054ff9e1-2b84-904b-5f92-55746292916e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

On 09/03/2016 06:41 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 3 Sep 2016 18:14:19 +0200
>
> Adjust jump labels according to the current Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

NAK, just noise.

> ---
>   arch/sparc/net/bpf_jit_comp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
> index a6b6e29..3aa19a1 100644
> --- a/arch/sparc/net/bpf_jit_comp.c
> +++ b/arch/sparc/net/bpf_jit_comp.c
> @@ -761,7 +761,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
>
>   			default:
>   				/* hmm, too complex filter, give up with jit compiler */
> -				goto out;
> +				goto free_addresses;
>   			}
>   			ilen = (void *) prog - (void *) temp;
>   			if (image) {
> @@ -793,7 +793,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
>   		if (proglen = oldproglen) {
>   			image = module_alloc(proglen);
>   			if (!image)
> -				goto out;
> +				goto free_addresses;
>   		}
>   		oldproglen = proglen;
>   	}
> @@ -806,7 +806,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
>   		fp->bpf_func = (void *)image;
>   		fp->jited = 1;
>   	}
> -out:
> + free_addresses:
>   	kfree(addrs);
>   	return;
>   }
>

