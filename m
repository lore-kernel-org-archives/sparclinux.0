From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 20:50:34 +0000
Subject: Re: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120520.165034.517562105075597539.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519200321.GA7617@merkur.ravnborg.org>
In-Reply-To: <20120519200321.GA7617@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 22:44:47 +0200

> This is what I came up with - on top of the other patches I sent
> which introduced flushi().
> Only RFC for now - I plan to submit a longer set
> of patches that does most of the work to allow leon
> to be used in parallel with the sun platfroms.

Looks great.  If you want to get fancy you can write a macro for the
whole section dance and LEON insn entry stuff.

> The sparc64 code I copied the run-time patching from used
> the following sequence for flushing the ICache:
> 	
>                 wmb();
>                 __asm__ __volatile__("flush     %0" : : "r" (addr +  0));
> 
> Compare this to the flushi() variant:
> #define flushi(addr)    __asm__ __volatile__ ("flush %0" : : "r" (addr) : "memory")
> 
> As far as I understand the macros "wmb()" is just another way to tell
> gcc what it may do. And the "memory" clobber in flushi()
> serve the same purpose as wmb().
> 
> On sparc64 wmb() is: __asm__ __volatile__("":::"memory")
> 
> One could introduce flushi() in the relevant functions in setup_64.c..

On sparc64wmb() used to actually do something, with a membar (MEMory
BARrier) instruction, which sparc32 doesn't have and doesn't need.
