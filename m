From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 25 May 2004 03:40:42 +0000
Subject: Re: PMD_SIZE and compile errors in 2.6.7-rc1
Message-Id: <20040525034042.GA29216@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040525003820.GK2632@artsapartment.org>
In-Reply-To: <20040525003820.GK2632@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 24, 2004 at 05:52:51PM -0700, William Lee Irwin III wrote:

> Hmm, preprocessor logic on the thing is probably ungood. How about this?

I like this a lot more.  Art's approach is somewhat ugly but it
correctly points out that sparc32 no longer needs a variable PMD_SIZE
(it's always 1<<22 now).  I'll fix that part up separately.

Thanks guys.

> Index: sparc32-2.6.7-rc1/mm/rmap.c
> =================================> --- sparc32-2.6.7-rc1.orig/mm/rmap.c	2004-05-24 08:50:32.354217000 -0700
> +++ sparc32-2.6.7-rc1/mm/rmap.c	2004-05-24 17:50:11.082902000 -0700
> @@ -537,11 +537,7 @@
>   * there there won't be many ptes located within the scan cluster.  In this case
>   * maybe we could scan further - to the end of the pte page, perhaps.
>   */
> -#define CLUSTER_SIZE	(32 * PAGE_SIZE)
> -#if     CLUSTER_SIZE  >	PMD_SIZE
> -#undef  CLUSTER_SIZE
> -#define CLUSTER_SIZE	PMD_SIZE
> -#endif
> +#define CLUSTER_SIZE	min(32*PAGE_SIZE, PMD_SIZE)
>  #define CLUSTER_MASK	(~(CLUSTER_SIZE - 1))
>  
>  static int try_to_unmap_cluster(unsigned long cursor,
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Keith M Wesolowski
