From: John Hubbard <jhubbard@nvidia.com>
Date: Sat, 03 Aug 2019 20:03:05 +0000
Subject: Re: [PATCH 06/34] drm/i915: convert put_page() to put_user_page*()
Message-Id: <22c309f6-a7ca-2624-79c3-b16a1487f488@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-7-jhubbard@nvidia.com>
 <156473756254.19842.12384378926183716632@jlahtine-desk.ger.corp.intel.com>
 <7d9a9c57-4322-270b-b636-7214019f87e9@nvidia.com>
In-Reply-To: <7d9a9c57-4322-270b-b636-7214019f87e9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, john.hubbard@gmail.com
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, devel@lists.orangefs.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mm@kvack.org

On 8/2/19 11:48 AM, John Hubbard wrote:
> On 8/2/19 2:19 AM, Joonas Lahtinen wrote:
>> Quoting john.hubbard@gmail.com (2019-08-02 05:19:37)
>>> From: John Hubbard <jhubbard@nvidia.com>
...
> In order to deal with the merge problem, I'll drop this patch from my series,
> and I'd recommend that the drm-intel-next take the following approach:

Actually, I just pulled the latest linux.git, and there are a few changes:

> 
> 1) For now, s/put_page/put_user_page/ in i915_gem_userptr_put_pages(),
> and fix up the set_page_dirty() --> set_page_dirty_lock() issue, like this
> (based against linux.git):
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index 528b61678334..94721cc0093b 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -664,10 +664,10 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object *obj,
> 
>         for_each_sgt_page(page, sgt_iter, pages) {
>                 if (obj->mm.dirty)
> -                       set_page_dirty(page);
> +                       set_page_dirty_lock(page);

I see you've already applied this fix to your tree, in linux.git already.

> 
>                 mark_page_accessed(page);
> -               put_page(page);
> +               put_user_page(page);

But this conversion still needs doing. So I'll repost a patch that only does 
this (plus the other call sites). 

That can go in via either your tree, or Andrew's -mm tree, without generating
any conflicts.

thanks,
-- 
John Hubbard
NVIDIA
