From: Jan Kara <jack@suse.cz>
Date: Fri, 02 Aug 2019 14:52:27 +0000
Subject: Re: [PATCH 00/34] put_user_pages(): miscellaneous call sites
Message-Id: <20190802145227.GQ25064@quack2.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802091244.GD6461@dhcp22.suse.cz>
 <20190802124146.GL25064@quack2.suse.cz>
 <20190802142443.GB5597@bombadil.infradead.org>
In-Reply-To: <20190802142443.GB5597@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, john.hubbard@gmail.com, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, linux-arm

On Fri 02-08-19 07:24:43, Matthew Wilcox wrote:
> On Fri, Aug 02, 2019 at 02:41:46PM +0200, Jan Kara wrote:
> > On Fri 02-08-19 11:12:44, Michal Hocko wrote:
> > > On Thu 01-08-19 19:19:31, john.hubbard@gmail.com wrote:
> > > [...]
> > > > 2) Convert all of the call sites for get_user_pages*(), to
> > > > invoke put_user_page*(), instead of put_page(). This involves dozens of
> > > > call sites, and will take some time.
> > > 
> > > How do we make sure this is the case and it will remain the case in the
> > > future? There must be some automagic to enforce/check that. It is simply
> > > not manageable to do it every now and then because then 3) will simply
> > > be never safe.
> > > 
> > > Have you considered coccinele or some other scripted way to do the
> > > transition? I have no idea how to deal with future changes that would
> > > break the balance though.
> > 
> > Yeah, that's why I've been suggesting at LSF/MM that we may need to create
> > a gup wrapper - say vaddr_pin_pages() - and track which sites dropping
> > references got converted by using this wrapper instead of gup. The
> > counterpart would then be more logically named as unpin_page() or whatever
> > instead of put_user_page().  Sure this is not completely foolproof (you can
> > create new callsite using vaddr_pin_pages() and then just drop refs using
> > put_page()) but I suppose it would be a high enough barrier for missed
> > conversions... Thoughts?
> 
> I think the API we really need is get_user_bvec() / put_user_bvec(),
> and I know Christoph has been putting some work into that.  That avoids
> doing refcount operations on hundreds of pages if the page in question is
> a huge page.  Once people are switched over to that, they won't be tempted
> to manually call put_page() on the individual constituent pages of a bvec.

Well, get_user_bvec() is certainly a good API for one class of users but
just looking at the above series, you'll see there are *many* places that
just don't work with bvecs at all and you need something for those.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
