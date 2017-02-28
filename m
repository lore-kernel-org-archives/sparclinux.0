From: Matthew Wilcox <willy@infradead.org>
Date: Tue, 28 Feb 2017 19:58:24 +0000
Subject: Re: [PATCH v1 1/3] sparc64: NG4 memset/memcpy 32 bits overflow
Message-Id: <20170228195824.GG16328@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1488293746-965735-1-git-send-email-pasha.tatashin@oracle.com>
 <1488293746-965735-2-git-send-email-pasha.tatashin@oracle.com>
 <20170228.101218.983689349992464602.davem@davemloft.net>
 <e196c73e-937c-50fa-ed19-a10372548fb7@oracle.com>
 <20170228185914.GF16328@bombadil.infradead.org>
 <a3a3a887-c7be-eb31-b73f-e179162fde93@oracle.com>
In-Reply-To: <a3a3a887-c7be-eb31-b73f-e179162fde93@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: David Miller <davem@davemloft.net>, linux-mm@kvack.org, sparclinux@vger.kernel.org

On Tue, Feb 28, 2017 at 02:34:17PM -0500, Pasha Tatashin wrote:
> Hi Matthew,
> 
> Thank you for your comments, my replies below:
> 
> On 02/28/2017 01:59 PM, Matthew Wilcox wrote:
> > ... what algorithms are deemed "inefficient" when they take a break every
> > 2 billion bytes to, ohidon'tknow, check to see that a higher priority
> > process doesn't want the CPU?
> 
> I do not see that NG4memcpy() is disabling interrupts so there should not be
> any issues with letting higher priority processes to interrupt and do their
> work. And, as I said my point was mostly for consideration, I will revert
> that bound check in NG4memcpy() to the 2G limit.

That's not how it works in Linux.  Unless you've configured your kernel
with PREEMPT, threads are not preempted while they're inside the kernel.
See cond_resched() in include/linux/sched.h.

> > Right, so suppose you're copying half the memory to the other half of
> > memory.  Let's suppose it takes a hundred extra instructions every 2GB to
> > check that nobody else wants the CPU and dive back into the memcpy code.
> > That's 800,000 additional instructions.  Which even on a SPARC CPU is
> > going to execute in less than 0.001 second.  CPU memory bandwidth is
> > on the order of 100GB/s, so the overall memcpy is going to take about
> > 160 seconds.
> 
> Sure, the computational overhead is minimal, but still adding and
> maintaining extra code to break-up a single memcpy() has its cost. For
> example: as far I as can tell x86 and powerpc memcpy()s do not have this
> limit, which means that an author of a driver would have to explicitly
> divide memcpy()s into 2G chunks only to work on SPARC (and know about this
> limit too!). If there is a driver that has a memory proportional data
> structure it is possible it will panic the kernel once such driver is
> attached on a larger memory machine.

Ah, now that is a good point.  We should insert such a limit into all
the architectural memcpy() implementations and the default implementation
in lib/.  This should not affect any drivers; it is almost impossible to
allocate 2GB of memory.  kmalloc won't do it, alloc_pages won't do it.
vmalloc will do it (maybe it shouldn't?) but I have a hard time thinking
of a good reason for a driver to allocate that much memory.

