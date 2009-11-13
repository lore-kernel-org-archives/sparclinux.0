From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 13 Nov 2009 13:42:27 +0000
Subject: Re: [PATH] No auxio on LEON
Message-Id: <20091113134227.GA16435@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AFD5EEF.4000805@gaisler.com>
In-Reply-To: <4AFD5EEF.4000805@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Nov 13, 2009 at 02:28:15PM +0100, Kristoffer Glembo wrote:
> Do not probe for auxio register on SPARC LEON.
>
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
>
> ---
>  arch/sparc/kernel/auxio_32.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
> index 45c4123..40c709d 100644
> --- a/arch/sparc/kernel/auxio_32.c
> +++ b/arch/sparc/kernel/auxio_32.c
> @@ -28,6 +28,7 @@ void __init auxio_probe(void)
>  	struct resource r;
>
>  	switch (sparc_cpu_model) {
> +        case sparc_leon:
>  	case sun4d:
>  	case sun4:
>  		return;

Spaces vs. tabs :)

-- 
     2. That which causes joy or happiness.
