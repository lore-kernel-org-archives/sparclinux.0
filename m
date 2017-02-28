From: Matthew Wilcox <willy@infradead.org>
Date: Tue, 28 Feb 2017 18:59:14 +0000
Subject: Re: [PATCH v1 1/3] sparc64: NG4 memset/memcpy 32 bits overflow
Message-Id: <20170228185914.GF16328@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1488293746-965735-1-git-send-email-pasha.tatashin@oracle.com>
 <1488293746-965735-2-git-send-email-pasha.tatashin@oracle.com>
 <20170228.101218.983689349992464602.davem@davemloft.net>
 <e196c73e-937c-50fa-ed19-a10372548fb7@oracle.com>
In-Reply-To: <e196c73e-937c-50fa-ed19-a10372548fb7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: David Miller <davem@davemloft.net>, linux-mm@kvack.org, sparclinux@vger.kernel.org

On Tue, Feb 28, 2017 at 10:56:57AM -0500, Pasha Tatashin wrote:
> Also, for consideration, machines are getting bigger, and 2G is becoming
> very small compared to the memory sizes, so some algorithms can become
> inefficient when they have to artificially limit memcpy()s to 2G chunks.

... what algorithms are deemed "inefficient" when they take a break every
2 billion bytes to, ohidon'tknow, check to see that a higher priority
process doesn't want the CPU?

> X6-8 scales up to 6T:
> http://www.oracle.com/technetwork/database/exadata/exadata-x6-8-ds-2968796.pdf
> 
> SPARC M7-16 scales up to 16T:
> http://www.oracle.com/us/products/servers-storage/sparc-m7-16-ds-2687045.pdf
> 
> 2G is just 0.012% of the total memory size on M7-16.

Right, so suppose you're copying half the memory to the other half of
memory.  Let's suppose it takes a hundred extra instructions every 2GB to
check that nobody else wants the CPU and dive back into the memcpy code.
That's 800,000 additional instructions.  Which even on a SPARC CPU is
going to execute in less than 0.001 second.  CPU memory bandwidth is
on the order of 100GB/s, so the overall memcpy is going to take about
160 seconds.

You'd have far more joy dividing the work up into 2GB chunks and
distributing the work to N CPU packages (... not hardware threads
...) than you would trying to save a millisecond by allowing the CPU to
copy more than 2GB at a time.
