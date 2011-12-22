From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 22 Dec 2011 18:02:43 +0000
Subject: Re: [PATCH 1/2] sparc: Make SA_NOMASK a synonym of SA_NODEFER
Message-Id: <20111222180142.GA5502@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1324493221-4435-1-git-send-email-matt@console-pimps.org> <1324493221-4435-2-git-send-email-matt@console-pimps.org>
In-Reply-To: <1324493221-4435-2-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, sparclinux@vger.kernel.org

On 12/21, Matt Fleming wrote:
>
> Unlike other architectures, sparc currently has no SA_NODEFER
> definition but only the older SA_NOMASK. Since SA_NOMASK is the
> historical name for SA_NODEFER, add SA_NODEFER and copy what other
> architectures do by making SA_NOMASK a synonym for SA_NODEFER.

Without this patch arch/sparc can't use the new helper from 2/2

Acked-by: Oleg Nesterov <oleg@redhat.com>

> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
>  arch/sparc/include/asm/signal.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/signal.h b/arch/sparc/include/asm/signal.h
> index e49b828..aa42fe3 100644
> --- a/arch/sparc/include/asm/signal.h
> +++ b/arch/sparc/include/asm/signal.h
> @@ -143,10 +143,11 @@ struct sigstack {
>  #define SA_ONSTACK	_SV_SSTACK
>  #define SA_RESTART	_SV_INTR
>  #define SA_ONESHOT	_SV_RESET
> -#define SA_NOMASK	0x20u
> +#define SA_NODEFER	0x20u
>  #define SA_NOCLDWAIT    0x100u
>  #define SA_SIGINFO      0x200u
>  
> +#define SA_NOMASK	SA_NODEFER
>  
>  #define SIG_BLOCK          0x01	/* for blocking signals */
>  #define SIG_UNBLOCK        0x02	/* for unblocking signals */
> -- 
> 1.7.4.4
> 

