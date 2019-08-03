From: Calum Mackay <calum.mackay@oracle.com>
Date: Sat, 03 Aug 2019 01:27:55 +0000
Subject: Re: [PATCH 31/34] nfs: convert put_page() to put_user_page*()
Message-Id: <1738cb1e-15d8-0bbe-5362-341664f6efc8@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-32-jhubbard@nvidia.com>
In-Reply-To: <20190802022005.5117-32-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, calum.mackay@oracle.com, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, Dan Williams <dan.j.williams@intel.com>, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-arm-kernel@lists.i

On 02/08/2019 3:20 am, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   fs/nfs/direct.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 0cb442406168..b00b89dda3c5 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -278,9 +278,7 @@ ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>   
>   static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
>   {
> -	unsigned int i;
> -	for (i = 0; i < npages; i++)
> -		put_page(pages[i]);
> +	put_user_pages(pages, npages);
>   }

Since it's static, and only called twice, might it be better to change 
its two callers [nfs_direct_{read,write}_schedule_iovec()] to call 
put_user_pages() directly, and remove nfs_direct_release_pages() entirely?

thanks,
calum.


>   
>   void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
> 
