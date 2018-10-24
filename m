From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 24 Oct 2018 15:27:42 +0000
Subject: Re: [mm PATCH v3 4/6] mm: Move hot-plug specific memory init into separate functions and optimize
Message-Id: <20181024152742.GJ18839@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202716.2171.7284.stgit@localhost.localdomain>
 <20181017091824.GL18839@dhcp22.suse.cz>
 <d9011108-4099-58dc-8b8c-110c5f2a3674@linux.intel.com>
 <20181024123640.GF18839@dhcp22.suse.cz>
 <40b17814b2a65531c5059e52a61c8f41b9603904.camel@linux.intel.com>
In-Reply-To: <40b17814b2a65531c5059e52a61c8f41b9603904.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, pavel.tatashin@microsoft.com, dave.jiang@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, davem@davemloft.net, yi.z.zhang@linux.intel.com, khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz, sparclinux@vger.kernel.org, dan.j.williams@intel.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, mingo@kernel.org, kirill.shutemov@linux.intel.com

On Wed 24-10-18 08:08:41, Alexander Duyck wrote:
> On Wed, 2018-10-24 at 14:36 +0200, Michal Hocko wrote:
> > On Wed 17-10-18 08:26:20, Alexander Duyck wrote:
> > [...]
> > > With that said I am also wondering if a possible solution to the
> > > complaints
> > > you had would be to look at just exporting the __init_pageblock
> > > function
> > > later and moving the call to memmap_init_zone_device out to the
> > > memremap or
> > > hotplug code when Dan gets the refactoring for HMM and memremap all
> > > sorted
> > > out.
> > 
> > Why cannot we simply provide a constructor for each page by the
> > caller if there are special requirements? we currently have alt_map
> > to do struct page allocation but nothing really prevents to make it
> > more generic and control both allocation and initialization whatever
> > suits a specific usecase. I really do not want make special cases
> > here and there.
> 
> The advantage to the current __init_pageblock function is that we end
> up constructing everything we are going to write outside of the main
> loop and then are focused only on init.

But we do really want move_pfn_range_to_zone to provide a usable pfn
range without any additional tweaks. If there are potential
optimizations to be done there then let's do it but please do not try to
micro optimize to the point that the interface doesn't make any sense
anymore.
-- 
Michal Hocko
SUSE Labs
