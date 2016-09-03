From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 03 Sep 2016 16:51:20 +0000
Subject: Re: [PATCH 1/4] sparc: bpf_jit: Use kmalloc_array() in bpf_jit_compile()
Message-Id: <57CAFF88.2000506@iogearbox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net> <ab4a20b2-16be-c3b2-58a7-fe7db39ab559@users.sourceforge.net> <259699cf-6fb1-f9e6-f535-fe880a7fa6dc@users.sourceforge.net>
In-Reply-To: <259699cf-6fb1-f9e6-f535-fe880a7fa6dc@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rabin Vincent <rabin@rab.in>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

On 09/03/2016 06:36 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 3 Sep 2016 17:10:20 +0200
>
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
>
> This issue was detected by using the Coccinelle software.

When you talk about "issue", could you please explain yourself what
concrete "issue" you were seeing ?!

This particular multiplication here is guaranteed to never overflow,
so at best a minor cleanup if you will.

(Do you actually have a sparc to test out your changes?)

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/sparc/net/bpf_jit_comp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
> index a6d9204..ced1393 100644
> --- a/arch/sparc/net/bpf_jit_comp.c
> +++ b/arch/sparc/net/bpf_jit_comp.c
> @@ -372,7 +372,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>   	if (!bpf_jit_enable)
>   		return;
>
> -	addrs = kmalloc(flen * sizeof(*addrs), GFP_KERNEL);
> +	addrs = kmalloc_array(flen, sizeof(*addrs), GFP_KERNEL);
>   	if (addrs = NULL)
>   		return;
>
>

