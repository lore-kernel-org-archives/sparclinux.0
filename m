From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Mon, 07 Jan 2008 04:45:07 +0000
Subject: Re: [RFC PATCH 10/11] mcount tracer show task comm and pid
Message-Id: <20080107044506.GA1798@Krystal>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072228.212967487@goodmis.org> <20080103175650.GE30582@Krystal> <20080106153758.GA27863@elte.hu>
In-Reply-To: <20080106153758.GA27863@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > > @@ -34,6 +34,7 @@ mctracer_add_trace_entry(struct mctracer
> > >  {
> > >  	unsigned long idx, idx_next;
> > >  	struct mctracer_entry *entry;
> > > +	struct task_struct *tsk = current;
> > 
> > Aren't there situations, like in the middle of a context switch, where 
> > current is not valid ? Is also poses a problem for early boot, and NMI 
> > tracing.
> 
> no such problems on x86.
> 
> 	Ingo

I based my comments on the following code snippet, but I think I start
to understand what makes it "so special"

arch/x86/mm/fault_32.c :

static inline int vmalloc_fault(unsigned long address)
{
        unsigned long pgd_paddr;
        pmd_t *pmd_k;
        pte_t *pte_k;
        /*
         * Synchronize this task's top level page-table
         * with the 'reference' page table.
         *
---->    * Do _not_ use "current" here. We might be inside
         * an interrupt in the middle of a task switch..
         */
        pgd_paddr = read_cr3();
        pmd_k = vmalloc_sync_one(__va(pgd_paddr), address);
        if (!pmd_k)
                return -1;
        pte_k = pte_offset_kernel(pmd_k, address);
        if (!pte_present(*pte_k))
                return -1;
        return 0;
}

At context switch on x86, loading the registers is done first, and only
after the is the current pointer set. However, for vmalloc faults, it's
the value in the cr3 register that is important, which may not
correspond to the cr3 value saved in "current".

So, I think using the "pid" and "comm" fields of current, even in NMI
context, is not a problem, just as you said. For early boot, the current
task will be init_task, which has pid = 0 and comm = "swapper", still
ok.

Thanks for pointing it out.

Mathieu

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
