From: John Hubbard <jhubbard@nvidia.com>
Date: Fri, 02 Aug 2019 18:51:14 +0000
Subject: Re: [PATCH 16/34] drivers/tee: convert put_page() to put_user_page*()
Message-Id: <23cc9ac3-4b03-9187-aae6-d64ba8cfca00@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-17-jhubbard@nvidia.com>
 <CAHUa44G++iiwU62jj7QH=V3sr4z26sf007xrwWLPw6AAeMLAEw@mail.gmail.com>
In-Reply-To: <CAHUa44G++iiwU62jj7QH=V3sr4z26sf007xrwWLPw6AAeMLAEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Wiklander <jens.wiklander@linaro.org>, john.hubbard@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, devel@lists.orangefs.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-block@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>linux

On 8/1/19 11:29 PM, Jens Wiklander wrote:
> On Fri, Aug 2, 2019 at 4:20 AM <john.hubbard@gmail.com> wrote:
>>
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> For pages that were retained via get_user_pages*(), release those pages
>> via the new put_user_page*() routines, instead of via put_page() or
>> release_pages().
>>
>> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
>> ("mm: introduce put_user_page*(), placeholder versions").
>>
>> Cc: Jens Wiklander <jens.wiklander@linaro.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   drivers/tee/tee_shm.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> I suppose you're taking this via your own tree or such.
> 

Hi Jens,

Thanks for the ACK! I'm expecting that Andrew will take this through his
-mm tree, unless he pops up and says otherwise.

thanks,
-- 
John Hubbard
NVIDIA
