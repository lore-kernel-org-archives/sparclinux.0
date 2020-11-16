From: Dave Hansen <dave.hansen@intel.com>
Date: Mon, 16 Nov 2020 16:36:36 +0000
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-Id: <3f2239fe-367a-16de-fcb5-543d39f34c22@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201113111901.743573013@infradead.org>
 <20201116154357.bw64c5ie2kiu5l4x@box>
 <20201116155404.GD29991@casper.infradead.org>
 <eeec67f6-ea05-1115-f249-b6cdcf2c5e2c@intel.com>
 <20201116163213.GG29991@casper.infradead.org>
In-Reply-To: <20201116163213.GG29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, kirill.shutemov@linux.intel.com

On 11/16/20 8:32 AM, Matthew Wilcox wrote:
>>
>> That's really the best we can do from software without digging into
>> microarchitecture-specific events.
> I mean this is perf.  Digging into microarch specific events is what it
> does ;-)

Yeah, totally.

But, if we see a bunch of 4k TLB hit events, it's still handy to know
that those 4k TLB hits originated from a 2M page table entry.  This
series just makes sure that perf has the data about the page table
mapping sizes regardless of what the microarchitecture does with it.

I'm just saying we need to make the descriptions in this perf feature
specifically about the page tables, not the TLB.
