From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 26 Nov 2020 13:06:19 +0000
Subject: Re: [PATCH v2 3/6] perf/core: Fix arch_perf_get_page_size()
Message-Id: <20201126130619.GI2414@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.164675154@infradead.org>
 <20201126123458.GO4327@casper.infradead.org>
 <20201126124207.GM3040@hirez.programming.kicks-ass.net>
 <20201126125606.GR4327@casper.infradead.org>
In-Reply-To: <20201126125606.GR4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Thu, Nov 26, 2020 at 12:56:06PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 01:42:07PM +0100, Peter Zijlstra wrote:
> > +	pgdp = pgd_offset(mm, addr);
> > +	pgd = READ_ONCE(*pgdp);
> 
> I forget how x86-32-PAE maps to Linux's PGD/P4D/PUD/PMD scheme, but
> according to volume 3, section 4.4.2, PAE paging uses a 64-bit PDE, so
> whether a PDE is a PGD or a PMD, we're only reading it with READ_ONCE
> rather than the lockless-retry method used by ptep_get_lockless().
> So it's potentially racy?  Do we need a pmdp_get_lockless() or
> pgdp_get_lockless()?

Oh gawd... this isn't new here though, right? Current gup_fast also gets
that wrong, if it is in deed wrong.

I suppose it's a race far more likely today, with THP and all, than it
ever was back then.
