From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 16 Nov 2020 16:55:04 +0000
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-Id: <20201116165504.GH3121392@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
 <20201116154357.bw64c5ie2kiu5l4x@box>
 <20201116155404.GD29991@casper.infradead.org>
 <eeec67f6-ea05-1115-f249-b6cdcf2c5e2c@intel.com>
In-Reply-To: <eeec67f6-ea05-1115-f249-b6cdcf2c5e2c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, kirill.shutemov@linux.intel.com

On Mon, Nov 16, 2020 at 08:28:23AM -0800, Dave Hansen wrote:
> On 11/16/20 7:54 AM, Matthew Wilcox wrote:
> > It gets even more complicated with CPUs with multiple levels of TLB
> > which support different TLB entry sizes.  My CPU reports:
> > 
> > TLB info
> >  Instruction TLB: 2M/4M pages, fully associative, 8 entries
> >  Instruction TLB: 4K pages, 8-way associative, 64 entries
> >  Data TLB: 1GB pages, 4-way set associative, 4 entries
> >  Data TLB: 4KB pages, 4-way associative, 64 entries
> >  Shared L2 TLB: 4KB/2MB pages, 6-way associative, 1536 entries
> 
> It's even "worse" on recent AMD systems.  Those will coalesce multiple
> adjacent PTEs into a single TLB entry.  I think Alphas did something
> like this back in the day with an opt-in.
> 
> Anyway, the changelog should probably replace:

ARM64 does too.

> > This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate TLB
> > page sizes.
> 
> with something more like:
> 
> This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate page
> table mapping sizes.

Sure.
