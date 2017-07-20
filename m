From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 20 Jul 2017 19:52:17 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <20170720195217.GB12218@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Allen.

On Thu, Jul 20, 2017 at 01:10:35PM +0530, Allen Pais wrote:
> Recognize SPARC-M8 cpu type, hardware caps and cpu
> distribution map.
> 
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> Signed-off-by: David Aldridge <david.j.aldridge@oracle.com>
> ---
>  arch/sparc/include/asm/spitfire.h |  1 +
>  arch/sparc/kernel/cpu.c           |  6 ++++++
>  arch/sparc/kernel/cpumap.c        |  1 +
>  arch/sparc/kernel/head_64.S       |  6 ++++++
>  arch/sparc/kernel/setup_64.c      | 15 +++++++++++++--
>  arch/sparc/mm/init_64.c           |  2 ++
>  6 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
> index 1d8321c..ba3a655 100644
> --- a/arch/sparc/include/asm/spitfire.h
> +++ b/arch/sparc/include/asm/spitfire.h
> @@ -47,6 +47,7 @@
>  #define SUN4V_CHIP_NIAGARA5	0x05
>  #define SUN4V_CHIP_SPARC_M6	0x06
>  #define SUN4V_CHIP_SPARC_M7	0x07
> +#define SUN4V_CHIP_SPARC_M8	0x08
>  #define SUN4V_CHIP_SPARC64X	0x8a
>  #define SUN4V_CHIP_SPARC_SN	0x8b
>  #define SUN4V_CHIP_UNKNOWN	0xff
> diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
> index 493e023..ef4f18f 100644
> --- a/arch/sparc/kernel/cpu.c
> +++ b/arch/sparc/kernel/cpu.c
> @@ -506,6 +506,12 @@ static void __init sun4v_cpu_probe(void)
>  		sparc_pmu_type = "sparc-m7";
>  		break;
>  
> +	case SUN4V_CHIP_SPARC_M8:
> +		sparc_cpu_type = "SPARC-M8";
> +		sparc_fpu_type = "SPARC-M8 integrated FPU";
> +		sparc_pmu_type = "sparc-m8";
> +		break;
> +
>  	case SUN4V_CHIP_SPARC_SN:
>  		sparc_cpu_type = "SPARC-SN";
>  		sparc_fpu_type = "SPARC-SN integrated FPU";
> diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
> index 45c820e..90d550b 100644
> --- a/arch/sparc/kernel/cpumap.c
> +++ b/arch/sparc/kernel/cpumap.c
> @@ -328,6 +328,7 @@ static int iterate_cpu(struct cpuinfo_tree *t, unsigned int root_index)
>  	case SUN4V_CHIP_NIAGARA5:
>  	case SUN4V_CHIP_SPARC_M6:
>  	case SUN4V_CHIP_SPARC_M7:
> +	case SUN4V_CHIP_SPARC_M8:
>  	case SUN4V_CHIP_SPARC_SN:
>  	case SUN4V_CHIP_SPARC64X:
>  		rover_inc_table = niagara_iterate_method;
> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
> index 41a4073..afcd4ca 100644
> --- a/arch/sparc/kernel/head_64.S
> +++ b/arch/sparc/kernel/head_64.S
> @@ -439,6 +439,9 @@ EXPORT_SYMBOL(sun4v_chip_type)
>  	cmp	%g2, '7'
>  	be,pt	%xcc, 5f
>  	 mov	SUN4V_CHIP_SPARC_M7, %g4
> +	cmp	%g2, '8'
> +	be,pt	%xcc, 5f
> +	 mov	SUN4V_CHIP_SPARC_M8, %g4

Could we use this opportunity to create properly named
constants for '7', '8', 'N' etc, rather than harcoding these
in some assembler files.
(Obviously in a separate patch).

	Sam
