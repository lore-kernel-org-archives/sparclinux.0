From: John Hubbard <jhubbard@nvidia.com>
Date: Fri, 30 Aug 2019 02:21:03 +0000
Subject: Re: [PATCH v3 00/39] put_user_pages(): miscellaneous call sites
Message-Id: <d453f865-2224-ed53-a2f4-f43d574c130a@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
 <912eb2bd-4102-05c1-5571-c261617ad30b@nvidia.com>
 <CAOg9mSQKGDywcMde2DE42diUS7J8m74Hdv+xp_PJhC39EXZQuw@mail.gmail.com>
In-Reply-To: <CAOg9mSQKGDywcMde2DE42diUS7J8m74Hdv+xp_PJhC39EXZQuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm <linux-mm@kvack.org>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org, john.hubbard@gmail.com, linux-block@vger.kernel.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel <ceph-devel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux NFS Mailing List <linux-nfs@vger.kernel.org>

On 8/29/2019 6:29 PM, Mike Marshall wrote:
> Hi John...
> 
> I added this patch series on top of Linux 5.3rc6 and ran
> xfstests with no regressions...
> 
> Acked-by: Mike Marshall <hubcap@omnibond.com>
> 

Hi Mike (and I hope Ira and others are reading as well, because
I'm making a bunch of claims further down),

That's great news, thanks for running that test suite and for
the report and the ACK.

There is an interesting pause right now, due to the fact that
we've made some tentative decisions about gup pinning, that affect
the call sites. A key decision is that only pages that were
requested via FOLL_PIN, will require put_user_page*() to release
them. There are 4 main cases, which were first explained by Jan
Kara and Vlastimil Babka, and are now written up in my FOLL_PIN
patch [1].

So, what that means for this series is that:

1. Some call sites (mlock.c for example, and a lot of the mm/ files
in fact, and more) will not be converted: some of these patches will
get dropped, especially in mm/.

2. Call sites that do DirectIO or RDMA will need to set FOLL_PIN, and
will also need to call put_user_page().

3. Call sites that do RDMA will need to set FOLL_LONGTERM *and* FOLL_PIN,

    3.a. ...and will at least in some cases need to provide a link to a
    vaddr_pin object, and thus back to a struct file*...maybe. Still
    under discussion.

4. It's desirable to keep FOLL_* flags (or at least FOLL_PIN) internal
to the gup() calls. That implies using a wrapper call such as Ira's
vaddr_pin_[user]_pages(), instead of gup(), and vaddr_unpin_[user]_pages()
instead of put_user_page*().

5. We don't want to churn the call sites unnecessarily.

With that in mind, I've taken another pass through all these patches
and narrowed it down to:

     a) 12 call sites that I'd like to convert soon, but even those
        really look cleaner with a full conversion to a wrapper call
        similar to (identical to?) vaddr_pin_[user]_pages(), probably
        just the FOLL_PIN only variant (not FOLL_LONGTERM). That
        wrapper call is not ready yet, though.

     b) Some more call sites that require both FOLL_PIN and FOLL_LONGTERM.
        Definitely will wait to use the wrapper calls for these, because
        they may also require hooking up to a struct file*.

     c) A few more that were already applied, which is fine, because they
        show where to convert, and simplify a few sites anyway. But they'll
        need follow-on changes to, one way or another, set FOLL_PIN.

     d) And of course a few sites whose patches get dropped, as mentioned
        above.

[1] https://lore.kernel.org/r/20190821040727.19650-3-jhubbard@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA
