From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 26 Nov 2020 13:02:02 +0000
Subject: Re: [PATCH v2 1/6] mm/gup: Provide gup_get_pte() more generic
Message-Id: <20201126130202.GH2414@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.036370527@infradead.org>
 <20201126124300.GP4327@casper.infradead.org>
In-Reply-To: <20201126124300.GP4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Thu, Nov 26, 2020 at 12:43:00PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 01:01:15PM +0100, Peter Zijlstra wrote:
> > +#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
> > +/*
> > + * WARNING: only to be used in the get_user_pages_fast() implementation.
> > + * With get_user_pages_fast(), we walk down the pagetables without taking any
> > + * locks.  For this we would like to load the pointers atomically, but sometimes
> > + * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
> > + * we do have is the guarantee that a PTE will only either go from not present
> > + * to present, or present to not present or both -- it will not switch to a
> > + * completely different present page without a TLB flush in between; something
> > + * that we are blocking by holding interrupts off.
> 
> I feel like this comment needs some love.  How about:
> 
>  * For walking the pagetables without holding any locks.  Some architectures
>  * (eg x86-32 PAE) cannot load the entries atomically without using
>  * expensive instructions.  We are guaranteed that a PTE will only either go
>  * from not present to present, or present to not present -- it will not
>  * switch to a completely different present page without a TLB flush
>  * inbetween; which we are blocking by holding interrupts off.
> 
> And it would be nice to have an assertion that interrupts are disabled
> in the code.  Because comments are nice, but nobody reads them.

Quite agreed, I'll stick a separate patch on with the updated comment
and a lockdep_assert_irqs_disabled() in. I'm afraid that latter will make
for header soup though :/

We'll see, let the robots have it.
