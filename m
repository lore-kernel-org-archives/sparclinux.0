From: Rodrigo Vivi <rodrigo.vivi@intel.com>
Date: Mon, 05 Aug 2019 16:53:46 +0000
Subject: Re: [PATCH v2 06/34] drm/i915: convert put_page() to put_user_page*()
Message-Id: <20190805165346.GB25953@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190804224915.28669-1-jhubbard@nvidia.com>
 <20190804224915.28669-7-jhubbard@nvidia.com>
In-Reply-To: <20190804224915.28669-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john.hubbard@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly

On Sun, Aug 04, 2019 at 03:48:47PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> This is a merge-able version of the fix, because it restricts
> itself to put_user_page() and put_user_pages(), both of which
> have not changed their APIs. Later, i915_gem_userptr_put_pages()
> can be simplified to use put_user_pages_dirty_lock().

Thanks for that.
with this version we won't have any conflict.

Ack for going through mm tree.

> 
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index 2caa594322bc..76dda2923cf1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -527,7 +527,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct *_work)
>  	}
>  	mutex_unlock(&obj->mm.lock);
>  
> -	release_pages(pvec, pinned);
> +	put_user_pages(pvec, pinned);
>  	kvfree(pvec);
>  
>  	i915_gem_object_put(obj);
> @@ -640,7 +640,7 @@ static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
>  		__i915_gem_userptr_set_active(obj, true);
>  
>  	if (IS_ERR(pages))
> -		release_pages(pvec, pinned);
> +		put_user_pages(pvec, pinned);
>  	kvfree(pvec);
>  
>  	return PTR_ERR_OR_ZERO(pages);
> @@ -675,7 +675,7 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
>  			set_page_dirty_lock(page);
>  
>  		mark_page_accessed(page);
> -		put_page(page);
> +		put_user_page(page);
>  	}
>  	obj->mm.dirty = false;
>  
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
