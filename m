From: Daniel Jordan <daniel.m.jordan@oracle.com>
Date: Mon, 12 Nov 2018 16:25:52 +0000
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-Id: <20181112162551.ot6q7r56unovlaon@ca-dmjordan1.us.oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
 <18b6634b912af7b4ec01396a2b0f3b31737c9ea2.camel@linux.intel.com>
 <20181110000006.tmcfnzynelaznn7u@xakep.localdomain>
In-Reply-To: <20181110000006.tmcfnzynelaznn7u@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, daniel.m.jordan@oracle.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, davem@davemloft.net, pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org, kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, yi.z.zhang@linux.intel.com

On Fri, Nov 09, 2018 at 07:00:06PM -0500, Pavel Tatashin wrote:
> On 18-11-09 15:14:35, Alexander Duyck wrote:
> > On Fri, 2018-11-09 at 16:15 -0500, Pavel Tatashin wrote:
> > > On 18-11-05 13:19:25, Alexander Duyck wrote:
> > > > This patchset is essentially a refactor of the page initialization logic
> > > > that is meant to provide for better code reuse while providing a
> > > > significant improvement in deferred page initialization performance.
> > > > 
> > > > In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> > > > memory per node I have seen the following. In the case of regular memory
> > > > initialization the deferred init time was decreased from 3.75s to 1.06s on
> > > > average. For the persistent memory the initialization time dropped from
> > > > 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> > > > deferred memory initialization performance, and a 26% improvement in the
> > > > persistent memory initialization performance.
> > > 
> > > Hi Alex,
> > > 
> > > Please try to run your persistent memory init experiment with Daniel's
> > > patches:
> > > 
> > > https://lore.kernel.org/lkml/20181105165558.11698-1-daniel.m.jordan@oracle.com/
> > 
> > I've taken a quick look at it. It seems like a bit of a brute force way
> > to try and speed things up. I would be worried about it potentially
> 
> There is a limit to max number of threads that ktasks start. The memory
> throughput is *much* higher than what one CPU can maxout in a node, so
> there is no reason to leave the other CPUs sit idle during boot when
> they can help to initialize.
> 
> > introducing performance issues if the number of CPUs thrown at it end
> > up exceeding the maximum throughput of the memory.
> > 
> > The data provided with patch 11 seems to point to issues such as that.
> > In the case of the E7-8895 example cited it is increasing the numbers
> > of CPUs used from memory initialization from 8 to 72, a 9x increase in
> > the number of CPUs but it is yeilding only a 3.88x speedup.
> 
> Yes, but in both cases we are far from maxing out the memory throughput.
> The 3.88x is indeed low, and I do not know what slows it down.
> 
> Daniel,
> 
> Could you please check why multi-threading efficiency is so low here?

I'll hop on the machine after Plumbers.

> I bet, there is some atomic operation introduces a contention within a
> node. It should be possible to resolve.

We'll see, in any case I'm curious to see what the multithreading does with
Alex's patches, especially since we won't do two passes through the memory
anymore.

Not seeing anything in Alex's work right off that would preclude
multithreading.
