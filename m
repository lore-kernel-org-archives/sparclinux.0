From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 12 Nov 2004 21:39:55 +0000
Subject: Re: page.h question
Message-Id: <20041112133955.37515e8b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5628F39A-34F2-11D9-A583-000D93B069F6@verizon.net>
In-Reply-To: <5628F39A-34F2-11D9-A583-000D93B069F6@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 12 Nov 2004 16:32:21 -0500
Stanley Benoit <sbenoit@verizon.net> wrote:

> <--------------------     snip ------------------------>
> 
> /* I have my suspicions... -DaveM */
> 19 #define PAGE_SIZE    (1UL << PAGE_SHIFT)
> 20 #else
> 21 #define PAGE_SIZE    (1 << PAGE_SHIFT)
> 22 #endif
> 23 #define PAGE_MASK    (~(PAGE_SIZE-1))
> 24
> 
> <----------- end snip ----------------->
> 
> Does anyone know what Dave M. was suspicious about....?

The assembler doesn't grok the "UL" thing normal C
parsing does.

In the sparc64 headers we deal with this slightly more
elegantly using an "_AC()" macro which is defined as:

/* Some constant macros are used in both assembler and
 * C code.  Therefore we cannot annotate them always with
 * 'UL' and other type specificers unilaterally.  We
 * use the following macros to deal with this.
 */

#ifdef __ASSEMBLY__
#define _AC(X,Y)	X
#else
#define _AC(X,Y)	(X##Y)
#endif

This is in asm-sparc64/const.h
