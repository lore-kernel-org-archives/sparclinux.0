From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 02 Apr 2020 08:01:44 +0000
Subject: Re: [PATCH RFC] mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP (was: Re: [PATCH v3 0/5] mm: Enable CONFIG_
Message-Id: <20200402080144.GK22681@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200330074246.GA14243@dhcp22.suse.cz>
 <20200330092127.GB30942@linux.ibm.com>
 <20200330095843.GF14243@dhcp22.suse.cz>
 <20200331215618.GG30942@linux.ibm.com>
 <20200401054227.GC2129@MiWiFi-R3L-srv>
 <20200401075155.GH30942@linux.ibm.com>
In-Reply-To: <20200401075155.GH30942@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: mmorana@amperecomputing.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Hoan Tran <Hoan@os.amperecomputing.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, lho@amperecomputing.com, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed 01-04-20 10:51:55, Mike Rapoport wrote:
> Hi,
> 
> On Wed, Apr 01, 2020 at 01:42:27PM +0800, Baoquan He wrote:
[...]
> > From above information, we can remove HAVE_MEMBLOCK_NODE_MAP, and
> > replace it with CONFIG_NUMA. That sounds more sensible to store nid into
> > memblock when NUMA support is enabled.
>  
> Replacing CONFIG_HAVE_MEMBLOCK_NODE_MAP with CONFIG_NUMA will work, but
> this will not help cleaning up the whole node/zone initialization mess and
> we'll be stuck with two implementations.

Yeah, this is far from optimal.

> The overhead of enabling HAVE_MEMBLOCK_NODE_MAP is only for init time as
> most architectures will anyway discard the entire memblock, so having it in
> a UMA arch won't be a problem. The only exception is arm that uses
> memblock for pfn_valid(), here we may also think about a solution to
> compensate the addition of nid to the memblock structures. 

Well, we can make memblock_region->nid defined only for CONFIG_NUMA.
memblock_get_region_node would then unconditionally return 0 on UMA.
Essentially the same way we do NUMA for other MM code. I only see few
direct usage of region->nid.
-- 
Michal Hocko
SUSE Labs
