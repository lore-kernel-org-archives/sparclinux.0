From: Calum Mackay <calum.mackay@oracle.com>
Date: Sun, 04 Aug 2019 23:28:01 +0000
Subject: Re: [PATCH 31/34] nfs: convert put_page() to put_user_page*()
Message-Id: <03a81556-98a7-7edb-5989-b799ec99a072@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-32-jhubbard@nvidia.com>
 <1738cb1e-15d8-0bbe-5362-341664f6efc8@oracle.com>
 <db136399-ed87-56ea-bd6e-e5d29b145eda@nvidia.com>
In-Reply-To: <db136399-ed87-56ea-bd6e-e5d29b145eda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, calum.mackay@oracle.com, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org, Dan Williams <dan.j.williams@intel.com>, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.o

On 03/08/2019 2:41 am, John Hubbard wrote:
> On 8/2/19 6:27 PM, Calum Mackay wrote:
>> On 02/08/2019 3:20 am, john.hubbard@gmail.com wrote:
> ...
>> Since it's static, and only called twice, might it be better to change its two callers [nfs_direct_{read,write}_schedule_iovec()] to call put_user_pages() directly, and remove nfs_direct_release_pages() entirely?
>>
>> thanks,
>> calum.
>>
>>
>>>      void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
>>>
>   
> Hi Calum,
> 
> Absolutely! Is it OK to add your reviewed-by, with the following incremental
> patch made to this one?

Thanks John; looks good.

Reviewed-by: Calum Mackay <calum.mackay@oracle.com>

> 
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index b00b89dda3c5..c0c1b9f2c069 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -276,11 +276,6 @@ ssize_t nfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>          return nfs_file_direct_write(iocb, iter);
>   }
>   
> -static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
> -{
> -       put_user_pages(pages, npages);
> -}
> -
>   void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
>                                struct nfs_direct_req *dreq)
>   {
> @@ -510,7 +505,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
>                          pos += req_len;
>                          dreq->bytes_left -= req_len;
>                  }
> -               nfs_direct_release_pages(pagevec, npages);
> +               put_user_pages(pagevec, npages);
>                  kvfree(pagevec);
>                  if (result < 0)
>                          break;
> @@ -933,7 +928,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
>                          pos += req_len;
>                          dreq->bytes_left -= req_len;
>                  }
> -               nfs_direct_release_pages(pagevec, npages);
> +               put_user_pages(pagevec, npages);
>                  kvfree(pagevec);
>                  if (result < 0)
>                          break;
> 
> 
> 
> thanks,
> 
