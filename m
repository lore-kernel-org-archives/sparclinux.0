From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Wed, 05 Dec 2018 17:55:17 +0000
Subject: Re: [mm PATCH v6 6/7] mm: Add reserved flag setting to set_page_links
Message-Id: <19c9f0fe83a857d5858c386a08ca2ddeba7cf27b.camel@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: 
	<154361452447.7497.1348692079883153517.stgit@ahduyck-desk1.amr.corp.intel.com>
	 <154361479877.7497.2824031260670152276.stgit@ahduyck-desk1.amr.corp.intel.com>
	 <20181205172225.GT1286@dhcp22.suse.cz>
In-Reply-To: <20181205172225.GT1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, davem@davemloft.net, pavel.tatashin@microsoft.com, mingo@kernel.org, kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, yi.z.zhang@linux.intel.com

On Wed, 2018-12-05 at 18:22 +0100, Michal Hocko wrote:
> On Fri 30-11-18 13:53:18, Alexander Duyck wrote:
> > Modify the set_page_links function to include the setting of the reserved
> > flag via a simple AND and OR operation. The motivation for this is the fact
> > that the existing __set_bit call still seems to have effects on performance
> > as replacing the call with the AND and OR can reduce initialization time.
> > 
> > Looking over the assembly code before and after the change the main
> > difference between the two is that the reserved bit is stored in a value
> > that is generated outside of the main initialization loop and is then
> > written with the other flags field values in one write to the page->flags
> > value. Previously the generated value was written and then then a btsq
> > instruction was issued.
> > 
> > On my x86_64 test system with 3TB of persistent memory per node I saw the
> > persistent memory initialization time on average drop from 23.49s to
> > 19.12s per node.
> 
> I have tried to explain why the whole reserved bit doesn't make much
> sense in this code several times already. You keep ignoring that and
> that is highly annoying. Especially when you add a tricky code to
> optimize something that is not really needed.
> 
> Based on that I am not going to waste my time on other patches in this
> series to review and give feedback which might be ignored again.

I got your explanation. However Andrew had already applied the patches
and I had some outstanding issues in them that needed to be addressed.
So I thought it best to send out this set of patches with those fixes
before the code in mm became too stale. I am still working on what to
do about the Reserved bit, and plan to submit it as a follow-up set.
