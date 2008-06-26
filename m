From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Thu, 26 Jun 2008 03:35:59 +0000
Subject: Re: [3/10 PATCH] inline wake_up_bit
Message-Id: <200806260535.59306.vda.linux@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200806251724.57689.vda.linux@googlemail.com> <200806252237.58046.vda.linux@googlemail.com> <20080625.172838.242554644.davem@davemloft.net>
In-Reply-To: <20080625.172838.242554644.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mpatocka@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thursday 26 June 2008 02:28, David Miller wrote:
> From: Denys Vlasenko <vda.linux@googlemail.com>
> Date: Wed, 25 Jun 2008 22:37:58 +0200
> > > Sparc64 has register windows: it passes arguments in registers, but it 
> > > must allocate space for that registers. If the call stack is too deep (8 
> > > levels), the CPU runs out of registers and starts spilling the registers 
> > > of the function 8-levels-deep to the stack.
> > > 
> > > The stack usage could be reduced to 176 bytes with little work from gcc 
> > > developers and to 128 bytes with more work (ABI change). If you wanted to 
> > 
> > Wow, it's nearly x2 reduction.
> > 
> > ABI change in not a problem for kernel, since it is a "freestanding
> > application". Exactly like i386 switched to regparm, which is a different ABI.
> 
> Except that nobody has written this code and therefore being about to
> use this unimplemented compiler facility to get correctness is not
> tenable.

Inlining everything is even less tenable. Why architectures which do not
require 128+ bytes of stack for every function call should suffer?

I am all for fixing code where there are extra useless levels of calls,
but in this example I pointed out that patch adds inlines too liberally.
Do you agree that blowing up every wake_up_bit() into half a dozen
or more C lines is not what we want?
--
vda
