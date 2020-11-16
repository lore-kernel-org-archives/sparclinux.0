From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 16 Nov 2020 16:57:07 +0000
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-Id: <20201116165707.GI3121392@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
 <20201116154357.bw64c5ie2kiu5l4x@box>
 <20201116155404.GD29991@casper.infradead.org>
 <eeec67f6-ea05-1115-f249-b6cdcf2c5e2c@intel.com>
 <20201116163213.GG29991@casper.infradead.org>
 <3f2239fe-367a-16de-fcb5-543d39f34c22@intel.com>
In-Reply-To: <3f2239fe-367a-16de-fcb5-543d39f34c22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, kirill.shutemov@linux.intel.com

On Mon, Nov 16, 2020 at 08:36:36AM -0800, Dave Hansen wrote:
> On 11/16/20 8:32 AM, Matthew Wilcox wrote:
> >>
> >> That's really the best we can do from software without digging into
> >> microarchitecture-specific events.
> > I mean this is perf.  Digging into microarch specific events is what it
> > does ;-)
> 
> Yeah, totally.

Sure, but the automatic promotion/demotion of TLB sizes is not visible
if you don't know what you startd out with.

> But, if we see a bunch of 4k TLB hit events, it's still handy to know
> that those 4k TLB hits originated from a 2M page table entry.  This
> series just makes sure that perf has the data about the page table
> mapping sizes regardless of what the microarchitecture does with it.

This. 
