From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 28 Feb 2017 19:34:17 +0000
Subject: Re: [PATCH v1 1/3] sparc64: NG4 memset/memcpy 32 bits overflow
Message-Id: <a3a3a887-c7be-eb31-b73f-e179162fde93@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1488293746-965735-1-git-send-email-pasha.tatashin@oracle.com>
 <1488293746-965735-2-git-send-email-pasha.tatashin@oracle.com>
 <20170228.101218.983689349992464602.davem@davemloft.net>
 <e196c73e-937c-50fa-ed19-a10372548fb7@oracle.com>
 <20170228185914.GF16328@bombadil.infradead.org>
In-Reply-To: <20170228185914.GF16328@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: David Miller <davem@davemloft.net>, linux-mm@kvack.org, sparclinux@vger.kernel.org

Hi Matthew,

Thank you for your comments, my replies below:

On 02/28/2017 01:59 PM, Matthew Wilcox wrote:
> ... what algorithms are deemed "inefficient" when they take a break every
> 2 billion bytes to, ohidon'tknow, check to see that a higher priority
> process doesn't want the CPU?

I do not see that NG4memcpy() is disabling interrupts so there should 
not be any issues with letting higher priority processes to interrupt 
and do their work. And, as I said my point was mostly for consideration, 
I will revert that bound check in NG4memcpy() to the 2G limit.

> Right, so suppose you're copying half the memory to the other half of
> memory.  Let's suppose it takes a hundred extra instructions every 2GB to
> check that nobody else wants the CPU and dive back into the memcpy code.
> That's 800,000 additional instructions.  Which even on a SPARC CPU is
> going to execute in less than 0.001 second.  CPU memory bandwidth is
> on the order of 100GB/s, so the overall memcpy is going to take about
> 160 seconds.

Sure, the computational overhead is minimal, but still adding and 
maintaining extra code to break-up a single memcpy() has its cost. For 
example: as far I as can tell x86 and powerpc memcpy()s do not have this 
limit, which means that an author of a driver would have to explicitly 
divide memcpy()s into 2G chunks only to work on SPARC (and know about 
this limit too!). If there is a driver that has a memory proportional 
data structure it is possible it will panic the kernel once such driver 
is attached on a larger memory machine.

Another example is memblock allocator that is currently unconditionally 
calls memset() to zero all the allocated memory without breaking it up 
into pieces, and when other CPUs are not yet available to split the work 
to speed it up.

So, if a large chunk of memory is allocated via memblock() allocator, 
(as one example when booted with kernel parameter: "hashdist=0") we will 
have memset() called for 8G and 4G pieces of memory on machine with 7T 
of memory, and that will cause panic if we will add this bound limit to 
memset as well.

Thank you,
Pasha
