From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 09 Jan 2008 16:45:38 +0000
Subject: Re: [RFC PATCH 10/11] mcount tracer show task comm and pid
Message-Id: <20080109164538.GJ17739@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org> <20080103072228.212967487@goodmis.org> <20080103175650.GE30582@Krystal> <20080106153758.GA27863@elte.hu> <20080107044506.GA1798@Krystal>
In-Reply-To: <20080107044506.GA1798@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> static inline int vmalloc_fault(unsigned long address)
> {
>         unsigned long pgd_paddr;
>         pmd_t *pmd_k;
>         pte_t *pte_k;
>         /*
>          * Synchronize this task's top level page-table
>          * with the 'reference' page table.
>          *
> ---->    * Do _not_ use "current" here. We might be inside
>          * an interrupt in the middle of a task switch..
>          */
>         pgd_paddr = read_cr3();
>         pmd_k = vmalloc_sync_one(__va(pgd_paddr), address);
>         if (!pmd_k)
>                 return -1;
>         pte_k = pte_offset_kernel(pmd_k, address);
>         if (!pte_present(*pte_k))
>                 return -1;
>         return 0;
> }
> 
> At context switch on x86, loading the registers is done first, and 
> only after the is the current pointer set. However, for vmalloc 
> faults, it's the value in the cr3 register that is important, which 
> may not correspond to the cr3 value saved in "current".
> 
> So, I think using the "pid" and "comm" fields of current, even in NMI 
> context, is not a problem, just as you said. For early boot, the 
> current task will be init_task, which has pid = 0 and comm = 
> "swapper", still ok.

yeah - during the context-switch the value of 'current' might be 'stale' 
in a number of ways, but it's always atomically and coherently either 
pointing to the previous task or the next task. So from a tracing POV 
it's perfectly safe to use it (and we've been doing that for ages with 
the mcount stuff).

(The notrace mcount exclusions arent really to avoid any tracing 
badness, they are mostly to make the trace less spammy and more 
readable.)

	Ingo
