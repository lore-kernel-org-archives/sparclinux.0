From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 09 Aug 2019 12:20:40 +0000
Subject: Re: [PATCH v3 38/41] powerpc: convert put_page() to put_user_page*()
Message-Id: <875zn6ttrb.fsf@concordia.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
 <20190807013340.9706-39-jhubbard@nvidia.com>
 <87k1botdpx.fsf@concordia.ellerman.id.au>
 <248c9ab2-93cc-6d8b-606d-d85b83e791e5@nvidia.com>
In-Reply-To: <248c9ab2-93cc-6d8b-606d-d85b83e791e5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?utf-8?B?SsOpcsO0?= =?utf-8?B?bWU=?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-ar

John Hubbard <jhubbard@nvidia.com> writes:
> On 8/7/19 10:42 PM, Michael Ellerman wrote:
>> Hi John,
>> 
>> john.hubbard@gmail.com writes:
>>> diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
>>> index b056cae3388b..e126193ba295 100644
>>> --- a/arch/powerpc/mm/book3s64/iommu_api.c
>>> +++ b/arch/powerpc/mm/book3s64/iommu_api.c
>>> @@ -203,6 +202,7 @@ static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
>>>  {
>>>  	long i;
>>>  	struct page *page = NULL;
>>> +	bool dirty = false;
>> 
>> I don't think you need that initialisation do you?
>> 
>
> Nope, it can go. Fixed locally, thanks.

Thanks.

> Did you get a chance to look at enough of the other bits to feel comfortable 
> with the patch, overall?

Mostly :) It's not really my area, but all the conversions looked
correct to me as best as I could tell.

So I'm fine for it to go in as part of the series:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
