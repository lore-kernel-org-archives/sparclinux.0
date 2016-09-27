From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 27 Sep 2016 04:46:25 +0000
Subject: Re: [PATCH v2 1/2] config: Add new CONFIG_PROVE_LOCKING_SMALL
Message-Id: <20160927044625.GA13264@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1474929098-68914-1-git-send-email-babu.moger@oracle.com>
 <1474929098-68914-2-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1474929098-68914-2-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi Babu.

On Mon, Sep 26, 2016 at 03:31:37PM -0700, Babu Moger wrote:
> Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc.
> 
> This feature limits the space used for "Lock debugging: prove locking
> correctness" by about 4MB. The current sparc systms have the limitation of
> 32MB size for kernel size including .text, .data and .bss sections. With
> PROVE_LOCKING feature, the kernel size could grow beyond this limit and
> causing system bootup issues. With this option, kernel limits the size
> of the entries of lock_chains, stack_trace etc. so that kernel fits in
> required size limit.  This is only visible for sparc.
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> ---
>  lib/Kconfig.debug |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index b9cfdbf..c79de25 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1035,6 +1035,7 @@ config PROVE_LOCKING
>  	select DEBUG_MUTEXES
>  	select DEBUG_LOCK_ALLOC
>  	select TRACE_IRQFLAGS
> +	select PROVE_LOCKING_SMALL if SPARC
>  	default n
>  	help
>  	 This feature enables the kernel to prove that all locking
> @@ -1070,6 +1071,22 @@ config PROVE_LOCKING
>  
>  	 For more details, see Documentation/locking/lockdep-design.txt.
>  
> +config PROVE_LOCKING_SMALL
> +	bool "Limit the space for prove locking correctness"
> +	depends on PROVE_LOCKING && SPARC
> +	help
> +	 This feature limits the space used for "Lock debugging: prove
> +	 locking correctness" by about 4MB. In sparc system, all the
> +	 kernel's code, data, and bss, must have locked translations in
> +	 the TLB so that it does not hit TLB misses. The current sparc
> +	 chips have 8 TLB entries available that may be locked down, and
> +	 with a 4mb page size, this gives a maximum of 32mb of memory for
> +	 the kernel size. With PROVE_LOCKING feature, the kernel size could
> +	 grow beyond this limit and causing system bootup issues. With
> +	 this option, kernel limits the size of the entries of lock_chains,
> +	 stack_trace etc. to debug PROVE_LOCKING so that kernel size fits
> +	 in 32MB. This is only visible for SPARC.

Since this is only relevant for sparc, and for sparc this is "select"ed,
then there is limited/no gain having this as a visible menu config option.

How about adding just a simple non-visible config symbol:

config PROVE_LOCKING_SMALL
	bool

The nice help text can be added to the H file, and the select
can be move to the sparc/Kconfig file where it really belongs.

	Sam
