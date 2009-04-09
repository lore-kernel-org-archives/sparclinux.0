From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 09 Apr 2009 06:44:47 +0000
Subject: Re: [PATCH 12/12]: sparc64: Use new dynamic per-cpu allocator.
Message-Id: <20090409064447.GB14255@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408.223758.81953207.davem@davemloft.net>
In-Reply-To: <20090408.223758.81953207.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: tj@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 08, 2009 at 10:37:58PM -0700, David Miller wrote:
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/Kconfig         |    3 +
>  arch/sparc/kernel/smp_64.c |  165 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 159 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index cc12cd4..2185cf9 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -93,6 +93,9 @@ config AUDIT_ARCH
>  config HAVE_SETUP_PER_CPU_AREA
>  	def_bool y if SPARC64
>  
> +config HAVE_DYNAMIC_PER_CPU_AREA
> +	def_bool y if SPARC64
> +

Not related to this specific patch - but I wonder if there
is any good reason these HAVE_ varaibles do not follow the
normal pattern with one definition
and users using select to enable it.

	Sam
