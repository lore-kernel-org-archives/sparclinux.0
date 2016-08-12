From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Fri, 12 Aug 2016 23:46:26 +0000
Subject: Re: [PATCH] Documentation: kprobes: Document jprobes stack copying limitations
Message-Id: <20160813084626.06b972afea3814959ab64ebc@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
In-Reply-To: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 12 Aug 2016 16:24:44 -0400
David Long <dave.long@linaro.org> wrote:

> From: "David A. Long" <dave.long@linaro.org>
> 
> Some architectures (i.e.: sparc64 and arm64) make reasonable partial stack
> duplication for jprobes problematic. Document this.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  Documentation/kprobes.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 1f9b3e2..1f6d45a 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -103,6 +103,16 @@ Note that the probed function's args may be passed on the stack
>  or in registers.  The jprobe will work in either case, so long as the
>  handler's prototype matches that of the probed function.
>  
> +Note that in some architectures (e.g.: arm64 and sparc64) the stack
> +copy is not done, as the actual location of stacked parameters may be
> +outside of a reasonable MAX_STACK_SIZE value and because that location
> +cannot be determined by the jprobes code. In this case the jprobes
> +user must be careful to make certain the calling signature of the
> +function does not cause parameters to be passed on the stack (e.g.:
> +more than eight function arguments, an argument of more than sixteen
> +bytes, or more than 64 bytes of argument data, depending on
> +architecture).
> +
>  1.3 Return Probes
>  
>  1.3.1 How Does a Return Probe Work?
> -- 
> 2.5.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
