From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 24 Oct 2018 12:36:40 +0000
Subject: Re: [mm PATCH v3 4/6] mm: Move hot-plug specific memory init into separate functions and optimize
Message-Id: <20181024123640.GF18839@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202716.2171.7284.stgit@localhost.localdomain>
 <20181017091824.GL18839@dhcp22.suse.cz>
 <d9011108-4099-58dc-8b8c-110c5f2a3674@linux.intel.com>
In-Reply-To: <d9011108-4099-58dc-8b8c-110c5f2a3674@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, pavel.tatashin@microsoft.com, dave.jiang@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, davem@davemloft.net, yi.z.zhang@linux.intel.com, khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz, sparclinux@vger.kernel.org, dan.j.williams@intel.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, mingo@kernel.org, kirill.shutemov@linux.intel.com

On Wed 17-10-18 08:26:20, Alexander Duyck wrote:
[...]
> With that said I am also wondering if a possible solution to the complaints
> you had would be to look at just exporting the __init_pageblock function
> later and moving the call to memmap_init_zone_device out to the memremap or
> hotplug code when Dan gets the refactoring for HMM and memremap all sorted
> out.

Why cannot we simply provide a constructor for each page by the caller
if there are special requirements? we currently have alt_map to do
struct page allocation but nothing really prevents to make it more
generic and control both allocation and initialization whatever suits a
specific usecase. I really do not want make special cases here and
there.
-- 
Michal Hocko
SUSE Labs
