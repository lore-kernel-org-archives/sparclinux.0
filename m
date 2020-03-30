From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 30 Mar 2020 09:21:27 +0000
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Message-Id: <20200330092127.GB30942@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
In-Reply-To: <20200330074246.GA14243@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: mmorana@amperecomputing.com, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Hoan Tran <Hoan@os.amperecomputing.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, lho@amperecomputing.com, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Mon, Mar 30, 2020 at 09:42:46AM +0200, Michal Hocko wrote:
> On Sat 28-03-20 11:31:17, Hoan Tran wrote:
> > In NUMA layout which nodes have memory ranges that span across other nodes,
> > the mm driver can detect the memory node id incorrectly.
> > 
> > For example, with layout below
> > Node 0 address: 0000 xxxx 0000 xxxx
> > Node 1 address: xxxx 1111 xxxx 1111
> > 
> > Note:
> >  - Memory from low to high
> >  - 0/1: Node id
> >  - x: Invalid memory of a node
> > 
> > When mm probes the memory map, without CONFIG_NODES_SPAN_OTHER_NODES
> > config, mm only checks the memory validity but not the node id.
> > Because of that, Node 1 also detects the memory from node 0 as below
> > when it scans from the start address to the end address of node 1.
> > 
> > Node 0 address: 0000 xxxx xxxx xxxx
> > Node 1 address: xxxx 1111 1111 1111
> > 
> > This layout could occur on any architecture. Most of them enables
> > this config by default with CONFIG_NUMA. This patch, by default, enables
> > CONFIG_NODES_SPAN_OTHER_NODES or uses early_pfn_in_nid() for NUMA.
> 
> I am not opposed to this at all. It reduces the config space and that is
> a good thing on its own. The history has shown that meory layout might
> be really wild wrt NUMA. The config is only used for early_pfn_in_nid
> which is clearly an overkill.
> 
> Your description doesn't really explain why this is safe though. The
> history of this config is somehow messy, though. Mike has tried
> to remove it a94b3ab7eab4 ("[PATCH] mm: remove arch independent
> NODES_SPAN_OTHER_NODES") just to be reintroduced by 7516795739bd
> ("[PATCH] Reintroduce NODES_SPAN_OTHER_NODES for powerpc") without any
> reasoning what so ever. This doesn't make it really easy see whether
> reasons for reintroduction are still there. Maybe there are some subtle
> dependencies. I do not see any TBH but that might be burried deep in an
> arch specific code.

Well, back then early_pfn_in_nid() was arch-dependant, today everyone
except ia64 rely on HAVE_MEMBLOCK_NODE_MAP. So, if the memblock node map
is correct, that using CONFIG_NUMA instead of CONFIG_NODES_SPAN_OTHER_NODES
would only mean that early_pfn_in_nid() will cost several cycles more on
architectures that didn't select CONFIG_NODES_SPAN_OTHER_NODES (i.e. arm64
and sh).
Agian, ia64 is an exception here.


> > v3:
> >  * Revise the patch description
> > 
> > V2:
> >  * Revise the patch description
> > 
> > Hoan Tran (5):
> >   mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
> >   powerpc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> >   x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> >   sparc: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> >   s390: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
> > 
> >  arch/powerpc/Kconfig | 9 ---------
> >  arch/s390/Kconfig    | 8 --------
> >  arch/sparc/Kconfig   | 9 ---------
> >  arch/x86/Kconfig     | 9 ---------
> >  mm/page_alloc.c      | 2 +-
> >  5 files changed, 1 insertion(+), 36 deletions(-)
> > 
> > -- 
> > 1.8.3.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
