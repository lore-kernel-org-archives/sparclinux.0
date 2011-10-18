From: David Miller <davem@davemloft.net>
Date: Tue, 18 Oct 2011 20:53:53 +0000
Subject: Re: longjmp question
Message-Id: <20111018.165353.281113564391297020.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 18 Oct 2011 21:46:20 +0100

> Finally, the "failing" memcpy is also easy to explain now: when we 
> invoke the memcpy, we do it with the correct arguments, but we really 
> do have incorrect memory contents in the source buffer, which end up 
> in the destination. However, as soon as gdb breaks, it flushes *all* 
> register windows of the interrupted process, including the current 
> one, altering the memory contents of the source buffer, and making it 
> appear like memcpy failed to synchronize the source and the 
> destination.

Now this makes a lot of sense, thanks for working to get to the bottom
of this.

I would suggest fixing this in Ruby by one or two possible methods:

1) Always do "ta 0x03", this is the simplest but most expensive fix.

2) Force the "flushw" into a helper function and force GCC to allocate
   a register window by clobbering the return address register, something
   like:

	void flushw_helper(void)
	{
	  /* Clobber %o7 so that the compiler is forced to allocate
	     a register window for this function.  */
	  __asm__ __volatile__("flushw" : : : "o7");
	}

   That results (on 32-bit) in something like:

	save	%sp, -96, %sp
	flushw
	return	%i7 + 8
	 nop

   which gives us exactly what we need.

Thanks again Jurij.
