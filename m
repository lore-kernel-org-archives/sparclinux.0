From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 11 Aug 2017 15:22:41 +0000
Subject: Re: [v6 00/15] complete deferred page initialization
Message-Id: <20170811152240.GQ30811@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <20170811075826.GB30811@dhcp22.suse.cz>
 <23e22449-89f0-507d-e92a-9ee947a7c363@oracle.com>
In-Reply-To: <23e22449-89f0-507d-e92a-9ee947a7c363@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 11-08-17 11:13:07, Pasha Tatashin wrote:
> On 08/11/2017 03:58 AM, Michal Hocko wrote:
> >[I am sorry I didn't get to your previous versions]
> 
> Thank you for reviewing this work. I will address your comments, and
> send-out a new patches.
> 
> >>
> >>In this work we do the following:
> >>- Never read access struct page until it was initialized
> >
> >How is this enforced? What about pfn walkers? E.g. page_ext
> >initialization code (page owner in particular)
> 
> This is hard to enforce 100%. But, because we have a patch in this series
> that sets all memory that was allocated by memblock_virt_alloc_try_nid_raw()
> to ones with debug options enabled, and because Linux has a good set of
> asserts in place that check struct pages to be sane, especially the ones
> that are enabled with this config: CONFIG_DEBUG_VM_PGFLAGS. I was able to
> find many places in linux which accessed struct pages before
> __init_single_page() is performed, and fix them. Most of these places happen
> only when deferred struct page initialization code is enabled.

Yes, I am very well aware of how hard is this to guarantee. I was merely
pointing out that the changelog should be more verbose about your
testing and assumptions so that we can revalidate them.
-- 
Michal Hocko
SUSE Labs
