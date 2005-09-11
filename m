From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 11 Sep 2005 00:11:03 +0000
Subject: Re: sparc family optimising support
Message-Id: <20050910.171103.20974079.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050910134013.GB7072@inskipp.digriz.org.uk>
In-Reply-To: <20050910134013.GB7072@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 10 Sep 2005 14:50:46 -0500

> This has been brought up before (my archives show a reference back in
> March of 2004), and the answer was that doing this is pointless. The
> sparc kernel patches in the hw versions of the muldiv functions at
> kernel startup anyway, so passing -mcpu=v8 is just a waste.
> 
> So, any improvement that you see from -mcpu=v8 should be
> psychosomatic...

Half true, half false :-)

True, the kernel patches the muldiv functions, so calls to
.mul, .div, .udiv, .umul et al. do end up using the hw
instructions, but:

1) When libcalls are used like this for such fundamental integer
   operations, gcc fails to optimize many things, including important
   strength reduction loop optimizations among other things.

2) It costs a call, and return.  It also makes it impossible for
   functions doing a multiply or divide from being leaf functions
   which is an incredibly big deal on sparc.  Something as trivial
   as:

	int foo(int a, int b)
	{
		return a * b;
	}

   needs a stack frame even though everything fits in registers
   without one.  And all of this merely because gcc had to emit
   a function call to '.mul'.

So a -mcpu=v8 kernel would be significantly faster than the
default.
