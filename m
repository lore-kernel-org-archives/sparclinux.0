From: Juergen Gross <jgross@suse.com>
Date: Mon, 05 Aug 2019 04:15:27 +0000
Subject: Re: [PATCH v2 20/34] xen: convert put_page() to put_user_page*()
Message-Id: <82afb221-52a2-b399-46f5-0ee1f21c3417@suse.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190804224915.28669-1-jhubbard@nvidia.com>
 <20190804224915.28669-21-jhubbard@nvidia.com>
In-Reply-To: <20190804224915.28669-21-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: devel@driverdev.osuosl.org, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, x86@kernel.org, linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devel@lists.orangefs.org, xen-devel@lists.xenproject.org, John Hubbard <jhubbard@nvidia.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, rds-devel@oss.oracle.com, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kerne

On 05.08.19 00:49, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> This also handles pages[i] = NULL cases, thanks to an approach
> that is actually written by Juergen Gross.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: xen-devel@lists.xenproject.org
> ---
> 
> Hi Juergen,
> 
> Say, this is *exactly* what you proposed in your gup.patch, so
> I've speculatively added your Signed-off-by above, but need your
> approval before that's final. Let me know please...

Yes, that's fine with me.


Juergen
