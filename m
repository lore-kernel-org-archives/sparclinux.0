From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 15 Sep 2020 11:26:29 +0000
Subject: Re: [PATCH v2 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
Message-Id: <87lfhbp9ga.fsf@mpe.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com> <20200914045219.3736466-2-npiggin@gmail.com> <20200914105617.GP1362448@hirez.programming.kicks-ass.net> <1600137586.nypnz3sbcl.astroid@bobo.none>
In-Reply-To: <1600137586.nypnz3sbcl.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>, peterz@infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, "linux-mm @ kvack . org" <linux-mm@kvack.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from peterz@infradead.org's message of September 14, 2020 8:56 pm:
>> On Mon, Sep 14, 2020 at 02:52:16PM +1000, Nicholas Piggin wrote:
>>> Reading and modifying current->mm and current->active_mm and switching
>>> mm should be done with irqs off, to prevent races seeing an intermediate
>>> state.
...
>>> 
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> 
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> 
>> I'm thinking we want this selected on x86 as well. Andy?
>
> Thanks for the ack. The plan was to take it through the powerpc tree,
> but if you'd want x86 to select it, maybe a topic branch? Although
> Michael will be away during the next merge window so I don't want to
> get too fancy. Would you mind doing it in a follow up merge after
> powerpc, being that it's (I think) a small change?

Or get akpm to take the series, including the x86 change.

cheers
