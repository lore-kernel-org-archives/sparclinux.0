From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 16 Nov 2020 15:54:04 +0000
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-Id: <20201116155404.GD29991@casper.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
 <20201116154357.bw64c5ie2kiu5l4x@box>
In-Reply-To: <20201116154357.bw64c5ie2kiu5l4x@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Mon, Nov 16, 2020 at 06:43:57PM +0300, Kirill A. Shutemov wrote:
> On Fri, Nov 13, 2020 at 12:19:01PM +0100, Peter Zijlstra wrote:
> > Hi,
> > 
> > These patches provide generic infrastructure to determine TLB page size from
> > page table entries alone. Perf will use this (for either data or code address)
> > to aid in profiling TLB issues.
> 
> I'm not sure it's an issue, but strictly speaking, size of page according
> to page table tree doesn't mean pagewalk would fill TLB entry of the size.
> CPU may support 1G pages in page table tree without 1G TLB at all.
> 
> IIRC, current Intel CPU still don't have any 1G iTLB entries and fill 2M
> iTLB instead.

It gets even more complicated with CPUs with multiple levels of TLB
which support different TLB entry sizes.  My CPU reports:

TLB info
 Instruction TLB: 2M/4M pages, fully associative, 8 entries
 Instruction TLB: 4K pages, 8-way associative, 64 entries
 Data TLB: 1GB pages, 4-way set associative, 4 entries
 Data TLB: 4KB pages, 4-way associative, 64 entries
 Shared L2 TLB: 4KB/2MB pages, 6-way associative, 1536 entries

I'm not quite sure what the rules are for evicting a 1GB entry in the
dTLB into the s2TLB.  I've read them for so many different processors,
I get quite confused.  Some CPUs fracture them; others ditch them entirely
and will look them up again if needed.

I think the architecture here is fine, but it'll need a little bit of
finagling to maybe pass i-vs-d to the pXd_leaf_size() routines, and x86
will need an implementation of pud_leaf_size() which interrogates the
TLB info to find out what size TLB entry will actually be used.
