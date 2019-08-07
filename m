From: John Hubbard <jhubbard@nvidia.com>
Date: Wed, 07 Aug 2019 01:49:55 +0000
Subject: Re: [PATCH v3 00/39] put_user_pages(): miscellaneous call sites
Message-Id: <912eb2bd-4102-05c1-5571-c261617ad30b@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 8/6/19 6:32 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> ...
> 
> John Hubbard (38):
>   mm/gup: add make_dirty arg to put_user_pages_dirty_lock()
...
>  54 files changed, 191 insertions(+), 323 deletions(-)
> 
ahem, yes, apparently this is what happens if I add a few patches while editing
the cover letter... :) 

The subject line should read "00/41", and the list of files affected here is
therefore under-reported in this cover letter. However, the patch series itself is 
intact and ready for submission.

thanks,
-- 
John Hubbard
NVIDIA
