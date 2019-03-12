From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Tue, 12 Mar 2019 22:50:36 +0000
Subject: Re: [mm PATCH v6 6/7] mm: Add reserved flag setting to set_page_links
Message-Id: <4c72a04bb87e341ea7c747d509f42136a99a0716.camel@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: 
	<154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com>
	 <154361479877.7497.2824031260670152276.stgit@ahduyck-desk1.amr.corp.intel.com>
	 <20181205172225.GT1286@dhcp22.suse.cz>
	 <19c9f0fe83a857d5858c386a08ca2ddeba7cf27b.camel@linux.intel.com>
	 <20181205204247.GY1286@dhcp22.suse.cz>
	 <20190312150727.cb15cbc323a742e520b9a881@linux-foundation.org>
In-Reply-To: <20190312150727.cb15cbc323a742e520b9a881@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, davem@davemloft.net, pavel.tatashin@microsoft.com, mingo@kernel.org, kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, yi.z.zhang@linux.intel.com

On Tue, 2019-03-12 at 15:07 -0700, Andrew Morton wrote:
> On Wed, 5 Dec 2018 21:42:47 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > I got your explanation. However Andrew had already applied the patches
> > > and I had some outstanding issues in them that needed to be addressed.
> > > So I thought it best to send out this set of patches with those fixes
> > > before the code in mm became too stale. I am still working on what to
> > > do about the Reserved bit, and plan to submit it as a follow-up set.
> > > From my experience Andrew can drop patches between different versions of
> > the patchset. Things can change a lot while they are in mmotm and under
> > the discussion.
> 
> It's been a while and everyone has forgotten everything, so I'll drop
> this version of the patchset.
> 

As far as getting to the reserved bit I probably won't have the time in
the near future. If I were to resubmit the first 4 patches as a
standalone patch set would that be acceptable, or would they be held up
as well until the reserved bit issues is addressed?

- Alex
