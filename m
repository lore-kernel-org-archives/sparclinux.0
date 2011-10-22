From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 22 Oct 2011 09:00:24 +0000
Subject: Re: longjmp question
Message-Id: <20111022090023.GA8388@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 18, 2011 at 04:53:53PM -0400, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Tue, 18 Oct 2011 21:46:20 +0100
> 
> > Finally, the "failing" memcpy is also easy to explain now: when we 
> > invoke the memcpy, we do it with the correct arguments, but we really 
> > do have incorrect memory contents in the source buffer, which end up 
> > in the destination. However, as soon as gdb breaks, it flushes *all* 
> > register windows of the interrupted process, including the current 
> > one, altering the memory contents of the source buffer, and making it 
> > appear like memcpy failed to synchronize the source and the 
> > destination.
> 
> Now this makes a lot of sense, thanks for working to get to the bottom
> of this.
> 
> I would suggest fixing this in Ruby by one or two possible methods:
> 
> 1) Always do "ta 0x03", this is the simplest but most expensive fix.

It turns out that freebsd/sparc64 is also suffering from this bug, 
and, as far as I can tell, there is no equivalent of 'ta 0x03' there. 
So, to fix it in a more generic way we probably should push for the 
second option.
 
> 2) Force the "flushw" into a helper function and force GCC to allocate
>    a register window by clobbering the return address register, something
>    like:
> 
> 	void flushw_helper(void)
> 	{
> 	  /* Clobber %o7 so that the compiler is forced to allocate
> 	     a register window for this function.  */
> 	  __asm__ __volatile__("flushw" : : : "o7");
> 	}
> 
>    That results (on 32-bit) in something like:
> 
> 	save	%sp, -96, %sp
> 	flushw
> 	return	%i7 + 8
> 	 nop
> 
>    which gives us exactly what we need.

Is something conceptually wrong with just doing this:

asm volatile ("save; flush; restore");

It fixes the problem for freebsd (will test on linux later today), and 
does not rely on compiler doing (or not doing) the "right" 
optimization.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
