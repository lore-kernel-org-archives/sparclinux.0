From: Keith Busch <keith.busch@intel.com>
Date: Fri, 02 Aug 2019 14:19:52 +0000
Subject: Re: [PATCH 26/34] mm/gup_benchmark.c: convert put_page() to put_user_page*()
Message-Id: <20190802141952.GA18214@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-27-jhubbard@nvidia.com>
In-Reply-To: <20190802022005.5117-27-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john.hubbard@gmail.com
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kerne

On Thu, Aug 01, 2019 at 07:19:57PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks fine.

Reviewed-by: Keith Busch <keith.busch@intel.com>

>  mm/gup_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index 7dd602d7f8db..515ac8eeb6ee 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -79,7 +79,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  	for (i = 0; i < nr_pages; i++) {
>  		if (!pages[i])
>  			break;
> -		put_page(pages[i]);
> +		put_user_page(pages[i]);
>  	}
>  	end_time = ktime_get();
>  	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
> -- 
